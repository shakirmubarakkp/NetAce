-- Tie NetAce profiles to Supabase Auth and keep privileged fields server-controlled.

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS auth_user_id UUID UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  ADD COLUMN IF NOT EXISTS preferred_subject_ids TEXT[] NOT NULL DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS onboarding_complete BOOLEAN NOT NULL DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS target_exam_date DATE,
  ADD COLUMN IF NOT EXISTS preferred_study_modes TEXT[] NOT NULL DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS terms_accepted_at TIMESTAMPTZ;

UPDATE public.profiles AS profile
SET auth_user_id = auth_user.id
FROM auth.users AS auth_user
WHERE profile.auth_user_id IS NULL
  AND lower(profile.email) = lower(auth_user.email);

CREATE TABLE IF NOT EXISTS public.moderator_subject_assignments (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  subject_id TEXT NOT NULL REFERENCES public.subjects(id) ON DELETE CASCADE,
  assigned_by UUID REFERENCES auth.users(id),
  assigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, subject_id)
);

CREATE OR REPLACE FUNCTION public.create_netace_profile()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
BEGIN
  INSERT INTO public.profiles (id, auth_user_id, email, name, role, terms_accepted_at)
  VALUES (
    NEW.id,
    NEW.id,
    NEW.email,
    COALESCE(NULLIF(NEW.raw_user_meta_data ->> 'full_name', ''), split_part(NEW.email, '@', 1)),
    'free_student',
    CASE WHEN NEW.raw_user_meta_data ->> 'terms_accepted' = 'true' THEN NOW() ELSE NULL END
  )
  ON CONFLICT (auth_user_id) DO NOTHING;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created_netace_profile ON auth.users;
CREATE TRIGGER on_auth_user_created_netace_profile
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.create_netace_profile();

CREATE OR REPLACE FUNCTION public.is_netace_admin()
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM public.profiles
    WHERE auth_user_id = auth.uid()
      AND role = 'admin'
  );
$$;

CREATE OR REPLACE FUNCTION public.can_manage_subject(target_subject_id TEXT)
RETURNS BOOLEAN
LANGUAGE SQL
STABLE
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
  SELECT public.is_netace_admin()
    OR EXISTS (
      SELECT 1
      FROM public.profiles profile
      JOIN public.moderator_subject_assignments assignment
        ON assignment.user_id = profile.auth_user_id
      WHERE profile.auth_user_id = auth.uid()
        AND profile.role = 'moderator'
        AND assignment.subject_id = target_subject_id
    );
$$;

ALTER TABLE public.moderator_subject_assignments ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Moderators view own assignments" ON public.moderator_subject_assignments;
CREATE POLICY "Moderators view own assignments"
  ON public.moderator_subject_assignments FOR SELECT
  USING (user_id = auth.uid() OR public.is_netace_admin());
DROP POLICY IF EXISTS "Admins manage moderator assignments" ON public.moderator_subject_assignments;
CREATE POLICY "Admins manage moderator assignments"
  ON public.moderator_subject_assignments FOR ALL
  USING (public.is_netace_admin())
  WITH CHECK (public.is_netace_admin());

CREATE OR REPLACE FUNCTION public.assign_netace_role(target_user_id UUID, new_role user_role_enum)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  actor_profile public.profiles%ROWTYPE;
BEGIN
  IF NOT public.is_netace_admin() THEN
    RAISE EXCEPTION 'Only an administrator can assign account roles';
  END IF;
  IF new_role = 'guest' THEN
    RAISE EXCEPTION 'Guest is not an assignable account role';
  END IF;
  IF target_user_id = auth.uid() THEN
    RAISE EXCEPTION 'Administrators cannot change their own role';
  END IF;

  SELECT * INTO actor_profile
  FROM public.profiles
  WHERE auth_user_id = auth.uid();

  UPDATE public.profiles
  SET role = new_role,
      is_premium = new_role IN ('premium_student', 'admin'),
      updated_at = NOW()
  WHERE auth_user_id = target_user_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Target account profile was not found';
  END IF;

  IF new_role <> 'moderator' THEN
    DELETE FROM public.moderator_subject_assignments
    WHERE user_id = target_user_id;
  END IF;

  INSERT INTO public.admin_audit_logs (actor_id, actor_name, actor_role, action, details)
  VALUES (
    actor_profile.id,
    actor_profile.name,
    actor_profile.role,
    'ROLE_ASSIGNED',
    format('Assigned role %s to auth user %s', new_role, target_user_id)
  );
END;
$$;

CREATE OR REPLACE FUNCTION public.replace_moderator_subject_assignments(
  target_user_id UUID,
  subject_ids TEXT[]
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  actor_profile public.profiles%ROWTYPE;
BEGIN
  IF NOT public.is_netace_admin() THEN
    RAISE EXCEPTION 'Only an administrator can manage moderator assignments';
  END IF;
  IF NOT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE auth_user_id = target_user_id
      AND role = 'moderator'
  ) THEN
    RAISE EXCEPTION 'Assignments can only be made to moderator accounts';
  END IF;

  SELECT * INTO actor_profile
  FROM public.profiles
  WHERE auth_user_id = auth.uid();

  DELETE FROM public.moderator_subject_assignments
  WHERE user_id = target_user_id;

  INSERT INTO public.moderator_subject_assignments (user_id, subject_id, assigned_by)
  SELECT target_user_id, subject.id, auth.uid()
  FROM public.subjects subject
  WHERE subject.id = ANY(COALESCE(subject_ids, '{}'));

  INSERT INTO public.admin_audit_logs (actor_id, actor_name, actor_role, action, details)
  VALUES (
    actor_profile.id,
    actor_profile.name,
    actor_profile.role,
    'MODERATOR_ASSIGNMENTS_UPDATED',
    format('Updated subject assignments for auth user %s', target_user_id)
  );
END;
$$;

CREATE OR REPLACE FUNCTION public.log_question_review_change()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, pg_temp
AS $$
DECLARE
  actor_profile public.profiles%ROWTYPE;
BEGIN
  IF OLD.review_status IS DISTINCT FROM NEW.review_status THEN
    SELECT * INTO actor_profile
    FROM public.profiles
    WHERE auth_user_id = auth.uid();

    INSERT INTO public.admin_audit_logs (actor_id, actor_name, actor_role, action, details)
    VALUES (
      actor_profile.id,
      actor_profile.name,
      actor_profile.role,
      'QUESTION_REVIEW_STATUS_CHANGED',
      format('Question %s changed from %s to %s', NEW.id, OLD.review_status, NEW.review_status)
    );
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS question_review_change_audit ON public.questions;
CREATE TRIGGER question_review_change_audit
  AFTER UPDATE OF review_status ON public.questions
  FOR EACH ROW EXECUTE FUNCTION public.log_question_review_change();

REVOKE ALL ON FUNCTION public.is_netace_admin() FROM PUBLIC;
REVOKE ALL ON FUNCTION public.can_manage_subject(TEXT) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.create_netace_profile() FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.log_question_review_change() FROM PUBLIC, anon, authenticated;
REVOKE ALL ON FUNCTION public.assign_netace_role(UUID, user_role_enum) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.replace_moderator_subject_assignments(UUID, TEXT[]) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.is_netace_admin() TO authenticated;
GRANT EXECUTE ON FUNCTION public.can_manage_subject(TEXT) TO authenticated;
GRANT EXECUTE ON FUNCTION public.assign_netace_role(UUID, user_role_enum) TO authenticated;
GRANT EXECUTE ON FUNCTION public.replace_moderator_subject_assignments(UUID, TEXT[]) TO authenticated;

DROP POLICY IF EXISTS "Public profiles can be viewed by all users" ON public.profiles;
DROP POLICY IF EXISTS "Users can edit own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users view own profile and admins view profiles" ON public.profiles;
CREATE POLICY "Users view own profile and admins view profiles"
  ON public.profiles FOR SELECT
  USING (auth_user_id = auth.uid() OR public.is_netace_admin());
DROP POLICY IF EXISTS "Users update allowed profile fields" ON public.profiles;
CREATE POLICY "Users update allowed profile fields"
  ON public.profiles FOR UPDATE
  USING (auth_user_id = auth.uid())
  WITH CHECK (auth_user_id = auth.uid());
REVOKE INSERT, UPDATE, DELETE ON public.profiles FROM anon, authenticated;
GRANT SELECT ON public.profiles TO authenticated;
GRANT UPDATE (name, avatar, target_exam_id, preferred_subject_ids, daily_goal, onboarding_complete, target_exam_date, preferred_study_modes)
  ON public.profiles TO authenticated;

DROP POLICY IF EXISTS "Staff manage all questions" ON public.questions;
DROP POLICY IF EXISTS "Authorized staff manage assigned questions" ON public.questions;
CREATE POLICY "Authorized staff manage assigned questions"
  ON public.questions FOR ALL
  USING (public.can_manage_subject(subject_id))
  WITH CHECK (public.can_manage_subject(subject_id));

ALTER TABLE public.question_options ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Read options for approved questions" ON public.question_options;
CREATE POLICY "Read options for approved questions"
  ON public.question_options FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.questions question
    WHERE question.id = question_id
      AND question.review_status = 'approved'
  ));
DROP POLICY IF EXISTS "Authorized staff manage options" ON public.question_options;
CREATE POLICY "Authorized staff manage options"
  ON public.question_options FOR ALL
  USING (EXISTS (
    SELECT 1 FROM public.questions question
    WHERE question.id = question_id
      AND public.can_manage_subject(question.subject_id)
  ))
  WITH CHECK (EXISTS (
    SELECT 1 FROM public.questions question
    WHERE question.id = question_id
      AND public.can_manage_subject(question.subject_id)
  ));

DROP POLICY IF EXISTS "Everyone can view examinations" ON public.examinations;
CREATE POLICY "Everyone can view examinations"
  ON public.examinations FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Admins manage examinations" ON public.examinations;
CREATE POLICY "Admins manage examinations"
  ON public.examinations FOR ALL
  USING (public.is_netace_admin())
  WITH CHECK (public.is_netace_admin());

ALTER TABLE public.papers ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Everyone can view papers" ON public.papers;
CREATE POLICY "Everyone can view papers"
  ON public.papers FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Admins manage papers" ON public.papers;
CREATE POLICY "Admins manage papers"
  ON public.papers FOR ALL
  USING (public.is_netace_admin())
  WITH CHECK (public.is_netace_admin());

DROP POLICY IF EXISTS "Everyone can view subjects" ON public.subjects;
CREATE POLICY "Everyone can view subjects"
  ON public.subjects FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Admins manage subjects" ON public.subjects;
CREATE POLICY "Admins manage subjects"
  ON public.subjects FOR ALL
  USING (public.is_netace_admin())
  WITH CHECK (public.is_netace_admin());

DROP POLICY IF EXISTS "Everyone can view chapters" ON public.chapters;
CREATE POLICY "Everyone can view chapters"
  ON public.chapters FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Admins manage chapter curriculum" ON public.chapters;
CREATE POLICY "Admins manage chapter curriculum"
  ON public.chapters FOR ALL
  USING (public.is_netace_admin())
  WITH CHECK (public.is_netace_admin());

DROP POLICY IF EXISTS "Everyone can view topics" ON public.topics;
CREATE POLICY "Everyone can view topics"
  ON public.topics FOR SELECT USING (TRUE);
DROP POLICY IF EXISTS "Admins manage chapter topics" ON public.topics;
CREATE POLICY "Admins manage chapter topics"
  ON public.topics FOR ALL
  USING (public.is_netace_admin())
  WITH CHECK (public.is_netace_admin());

-- Curriculum identifiers mirror the existing configured content IDs, which are not seeded into the database yet.
CREATE TABLE IF NOT EXISTS public.chapter_practice_sessions (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  exam_id TEXT NOT NULL,
  paper_id TEXT,
  subject_id TEXT NOT NULL,
  chapter_id TEXT NOT NULL,
  mode TEXT NOT NULL CHECK (mode IN ('learn', 'timed', 'simulation', 'revision')),
  source TEXT NOT NULL CHECK (source IN ('all', 'pyq', 'saved', 'incorrect', 'unattempted')),
  total_questions INTEGER NOT NULL CHECK (total_questions > 0),
  answered_count INTEGER NOT NULL CHECK (answered_count >= 0 AND answered_count <= total_questions),
  correct_count INTEGER NOT NULL CHECK (correct_count >= 0 AND correct_count <= answered_count),
  accuracy_percentage NUMERIC(5,2) NOT NULL CHECK (accuracy_percentage >= 0 AND accuracy_percentage <= 100),
  time_spent_seconds INTEGER NOT NULL CHECK (time_spent_seconds >= 0),
  question_results JSONB NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS chapter_practice_sessions_user_chapter_created_idx
  ON public.chapter_practice_sessions (user_id, chapter_id, created_at DESC);
ALTER TABLE public.chapter_practice_sessions ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Users view their own chapter practice sessions" ON public.chapter_practice_sessions;
CREATE POLICY "Users view their own chapter practice sessions"
  ON public.chapter_practice_sessions FOR SELECT
  USING (user_id = auth.uid());
DROP POLICY IF EXISTS "Users insert their own chapter practice sessions" ON public.chapter_practice_sessions;
CREATE POLICY "Users insert their own chapter practice sessions"
  ON public.chapter_practice_sessions FOR INSERT
  WITH CHECK (user_id = auth.uid());

DROP POLICY IF EXISTS "Admins view audit logs" ON public.admin_audit_logs;
CREATE POLICY "Admins view audit logs"
  ON public.admin_audit_logs FOR SELECT
  USING (public.is_netace_admin());

DROP POLICY IF EXISTS "Users can view own attempts" ON public.question_attempts;
DROP POLICY IF EXISTS "Users can insert own attempts" ON public.question_attempts;
CREATE POLICY "Users can view own attempts"
  ON public.question_attempts FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.profiles profile
    WHERE profile.id = user_id AND profile.auth_user_id = auth.uid()
  ));
CREATE POLICY "Users can insert own attempts"
  ON public.question_attempts FOR INSERT
  WITH CHECK (EXISTS (
    SELECT 1 FROM public.profiles profile
    WHERE profile.id = user_id AND profile.auth_user_id = auth.uid()
  ));
