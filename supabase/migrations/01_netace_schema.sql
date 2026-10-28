-- NetAce Production Database Schema & Migration
-- Supports PostgreSQL 15+ and Supabase with Row Level Security (RLS)

-- 1. EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. ENUMS (Safe against repeated executions)
DO $$ BEGIN
    CREATE TYPE user_role_enum AS ENUM ('guest', 'free_student', 'premium_student', 'moderator', 'admin');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
    CREATE TYPE question_type_enum AS ENUM ('mcq_single', 'mcq_multiple', 'numerical', 'assertion_reason', 'match_pairs', 'true_false', 'fill_gap');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
    CREATE TYPE difficulty_enum AS ENUM ('easy', 'medium', 'hard');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
    CREATE TYPE review_status_enum AS ENUM ('approved', 'pending_review', 'rejected', 'needs_edit');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

DO $$ BEGIN
    CREATE TYPE topic_status_enum AS ENUM ('locked', 'available', 'in_progress', 'completed', 'mastered', 'needs_revision');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

-- 3. PROFILES TABLE
CREATE TABLE IF NOT EXISTS profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    avatar TEXT DEFAULT '🚀',
    role user_role_enum DEFAULT 'free_student',
    target_exam_id TEXT,
    xp INTEGER DEFAULT 0,
    level INTEGER DEFAULT 1,
    level_title TEXT DEFAULT 'Beginner',
    streak_days INTEGER DEFAULT 0,
    last_active_date DATE DEFAULT CURRENT_DATE,
    streak_frozen BOOLEAN DEFAULT FALSE,
    daily_goal INTEGER DEFAULT 15,
    coins INTEGER DEFAULT 100,
    is_premium BOOLEAN DEFAULT FALSE,
    premium_expires_at TIMESTAMPTZ,
    plan_id TEXT DEFAULT 'free',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. EXAMINATIONS HIERARCHY
CREATE TABLE IF NOT EXISTS examinations (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    short_code TEXT NOT NULL,
    description TEXT,
    category TEXT,
    icon TEXT,
    badge_color TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS papers (
    id TEXT PRIMARY KEY,
    exam_id TEXT REFERENCES examinations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    code TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS subjects (
    id TEXT PRIMARY KEY,
    paper_id TEXT REFERENCES papers(id) ON DELETE CASCADE,
    exam_id TEXT REFERENCES examinations(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    name_malayalam TEXT,
    name_arabic TEXT,
    description TEXT,
    icon TEXT,
    color TEXT,
    is_free_preview BOOLEAN DEFAULT TRUE,
    total_chapters INTEGER DEFAULT 0,
    total_questions INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS chapters (
    id TEXT PRIMARY KEY,
    subject_id TEXT REFERENCES subjects(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    unit_number INTEGER NOT NULL,
    description TEXT,
    is_free BOOLEAN DEFAULT TRUE,
    order_num INTEGER NOT NULL,
    estimated_minutes INTEGER DEFAULT 45,
    boss_name TEXT,
    boss_avatar TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS topics (
    id TEXT PRIMARY KEY,
    chapter_id TEXT REFERENCES chapters(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    order_num INTEGER NOT NULL,
    summary_note TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. QUESTIONS AND OPTIONS
CREATE TABLE IF NOT EXISTS questions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    exam_id TEXT REFERENCES examinations(id),
    subject_id TEXT REFERENCES subjects(id),
    chapter_id TEXT REFERENCES chapters(id),
    topic_id TEXT REFERENCES topics(id),
    type question_type_enum NOT NULL DEFAULT 'mcq_single',
    difficulty difficulty_enum NOT NULL DEFAULT 'medium',
    question_text TEXT NOT NULL,
    question_text_malayalam TEXT,
    question_text_arabic TEXT,
    correct_answer_text TEXT,
    assertion_text TEXT,
    reason_text TEXT,
    match_pairs JSONB,
    explanation TEXT NOT NULL,
    explanation_malayalam TEXT,
    explanation_arabic TEXT,
    hint TEXT,
    is_pyq BOOLEAN DEFAULT FALSE,
    pyq_year INTEGER,
    pyq_paper TEXT,
    pyq_question_no INTEGER,
    review_status review_status_enum DEFAULT 'approved',
    creator_id UUID REFERENCES profiles(id),
    flawed_solution JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS question_options (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
    option_key TEXT NOT NULL,
    option_text TEXT NOT NULL,
    option_text_malayalam TEXT,
    option_text_arabic TEXT,
    is_correct BOOLEAN DEFAULT FALSE
);

-- 6. QUIZ SESSIONS AND ATTEMPTS
CREATE TABLE IF NOT EXISTS quiz_sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    game_mode TEXT NOT NULL,
    exam_id TEXT REFERENCES examinations(id),
    subject_id TEXT REFERENCES subjects(id),
    chapter_id TEXT REFERENCES chapters(id),
    total_questions INTEGER DEFAULT 0,
    correct_count INTEGER DEFAULT 0,
    total_xp_earned INTEGER DEFAULT 0,
    accuracy_percentage NUMERIC(5,2) DEFAULT 0.00,
    time_spent_seconds INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS question_attempts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
    quiz_session_id UUID REFERENCES quiz_sessions(id) ON DELETE SET NULL,
    game_mode TEXT NOT NULL,
    selected_option_ids TEXT[],
    given_answer_text TEXT,
    is_correct BOOLEAN NOT NULL,
    time_spent_seconds INTEGER DEFAULT 0,
    awarded_xp INTEGER DEFAULT 10,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. REVISION AND MISTAKE NOTEBOOK
CREATE TABLE IF NOT EXISTS mistake_notebook (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
    attempt_count INTEGER DEFAULT 1,
    is_resolved BOOLEAN DEFAULT FALSE,
    last_attempt_at TIMESTAMPTZ DEFAULT NOW(),
    next_review_at TIMESTAMPTZ DEFAULT NOW() + INTERVAL '1 day',
    repetition_interval_days INTEGER DEFAULT 1,
    ease_factor NUMERIC(4,2) DEFAULT 2.50,
    UNIQUE(user_id, question_id)
);

CREATE TABLE IF NOT EXISTS bookmarks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    question_id UUID REFERENCES questions(id) ON DELETE CASCADE,
    note TEXT,
    tags TEXT[],
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, question_id)
);

-- 8. XP LEDGER & BADGES
CREATE TABLE IF NOT EXISTS xp_ledger (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    amount INTEGER NOT NULL,
    reason TEXT NOT NULL,
    source_type TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS badges (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    icon TEXT NOT NULL,
    category TEXT NOT NULL,
    rarity TEXT NOT NULL,
    target_count INTEGER DEFAULT 1
);

CREATE TABLE IF NOT EXISTS earned_badges (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    badge_id TEXT REFERENCES badges(id) ON DELETE CASCADE,
    unlocked_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, badge_id)
);

-- 9. LEARNING PROGRESS / TOPIC NODES
CREATE TABLE IF NOT EXISTS learning_progress (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    topic_id TEXT REFERENCES topics(id) ON DELETE CASCADE,
    status topic_status_enum DEFAULT 'available',
    accuracy NUMERIC(5,2) DEFAULT 0.00,
    attempts_count INTEGER DEFAULT 0,
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, topic_id)
);

-- 10. MULTIPLAYER BATTLES
CREATE TABLE IF NOT EXISTS battle_rooms (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    room_code TEXT UNIQUE NOT NULL,
    created_by UUID REFERENCES profiles(id),
    status TEXT DEFAULT 'waiting', -- waiting, in_progress, completed
    game_mode TEXT DEFAULT '1v1_battle',
    subject_id TEXT REFERENCES subjects(id),
    questions_count INTEGER DEFAULT 5,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS battle_participants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    battle_room_id UUID REFERENCES battle_rooms(id) ON DELETE CASCADE,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    score INTEGER DEFAULT 0,
    streak INTEGER DEFAULT 0,
    is_ready BOOLEAN DEFAULT FALSE,
    finished_at TIMESTAMPTZ
);

-- 11. CLASSROOM AND COACHING
CREATE TABLE IF NOT EXISTS classrooms (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    institute_name TEXT NOT NULL,
    teacher_id UUID REFERENCES profiles(id),
    invite_code TEXT UNIQUE NOT NULL,
    exam_id TEXT REFERENCES examinations(id),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS classroom_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    classroom_id UUID REFERENCES classrooms(id) ON DELETE CASCADE,
    student_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(classroom_id, student_id)
);

CREATE TABLE IF NOT EXISTS classroom_assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    classroom_id UUID REFERENCES classrooms(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    chapter_id TEXT REFERENCES chapters(id),
    deadline TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 12. SUBSCRIPTIONS AND PAYMENTS (RAZORPAY)
CREATE TABLE IF NOT EXISTS subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    plan_id TEXT NOT NULL, -- monthly (99 INR), annual (799 INR)
    status TEXT NOT NULL, -- active, past_due, canceled, expired
    amount_inr NUMERIC(10,2) NOT NULL,
    razorpay_subscription_id TEXT,
    razorpay_payment_id TEXT,
    started_at TIMESTAMPTZ DEFAULT NOW(),
    expires_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    razorpay_order_id TEXT NOT NULL,
    razorpay_payment_id TEXT,
    razorpay_signature TEXT,
    amount_paisa INTEGER NOT NULL,
    currency TEXT DEFAULT 'INR',
    status TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 13. OCR IMPORT JOBS
CREATE TABLE IF NOT EXISTS ocr_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    uploaded_by UUID REFERENCES profiles(id),
    file_name TEXT NOT NULL,
    file_url TEXT,
    status TEXT DEFAULT 'processing',
    extracted_questions_count INTEGER DEFAULT 0,
    confidence_score NUMERIC(5,2) DEFAULT 0.00,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 14. AUDIT LOGS
CREATE TABLE IF NOT EXISTS admin_audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    actor_id UUID REFERENCES profiles(id),
    actor_name TEXT NOT NULL,
    actor_role user_role_enum NOT NULL,
    action TEXT NOT NULL,
    details TEXT,
    ip_address TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 15. ROW LEVEL SECURITY (RLS)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE mistake_notebook ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookmarks ENABLE ROW LEVEL SECURITY;
ALTER TABLE xp_ledger ENABLE ROW LEVEL SECURITY;
ALTER TABLE earned_badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE learning_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_audit_logs ENABLE ROW LEVEL SECURITY;

-- Read policies
DROP POLICY IF EXISTS "Public profiles can be viewed by all users" ON profiles;
CREATE POLICY "Public profiles can be viewed by all users" ON profiles FOR SELECT USING (true);

DROP POLICY IF EXISTS "Users can edit own profile" ON profiles;
CREATE POLICY "Users can edit own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

DROP POLICY IF EXISTS "Users can view own attempts" ON question_attempts;
CREATE POLICY "Users can view own attempts" ON question_attempts FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert own attempts" ON question_attempts;
CREATE POLICY "Users can insert own attempts" ON question_attempts FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users manage own mistakes" ON mistake_notebook;
CREATE POLICY "Users manage own mistakes" ON mistake_notebook FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users manage own bookmarks" ON bookmarks;
CREATE POLICY "Users manage own bookmarks" ON bookmarks FOR ALL USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users view own xp ledger" ON xp_ledger;
CREATE POLICY "Users view own xp ledger" ON xp_ledger FOR SELECT USING (auth.uid() = user_id);

-- Questions & hierarchy public readable
ALTER TABLE examinations ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Everyone can view examinations" ON examinations;
CREATE POLICY "Everyone can view examinations" ON examinations FOR SELECT USING (true);

ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Everyone can view subjects" ON subjects;
CREATE POLICY "Everyone can view subjects" ON subjects FOR SELECT USING (true);

ALTER TABLE chapters ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Everyone can view chapters" ON chapters;
CREATE POLICY "Everyone can view chapters" ON chapters FOR SELECT USING (true);

ALTER TABLE topics ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Everyone can view topics" ON topics;
CREATE POLICY "Everyone can view topics" ON topics FOR SELECT USING (true);

ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Everyone can view questions" ON questions;
CREATE POLICY "Everyone can view questions" ON questions FOR SELECT USING (review_status = 'approved');

-- Admins and moderators can view and manage all questions
DROP POLICY IF EXISTS "Staff manage all questions" ON questions;
CREATE POLICY "Staff manage all questions" ON questions FOR ALL USING (
  EXISTS (
    SELECT 1 FROM profiles 
    WHERE profiles.id = auth.uid() 
    AND profiles.role IN ('admin', 'moderator')
  )
);
