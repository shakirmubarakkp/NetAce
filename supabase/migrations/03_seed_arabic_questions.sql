-- 03_seed_arabic_questions.sql
-- Automatically generated seed for 386 UGC NET Arabic Literature questions from questions.docx
-- Includes full prerequisite hierarchy (Examinations -> Papers -> Subjects -> Chapters -> Topics -> Questions)

-- 1. Ensure UGC NET Examination exists
INSERT INTO public.examinations (id, name, short_code, description, category, icon, badge_color, is_active)
VALUES ('ugc_net', 'UGC NET / JRF', 'UGC-NET', 'National Eligibility Test for Assistant Professor and Junior Research Fellowship by NTA.', 'Teaching & Research', 'GraduationCap', 'from-blue-600 to-indigo-700', true)
ON CONFLICT (id) DO NOTHING;

-- 2. Ensure Paper II exists
INSERT INTO public.papers (id, exam_id, name, code, description)
VALUES ('ugc_p2', 'ugc_net', 'Paper II: Subject Specialization', 'PAPER-2', 'Core domain paper (100 questions, 200 marks)')
ON CONFLICT (id) DO NOTHING;

-- 3. Ensure Arabic Subject exists
INSERT INTO public.subjects (id, paper_id, exam_id, name, name_arabic, description, icon, color, is_free_preview, total_chapters, total_questions)
VALUES ('sub_ugc_arabic', 'ugc_p2', 'ugc_net', 'Arabic (اللغة العربية وآدابها)', 'اللغة العربية وآدابها', 'Classical, Umayyad, Abbasid & Modern Literature, Literary Criticism, Balaghah, and Nahw.', 'Languages', 'from-emerald-500 to-teal-700', true, 4, 390)
ON CONFLICT (id) DO UPDATE SET total_questions = 390, total_chapters = 4;

-- 4. Ensure all Arabic Chapters exist
INSERT INTO public.chapters (id, subject_id, name, unit_number, description, is_free, order_num, estimated_minutes, boss_name, boss_avatar)
VALUES ('chap_arabic_classical', 'sub_ugc_arabic', 'Pre-Islamic & Early Islamic Literature (الأدب الجاهلي والإسلامي)', 1, 'Al-Mu’allaqat, Imru’ al-Qays, Hassan ibn Thabit, characteristics of Jahili poetry and Su’luk.', true, 1, 60, 'Imru’ al-Qays the Vagabond King (الملك الضليل)', '👑')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.chapters (id, subject_id, name, unit_number, description, is_free, order_num, estimated_minutes, boss_name, boss_avatar)
VALUES ('chap_arabic_abbasid', 'sub_ugc_arabic', 'Abbasid Golden Era & Criticism (العصر العباسي والنقد الأدبي)', 2, 'Al-Mutanabbi, Abu Tammam, Al-Jahiz, Ibn al-Muqaffa, and evolution of Arabic literary theory.', true, 2, 65, 'Al-Mutanabbi: The Undefeated Poet (المتنبي)', '⚔️')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.chapters (id, subject_id, name, unit_number, description, is_free, order_num, estimated_minutes, boss_name, boss_avatar)
VALUES ('chap_arabic_nahw', 'sub_ugc_arabic', 'Grammar, Morphology & Rhetoric (النحو والصرف والبلاغة)', 3, 'I’rab rules, Nawasikh, Majaz, Kinayah, Badi’, and Sibawayh grammatical school principles.', false, 3, 70, 'Sibawayh: Sovereign of Grammatical I’rab (سيبويه)', '📜')
ON CONFLICT (id) DO NOTHING;
INSERT INTO public.chapters (id, subject_id, name, unit_number, description, is_free, order_num, estimated_minutes, boss_name, boss_avatar)
VALUES ('chap_arabic_umayyad', 'sub_ugc_arabic', 'Umayyad Poetry, Naqa’id & Ghazal (العصر الأموي والنقائض والغزل)', 4, 'Jarir, Al-Farazdaq, Al-Akhtal (Naqa’id), Ghazal Udri & Sarih (Jamil Buthayna, Umar ibn Abi Rabi’ah).', true, 4, 55, 'Jarir & Farazdaq: Duelists of Naqa’id (صقرا النقائض)', '🦅')
ON CONFLICT (id) DO NOTHING;

-- 5. Ensure all Arabic Topics exist
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_origins_jahili', 'chap_arabic_classical', 'Arab Origins & Pre-Islamic Literature (أصول العرب والأدب الجاهلي)', 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_muallaqat', 'chap_arabic_classical', 'The Seven Mu’allaqat & As-habuha (المعلقات وأصحابها)', 2) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_suluk', 'chap_arabic_classical', 'Su’luk Poets (الشعراء الصعاليك: الشنفرى وتأبط شرا)', 3) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_mukhadramun', 'chap_arabic_classical', 'Islamic & Mukhadramun Poets (الشعراء المخضرمون والإسلاميون)', 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_naqaid_ghazal', 'chap_arabic_umayyad', 'Naqa’id & Umayyad Ghazal (شعر النقائض والغزل الأموي)', 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_mutanabbi', 'chap_arabic_abbasid', 'Al-Mutanabbi & Al-Ma’arri (المتنبي والمعري)', 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_abbasid_poets', 'chap_arabic_abbasid', 'Abbasid Innovator Poets (بشار، أبو نواس، أبو تمام، البحتري، ابن الرومي)', 2) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_jahiz_prose', 'chap_arabic_abbasid', 'Al-Jahiz & Abbasid Art of Prose (الجاحظ وكتاب البخلاء)', 3) ON CONFLICT (id) DO NOTHING;
INSERT INTO public.topics (id, chapter_id, name, order_num) VALUES ('top_nawasikh', 'chap_arabic_nahw', 'Inna and Kana Nawasikh Rules (النواسخ: إن وأخواتها وكان وأخواتها)', 1) ON CONFLICT (id) DO NOTHING;

-- 6. Insert 386 Questions and Options
DO $$
DECLARE
    v_qid UUID;
BEGIN
    -- Question 1: q_ar_001
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'يعود أصل العرب إلى العدنانيين والقحطانيين. القحطانيون هم:', 'يعود أصل العرب إلى العدنانيين والقحطانيين. القحطانيون هم:', 'يُقسم المؤرخون العرب إلى طبقتين رئيسيتين: القحطانيون وهم "العرب العاربة" وأصلهم من اليمن (الجنوب)، والعدنانيون وهم "العرب المستعربة" وسكنوا الحجاز ونجد (الشمال).', 'يُقسم المؤرخون العرب إلى طبقتين رئيسيتين: القحطانيون وهم "العرب العاربة" وأصلهم من اليمن (الجنوب)، والعدنانيون وهم "العرب المستعربة" وسكنوا الحجاز ونجد (الشمال).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عرب الشمال', 'عرب الشمال', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عرب الجنوب', 'عرب الجنوب', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عرب الشرق', 'عرب الشرق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عرب الغرب', 'عرب الغرب', FALSE);
    -- Question 2: q_ar_002
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'العرب البائدة: كانت مساكنهم في:', 'العرب البائدة: كانت مساكنهم في:', 'العرب البائدة هم القبائل التي انقرضت قبل الإسلام بفترة طويلة (مثل عاد وثمود وطسم وجديس)، وكانت اليمامة والبحرين هي المراكز الأساسية لاستقرارهم قبل هلاكهم أو اندماجهم.', 'العرب البائدة هم القبائل التي انقرضت قبل الإسلام بفترة طويلة (مثل عاد وثمود وطسم وجديس)، وكانت اليمامة والبحرين هي المراكز الأساسية لاستقرارهم قبل هلاكهم أو اندماجهم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمان والبحرين واليمامة', 'عمان والبحرين واليمامة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'مكة والبحرين واليمامة', 'مكة والبحرين واليمامة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمان والبحرين والمدينة', 'عمان والبحرين والمدينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمان والبحرين واليمن', 'عمان والبحرين واليمن', FALSE);
    -- Question 3: q_ar_003
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'العرب العاربة:', 'العرب العاربة:', 'يُطلق لقب "العاربة" على القحطانيين لأنهم هم الذين استنبطوا اللغة العربية وتكلموا بها أولاً، وموطنهم الأصلي هو اليمن.', 'يُطلق لقب "العاربة" على القحطانيين لأنهم هم الذين استنبطوا اللغة العربية وتكلموا بها أولاً، وموطنهم الأصلي هو اليمن.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'هم عرب اليمن', 'هم عرب اليمن', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'هم عرب اليمامة', 'هم عرب اليمامة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'هم عرب البحرين', 'هم عرب البحرين', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'هم عرب العراق', 'هم عرب العراق', FALSE);
    -- Question 4: q_ar_004
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'العرب المستعربة: هم عرب الشمال من نسل:', 'العرب المستعربة: هم عرب الشمال من نسل:', 'يُنسب عرب الشمال إلى عدنان (من ولد إسماعيل عليه السلام). سُموا "مستعربة" لأن إسماعيل عليه السلام لم يكن عربياً بالأصل بل تعلم العربية من قبيلة جرهم اليمنية.', 'يُنسب عرب الشمال إلى عدنان (من ولد إسماعيل عليه السلام). سُموا "مستعربة" لأن إسماعيل عليه السلام لم يكن عربياً بالأصل بل تعلم العربية من قبيلة جرهم اليمنية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'قحطان', 'قحطان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عدنان', 'عدنان', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'سام', 'سام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'نزار', 'نزار', FALSE);
    -- Question 5: q_ar_005
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'اللغات السامية ثلاثة:', 'اللغات السامية ثلاثة:', 'اللغات السامية هي فصيلة لغوية تضم العربية والآرامية والعبرية والكنعانية والحبشية. أما اليونانية واللاتينية فهي لغات هندوأوروبية.', 'اللغات السامية هي فصيلة لغوية تضم العربية والآرامية والعبرية والكنعانية والحبشية. أما اليونانية واللاتينية فهي لغات هندوأوروبية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'آرامية والكنعانية واليونانية', 'آرامية والكنعانية واليونانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'آرامية والكنعانية والعربية', 'آرامية والكنعانية والعربية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'آرامية والكنعانية والسنسكريتية', 'آرامية والكنعانية والسنسكريتية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'آرامية والكنعانية واللاتينية', 'آرامية والكنعانية واللاتينية', FALSE);
    -- Question 6: q_ar_006
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'أقدم لغة من اللغة السامية:', 'أقدم لغة من اللغة السامية:', 'تعتبر الآرامية من أقدم اللغات السامية التي دونت بها وثائق تاريخية ونقوش قديمة جداً، وكانت لغة الدبلوماسية والتجارة في الشرق الأدنى القديم.', 'تعتبر الآرامية من أقدم اللغات السامية التي دونت بها وثائق تاريخية ونقوش قديمة جداً، وكانت لغة الدبلوماسية والتجارة في الشرق الأدنى القديم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'آرامية', 'آرامية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'اليونانية', 'اليونانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الكنعانية', 'الكنعانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'العربية', 'العربية', FALSE);
    -- Question 7: q_ar_007
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'كانت شعراء العربية ينظمون أشعارهم باللغة:', 'كانت شعراء العربية ينظمون أشعارهم باللغة:', 'اللغة المضرية هي لغة قريش وما حولها من قبائل الشمال، وهي اللغة التي توحدت عليها لهجات العرب في "اللغة الأدبية المشتركة" التي نزل بها القرآن الكريم.', 'اللغة المضرية هي لغة قريش وما حولها من قبائل الشمال، وهي اللغة التي توحدت عليها لهجات العرب في "اللغة الأدبية المشتركة" التي نزل بها القرآن الكريم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المضرية', 'المضرية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'يمنية', 'يمنية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حبشية', 'حبشية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'نزارية', 'نزارية', FALSE);
    -- Question 8: q_ar_008
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'عاصمة مملكة المناذرة:', 'عاصمة مملكة المناذرة:', 'الحيرة (قرب الكوفة حالياً في العراق) كانت عاصمة المناذرة الذين حكموا تحت سيادة الفرس الساسانيين.', 'الحيرة (قرب الكوفة حالياً في العراق) كانت عاصمة المناذرة الذين حكموا تحت سيادة الفرس الساسانيين.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'مدينة', 'مدينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'يمن', 'يمن', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الحيرة', 'الحيرة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مكة', 'مكة', FALSE);
    -- Question 9: q_ar_009
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'كان أول ملك لمملكة المناذرة:', 'كان أول ملك لمملكة المناذرة:', 'عمرو بن عدي هو مؤسس دولة اللخميين (المناذرة) في الحيرة، وهو ابن أخت "الزباء" الملكة الشهيرة.', 'عمرو بن عدي هو مؤسس دولة اللخميين (المناذرة) في الحيرة، وهو ابن أخت "الزباء" الملكة الشهيرة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمرو بن عدي اللخمي', 'عمرو بن عدي اللخمي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المنذر بن ماء السماء', 'المنذر بن ماء السماء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'المنذر بن عيد السماء', 'المنذر بن عيد السماء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن عبد اللخمي', 'عمر بن عبد اللخمي', FALSE);
    -- Question 10: q_ar_010
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'آخر ملك لمملكة المناذرة المكنى بأبي قابوس:', 'آخر ملك لمملكة المناذرة المكنى بأبي قابوس:', 'النعمان بن المنذر هو أشهر ملوكهم، ولُقب بأبي قابوس، وانتهى ملكه بعد أن غدر به كسرى وسجنه حتى مات.', 'النعمان بن المنذر هو أشهر ملوكهم، ولُقب بأبي قابوس، وانتهى ملكه بعد أن غدر به كسرى وسجنه حتى مات.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمر بن هند', 'عمر بن هند', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المنذر بن ماء السماء', 'المنذر بن ماء السماء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'النعمان بن المنذر', 'النعمان بن المنذر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن عبد اللخمي', 'عمر بن عبد اللخمي', FALSE);
    -- Question 11: q_ar_011
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'حرب داحس والغبراء وحرب البسوس وقعت بين قبائل:', 'حرب داحس والغبراء وحرب البسوس وقعت بين قبائل:', 'هذه الحروب كانت حروباً أهلية بين أبناء العمومة من قبائل الشمال (بكر وتغلب في البسوس، وعبس وذبيان في داحس والغبراء)، وكلها قبائل عدنانية.', 'هذه الحروب كانت حروباً أهلية بين أبناء العمومة من قبائل الشمال (بكر وتغلب في البسوس، وعبس وذبيان في داحس والغبراء)، وكلها قبائل عدنانية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'القبائل القحطانية', 'القبائل القحطانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'القبائل العدنانية', 'القبائل العدنانية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'القبائل القحطانية والعدنانية', 'القبائل القحطانية والعدنانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'القبائل النزارية', 'القبائل النزارية', FALSE);
    -- Question 12: q_ar_012
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'في الأدب الجاهلي - في الشعر الجاهلي، كتابان لـ:', 'في الأدب الجاهلي - في الشعر الجاهلي، كتابان لـ:', 'طه حسين أصدر كتاب "في الشعر الجاهلي" ثم عدله إلى "في الأدب الجاهلي"، وطرح فيه نظريته الشهيرة حول "الانتحال" (شكوك حول صحة الشعر الجاهلي).', 'طه حسين أصدر كتاب "في الشعر الجاهلي" ثم عدله إلى "في الأدب الجاهلي"، وطرح فيه نظريته الشهيرة حول "الانتحال" (شكوك حول صحة الشعر الجاهلي).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'طه حسين', 'طه حسين', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'شوقي ضيف', 'شوقي ضيف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'يوسف خليف', 'يوسف خليف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ناصر الدين', 'ناصر الدين', FALSE);
    -- Question 13: q_ar_013
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'تاريخ الأدب العربي - العصر الجاهلي، كتاب لـ:', 'تاريخ الأدب العربي - العصر الجاهلي، كتاب لـ:', 'الدكتور شوقي ضيف صاحب السلسلة الشهيرة في تاريخ الأدب العربي، ويعتبر كتابه عن العصر الجاهلي مرجعاً أكاديمياً أساسياً.', 'الدكتور شوقي ضيف صاحب السلسلة الشهيرة في تاريخ الأدب العربي، ويعتبر كتابه عن العصر الجاهلي مرجعاً أكاديمياً أساسياً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'طه حسين', 'طه حسين', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'شوقي ضيف', 'شوقي ضيف', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'يوسف خليف', 'يوسف خليف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ناصر الدين', 'ناصر الدين', FALSE);
    -- Question 14: q_ar_014
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'جمهرة أشعار العرب، كتاب لـ:', 'جمهرة أشعار العرب، كتاب لـ:', 'هذا الكتاب من أمهات كتب الأدب، حيث قسم أبو زيد القرشي الشعراء إلى طبقات، ووضع المعلقات في الطبقة الأولى.', 'هذا الكتاب من أمهات كتب الأدب، حيث قسم أبو زيد القرشي الشعراء إلى طبقات، ووضع المعلقات في الطبقة الأولى.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'طه حسين', 'طه حسين', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'شوقي ضيف', 'شوقي ضيف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو زيد القرشي', 'أبو زيد القرشي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ناصر الدين الأسد', 'ناصر الدين الأسد', FALSE);
    -- Question 15: q_ar_015
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'ليس من كنية امرؤ القيس؟', 'ليس من كنية امرؤ القيس؟', 'اشتهر امرؤ القيس بعدة كنى مثل أبي وهب وأبي الحارث، لكن "أبي وقاص" ليست من كناه المعروفة.', 'اشتهر امرؤ القيس بعدة كنى مثل أبي وهب وأبي الحارث، لكن "أبي وقاص" ليست من كناه المعروفة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبي زيد', 'أبي زيد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبي الحارث', 'أبي الحارث', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبي وهب', 'أبي وهب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبي وقاص', 'أبي وقاص', TRUE);
    -- Question 16: q_ar_016
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'قبيلة امرؤ القيس كانت كندة، وأصلهم من؟', 'قبيلة امرؤ القيس كانت كندة، وأصلهم من؟', 'قبيلة كندة هي قبيلة قحطانية يمنية الأصل، أسست مملكة في نجد، وكان حجر (والد امرؤ القيس) ملكاً عليها.', 'قبيلة كندة هي قبيلة قحطانية يمنية الأصل، أسست مملكة في نجد، وكان حجر (والد امرؤ القيس) ملكاً عليها.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'اليمن', 'اليمن', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الفارس', 'الفارس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الروم', 'الروم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مكة', 'مكة', FALSE);
    -- Question 17: q_ar_017
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'معنى كلمة "امرؤ القيس"؟', 'معنى كلمة "امرؤ القيس"؟', '"امرؤ" تعني رجل، و"القيس" في اللغة العربية تدل على الشدة والقوة، فالمعنى الإجمالي هو الرجل الشديد.', '"امرؤ" تعني رجل، و"القيس" في اللغة العربية تدل على الشدة والقوة، فالمعنى الإجمالي هو الرجل الشديد.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'رجل رحيم', 'رجل رحيم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'رجل كريم', 'رجل كريم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'رجل شديد', 'رجل شديد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'رجل فخور', 'رجل فخور', FALSE);
    -- Question 18: q_ar_018
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'ليس من ألقاب امرؤ القيس؟', 'ليس من ألقاب امرؤ القيس؟', 'ألقابه الشهيرة هي الملك الضليل (لضياع ملك أبيه)، وذو القروح (بسبب مرضه الجلدي في نهاية حياته)، وأمير شعراء الجاهلية. "أمير الطريد" تسمية غير دقيقة تاريخياً.', 'ألقابه الشهيرة هي الملك الضليل (لضياع ملك أبيه)، وذو القروح (بسبب مرضه الجلدي في نهاية حياته)، وأمير شعراء الجاهلية. "أمير الطريد" تسمية غير دقيقة تاريخياً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الملك الضليل', 'الملك الضليل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أمير الطريد', 'أمير الطريد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أثير الضليل', 'أثير الضليل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ذو القروح', 'ذو القروح', FALSE);
    -- Question 19: q_ar_019
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'أم امرؤ القيس "فاطمة" كانت أخت؟', 'أم امرؤ القيس "فاطمة" كانت أخت؟', 'فاطمة بنت ربيعة هي أخت البطلين الشهيرين كليب والمهلهل (الزير سالم)، مما يعني أن خال امرؤ القيس هو المهلهل الذي تعلم منه الشعر.', 'فاطمة بنت ربيعة هي أخت البطلين الشهيرين كليب والمهلهل (الزير سالم)، مما يعني أن خال امرؤ القيس هو المهلهل الذي تعلم منه الشعر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كليب ومهلهل', 'كليب ومهلهل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كليب وبخت نصر', 'كليب وبخت نصر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بخت نصر ومهلهل', 'بخت نصر ومهلهل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'داحس ومهلهل', 'داحس ومهلهل', FALSE);
    -- Question 20: q_ar_020
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'طرد أب امرؤ القيس ابنه في عمر العشرين إلى؟', 'طرد أب امرؤ القيس ابنه في عمر العشرين إلى؟', 'طرده والده الملك حجر لأنه كان يشتغل باللهو والشعر، وهو ما كان يعتبره الملوك عيباً، فذهب ليعيش حياة "التشرد" مع العرب في بوادي نجد.', 'طرده والده الملك حجر لأنه كان يشتغل باللهو والشعر، وهو ما كان يعتبره الملوك عيباً، فذهب ليعيش حياة "التشرد" مع العرب في بوادي نجد.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'حضر موت', 'حضر موت', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تهامة', 'تهامة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تريم', 'تريم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'نجد', 'نجد', TRUE);
    -- Question 21: q_ar_021
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'اسم محبوبة امرؤ القيس؟', 'اسم محبوبة امرؤ القيس؟', 'ذكرها في معلقته الشهيرة باسم "عنيزة" في قوله: "ويوم عقرت للعذارى مطيتي.. فيا عجباً من كورها المتحملِ.. تقول وقد مال الغبيط بنا معاً.. عقرت بعيري يا امرأ القيس فانزلِ".', 'ذكرها في معلقته الشهيرة باسم "عنيزة" في قوله: "ويوم عقرت للعذارى مطيتي.. فيا عجباً من كورها المتحملِ.. تقول وقد مال الغبيط بنا معاً.. عقرت بعيري يا امرأ القيس فانزلِ".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عنيزة', 'عنيزة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أنبسة', 'أنبسة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حنيصة', 'حنيصة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'خنيسة', 'خنيسة', FALSE);
    -- Question 22: q_ar_022
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'عدد أبيات معلقة امرؤ القيس؟', 'عدد أبيات معلقة امرؤ القيس؟', 'تتراوح الروايات بين 77 و81 بيتاً، وأشهرها الرواية التي تقر بـ 80 بيتاً.', 'تتراوح الروايات بين 77 و81 بيتاً، وأشهرها الرواية التي تقر بـ 80 بيتاً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '50', '50', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '60', '60', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '80', '80', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '70', '70', FALSE);
    -- Question 23: q_ar_023
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'معلقة امرؤ القيس ثلاثة أقسام كبرى؟', 'معلقة امرؤ القيس ثلاثة أقسام كبرى؟', 'تبدأ بالطلل، ثم الغزل والمغامرات (مثل قصة دارة جلجل)، ثم الوصف الدقيق لفرسه وللليل وللمطر والبرق.', 'تبدأ بالطلل، ثم الغزل والمغامرات (مثل قصة دارة جلجل)، ثم الوصف الدقيق لفرسه وللليل وللمطر والبرق.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الوقوف على الأطلال، وصف المغامرات والغزل', 'الوقوف على الأطلال، وصف المغامرات والغزل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الوقوف على الأطلال، وصف المغامرات والوصف', 'الوقوف على الأطلال، وصف المغامرات والوصف', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الوقوف على الأطلال، وصف المغامرات والرثاء', 'الوقوف على الأطلال، وصف المغامرات والرثاء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الوقوف على الأطلال، وصف المغامرات والتشجيع', 'الوقوف على الأطلال، وصف المغامرات والتشجيع', FALSE);
    -- Question 24: q_ar_024
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'يقال أشهر الشعراء امرؤ القيس إذا؟', 'يقال أشهر الشعراء امرؤ القيس إذا؟', 'هناك مقولة نقدية شهيرة: "امرؤ القيس إذا ركب (لوصفه الخيل)، والنابعة إذا رغب، وزهير إذا رغب، وعنترة إذا غضب".', 'هناك مقولة نقدية شهيرة: "امرؤ القيس إذا ركب (لوصفه الخيل)، والنابعة إذا رغب، وزهير إذا رغب، وعنترة إذا غضب".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ركب', 'ركب', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'طرب', 'طرب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'غضب', 'غضب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'رغب', 'رغب', FALSE);
    -- Question 25: q_ar_025
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من لقب بفتاك العرب؟', 'من لقب بفتاك العرب؟', 'لُقب بالفتاك لقتله الملك عمرو بن هند في عقر داره وأمام حراسه دفاعاً عن كرامة أمه.', 'لُقب بالفتاك لقتله الملك عمرو بن هند في عقر داره وأمام حراسه دفاعاً عن كرامة أمه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمرو بن كلثوم', 'عمرو بن كلثوم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمرو بن هند', 'عمرو بن هند', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'خالد بن جعفر', 'خالد بن جعفر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عروة', 'عروة', FALSE);
    -- Question 26: q_ar_026
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'اسم أم عمرو بن كلثوم؟', 'اسم أم عمرو بن كلثوم؟', 'هي ابنة المهلهل بن ربيعة، وكانت من أعز نساء العرب نفساً.', 'هي ابنة المهلهل بن ربيعة، وكانت من أعز نساء العرب نفساً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ليلى بنت مهلهل', 'ليلى بنت مهلهل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ليلى بنت كليب', 'ليلى بنت كليب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ليلى بنت تغلب', 'ليلى بنت تغلب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ليلى بنت معري', 'ليلى بنت معري', FALSE);
    -- Question 27: q_ar_027
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'ساد عمرو بن كلثوم قومه تغلب في حرب البسوس وهو ابن كم سنة؟', 'ساد عمرو بن كلثوم قومه تغلب في حرب البسوس وهو ابن كم سنة؟', 'عُرف عمرو بن كلثوم بالسيادة المبكرة، حيث ترأس قبيلته وهو في سن الخامسة عشرة.', 'عُرف عمرو بن كلثوم بالسيادة المبكرة، حيث ترأس قبيلته وهو في سن الخامسة عشرة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '15', '15', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '18', '18', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '17', '17', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '21', '21', FALSE);
    -- Question 28: q_ar_028
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'قصيدة عمرو بن كلثوم (المعلقة) نونية على بحر؟', 'قصيدة عمرو بن كلثوم (المعلقة) نونية على بحر؟', 'معلقته "ألا هبي بصحنك فاصبحينا" جاءت على بحر الوافر، وهو بحر يمتاز بالقوة والحماسة.', 'معلقته "ألا هبي بصحنك فاصبحينا" جاءت على بحر الوافر، وهو بحر يمتاز بالقوة والحماسة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الوافر', 'الوافر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'طويل', 'طويل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بسيط', 'بسيط', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'وجيز', 'وجيز', FALSE);
    -- Question 29: q_ar_029
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'زهير بن أبي سلمى ينتمي إلى قبيلة؟', 'زهير بن أبي سلمى ينتمي إلى قبيلة؟', 'ينتمي إلى قبيلة مزينة، لكنه عاش وتربى في قبيلة غطفان.', 'ينتمي إلى قبيلة مزينة، لكنه عاش وتربى في قبيلة غطفان.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المزينة', 'المزينة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'التميم', 'التميم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الكندة', 'الكندة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'التغلب', 'التغلب', FALSE);
    -- Question 30: q_ar_030
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', '"أمن أم أوفى دمنة لم تكلم؟" لمن هذا المطلع؟', '"أمن أم أوفى دمنة لم تكلم؟" لمن هذا المطلع؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'مطلع معلقة زهير بن أبي سلمى', 'مطلع معلقة زهير بن أبي سلمى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'مطلع معلقة عمرو بن كلثوم', 'مطلع معلقة عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'مطلع معلقة امرؤ القيس', 'مطلع معلقة امرؤ القيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مطلع حارث بن حلزة', 'مطلع حارث بن حلزة', FALSE);
    -- Question 31: q_ar_031
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'ليست من أسماء المعلقات؟', 'ليست من أسماء المعلقات؟', 'المعلقات تسمى السموط (العقود)، المذهبات (لكتابتها بالذهب)، السبع الطوال، لكن "القلادات" ليس مصطلحاً اصطلاحياً مشهوراً لها.', 'المعلقات تسمى السموط (العقود)، المذهبات (لكتابتها بالذهب)، السبع الطوال، لكن "القلادات" ليس مصطلحاً اصطلاحياً مشهوراً لها.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'السموط', 'السموط', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المذهبات', 'المذهبات', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'القلادات', 'القلادات', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'السبع الطوال', 'السبع الطوال', FALSE);
    -- Question 32: q_ar_032
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'لمن هو الذي بدأ معلقته بوصف الخمر؟', 'لمن هو الذي بدأ معلقته بوصف الخمر؟', 'خالف عمرو بن كلثوم عادة العرب بالبدء بالأطلال، وبدأ معلقته بطلب الخمر: "ألا هبي بصحنك فاصبحينا.. ولا تبقي خمور الأندرينا".', 'خالف عمرو بن كلثوم عادة العرب بالبدء بالأطلال، وبدأ معلقته بطلب الخمر: "ألا هبي بصحنك فاصبحينا.. ولا تبقي خمور الأندرينا".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'النابغة الذبياني', 'النابغة الذبياني', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم', 'عمرو بن كلثوم', TRUE);
    -- Question 33: q_ar_033
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'عصر الجاهلي الثاني يعتبر؟', 'عصر الجاهلي الثاني يعتبر؟', 'العصر الجاهلي الذي وصل إلينا أدبه (الجاهلية القريبة) يمتد لحوالي 150-200 سنة قبل الهجرة (622م).', 'العصر الجاهلي الذي وصل إلينا أدبه (الجاهلية القريبة) يمتد لحوالي 150-200 سنة قبل الهجرة (622م).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '450-622', '450-622', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '475-522', '475-522', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '475-622', '475-622', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '522-622', '522-622', FALSE);
    -- Question 34: q_ar_034
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'hard', 'تزوج زهير أم أوفى (ليلى)، ولكن لم يكن له منها أولاد فطلقها، واقترن بكبشة بنت عمار الغطفانية.. وأنجبا منها شاعران هما؟', 'تزوج زهير أم أوفى (ليلى)، ولكن لم يكن له منها أولاد فطلقها، واقترن بكبشة بنت عمار الغطفانية.. وأنجبا منها شاعران هما؟', 'زهير أنجب من زوجته كبشة ولدين صارا من كبار الشعراء، كعب بن زهير (صاحب قصيدة "بانت سعاد") وبجير بن زهير، وكلاهما أسلما.', 'زهير أنجب من زوجته كبشة ولدين صارا من كبار الشعراء، كعب بن زهير (صاحب قصيدة "بانت سعاد") وبجير بن زهير، وكلاهما أسلما.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كعب وبجير', 'كعب وبجير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كعب وبحير', 'كعب وبحير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كعب وزبير', 'كعب وزبير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كعب ورحيب', 'كعب ورحيب', FALSE);
    -- Question 35: q_ar_035
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'كان زهير؟', 'كان زهير؟', 'تذكر المصادر أن زهير بن أبي سلمى كان نصرانياً على مذهب أهل الشام، وكان في شعره إيمان باليوم الآخر والحساب، مما جعله أقرب للموحدين ("الحنفاء").', 'تذكر المصادر أن زهير بن أبي سلمى كان نصرانياً على مذهب أهل الشام، وكان في شعره إيمان باليوم الآخر والحساب، مما جعله أقرب للموحدين ("الحنفاء").', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'وثنياً', 'وثنياً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'مسلماً', 'مسلماً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'يهودياً', 'يهودياً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'نصرانياً (أو "متألهاً" يميل للتوحيد)', 'نصرانياً (أو "متألهاً" يميل للتوحيد)', TRUE);
    -- Question 36: q_ar_036
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'ليس من ألقاب زهير؟', 'ليس من ألقاب زهير؟', 'اشتهر زهير بـ الحكمة والصلح (لمدحه هرم بن سنان والحارث بن عوف)، ولقب بشاعر الأحناف (لميوله التوحيدية)، لكنه لم يشتهر بلقب "شاعر الوصف" كلقب علم عليه مقارنة بامرئ القيس.', 'اشتهر زهير بـ الحكمة والصلح (لمدحه هرم بن سنان والحارث بن عوف)، ولقب بشاعر الأحناف (لميوله التوحيدية)، لكنه لم يشتهر بلقب "شاعر الوصف" كلقب علم عليه مقارنة بامرئ القيس.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'شاعر الحكمة', 'شاعر الحكمة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'وشاعر الصلح', 'وشاعر الصلح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'وشاعر الأحناف', 'وشاعر الأحناف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'وشاعر الوصف', 'وشاعر الوصف', TRUE);
    -- Question 37: q_ar_037
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'أطلق عليه الأصمعي صاحب الحوليات (أو عبيد الشعر)؟', 'أطلق عليه الأصمعي صاحب الحوليات (أو عبيد الشعر)؟', 'أطلق الأصمعي على زهير وطبقته لقب "عبيد الشعر" لأنهم كانوا ينقحون قصائدهم لمدة عام كامل (حول)، فسميت قصائدهم بـ "الحوليات".', 'أطلق الأصمعي على زهير وطبقته لقب "عبيد الشعر" لأنهم كانوا ينقحون قصائدهم لمدة عام كامل (حول)، فسميت قصائدهم بـ "الحوليات".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'شاعر الحكمة', 'شاعر الحكمة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبيد الشعر', 'عبيد الشعر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'شاعر الأحناف', 'شاعر الأحناف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'قاضي الشعراء', 'قاضي الشعراء', FALSE);
    -- Question 38: q_ar_038
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'الشعراء الثلاثة المتقدمة (الطبقة الأولى) هم؟', 'الشعراء الثلاثة المتقدمة (الطبقة الأولى) هم؟', 'اتفق معظم النقاد القدامى (مثل ابن سلام الجمحي) على أن رؤوس شعراء الجاهلية هم: امرؤ القيس، زهير بن أبي سلمى، والنابعة الذبياني.', 'اتفق معظم النقاد القدامى (مثل ابن سلام الجمحي) على أن رؤوس شعراء الجاهلية هم: امرؤ القيس، زهير بن أبي سلمى، والنابعة الذبياني.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'امرؤ القيس، زهير، النابغة', 'امرؤ القيس، زهير، النابغة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'امرؤ القيس، زهير، عنترة', 'امرؤ القيس، زهير، عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'امرؤ القيس، زهير، خنساء', 'امرؤ القيس، زهير، خنساء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'امرؤ القيس، خنساء، النابغة', 'امرؤ القيس، خنساء، النابغة', FALSE);
    -- Question 39: q_ar_039
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الذي نشأ في أقارب أبيه من بني غطفان ولزم بشامة بن الغدير خال أبيه؟', 'من هو الذي نشأ في أقارب أبيه من بني غطفان ولزم بشامة بن الغدير خال أبيه؟', 'بشامة بن الغدير كان خال والد زهير، وكان شاعراً حكيماً ومقتدراً، ورث منه زهير الحكمة والشعر والمال.', 'بشامة بن الغدير كان خال والد زهير، وكان شاعراً حكيماً ومقتدراً، ورث منه زهير الحكمة والشعر والمال.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    -- Question 40: q_ar_040
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'hard', 'من هو الذي نظم أشعاره في أربعة أشهر ويهذبها في أربعة أشهر ثم يعرضها على خاصة الشعراء في أربعة أشهر فلا ينشدها الناس إلا بعد حول؟', 'من هو الذي نظم أشعاره في أربعة أشهر ويهذبها في أربعة أشهر ثم يعرضها على خاصة الشعراء في أربعة أشهر فلا ينشدها الناس إلا بعد حول؟', 'هذا هو المنهج الذي اتبعه زهير في نظم "الحوليات"، لضمان خلو الشعر من العيوب، ولهذا لُقب بـ "عبد الشعر" لدقة عمله.', 'هذا هو المنهج الذي اتبعه زهير في نظم "الحوليات"، لضمان خلو الشعر من العيوب، ولهذا لُقب بـ "عبد الشعر" لدقة عمله.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كعب بن زهير', 'كعب بن زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الخنساء', 'الخنساء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الشنفرى', 'الشنفرى', FALSE);
    -- Question 41: q_ar_041
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'كان رجلاً مقعداً عقيماً حكيماً قد اشتهر بسداد الرأي وجودة الشعر ووفرة المال.. من؟', 'كان رجلاً مقعداً عقيماً حكيماً قد اشتهر بسداد الرأي وجودة الشعر ووفرة المال.. من؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأعشى قيس', 'الأعشى قيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشامة بن الغدير (المقصود هنا في سياق السؤال هو من تعلم منه زهير، لكن إذا كان الاختيار من الشعراء فالإجابة هي حارث بن حلزة في سياق معلقته)', 'بشامة بن الغدير (المقصود هنا في سياق السؤال هو من تعلم منه زهير، لكن إذا كان الاختيار من الشعراء فالإجابة هي حارث بن حلزة في سياق معلقته)', TRUE);
    -- Question 42: q_ar_042
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'متى توفي عمرو بن كلثوم؟', 'متى توفي عمرو بن كلثوم؟', 'توفي عمرو بن كلثوم حوالي عام 584م، وقد عمر طويلاً (يقال عاش 150 سنة).', 'توفي عمرو بن كلثوم حوالي عام 584م، وقد عمر طويلاً (يقال عاش 150 سنة).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '580', '580', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '584', '584', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '564', '564', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '684', '684', FALSE);
    -- Question 43: q_ar_043
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'متى توفي عنترة بن الشداد؟', 'متى توفي عنترة بن الشداد؟', 'توفي عنترة بن شداد حوالي عام 615م (أي قبيل الهجرة النبوية بفترة قصيرة).', 'توفي عنترة بن شداد حوالي عام 615م (أي قبيل الهجرة النبوية بفترة قصيرة).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '584', '584', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '335', '335', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '325', '325', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '615', '615', TRUE);
    -- Question 44: q_ar_044
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'اشترك عنترة في حرب؟', 'اشترك عنترة في حرب؟', 'كان عنترة بطل قبيلة "عبس" في حربها ضد "ذبيان"، وهي الحرب الشهيرة المعروفة بـ داحس والغبراء.', 'كان عنترة بطل قبيلة "عبس" في حربها ضد "ذبيان"، وهي الحرب الشهيرة المعروفة بـ داحس والغبراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'داحس والغبراء', 'داحس والغبراء', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البسوس', 'البسوس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حرب الأوس والخزرج', 'حرب الأوس والخزرج', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'حرب يثرب', 'حرب يثرب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_5', 'بالتوفيق في اختبارك! هذه المعلومات أساسية جداً في قسم الأدب الجاهلي.', 'بالتوفيق في اختبارك! هذه المعلومات أساسية جداً في قسم الأدب الجاهلي.', FALSE);
    -- Question 45: q_ar_045
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو رائد الشعر الملحمي من أصحاب المعلقات؟', 'من هو رائد الشعر الملحمي من أصحاب المعلقات؟', 'يُعتبر الحارث بن حلزة رائد الشعر الملحمي والخطابي في معلقته، لأن قصيدته كانت بمثابة دفاع "ملحمي" عن قبيلته (بكر) أمام الملك عمرو بن هند، واتسمت بطول النفس التاريخي والافتخار.', 'يُعتبر الحارث بن حلزة رائد الشعر الملحمي والخطابي في معلقته، لأن قصيدته كانت بمثابة دفاع "ملحمي" عن قبيلته (بكر) أمام الملك عمرو بن هند، واتسمت بطول النفس التاريخي والافتخار.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'لبيد بن أبي ربيعة', 'لبيد بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حارث بن حلزة', 'حارث بن حلزة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    -- Question 46: q_ar_046
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'ليست من كنية عنترة بن شداد العبسي؟', 'ليست من كنية عنترة بن شداد العبسي؟', 'كنيته الأشهر هي أبو الفوارس، ولقب بـ أبو المغلس لجرأته في الغلس (ظلمة آخر الليل)، أما "أبو وهب" فهي كنية امرئ القيس وليست لعنترة.', 'كنيته الأشهر هي أبو الفوارس، ولقب بـ أبو المغلس لجرأته في الغلس (ظلمة آخر الليل)، أما "أبو وهب" فهي كنية امرئ القيس وليست لعنترة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو الفوارس', 'أبو الفوارس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو المعايش', 'أبو المعايش', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو المغلس', 'أبو المغلس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو وهب', 'أبو وهب', TRUE);
    -- Question 47: q_ar_047
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو المعروف بشعره الجميل وغزله العفيف بعبلة؟', 'من هو المعروف بشعره الجميل وغزله العفيف بعبلة؟', 'اشتهر عنترة بحبه لابنة عمه عبلة، وكان شعره فيها نموذجاً للغزل العفيف الصادق المرتبط بالفروسية.', 'اشتهر عنترة بحبه لابنة عمه عبلة، وكان شعره فيها نموذجاً للغزل العفيف الصادق المرتبط بالفروسية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عنترة بن شداد', 'عنترة بن شداد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'النابغة الذبياني', 'النابغة الذبياني', FALSE);
    -- Question 48: q_ar_048
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الشاعر الشهير الذي قال لأبيه: "العبد لا يحسن الكر إنما يحسن الحلاب والصر"؟', 'من هو الشاعر الشهير الذي قال لأبيه: "العبد لا يحسن الكر إنما يحسن الحلاب والصر"؟', 'قيلت هذه العبارة عندما طلب منه والده شداد المشاركة في الحرب (الكر)، فرد عنترة بذلك لأنه كان ما يزال عبداً في نظر أبيه، فقال له أبوه: "كر وأنت حر"، فاعتزل العبودية من يومها.', 'قيلت هذه العبارة عندما طلب منه والده شداد المشاركة في الحرب (الكر)، فرد عنترة بذلك لأنه كان ما يزال عبداً في نظر أبيه، فقال له أبوه: "كر وأنت حر"، فاعتزل العبودية من يومها.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'امرؤ القيس', 'امرؤ القيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة بن شداد', 'عنترة بن شداد', TRUE);
    -- Question 49: q_ar_049
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الذي لقب بـ "الفلحاء"؟', 'من هو الذي لقب بـ "الفلحاء"؟', 'لُقب عنترة بـ "عنترة الفلحاء" لوجود شق (فلح) في شفته.', 'لُقب عنترة بـ "عنترة الفلحاء" لوجود شق (فلح) في شفته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عنترة', 'عنترة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير', 'زهير', FALSE);
    -- Question 50: q_ar_050
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'عنترة معناه؟', 'عنترة معناه؟', 'في اللغة، "العنترة" هي الذباب الأزرق الذي يقع على الدواب، وقيل أيضاً هو الشجاع في الحرب.', 'في اللغة، "العنترة" هي الذباب الأزرق الذي يقع على الدواب، وقيل أيضاً هو الشجاع في الحرب.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الذباب الأحمر', 'الذباب الأحمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الذباب الأبيض', 'الذباب الأبيض', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الذباب الأسود', 'الذباب الأسود', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الذباب الأزرق', 'الذباب الأزرق', TRUE);
    -- Question 51: q_ar_051
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'معلقة عنترة ميمية، تقع فيها نحو .......... بيتاً من البحر الكامل؟', 'معلقة عنترة ميمية، تقع فيها نحو .......... بيتاً من البحر الكامل؟', 'معلقة عنترة (هل غادر الشعراء...) تبلغ في معظم الروايات 79 بيتاً، وهي من بحر الكامل.', 'معلقة عنترة (هل غادر الشعراء...) تبلغ في معظم الروايات 79 بيتاً، وهي من بحر الكامل.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '79', '79', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '81', '81', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '105', '105', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '110', '110', FALSE);
    -- Question 52: q_ar_052
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'قال عمر رضي الله عنه: "كان لا يمدح الرجل إلا بما هو فيه" لـ....؟', 'قال عمر رضي الله عنه: "كان لا يمدح الرجل إلا بما هو فيه" لـ....؟', 'كان عمر بن الخطاب معجباً بزهير لأنه لا يبالغ في المديح الكاذب، بل يصف الممدوح بخصاله الحقيقية، خاصة في مدحه لهرم بن سنان.', 'كان عمر بن الخطاب معجباً بزهير لأنه لا يبالغ في المديح الكاذب، بل يصف الممدوح بخصاله الحقيقية، خاصة في مدحه لهرم بن سنان.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'لبيد بن ربيعة', 'لبيد بن ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'طرفة بن العبد', 'طرفة بن العبد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'امرؤ القيس', 'امرؤ القيس', FALSE);
    -- Question 53: q_ar_053
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الذي يدور في كثير من شعره حول سلم بين القبيلتين عبس وذبيان؟', 'من هو الذي يدور في كثير من شعره حول سلم بين القبيلتين عبس وذبيان؟', 'نظم زهير معلقته خصيصاً للإشادة بالصلح الذي تم بين عبس وذبيان بفضل الحارث بن عوف وهرم بن سنان، اللذين تحملا ديات القتلى لإنهاء حرب داحس والغبراء.', 'نظم زهير معلقته خصيصاً للإشادة بالصلح الذي تم بين عبس وذبيان بفضل الحارث بن عوف وهرم بن سنان، اللذين تحملا ديات القتلى لإنهاء حرب داحس والغبراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن هاني', 'ابن هاني', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الخنساء', 'الخنساء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', TRUE);
    -- Question 54: q_ar_054
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الذي لقب بـ "صاحب الحوليات" و "شاعر الحكمة"؟', 'من هو الذي لقب بـ "صاحب الحوليات" و "شاعر الحكمة"؟', 'الحوليات لأن قصيدته كانت تستغرق سنة (حولاً) لتخرج للناس، والحكمة لانتشار المواعظ والأمثال في شعره.', 'الحوليات لأن قصيدته كانت تستغرق سنة (حولاً) لتخرج للناس، والحكمة لانتشار المواعظ والأمثال في شعره.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الشنفرى', 'الشنفرى', FALSE);
    -- Question 55: q_ar_055
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', '"إنه كان ليحسن فيكم القول" قال عمر رضي الله عنه لـ...؟', '"إنه كان ليحسن فيكم القول" قال عمر رضي الله عنه لـ...؟', 'قالها عمر بن الخطاب لأحد أولاد هرم بن سنان عندما سألهم عما أعطاهم زهير (الشعر) وما أعطوه (المال)، فقال عمر: "ذهب ما أعطيتموه وبقي ما أعطاكم".', 'قالها عمر بن الخطاب لأحد أولاد هرم بن سنان عندما سألهم عما أعطاهم زهير (الشعر) وما أعطوه (المال)، فقال عمر: "ذهب ما أعطيتموه وبقي ما أعطاكم".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'آل هرم بن سنان (بشأن زهير)', 'آل هرم بن سنان (بشأن زهير)', TRUE);
    -- Question 56: q_ar_056
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'لمن قيل "لو أبطأ الإسلام لأكلت تغلب الناس"؟', 'لمن قيل "لو أبطأ الإسلام لأكلت تغلب الناس"؟', 'قيلت في قبيلة تغلب لقوتهم وكثرة عددهم وبأسهم الشديد الذي صوره عمرو بن كلثوم في معلقته، وكانوا مسيحيين فأسلموا لاحقاً.', 'قيلت في قبيلة تغلب لقوتهم وكثرة عددهم وبأسهم الشديد الذي صوره عمرو بن كلثوم في معلقته، وكانوا مسيحيين فأسلموا لاحقاً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'طرفة بن العبد', 'طرفة بن العبد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم (أو قبيلته تغلب)', 'عمرو بن كلثوم (أو قبيلته تغلب)', TRUE);
    -- Question 57: q_ar_057
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'لامية العرب الشنفرى في بحر؟', 'لامية العرب الشنفرى في بحر؟', 'نُظمت قصيدة لامية العرب (أقيموا بني قومي صدور مطيكم) على بحر الطويل، وهو البحر الذي يناسب القصائد الطويلة ذات النفس الملحمي والحزين.', 'نُظمت قصيدة لامية العرب (أقيموا بني قومي صدور مطيكم) على بحر الطويل، وهو البحر الذي يناسب القصائد الطويلة ذات النفس الملحمي والحزين.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الطويل', 'الطويل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البسيط', 'البسيط', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الخفيف', 'الخفيف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الكامل', 'الكامل', FALSE);
    -- Question 58: q_ar_058
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'عدد أبيات لامية العرب الشنفرى؟', 'عدد أبيات لامية العرب الشنفرى؟', 'يبلغ عدد أبيات لامية العرب في معظم الروايات 68 بيتاً، وهي من عيون الشعر العربي التي تصف حياة الصعلوك في الصحراء.', 'يبلغ عدد أبيات لامية العرب في معظم الروايات 68 بيتاً، وهي من عيون الشعر العربي التي تصف حياة الصعلوك في الصحراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '58', '58', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '68', '68', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '72', '72', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '48', '48', FALSE);
    -- Question 59: q_ar_059
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'متى توفي الشنفرى؟', 'متى توفي الشنفرى؟', 'توفي الشنفرى حوالي عام 525م، أي في النصف الأول من القرن السادس الميلادي، قبل الإسلام بنحو قرن.', 'توفي الشنفرى حوالي عام 525م، أي في النصف الأول من القرن السادس الميلادي، قبل الإسلام بنحو قرن.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '530', '530', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '540', '540', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '525', '525', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '625', '625', FALSE);
    -- Question 60: q_ar_060
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من قال "علموا أولادكم قصيدة الشنفرى فإنها تعلمهم مكارم الأخلاق"؟', 'من قال "علموا أولادكم قصيدة الشنفرى فإنها تعلمهم مكارم الأخلاق"؟', 'يُروى عن عمر بن الخطاب رضي الله عنه إعجابه الشديد بلامية العرب لما فيها من قيم الصبر، والجلد، والاعتزاز بالنفس، والأنفة.', 'يُروى عن عمر بن الخطاب رضي الله عنه إعجابه الشديد بلامية العرب لما فيها من قيم الصبر، والجلد، والاعتزاز بالنفس، والأنفة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'علي رضي الله عنه', 'علي رضي الله عنه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمر رضي الله عنه', 'عمر رضي الله عنه', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عثمان رضي الله عنه', 'عثمان رضي الله عنه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو بكر رضي الله عنه', 'أبو بكر رضي الله عنه', FALSE);
    -- Question 61: q_ar_061
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي مات مقتولاً على يد أحد أفراد قبيلة بني سلامان التي انتقم منها وقتل تسعة وتسعين من رجالها؟', 'من هو الذي مات مقتولاً على يد أحد أفراد قبيلة بني سلامان التي انتقم منها وقتل تسعة وتسعين من رجالها؟', 'كان الشنفرى قد آلى على نفسه أن يقتل مئة من بني سلامان ثأراً لنفسه، فقتل 99 في حياته، وتقول الأسطورة إن المئة تم بسببه بعد موته عندما ركل رجل من القبيلة جمجمة الشنفرى فدخلت شظية في رجله فمات منها.', 'كان الشنفرى قد آلى على نفسه أن يقتل مئة من بني سلامان ثأراً لنفسه، فقتل 99 في حياته، وتقول الأسطورة إن المئة تم بسببه بعد موته عندما ركل رجل من القبيلة جمجمة الشنفرى فدخلت شظية في رجله فمات منها.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الشنفرى', 'الشنفرى', TRUE);
    -- Question 62: q_ar_062
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'متى توفي تأبط شراً؟', 'متى توفي تأبط شراً؟', 'توفي تأبط شراً (ثابت بن جابر) حوالي عام 530م، وهو من كبار شعراء الصعاليك وصديق الشنفرى.', 'توفي تأبط شراً (ثابت بن جابر) حوالي عام 530م، وهو من كبار شعراء الصعاليك وصديق الشنفرى.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '635', '635', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '530', '530', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '540', '540', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '535', '535', FALSE);
    -- Question 63: q_ar_063
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'ليس من شعراء الصعاليك؟', 'ليس من شعراء الصعاليك؟', 'تأبط شراً والشنفرى والسليك هم أشهر صعاليك الجاهلية. أما زهير بن جناب فكان سيداً وخطيباً من سادات قبيلة كلب، وليس من الصعاليك.', 'تأبط شراً والشنفرى والسليك هم أشهر صعاليك الجاهلية. أما زهير بن جناب فكان سيداً وخطيباً من سادات قبيلة كلب، وليس من الصعاليك.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ثابت بن جابر (تأبط شراً)', 'ثابت بن جابر (تأبط شراً)', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ثابت بن أوس (الشنفرى)', 'ثابت بن أوس (الشنفرى)', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'السليك بن السلكة', 'السليك بن السلكة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير بن جناب', 'زهير بن جناب', TRUE);
    -- Question 64: q_ar_064
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي كان من الصعاليك حاد البصر والسمع يلحق بالخيل؟', 'من هو الذي كان من الصعاليك حاد البصر والسمع يلحق بالخيل؟', 'لُقب السليك بن السلكة بـ "رئبال الفلوات"، واشتهر بسرعة العدو حتى قيل إنه كان يسبق الخيل، وكان خبيراً بمسالك الصحراء.', 'لُقب السليك بن السلكة بـ "رئبال الفلوات"، واشتهر بسرعة العدو حتى قيل إنه كان يسبق الخيل، وكان خبيراً بمسالك الصحراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'السليك بن السلكة', 'السليك بن السلكة', TRUE);
    -- Question 65: q_ar_065
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي لقب بـ "أم العيال" أو "عروة الصعاليك"؟', 'من هو الذي لقب بـ "أم العيال" أو "عروة الصعاليك"؟', 'لُقب عروة بن الورد بـ "أم العيال" لأنه كان يجمع الفقراء والصعاليك فيعتني بهم ويطعمهم من غنائمه، وكان يمثل الجانب الإنساني والاجتماعي في حركة الصعلكة.', 'لُقب عروة بن الورد بـ "أم العيال" لأنه كان يجمع الفقراء والصعاليك فيعتني بهم ويطعمهم من غنائمه، وكان يمثل الجانب الإنساني والاجتماعي في حركة الصعلكة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عنترة', 'عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عروة بن الورد', 'عروة بن الورد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير', 'زهير', FALSE);
    -- Question 66: q_ar_066
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي أشهر فرسان العرب واشتهر بشعر الفروسية؟', 'من هو الذي أشهر فرسان العرب واشتهر بشعر الفروسية؟', 'عنترة بن شداد هو الرمز الأول للفروسية والشجاعة في الأدب الجاهلي، واقترن شعره بوصف المعارك والبطولة والذود عن القبيلة.', 'عنترة بن شداد هو الرمز الأول للفروسية والشجاعة في الأدب الجاهلي، واقترن شعره بوصف المعارك والبطولة والذود عن القبيلة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الخنساء', 'الخنساء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة', 'عنترة', TRUE);
    -- Question 67: q_ar_067
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "ابن الصحراء"؟', 'من هو الذي لُقب بـ "ابن الصحراء"؟', 'لُقب الشنفرى بهذا اللقب لشدة توحشه وانعزاله في القفار، حيث كان يفضل العيش مع وحوش الفلاة على العيش مع البشر، وصوّر ذلك ببراعة في لاميته.', 'لُقب الشنفرى بهذا اللقب لشدة توحشه وانعزاله في القفار، حيث كان يفضل العيش مع وحوش الفلاة على العيش مع البشر، وصوّر ذلك ببراعة في لاميته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- الشنفرى', 'أ- الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- عنترة', 'ب- عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- تأبط شراً', 'ت- تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- عروة بن الورد', 'ث- عروة بن الورد', FALSE);
    -- Question 68: q_ar_068
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "ابن الطبيعة العربية البدوية"؟', 'من هو الذي لُقب بـ "ابن الطبيعة العربية البدوية"؟', 'يعود هذا اللقب لارتباطه الوثيق بمظاهر الطبيعة الصحراوية من حيوانات (الذئب، النمر، الضبع) وتضاريس، وصدق تمثيله للحياة البدوية القاسية.', 'يعود هذا اللقب لارتباطه الوثيق بمظاهر الطبيعة الصحراوية من حيوانات (الذئب، النمر، الضبع) وتضاريس، وصدق تمثيله للحياة البدوية القاسية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- الحطيئة', 'أ- الحطيئة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- الشنفرى', 'ب- الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- تأبط شراً', 'ت- تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- كعب بن زهير', 'ث- كعب بن زهير', FALSE);
    -- Question 69: q_ar_069
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "أم العيال" أو "عروة الصعاليك"؟', 'من هو الذي لُقب بـ "أم العيال" أو "عروة الصعاليك"؟', 'لُقب بـ "أم العيال" لأنه كان يجمع الفقراء والعجزة في حظيرة ويطعمهم من غنائمه، فكان بمثابة الراعي والوالد لهم.', 'لُقب بـ "أم العيال" لأنه كان يجمع الفقراء والعجزة في حظيرة ويطعمهم من غنائمه، فكان بمثابة الراعي والوالد لهم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- عنترة', 'أ- عنترة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- تأبط شراً', 'ب- تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- عروة بن الورد', 'ت- عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- زهير', 'ث- زهير', FALSE);
    -- Question 70: q_ar_070
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي ولد لأب عربي وأم حبشية؟', 'من هو الذي ولد لأب عربي وأم حبشية؟', 'والده هو شداد العبسي وأمه هي "زبيبة" الحبشية، وبسبب سواد لونه ونظام القبيلة آنذاك، عُدَّ عبداً حتى أثبت فروسيته وحصل على حريته.', 'والده هو شداد العبسي وأمه هي "زبيبة" الحبشية، وبسبب سواد لونه ونظام القبيلة آنذاك، عُدَّ عبداً حتى أثبت فروسيته وحصل على حريته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- الأعشى قيس', 'أ- الأعشى قيس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- حارث بن حلزة', 'ب- حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- عنترة بن شداد', 'ت- عنترة بن شداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- امرؤ القيس', 'ث- امرؤ القيس', FALSE);
    -- Question 71: q_ar_071
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'الاسم الكامل للشنفرى هو؟', 'الاسم الكامل للشنفرى هو؟', 'هو ثابت بن أوس الأزدي، و"الشنفرى" لقب لُقب به لحدة في خلقه أو لعظم شفتيه.', 'هو ثابت بن أوس الأزدي، و"الشنفرى" لقب لُقب به لحدة في خلقه أو لعظم شفتيه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- توبة بن الحمير', 'أ- توبة بن الحمير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- حاجز بن عوف', 'ب- حاجز بن عوف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- ثابت بن جابر', 'ت- ثابت بن جابر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- ثابت بن أوس', 'ث- ثابت بن أوس', FALSE);
    -- Question 72: q_ar_072
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'الاسم الكامل لتأبط شراً هو؟', 'الاسم الكامل لتأبط شراً هو؟', 'هو ثابت بن جابر الفهمي، ولُقب بـ "تأبط شراً" لأنه خرج يوماً واضعاً سيفاً تحت إبطه، فقالت أمه: "تأبط شراً".', 'هو ثابت بن جابر الفهمي، ولُقب بـ "تأبط شراً" لأنه خرج يوماً واضعاً سيفاً تحت إبطه، فقالت أمه: "تأبط شراً".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- ثابت بن جابر', 'أ- ثابت بن جابر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- ثابت بن أوس', 'ب- ثابت بن أوس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- حسان بن ثابت', 'ت- حسان بن ثابت', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- زهير بن جناب', 'ث- زهير بن جناب', FALSE);
    -- Question 73: q_ar_073
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'الشنفرى ينتمي إلى قبيلة؟', 'الشنفرى ينتمي إلى قبيلة؟', 'هو أزدي من اليمن، ولكن نشأته كانت في قبيلة "بني سلامان" من قبيلة فهم بعد أن أُسر صغيراً.', 'هو أزدي من اليمن، ولكن نشأته كانت في قبيلة "بني سلامان" من قبيلة فهم بعد أن أُسر صغيراً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- فهم', 'أ- فهم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- الأزد', 'ب- الأزد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- عبس', 'ت- عبس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- تغلب', 'ث- تغلب', FALSE);
    -- Question 74: q_ar_074
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'عروة بن الورد ينتمي إلى قبيلة؟', 'عروة بن الورد ينتمي إلى قبيلة؟', 'هو عروة بن الورد العبسي، وهو ابن عم الشاعر الفارس عنترة بن شداد.', 'هو عروة بن الورد العبسي، وهو ابن عم الشاعر الفارس عنترة بن شداد.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- فهم', 'أ- فهم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- الأزد', 'ب- الأزد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- عبس', 'ت- عبس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- تغلب', 'ث- تغلب', FALSE);
    -- Question 75: q_ar_075
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي نشأ وعاش بين بني سلامان الذين أسروه وهو طفل صغير؟', 'من هو الذي نشأ وعاش بين بني سلامان الذين أسروه وهو طفل صغير؟', 'نشأ بينهم معتقداً أنه منهم، حتى أهانته ابنة الرجل الذي ربه، فعلم بالحقيقة ونذر أن يقتل منهم مئة رجل انتقاماً.', 'نشأ بينهم معتقداً أنه منهم، حتى أهانته ابنة الرجل الذي ربه، فعلم بالحقيقة ونذر أن يقتل منهم مئة رجل انتقاماً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- الشنفرى', 'أ- الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- تأبط شراً', 'ب- تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- عمرو بن كلثوم', 'ت- عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- النابغة الذبياني', 'ث- النابغة الذبياني', FALSE);
    -- Question 76: q_ar_076
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي كان من أصحاب الصعاليك ولكن كان من أشراف العرب وأسيادهم؟', 'من هو الذي كان من أصحاب الصعاليك ولكن كان من أشراف العرب وأسيادهم؟', 'لم يكن عروة صعلوكاً بسبب طرده من القبيلة أو سواد لونه، بل كان سيداً اختار الصعلكة كمنهج لتوزيع الثروة ومساعدة الفقراء.', 'لم يكن عروة صعلوكاً بسبب طرده من القبيلة أو سواد لونه، بل كان سيداً اختار الصعلكة كمنهج لتوزيع الثروة ومساعدة الفقراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- الشنفرى', 'أ- الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- تأبط شراً', 'ب- تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- عروة بن الورد', 'ت- عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- السليك بن السلكة', 'ث- السليك بن السلكة', FALSE);
    -- Question 77: q_ar_077
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي كان من دهاة العرب؟', 'من هو الذي كان من دهاة العرب؟', 'عُرف بالدهاء الشديد في الغزو والقدرة على التخلص من الأسر والمواقف الصعبة بحيل ذكية.', 'عُرف بالدهاء الشديد في الغزو والقدرة على التخلص من الأسر والمواقف الصعبة بحيل ذكية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- حارث بن حلزة', 'أ- حارث بن حلزة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- تأبط شراً', 'ب- تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- الشنفرى', 'ت- الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- عروة بن الورد', 'ث- عروة بن الورد', FALSE);
    -- Question 78: q_ar_078
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "رفيق الوعول والغزلان" لسرعته؟', 'من هو الذي لُقب بـ "رفيق الوعول والغزلان" لسرعته؟', 'كان سريع العدو جداً، وقادراً على تسلق الجبال الوعرة والعيش مع الحيوانات البرية في الأماكن التي لا يصل إليها البشر.', 'كان سريع العدو جداً، وقادراً على تسلق الجبال الوعرة والعيش مع الحيوانات البرية في الأماكن التي لا يصل إليها البشر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- عنترة', 'أ- عنترة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- تأبط شراً', 'ب- تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- حارث بن حلزة', 'ت- حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- لبيد بن أبي ربيعة', 'ث- لبيد بن أبي ربيعة', FALSE);
    -- Question 79: q_ar_079
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من قال "من قال إن حاتماً أسمح الناس فقد ظلم عروة بن الورد"؟', 'من قال "من قال إن حاتماً أسمح الناس فقد ظلم عروة بن الورد"؟', 'كان معاوية يرى أن كرم عروة بن الورد الذي يشارك فيه الفقراء غنائمه ودمه أسمى من كرم حاتم الطائي التقليدي.', 'كان معاوية يرى أن كرم عروة بن الورد الذي يشارك فيه الفقراء غنائمه ودمه أسمى من كرم حاتم الطائي التقليدي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ- أبو سفيان', 'أ- أبو سفيان', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب- عبد الملك بن مروان', 'ب- عبد الملك بن مروان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ت- معاوية بن أبي سفيان', 'ت- معاوية بن أبي سفيان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ث- هشام بن عبد الملك', 'ث- هشام بن عبد الملك', FALSE);
    -- Question 80: q_ar_080
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "ابن الصحراء"؟', 'من هو الذي لُقب بـ "ابن الصحراء"؟', 'لُقب الشنفرى بهذا اللقب لشدة توحشه وانعزاله في القفار، حيث كان يفضل العيش مع وحوش الفلاة على العيش مع البشر، وصوّر ذلك ببراعة في لاميته الشهيرة (لامية العرب).', 'لُقب الشنفرى بهذا اللقب لشدة توحشه وانعزاله في القفار، حيث كان يفضل العيش مع وحوش الفلاة على العيش مع البشر، وصوّر ذلك ببراعة في لاميته الشهيرة (لامية العرب).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الشنفرى', 'الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة', 'عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    -- Question 81: q_ar_081
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "ابن الطبيعة العربية البدوية"؟', 'من هو الذي لُقب بـ "ابن الطبيعة العربية البدوية"؟', 'يعود هذا اللقب لارتباطه الوثيق بمظاهر الطبيعة الصحراوية من حيوانات (مثل الذئب والضبع) وتضاريس، وصدق تمثيله للحياة البدوية القاسية في شعره.', 'يعود هذا اللقب لارتباطه الوثيق بمظاهر الطبيعة الصحراوية من حيوانات (مثل الذئب والضبع) وتضاريس، وصدق تمثيله للحياة البدوية القاسية في شعره.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الشنفرى', 'الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كعب بن زهير', 'كعب بن زهير', FALSE);
    -- Question 82: q_ar_082
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "رفيق الوعول والغزلان"؟', 'من هو الذي لُقب بـ "رفيق الوعول والغزلان"؟', 'لُقب بذلك لسرعته الفائقة وقدرته على تسلق الجبال الوعرة والعيش في القمم مع الحيوانات البرية (الوعول) بعيداً عن أعين الناس.', 'لُقب بذلك لسرعته الفائقة وقدرته على تسلق الجبال الوعرة والعيش في القمم مع الحيوانات البرية (الوعول) بعيداً عن أعين الناس.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عنترة', 'عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'لبيد بن أبي ربيعة', 'لبيد بن أبي ربيعة', FALSE);
    -- Question 83: q_ar_083
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي ولد لأب عربي وأم حبشية؟', 'من هو الذي ولد لأب عربي وأم حبشية؟', 'والده هو شداد العبسي وأمه هي "زبيبة" الحبشية. وبسبب سواد لونه ونظام القبيلة الجاهلي، لم يعترف به والده في البداية وعُدَّ عبداً حتى أثبت شجاعته في الحرب فحرره والده.', 'والده هو شداد العبسي وأمه هي "زبيبة" الحبشية. وبسبب سواد لونه ونظام القبيلة الجاهلي، لم يعترف به والده في البداية وعُدَّ عبداً حتى أثبت شجاعته في الحرب فحرره والده.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأعشى قيس', 'الأعشى قيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عنترة بن شداد', 'عنترة بن شداد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'امرؤ القيس', 'امرؤ القيس', FALSE);
    -- Question 84: q_ar_084
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'الاسم الكامل للشنفرى هو؟', 'الاسم الكامل للشنفرى هو؟', 'هو ثابت بن أوس الأزدي، و"الشنفرى" لقب لُقب به لحدة في خلقه أو لعظم شفتيه، وهو صاحب (لامية العرب).', 'هو ثابت بن أوس الأزدي، و"الشنفرى" لقب لُقب به لحدة في خلقه أو لعظم شفتيه، وهو صاحب (لامية العرب).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'توبة بن الحمير', 'توبة بن الحمير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حاجز بن عوف', 'حاجز بن عوف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ثابت بن جابر', 'ثابت بن جابر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ثابت بن أوس', 'ثابت بن أوس', TRUE);
    -- Question 85: q_ar_085
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'الاسم الكامل لتأبط شراً هو؟', 'الاسم الكامل لتأبط شراً هو؟', 'هو ثابت بن جابر الفهمي، ولُقب بـ "تأبط شراً" لاصطحابه السيف دائماً تحت إبطه، وهو من أشهر عداءي العرب وصعاليكهم.', 'هو ثابت بن جابر الفهمي، ولُقب بـ "تأبط شراً" لاصطحابه السيف دائماً تحت إبطه، وهو من أشهر عداءي العرب وصعاليكهم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ثابت بن جابر', 'ثابت بن جابر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ثابت بن أوس', 'ثابت بن أوس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حسان بن ثابت', 'حسان بن ثابت', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير بن جناب', 'زهير بن جناب', FALSE);
    -- Question 86: q_ar_086
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'الشنفرى ينتمي إلى قبيلة؟', 'الشنفرى ينتمي إلى قبيلة؟', 'هو أزدي من اليمن، ولكن نشأته كانت في قبيلة "بني سلامان" من قبيلة فهم بعد أن أُسر وهو طفل صغير.', 'هو أزدي من اليمن، ولكن نشأته كانت في قبيلة "بني سلامان" من قبيلة فهم بعد أن أُسر وهو طفل صغير.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'فهم', 'فهم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأزد', 'الأزد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عبس', 'عبس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'تغلب', 'تغلب', FALSE);
    -- Question 87: q_ar_087
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'عروة بن الورد ينتمي إلى قبيلة؟', 'عروة بن الورد ينتمي إلى قبيلة؟', 'هو عروة بن الورد العبسي، من قبيلة عبس العدنانية، وهو ابن عم الشاعر الفارس عنترة بن شداد.', 'هو عروة بن الورد العبسي، من قبيلة عبس العدنانية، وهو ابن عم الشاعر الفارس عنترة بن شداد.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'فهم', 'فهم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأزد', 'الأزد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عبس', 'عبس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'تغلب', 'تغلب', FALSE);
    -- Question 88: q_ar_088
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي نشأ وعاش بين بني سلامان من بني فهم الذين أسروه وهو طفل صغير؟', 'من هو الذي نشأ وعاش بين بني سلامان من بني فهم الذين أسروه وهو طفل صغير؟', 'نشأ بينهم وهو يظن أنه أحدهم، حتى علم بحقيقة أسره، فنذر أن يقتل من بني سلامان مئة رجل ثأراً لكرامته.', 'نشأ بينهم وهو يظن أنه أحدهم، حتى علم بحقيقة أسره، فنذر أن يقتل من بني سلامان مئة رجل ثأراً لكرامته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الشنفرى', 'الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'النابغة الذبياني', 'النابغة الذبياني', FALSE);
    -- Question 89: q_ar_089
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'ولد عروة بن الورد في؟', 'ولد عروة بن الورد في؟', 'نجد كانت الموطن الأساسي لقبيلة عبس التي ينتمي إليها عروة، وفي بواديها نشأت بطولاته وشعره.', 'نجد كانت الموطن الأساسي لقبيلة عبس التي ينتمي إليها عروة، وفي بواديها نشأت بطولاته وشعره.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'نجد', 'نجد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'اليمامة', 'اليمامة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'العراق', 'العراق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مكة', 'مكة', FALSE);
    -- Question 90: q_ar_090
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي كان من دهاة العرب؟', 'من هو الذي كان من دهاة العرب؟', 'عُرف بالدهاء والمكر في الغزو والقدرة العجيبة على التخلص من المآزق والأسر بحيل ذكية، كما عُرف بسرعة عدوه.', 'عُرف بالدهاء والمكر في الغزو والقدرة العجيبة على التخلص من المآزق والأسر بحيل ذكية، كما عُرف بسرعة عدوه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    -- Question 91: q_ar_091
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي كان من أصحاب الصعاليك يعيش لغيره أكثر مما يعيش لنفسه؟', 'من هو الذي كان من أصحاب الصعاليك يعيش لغيره أكثر مما يعيش لنفسه؟', 'تميز عروة بن الورد بإيثاره الشديد، فكان يوزع ما يغتنمه على فقراء الصعاليك والمرضى منهم، ولذلك لُقب بـ "عروة الصعاليك".', 'تميز عروة بن الورد بإيثاره الشديد، فكان يوزع ما يغتنمه على فقراء الصعاليك والمرضى منهم، ولذلك لُقب بـ "عروة الصعاليك".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عروة بن الورد', 'عروة بن الورد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    -- Question 92: q_ar_092
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي كان من أصحاب الصعاليك ولكن كان من أشراف العرب ومن أسيادهم؟', 'من هو الذي كان من أصحاب الصعاليك ولكن كان من أشراف العرب ومن أسيادهم؟', 'بخلاف معظم الصعاليك الذين كانوا "خلعاء" (مطرودين) من قبائلهم، كان عروة سيداً مطاعاً في عبس، لكنه اختار الصعلكة كفلسفة اجتماعية لمساعدة المحتاجين.', 'بخلاف معظم الصعاليك الذين كانوا "خلعاء" (مطرودين) من قبائلهم، كان عروة سيداً مطاعاً في عبس، لكنه اختار الصعلكة كفلسفة اجتماعية لمساعدة المحتاجين.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عروة بن الورد', 'عروة بن الورد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'السليك بن السلكة', 'السليك بن السلكة', FALSE);
    -- Question 93: q_ar_093
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من هو الذي كان أمير الصعاليك؟', 'من هو الذي كان أمير الصعاليك؟', 'لُقب بـ "أمير الصعاليك" و"عروة الصعاليك" لأنه كان يقودهم في الغزوات ويرعاهم ويدافع عنهم.', 'لُقب بـ "أمير الصعاليك" و"عروة الصعاليك" لأنه كان يقودهم في الغزوات ويرعاهم ويدافع عنهم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عروة بن الورد', 'عروة بن الورد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'تأبط شراً', 'تأبط شراً', FALSE);
    -- Question 94: q_ar_094
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', '"هالة بنت كبير بن حبيب" اسم حبيبة؟', '"هالة بنت كبير بن حبيب" اسم حبيبة؟', 'هالة هي زوجة عروة بن الورد، وقد ذُكرت في قصصه وأشعاره كشريكة لحياته الصعبة في الصحراء.', 'هالة هي زوجة عروة بن الورد، وقد ذُكرت في قصصه وأشعاره كشريكة لحياته الصعبة في الصحراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عروة بن الورد', 'عروة بن الورد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة', 'عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'تأبط شراً', 'تأبط شراً', FALSE);
    -- Question 95: q_ar_095
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من قال "من قال إن حاتماً أسمح الناس فقد ظلم عروة بن الورد"؟', 'من قال "من قال إن حاتماً أسمح الناس فقد ظلم عروة بن الورد"؟', 'كان معاوية رضي الله عنه معجباً بشخصية عروة ويرى أن كرمه الذي يشاركه فيه الفقراء دمه وروحه أشد نبلاً من كرم حاتم الطائي التقليدي.', 'كان معاوية رضي الله عنه معجباً بشخصية عروة ويرى أن كرمه الذي يشاركه فيه الفقراء دمه وروحه أشد نبلاً من كرم حاتم الطائي التقليدي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو سفيان', 'أبو سفيان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبد الملك بن مروان', 'عبد الملك بن مروان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'معاوية بن أبي سفيان', 'معاوية بن أبي سفيان', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'هشام بن عبد الملك', 'هشام بن عبد الملك', FALSE);
    -- Question 96: q_ar_096
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'من قال "إذن يموت عيالي جوعاً، هذا مكسبي ومنه معاشي"؟', 'من قال "إذن يموت عيالي جوعاً، هذا مكسبي ومنه معاشي"؟', 'قال الحطيئة هذه العبارة لعمر بن الخطاب رضي الله عنه عندما أراد عمر منعه من الهجاء، فأجابه الحطيئة بأن شعره (وهجاءه) هو وسيلته الوحيدة لكسب الرزق وإطعام عياله.', 'قال الحطيئة هذه العبارة لعمر بن الخطاب رضي الله عنه عندما أراد عمر منعه من الهجاء، فأجابه الحطيئة بأن شعره (وهجاءه) هو وسيلته الوحيدة لكسب الرزق وإطعام عياله.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الحطيئة', 'الحطيئة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حسان بن ثابت', 'حسان بن ثابت', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير', 'زهير', FALSE);
    -- Question 97: q_ar_097
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', '"دع المكارم لا ترحل لبغيتها.. واقعد فإنك أنت الطاعم الكاسي" لمن هذا البيت؟', '"دع المكارم لا ترحل لبغيتها.. واقعد فإنك أنت الطاعم الكاسي" لمن هذا البيت؟', 'هذا أشهر بيت في الهجاء، قاله الحطيئة في "الزبرقان بن بدر"، وهو البيت الذي تسبب في سجن الحطيئة لأن عمر بن الخطاب اعتبره قذفاً وإهانة شديدة.', 'هذا أشهر بيت في الهجاء، قاله الحطيئة في "الزبرقان بن بدر"، وهو البيت الذي تسبب في سجن الحطيئة لأن عمر بن الخطاب اعتبره قذفاً وإهانة شديدة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الحطيئة', 'الحطيئة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حسان بن ثابت', 'حسان بن ثابت', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير', 'زهير', FALSE);
    -- Question 98: q_ar_098
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'كان له أسلوب النابغة في المدح وفي التنقيح أسلوب زهير؟', 'كان له أسلوب النابغة في المدح وفي التنقيح أسلوب زهير؟', 'يُعد الحطيئة من طبقة "عبيد الشعر"؛ فقد ورث دقة التنقيح عن مدرسة زهير بن أبي سلمى، بينما شابه النابغة الذبياني في جودة المديح والتكسب بالشعر.', 'يُعد الحطيئة من طبقة "عبيد الشعر"؛ فقد ورث دقة التنقيح عن مدرسة زهير بن أبي سلمى، بينما شابه النابغة الذبياني في جودة المديح والتكسب بالشعر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الحطيئة', 'الحطيئة', TRUE);
    -- Question 99: q_ar_099
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'قدم عمر رضي الله عنه إلى الحطيئة ...... آلاف درهم ليجتنب عن هجائه؟', 'قدم عمر رضي الله عنه إلى الحطيئة ...... آلاف درهم ليجتنب عن هجائه؟', 'اشترى عمر بن الخطاب رضي الله عنه أعراض المسلمين من الحطيئة بثلاثة آلاف درهم، مقابل أن يكف عن الهجاء تماماً.', 'اشترى عمر بن الخطاب رضي الله عنه أعراض المسلمين من الحطيئة بثلاثة آلاف درهم، مقابل أن يكف عن الهجاء تماماً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ثلاث', 'ثلاث', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أربع', 'أربع', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ست', 'ست', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ثلاث (تكرار في الخيارات، الإجابة الصحيحة هي ثلاث)', 'ثلاث (تكرار في الخيارات، الإجابة الصحيحة هي ثلاث)', FALSE);
    -- Question 100: q_ar_100
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'كنية "أبو عقبة" لمن؟', 'كنية "أبو عقبة" لمن؟', 'يُكنى كعب بن زهير بـ أبي عقبة، وهو الابن الأكبر للشاعر زهير بن أبي سلمى.', 'يُكنى كعب بن زهير بـ أبي عقبة، وهو الابن الأكبر للشاعر زهير بن أبي سلمى.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الخنساء', 'الخنساء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كعب بن زهير', 'كعب بن زهير', TRUE);
    -- Question 101: q_ar_101
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'من هو الذي كان في عصر ما قبل الإسلام شاعراً معروفاً أكثر من الحطيئة؟', 'من هو الذي كان في عصر ما قبل الإسلام شاعراً معروفاً أكثر من الحطيئة؟', 'كعب بن زهير نشأ في بيت كله شعراء، وكان اسمه لامعاً في الجاهلية قبل الإسلام، بينما برزت شهرة الحطيئة الكبرى في هجائه وتكسبه في العصور اللاحقة.', 'كعب بن زهير نشأ في بيت كله شعراء، وكان اسمه لامعاً في الجاهلية قبل الإسلام، بينما برزت شهرة الحطيئة الكبرى في هجائه وتكسبه في العصور اللاحقة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كعب بن زهير', 'كعب بن زهير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    -- Question 102: q_ar_102
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'قصيدة "بانت سعاد" (البردة) نُظمت على بحر؟', 'قصيدة "بانت سعاد" (البردة) نُظمت على بحر؟', 'قصيدة البردة الشهيرة "بانت سعاد فقلبي اليوم متبول" التي مدح بها النبي ﷺ نُظمت على بحر البسيط.', 'قصيدة البردة الشهيرة "بانت سعاد فقلبي اليوم متبول" التي مدح بها النبي ﷺ نُظمت على بحر البسيط.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البسيط', 'البسيط', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الطويل', 'الطويل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الخفيف', 'الخفيف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المديد', 'المديد', FALSE);
    -- Question 103: q_ar_103
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'أنشد كعب قصيدة "بانت سعاد" في السنة ..... الهجرية في المسجد النبوي؟', 'أنشد كعب قصيدة "بانت سعاد" في السنة ..... الهجرية في المسجد النبوي؟', 'نُظمت القصيدة في "عام الوفود" (السنة التاسعة للهجرة)، عندما جاء كعب تائباً ومسلماً بعد أن أهدر النبي ﷺ دمه، فألقى قصيدته الشهيرة في المسجد النبوي ونال العفو والبردة الشريفة.', 'نُظمت القصيدة في "عام الوفود" (السنة التاسعة للهجرة)، عندما جاء كعب تائباً ومسلماً بعد أن أهدر النبي ﷺ دمه، فألقى قصيدته الشهيرة في المسجد النبوي ونال العفو والبردة الشريفة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '8 هـ', '8 هـ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '7 هـ', '7 هـ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '9 هـ', '9 هـ', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '11 هـ', '11 هـ', FALSE);
    -- Question 104: q_ar_104
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', '"إن الرسول لنور يستضاء به.. من سيوف الله مسلول" من قائل هذا البيت؟', '"إن الرسول لنور يستضاء به.. من سيوف الله مسلول" من قائل هذا البيت؟', 'هذا البيت هو ذروة المديح النبوي في قصيدة "بانت سعاد"، وفيه شبه الرسول ﷺ بالنور الذي يضيء ظلمات الجهل وبسيف الله المسلول الذي يحق الحق.', 'هذا البيت هو ذروة المديح النبوي في قصيدة "بانت سعاد"، وفيه شبه الرسول ﷺ بالنور الذي يضيء ظلمات الجهل وبسيف الله المسلول الذي يحق الحق.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'حسان بن ثابت', 'حسان بن ثابت', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كعب بن زهير', 'كعب بن زهير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    -- Question 105: q_ar_105
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'من هو الذي أهدر النبي صلى الله عليه وسلم دمه؟', 'من هو الذي أهدر النبي صلى الله عليه وسلم دمه؟', 'أهدر النبي ﷺ دمه لتحريضه على الإسلام وهجائه للمسلمين، ولكنه نجا بإسلامه ومدحه للنبي ﷺ في "البردة".', 'أهدر النبي ﷺ دمه لتحريضه على الإسلام وهجائه للمسلمين، ولكنه نجا بإسلامه ومدحه للنبي ﷺ في "البردة".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كعب بن زهير', 'كعب بن زهير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الفرزدق', 'الفرزدق', FALSE);
    -- Question 106: q_ar_106
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'من هو الذي يعرف بـ "نائب الصادق"؟', 'من هو الذي يعرف بـ "نائب الصادق"؟', 'لُقب بذلك في بعض المراجع الأدبية لصدق توبته وقوة شعره الذي كان ينوب عن الحق بعد إسلامه.', 'لُقب بذلك في بعض المراجع الأدبية لصدق توبته وقوة شعره الذي كان ينوب عن الحق بعد إسلامه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كعب بن زهير', 'كعب بن زهير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الشنفرى', 'الشنفرى', FALSE);
    -- Question 107: q_ar_107
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'توفيت الخنساء سنة؟', 'توفيت الخنساء سنة؟', 'توفيت في مطلع خلافة عثمان بن عفان رضي الله عنه عام 24 هـ، بعد أن أدركت الإسلام وشاركت في معركة القادسية باستشهاد أبنائها الأربعة.', 'توفيت في مطلع خلافة عثمان بن عفان رضي الله عنه عام 24 هـ، بعد أن أدركت الإسلام وشاركت في معركة القادسية باستشهاد أبنائها الأربعة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '24 هـ', '24 هـ', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '26 هـ', '26 هـ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '23 هـ', '23 هـ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '28 هـ', '28 هـ', FALSE);
    -- Question 108: q_ar_108
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'من قال عن الخنساء "الخنساء أشعر الجن والإنس"؟', 'من قال عن الخنساء "الخنساء أشعر الجن والإنس"؟', 'قالها النابغة في سوق عكاظ عندما سمع رثاءها لأخيها صخر، وكان النابغة هو الحكَم الذي تُضرب له القبة الحمراء لتقييم الشعراء.', 'قالها النابغة في سوق عكاظ عندما سمع رثاءها لأخيها صخر، وكان النابغة هو الحكَم الذي تُضرب له القبة الحمراء لتقييم الشعراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'النابغة الذبياني', 'النابغة الذبياني', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمرو بن العلاء', 'عمرو بن العلاء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حسان بن ثابت', 'حسان بن ثابت', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير', 'زهير', FALSE);
    -- Question 109: q_ar_109
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', '(الأول): عاشت الخنساء في الإسلام حتى أول خلافة عثمان. (الثاني): قرضت الخنساء أكثر شعرها في المدح؟', '(الأول): عاشت الخنساء في الإسلام حتى أول خلافة عثمان. (الثاني): قرضت الخنساء أكثر شعرها في المدح؟', 'الجزء الأول صحيح، أما الثاني فخطأ لأن الخنساء هي أشعر شاعرات الرثاء في تاريخ العرب، وديوانها يكاد يقتصر على رثاء أخويها (صخر ومعاوية).', 'الجزء الأول صحيح، أما الثاني فخطأ لأن الخنساء هي أشعر شاعرات الرثاء في تاريخ العرب، وديوانها يكاد يقتصر على رثاء أخويها (صخر ومعاوية).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كلاهما صحيح', 'كلاهما صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كلاهما غير صحيح', 'كلاهما غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأول صحيح والثاني غير صحيح', 'الأول صحيح والثاني غير صحيح', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأول غير صحيح والثاني صحيح', 'الأول غير صحيح والثاني صحيح', FALSE);
    -- Question 110: q_ar_110
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', '"كيف تهجوهم وأنا منهم؟" من قال هذه العبارة لحسان؟', '"كيف تهجوهم وأنا منهم؟" من قال هذه العبارة لحسان؟', 'سأله النبي ﷺ ذلك عند رغبته في هجاء قريش، فأجابه حسان بذكاء وبراعة: "لأسلنَّك منهم كما تُسل الشعرة من العجين"، أي سأهجوهم دون أن يمسك أذى.', 'سأله النبي ﷺ ذلك عند رغبته في هجاء قريش، فأجابه حسان بذكاء وبراعة: "لأسلنَّك منهم كما تُسل الشعرة من العجين"، أي سأهجوهم دون أن يمسك أذى.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمر رضي الله عنه', 'عمر رضي الله عنه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'النبي ﷺ', 'النبي ﷺ', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عثمان رضي الله عنه', 'عثمان رضي الله عنه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'علي رضي الله عنه', 'علي رضي الله عنه', FALSE);
    -- Question 111: q_ar_111
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', '(الأول): ولد حسان بالمدينة ونشأ في الجاهلية. (الثاني): مدح حسان المناذرة والغساسنة؟', '(الأول): ولد حسان بالمدينة ونشأ في الجاهلية. (الثاني): مدح حسان المناذرة والغساسنة؟', 'حسان أنصاري خزرجي من المدينة، وقبل إسلامه كان شاعر بلاط ملوك الغساسنة في الشام والمناذرة في الحيرة، مما صقل موهبته في المدح.', 'حسان أنصاري خزرجي من المدينة، وقبل إسلامه كان شاعر بلاط ملوك الغساسنة في الشام والمناذرة في الحيرة، مما صقل موهبته في المدح.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كلاهما صحيح', 'كلاهما صحيح', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كلاهما غير صحيح', 'كلاهما غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأول صحيح والثاني غير صحيح', 'الأول صحيح والثاني غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأول غير صحيح والثاني صحيح', 'الأول غير صحيح والثاني صحيح', FALSE);
    -- Question 112: q_ar_112
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'ينتمي حسان بن ثابت إلى قبيلة؟', 'ينتمي حسان بن ثابت إلى قبيلة؟', 'هو حسان بن ثابت الأنصاري، وينتمي تحديداً إلى قبيلة الخزرج في المدينة المنورة.', 'هو حسان بن ثابت الأنصاري، وينتمي تحديداً إلى قبيلة الخزرج في المدينة المنورة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'مزينة', 'مزينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'خزرجية', 'خزرجية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تهامة', 'تهامة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الغسانية', 'الغسانية', FALSE);
    -- Question 113: q_ar_113
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'إنه كان يضارع ابن كلثوم في الفخر بقومه ولكنه كان "جباناً مخلوع القلب" قيل عن؟', 'إنه كان يضارع ابن كلثوم في الفخر بقومه ولكنه كان "جباناً مخلوع القلب" قيل عن؟', 'تواترت الروايات أن حسان لم يشهد الغزوات بسيفه بسبب علة نفسية أو جسدية أصابته، فكان سلاحه لسانه وشعره الذي كان "أشد عليهم من رشق النبال".', 'تواترت الروايات أن حسان لم يشهد الغزوات بسيفه بسبب علة نفسية أو جسدية أصابته، فكان سلاحه لسانه وشعره الذي كان "أشد عليهم من رشق النبال".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كعب بن زهير', 'كعب بن زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حسان بن ثابت', 'حسان بن ثابت', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    -- Question 114: q_ar_114
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'ولد الفرزدق سنة؟', 'ولد الفرزدق سنة؟', 'ولد الفرزدق في كاظمة (الكويت حالياً) ونشأ في البصرة، وهو ينتمي لبيت عريق في قبيلة تميم.', 'ولد الفرزدق في كاظمة (الكويت حالياً) ونشأ في البصرة، وهو ينتمي لبيت عريق في قبيلة تميم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '641 م', '641 م', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '643 م', '643 م', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '645 م', '645 م', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '647 م', '647 م', FALSE);
    -- Question 115: q_ar_115
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من قائل: "هذا الذي تعرف البطحاء وطأته.. والبيت يعرفه والحل والحرم"؟', 'من قائل: "هذا الذي تعرف البطحاء وطأته.. والبيت يعرفه والحل والحرم"؟', 'هذه من أشهر قصائد المديح، قالها الفرزدق في علي زين العابدين بن الحسين عندما تجاهله هشام بن عبد الملك في الحج، فارتجل الفرزدق هذه القصيدة إجلالاً لآل البيت.', 'هذه من أشهر قصائد المديح، قالها الفرزدق في علي زين العابدين بن الحسين عندما تجاهله هشام بن عبد الملك في الحج، فارتجل الفرزدق هذه القصيدة إجلالاً لآل البيت.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الفرزدق', 'الفرزدق', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كعب بن زهير', 'كعب بن زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'حسان بن ثابت', 'حسان بن ثابت', FALSE);
    -- Question 116: q_ar_116
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'الفرزدق ينتمي إلى قبيلة؟', 'الفرزدق ينتمي إلى قبيلة؟', 'هو من بني دارم من تميم، وكان والده غالب من أجواد العرب وساداتهم.', 'هو من بني دارم من تميم، وكان والده غالب من أجواد العرب وساداتهم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'تغلب', 'تغلب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تميم', 'تميم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عبس', 'عبس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مزينة', 'مزينة', FALSE);
    -- Question 117: q_ar_117
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'فيمن قيل: "لولا شعره لذهب ثلث لغة العرب ونصف أخبار الناس"؟', 'فيمن قيل: "لولا شعره لذهب ثلث لغة العرب ونصف أخبار الناس"؟', 'قيل ذلك لأن الفرزدق كان يفخر بأيام العرب وأنسابها ووقائعها، فكان شعره سجلاً تاريخياً ولغوياً ضخماً.', 'قيل ذلك لأن الفرزدق كان يفخر بأيام العرب وأنسابها ووقائعها، فكان شعره سجلاً تاريخياً ولغوياً ضخماً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الفرزدق', 'الفرزدق', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    -- Question 118: q_ar_118
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي نصحه علي (رضي الله عنه) أن يحفظ القرآن؟', 'من هو الذي نصحه علي (رضي الله عنه) أن يحفظ القرآن؟', 'عندما قدم به والده غالب على الإمام علي، قال له الإمام: "علمه القرآن فهو خير له من الشعر"، فقام الفرزدق بتقييد نفسه حتى حفظ القرآن.', 'عندما قدم به والده غالب على الإمام علي، قال له الإمام: "علمه القرآن فهو خير له من الشعر"، فقام الفرزدق بتقييد نفسه حتى حفظ القرآن.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'علي رضي الله عنه', 'علي رضي الله عنه', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عثمان رضي الله عنه', 'عثمان رضي الله عنه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو بكر رضي الله عنه', 'أبو بكر رضي الله عنه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن عبد العزيز', 'عمر بن عبد العزيز', FALSE);
    -- Question 119: q_ar_119
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي لا يأكل حتى يكون أحد معه على السفرة والطعام؟', 'من هو الذي لا يأكل حتى يكون أحد معه على السفرة والطعام؟', 'اشتهر الفرزدق بالكرم المفرط كوالده، وكان يضع الطعام وينادي للناس ليشاركوه، وكان يجير من استجار بقبر والده.', 'اشتهر الفرزدق بالكرم المفرط كوالده، وكان يضع الطعام وينادي للناس ليشاركوه، وكان يجير من استجار بقبر والده.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير', 'زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة', 'عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الفرزدق', 'الفرزدق', TRUE);
    -- Question 120: q_ar_120
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي ولد لسبعة أشهر من شعراء النقائض؟', 'من هو الذي ولد لسبعة أشهر من شعراء النقائض؟', 'ولد جرير لسبعة أشهر (خديجاً)، وكان نحيف الجسم لكنه كان من أقوى العرب لساناً في الهجاء.', 'ولد جرير لسبعة أشهر (خديجاً)، وكان نحيف الجسم لكنه كان من أقوى العرب لساناً في الهجاء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة', 'عنترة', FALSE);
    -- Question 121: q_ar_121
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'ولد جرير في؟', 'ولد جرير في؟', 'ولد جرير في اليمامة (في نجد - السعودية حالياً) وعاش فيها معظم حياته يرعى غنم أهله.', 'ولد جرير في اليمامة (في نجد - السعودية حالياً) وعاش فيها معظم حياته يرعى غنم أهله.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'العراق', 'العراق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البصرة', 'البصرة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'اليمامة', 'اليمامة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'نجد', 'نجد', FALSE);
    -- Question 122: q_ar_122
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي اتصل بسليمان بن عبد الملك ومدحه وسماه "المهدي"؟', 'من هو الذي اتصل بسليمان بن عبد الملك ومدحه وسماه "المهدي"؟', 'كان جرير مقرباً من الخلفاء الأمويين، ومدح سليمان بن عبد الملك بلقب "المهدي" تأكيداً على عدله وصلاحه.', 'كان جرير مقرباً من الخلفاء الأمويين، ومدح سليمان بن عبد الملك بلقب "المهدي" تأكيداً على عدله وصلاحه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    -- Question 123: q_ar_123
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"ذهبت قريش بالمكارم والعلا.. واللؤم تحت عمائم الأنصار" من قائل هذا البيت؟', '"ذهبت قريش بالمكارم والعلا.. واللؤم تحت عمائم الأنصار" من قائل هذا البيت؟', 'هذا البيت من أهجى ما قيل في الأنصار، قاله الأخطل بتحريض من يزيد بن معاوية، وهو سبب شهرته كشاعر للبلاط الأموي.', 'هذا البيت من أهجى ما قيل في الأنصار، قاله الأخطل بتحريض من يزيد بن معاوية، وهو سبب شهرته كشاعر للبلاط الأموي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأخطل', 'الأخطل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'حسان', 'حسان', FALSE);
    -- Question 124: q_ar_124
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '(الأول): هجا الأخطل زوجة أبيه وهو صغير. (الثاني): مات الأخطل على دين المسيحية؟', '(الأول): هجا الأخطل زوجة أبيه وهو صغير. (الثاني): مات الأخطل على دين المسيحية؟', 'بدأ الأخطل هجاءه بزوجة أبيه التي كانت تسيء معاملته، وظل نصرانياً (مسيحياً) طوال حياته حتى وفاته.', 'بدأ الأخطل هجاءه بزوجة أبيه التي كانت تسيء معاملته، وظل نصرانياً (مسيحياً) طوال حياته حتى وفاته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كلاهما صحيح', 'كلاهما صحيح', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كلاهما غير صحيح', 'كلاهما غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأول صحيح والثاني غير صحيح', 'الأول صحيح والثاني غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأول غير صحيح والثاني صحيح', 'الأول غير صحيح والثاني صحيح', FALSE);
    -- Question 125: q_ar_125
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '(الأول): الأخطل كان مجوسياً. (الثاني): الأخطل كان نصرانياً؟', '(الأول): الأخطل كان مجوسياً. (الثاني): الأخطل كان نصرانياً؟', 'الأخطل كان مسيحياً من قبيلة تغلب، ولم يكن مجوسياً أبداً.', 'الأخطل كان مسيحياً من قبيلة تغلب، ولم يكن مجوسياً أبداً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كلاهما صحيح', 'كلاهما صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كلاهما غير صحيح', 'كلاهما غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأول صحيح والثاني غير صحيح', 'الأول صحيح والثاني غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأول غير صحيح والثاني صحيح', 'الأول غير صحيح والثاني صحيح', TRUE);
    -- Question 126: q_ar_126
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من قال عن الأخطل "أدركته وله ناب واحد ولو أدركته وله نابان لأكلني"؟', 'من قال عن الأخطل "أدركته وله ناب واحد ولو أدركته وله نابان لأكلني"؟', 'قالها جرير اعترافاً بقوة الأخطل الشعرية بعد وفاته، مبيناً أنه رغم سقوط معظم أسنانه كبراً إلا أن لسانه كان مهلكاً.', 'قالها جرير اعترافاً بقوة الأخطل الشعرية بعد وفاته، مبيناً أنه رغم سقوط معظم أسنانه كبراً إلا أن لسانه كان مهلكاً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كعب', 'كعب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الحطيئة', 'الحطيئة', FALSE);
    -- Question 127: q_ar_127
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'ينتمي الأخطل إلى قبيلة؟', 'ينتمي الأخطل إلى قبيلة؟', 'هو غياث بن غوث التغلبي، وقبيلة تغلب كانت من القبائل العربية النصرانية الكبرى في شمال الجزيرة والفرات.', 'هو غياث بن غوث التغلبي، وقبيلة تغلب كانت من القبائل العربية النصرانية الكبرى في شمال الجزيرة والفرات.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عبس', 'عبس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عامر', 'عامر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تغلب', 'تغلب', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مخزوم', 'مخزوم', FALSE);
    -- Question 128: q_ar_128
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من قال: "الفرزدق ينحت من صخر وجرير يغرف من بحر"؟', 'من قال: "الفرزدق ينحت من صخر وجرير يغرف من بحر"؟', 'الأخطل هو الذي أطلق هذا الحكم النقدي الشهير؛ ويقصد أن الفرزدق شعره قوي وصعب (وعر)، بينما جرير شعره سهل وسلس ومنساب (رقيق).', 'الأخطل هو الذي أطلق هذا الحكم النقدي الشهير؛ ويقصد أن الفرزدق شعره قوي وصعب (وعر)، بينما جرير شعره سهل وسلس ومنساب (رقيق).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير', 'زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة', 'عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الفرزدق', 'الفرزدق', FALSE);
    -- Question 129: q_ar_129
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'قرض الفرزدق الشعر في سن؟', 'قرض الفرزدق الشعر في سن؟', 'بدأ الفرزدق نبوغه الشعري مبكراً جداً، ويُقال إنه كان في الخامسة عشرة عندما لفت الأنظار بقوة منطقه وشعره.', 'بدأ الفرزدق نبوغه الشعري مبكراً جداً، ويُقال إنه كان في الخامسة عشرة عندما لفت الأنظار بقوة منطقه وشعره.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '11 سنة', '11 سنة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '14 سنة', '14 سنة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '15 سنة', '15 سنة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '17 سنة', '17 سنة', FALSE);
    -- Question 130: q_ar_130
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'ينتمي عمر بن أبي ربيعة إلى قبيلة؟', 'ينتمي عمر بن أبي ربيعة إلى قبيلة؟', 'هو عمر بن عبد الله بن أبي ربيعة المخزومي القرشي. ولد في بيت ثراء وجاه في قريش، وتفرغ لغزل النساء ووصف مغامراته معهن.', 'هو عمر بن عبد الله بن أبي ربيعة المخزومي القرشي. ولد في بيت ثراء وجاه في قريش، وتفرغ لغزل النساء ووصف مغامراته معهن.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'خزرج', 'خزرج', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'مخزوم', 'مخزوم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عبس', 'عبس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'تغلب', 'تغلب', FALSE);
    -- Question 131: q_ar_131
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'نُفي عمر بن أبي ربيعة من قبل الخليفة عمر بن عبد العزيز إلى؟', 'نُفي عمر بن أبي ربيعة من قبل الخليفة عمر بن عبد العزيز إلى؟', '"دهلك" جزيرة في البحر الأحمر كانت تُستخدم كمنفى. نُفي إليها بسبب شعره الذي اعتبره الخليفة مفسداً للأخلاق، وقيل إنه تاب في أواخر حياته.', '"دهلك" جزيرة في البحر الأحمر كانت تُستخدم كمنفى. نُفي إليها بسبب شعره الذي اعتبره الخليفة مفسداً للأخلاق، وقيل إنه تاب في أواخر حياته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'العراق', 'العراق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'نجد', 'نجد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'دهلك', 'دهلك', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مصر', 'مصر', FALSE);
    -- Question 132: q_ar_132
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'ولد عمر بن أبي ربيعة في؟', 'ولد عمر بن أبي ربيعة في؟', 'ولد في المدينة المنورة في الليلة التي توفي فيها الخليفة عمر بن الخطاب (سنة 23 هـ)، ولهذا قيلت العبارة الشهيرة: "أي حقٍّ رُفع وباطلٍ وُضع".', 'ولد في المدينة المنورة في الليلة التي توفي فيها الخليفة عمر بن الخطاب (سنة 23 هـ)، ولهذا قيلت العبارة الشهيرة: "أي حقٍّ رُفع وباطلٍ وُضع".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الحجاز', 'الحجاز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'العراق', 'العراق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'المدينة', 'المدينة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البصرة', 'البصرة', FALSE);
    -- Question 133: q_ar_133
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي تلقن الشعر من هدبة بن الخشرم وأصبح راوياً له؟', 'من هو الذي تلقن الشعر من هدبة بن الخشرم وأصبح راوياً له؟', 'جميل العذري كان يروي شعر هدبة بن الخشرم، ومنه استقى أسلوب العفة والوفاء الذي ميز مدرسة "الغزل العذري".', 'جميل العذري كان يروي شعر هدبة بن الخشرم، ومنه استقى أسلوب العفة والوفاء الذي ميز مدرسة "الغزل العذري".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جميل بن معمر', 'جميل بن معمر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كعب', 'كعب', FALSE);
    -- Question 134: q_ar_134
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي أهدر مروان بن الحكم (والي المدينة) دمه؟', 'من هو الذي أهدر مروان بن الحكم (والي المدينة) دمه؟', 'أهدر والي المدينة دمه لأن جميل استمر في ذكر "بثينة" في شعره والتشبيب بها بعد زواجها من رجل آخر، وهو ما كان يُعتبر عاراً عند العرب.', 'أهدر والي المدينة دمه لأن جميل استمر في ذكر "بثينة" في شعره والتشبيب بها بعد زواجها من رجل آخر، وهو ما كان يُعتبر عاراً عند العرب.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عبد الملك بن مروان', 'عبد الملك بن مروان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'مروان بن حكم', 'مروان بن حكم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عبد العزيز', 'عبد العزيز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'معاوية', 'معاوية', FALSE);
    -- Question 135: q_ar_135
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '(الأول): كان أسلوب جميل أسلوب الشعر الغنائي الوجداني. (الثاني): تزوجت بثينة من حجنة الهلالي؟', '(الأول): كان أسلوب جميل أسلوب الشعر الغنائي الوجداني. (الثاني): تزوجت بثينة من حجنة الهلالي؟', 'شعر جميل يعبر عن عاطفة صادقة (وجدانية)، أما بثينة فقد أُجبرت على الزواج من "حجنة" ليقطع أهلها الطريق على جميل.', 'شعر جميل يعبر عن عاطفة صادقة (وجدانية)، أما بثينة فقد أُجبرت على الزواج من "حجنة" ليقطع أهلها الطريق على جميل.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كلاهما صحيح', 'كلاهما صحيح', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كلاهما غير صحيح', 'كلاهما غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأول صحيح والثاني غير صحيح', 'الأول صحيح والثاني غير صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأول غير صحيح والثاني صحيح', 'الأول غير صحيح والثاني صحيح', FALSE);
    -- Question 136: q_ar_136
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'فيمن قيل "أهجى شعراء العرب"؟', 'فيمن قيل "أهجى شعراء العرب"؟', 'اشتهر جرير بقدرته الفائقة على إفحام خصومه، ويُقال إنه هجا ثمانين شاعراً فغلبهم جميعاً ببراعته في اختيار الألفاظ اللاذعة.', 'اشتهر جرير بقدرته الفائقة على إفحام خصومه، ويُقال إنه هجا ثمانين شاعراً فغلبهم جميعاً ببراعته في اختيار الألفاظ اللاذعة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار', 'بشار', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'جرير', 'جرير', TRUE);
    -- Question 137: q_ar_137
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'تبادل جرير والفرزدق الهجاء (النقائض) لأكثر من؟', 'تبادل جرير والفرزدق الهجاء (النقائض) لأكثر من؟', 'استمرت المعركة الشعرية بين جرير والفرزدق قرابة 40 عاماً، ولم تنتهِ إلا بوفاتهما في نفس العام تقريباً (110 هـ - 114 هـ حسب الروايات).', 'استمرت المعركة الشعرية بين جرير والفرزدق قرابة 40 عاماً، ولم تنتهِ إلا بوفاتهما في نفس العام تقريباً (110 هـ - 114 هـ حسب الروايات).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'خمسين سنة', 'خمسين سنة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ستين سنة', 'ستين سنة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أربعين سنة', 'أربعين سنة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ثلاثين سنة', 'ثلاثين سنة', FALSE);
    -- Question 138: q_ar_138
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي كان أشهر في فن "الفخر" من شعراء النقائض؟', 'من هو الذي كان أشهر في فن "الفخر" من شعراء النقائض؟', 'كانت قوة الفرزدق تكمن في "الفخر" بآبائه وأجداده (بني دارم) ومكانة قبيلة تميم، بينما تفوق جرير في "الهجاء" و"النسيب".', 'كانت قوة الفرزدق تكمن في "الفخر" بآبائه وأجداده (بني دارم) ومكانة قبيلة تميم، بينما تفوق جرير في "الهجاء" و"النسيب".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كعب', 'كعب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الفرزدق', 'الفرزدق', TRUE);
    -- Question 139: q_ar_139
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "شاعر بني أمية"؟', 'من هو الذي لُقب بـ "شاعر بني أمية"؟', 'لُقب بذلك لشدة قربه من الخلفاء الأمويين (خاصة عبد الملك بن مروان) ودفاعه عن دولتهم ضد خصومهم مثل الزبيريين والأنصار.', 'لُقب بذلك لشدة قربه من الخلفاء الأمويين (خاصة عبد الملك بن مروان) ودفاعه عن دولتهم ضد خصومهم مثل الزبيريين والأنصار.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'زهير', 'زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    -- Question 140: q_ar_140
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الممتاز بإجادة المدح ونعت الخمر وقلة البذاء في الهجاء؟', 'من هو الممتاز بإجادة المدح ونعت الخمر وقلة البذاء في الهجاء؟', 'تميز الأخطل بأسلوبه المصقول، وكان يترفع عن شتم الأعراض بالألفاظ السوقية (البذاء) كما كان يفعل جرير أحياناً، واشتهر بوصف مجالس الخمر.', 'تميز الأخطل بأسلوبه المصقول، وكان يترفع عن شتم الأعراض بالألفاظ السوقية (البذاء) كما كان يفعل جرير أحياناً، واشتهر بوصف مجالس الخمر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير', 'زهير', FALSE);
    -- Question 141: q_ar_141
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'توفي الأخطل في خلافة؟', 'توفي الأخطل في خلافة؟', 'توفي الأخطل في حدود سنة 90 هـ أو 92 هـ، وهي فترة خلافة الوليد بن عبد الملك.', 'توفي الأخطل في حدود سنة 90 هـ أو 92 هـ، وهي فترة خلافة الوليد بن عبد الملك.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الوليد', 'الوليد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمر بن عبد العزيز', 'عمر بن عبد العزيز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'مروان بن حكم', 'مروان بن حكم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'معاوية', 'معاوية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_5', 'بشار,ابو نواس,ابو تمام', 'بشار,ابو نواس,ابو تمام', FALSE);
    -- Question 142: q_ar_142
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'ولد أبو نواس في ....؟', 'ولد أبو نواس في ....؟', 'ولد أبو نواس في مدينة "الأهواز" (في إقليم خوزستان حالياً)، ثم انتقل إلى البصرة حيث نشأ وتعلم اللغة والشعر.', 'ولد أبو نواس في مدينة "الأهواز" (في إقليم خوزستان حالياً)، ثم انتقل إلى البصرة حيث نشأ وتعلم اللغة والشعر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأهواز', 'الأهواز', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البصرة', 'البصرة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'العراق', 'العراق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'السعودية', 'السعودية', FALSE);
    -- Question 143: q_ar_143
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'ولد أبو نواس عام؟', 'ولد أبو نواس عام؟', 'ولد سنة 145 هـ في أواخر عهد المنصور ومطلع عهد المهدي العباسي.', 'ولد سنة 145 هـ في أواخر عهد المنصور ومطلع عهد المهدي العباسي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الهجري 146', 'الهجري 146', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الهجري 154', 'الهجري 154', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الهجري 145', 'الهجري 145', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الهجري 156', 'الهجري 156', FALSE);
    -- Question 144: q_ar_144
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'شاعر عباسي شهير، أبو نواس هو؟', 'شاعر عباسي شهير، أبو نواس هو؟', 'كان أبو نواس من أب عربي (من دمشق) وأم فارسية تُدعى "جلبان"، ولذلك غلب عليه العنصر الفارسي في ثقافته وميله للشعوبية.', 'كان أبو نواس من أب عربي (من دمشق) وأم فارسية تُدعى "جلبان"، ولذلك غلب عليه العنصر الفارسي في ثقافته وميله للشعوبية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جزائري الأصل', 'جزائري الأصل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'فارسي الأصل', 'فارسي الأصل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'سعودي الأصل', 'سعودي الأصل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'يمني الأصل', 'يمني الأصل', FALSE);
    -- Question 145: q_ar_145
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الأول الذي نهج للشعر طريقته الحضرية وأخرجه من اللهجة البدوية؟', 'من هو الأول الذي نهج للشعر طريقته الحضرية وأخرجه من اللهجة البدوية؟', 'يُعد بشار بن برد هو الرائد الأول الذي خرج بالشعر عن التقاليد البدوية الجاهلية، ومهد الطريق لأبي نواس والمحدثين لابتكار أوزان وصور مستمدة من حياة الحضر.', 'يُعد بشار بن برد هو الرائد الأول الذي خرج بالشعر عن التقاليد البدوية الجاهلية، ومهد الطريق لأبي نواس والمحدثين لابتكار أوزان وصور مستمدة من حياة الحضر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'زهير', 'زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار', 'بشار', TRUE);
    -- Question 146: q_ar_146
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'hard', 'من هو الذي كان عالماً فقيهاً عارفاً بالأحكام والفتيا بصيراً بالاختلاف وصاحب حفظ ونظر ومعرفة بطرق الحديث ويعرف القرآن ومتشابهه وناسخه ومنسوخه؟', 'من هو الذي كان عالماً فقيهاً عارفاً بالأحكام والفتيا بصيراً بالاختلاف وصاحب حفظ ونظر ومعرفة بطرق الحديث ويعرف القرآن ومتشابهه وناسخه ومنسوخه؟', 'هذه حقيقة قد تخفى على الكثيرين؛ فقد كان أبو نواس متمكناً جداً من العلوم الدينية واللغوية والقراءات، وهذا الثراء المعرفي هو ما جعل شعره قوياً وجزلاً رغم مجونه.', 'هذه حقيقة قد تخفى على الكثيرين؛ فقد كان أبو نواس متمكناً جداً من العلوم الدينية واللغوية والقراءات، وهذا الثراء المعرفي هو ما جعل شعره قوياً وجزلاً رغم مجونه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حسان', 'حسان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كعب', 'كعب', FALSE);
    -- Question 147: q_ar_147
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'فيمن قيل عن وصفه الخمر "لو سمعه الحسنان (الحسن البصري وابن سيرين) لهاجرا إليها وعكفا عليها"؟', 'فيمن قيل عن وصفه الخمر "لو سمعه الحسنان (الحسن البصري وابن سيرين) لهاجرا إليها وعكفا عليها"؟', 'قيل ذلك لشدة براعته وجمال وصفه للخمر (الخمريات)، حتى قيل إن وصفه يُغري التائب والزاهد.', 'قيل ذلك لشدة براعته وجمال وصفه للخمر (الخمريات)، حتى قيل إن وصفه يُغري التائب والزاهد.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة', 'عنترة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأخطل', 'الأخطل', FALSE);
    -- Question 148: q_ar_148
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', '"ما رأيت أحداً كان أعلم باللغة من أبي نواس ولا أفصح لهجة منه..." من قال هذا؟', '"ما رأيت أحداً كان أعلم باللغة من أبي نواس ولا أفصح لهجة منه..." من قال هذا؟', 'شهد الجاحظ (وهو إمام الأدب) لأبي نواس بالتفوق اللغوي والفصاحة والقدرة على تطويع اللغة دون تكلف.', 'شهد الجاحظ (وهو إمام الأدب) لأبي نواس بالتفوق اللغوي والفصاحة والقدرة على تطويع اللغة دون تكلف.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الجاحظ', 'الجاحظ', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو عمر بن العلاء', 'أبو عمر بن العلاء', FALSE);
    -- Question 149: q_ar_149
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'يقال شعراء اليمن ثلاثة: امرؤ القيس، وحسان بن ثابت، و........؟', 'يقال شعراء اليمن ثلاثة: امرؤ القيس، وحسان بن ثابت، و........؟', 'لأن والد أبي نواس ينتمي لقبيلة "حكم" وهي من قبائل اليمن، فاعتبره النقاد ثالث عظماء شعراء اليمن عبر العصور.', 'لأن والد أبي نواس ينتمي لقبيلة "حكم" وهي من قبائل اليمن، فاعتبره النقاد ثالث عظماء شعراء اليمن عبر العصور.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأخطل', 'الأخطل', FALSE);
    -- Question 150: q_ar_150
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الذي لُقب بـ "المرعث"؟', 'من هو الذي لُقب بـ "المرعث"؟', 'لُقب بـ "المرعث" لأنه كان يلبس في أذنيه "رعاثاً" (وهي أقراط أو حلق) في صغره، وظل اللقب ملازماً له.', 'لُقب بـ "المرعث" لأنه كان يلبس في أذنيه "رعاثاً" (وهي أقراط أو حلق) في صغره، وظل اللقب ملازماً له.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'زهير', 'زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار بن برد', 'بشار بن برد', TRUE);
    -- Question 151: q_ar_151
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'شاعر عباسي، بشار بن برد هو؟', 'شاعر عباسي، بشار بن برد هو؟', 'بشار من أصل فارسي (من طخارستان)، وكان جده من السبايا الذين جيء بهم إلى البصرة، وقد كان بشار شديد الافتخار بأصله الفارسي (شعوبياً).', 'بشار من أصل فارسي (من طخارستان)، وكان جده من السبايا الذين جيء بهم إلى البصرة، وقد كان بشار شديد الافتخار بأصله الفارسي (شعوبياً).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عربي الأصل', 'عربي الأصل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'فارسي الأصل', 'فارسي الأصل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'يمني الأصل', 'يمني الأصل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مغربي الأصل', 'مغربي الأصل', FALSE);
    -- Question 152: q_ar_152
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'بشار بن برد ينتمي إلى .....؟', 'بشار بن برد ينتمي إلى .....؟', 'بشار من أصل فارسي من إقليم "طخارستان" (شمال أفغانستان حالياً)، وكان جده من السبايا الذين جيء بهم إلى البصرة.', 'بشار من أصل فارسي من إقليم "طخارستان" (شمال أفغانستان حالياً)، وكان جده من السبايا الذين جيء بهم إلى البصرة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'خراسان', 'خراسان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'طخارستان', 'طخارستان', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'يمن', 'يمن', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البصرة', 'البصرة', FALSE);
    -- Question 153: q_ar_153
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'ولد بشار بن برد في؟', 'ولد بشار بن برد في؟', 'ولد بشار في مدينة البصرة، وهي المدينة التي صقلت لغته وثقافته العربية والفارسية.', 'ولد بشار في مدينة البصرة، وهي المدينة التي صقلت لغته وثقافته العربية والفارسية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كوفة', 'كوفة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بغداد', 'بغداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بصرة', 'بصرة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'اليمن', 'اليمن', FALSE);
    -- Question 154: q_ar_154
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'ولد بشار بن برد عام؟', 'ولد بشار بن برد عام؟', 'ولد في أواخر العصر الأموي سنة 96 هـ، وعاش حتى العصر العباسي، لذا يُعد من المخضرمين (بين الدولتين).', 'ولد في أواخر العصر الأموي سنة 96 هـ، وعاش حتى العصر العباسي، لذا يُعد من المخضرمين (بين الدولتين).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الهجري 96', 'الهجري 96', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الهجري 90', 'الهجري 90', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الهجري 94', 'الهجري 94', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الهجري 92', 'الهجري 92', FALSE);
    -- Question 155: q_ar_155
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من قال لبشار بن برد: "ما أضلَّ أهل هذه المدينة إلا فسقُ أشعار هذا الأعمى الملحد"؟', 'من قال لبشار بن برد: "ما أضلَّ أهل هذه المدينة إلا فسقُ أشعار هذا الأعمى الملحد"؟', 'كان مالك بن دينار زاهداً ورعاً، واستنكر بشدة أشعار بشار بن برد التي كانت تحرض على الفسق والمجون في البصرة.', 'كان مالك بن دينار زاهداً ورعاً، واستنكر بشدة أشعار بشار بن برد التي كانت تحرض على الفسق والمجون في البصرة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الجاحظ', 'الجاحظ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو عمرو بن العلاء', 'أبو عمرو بن العلاء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الأثير', 'ابن الأثير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مالك بن دينار', 'مالك بن دينار', TRUE);
    -- Question 156: q_ar_156
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الأول الذي جمع شعره بين جزالة البدو ورقة الحضر؟', 'من هو الأول الذي جمع شعره بين جزالة البدو ورقة الحضر؟', 'تميز بشار بأنه حافظ على قوة اللغة الجاهلية (الجزالة) مع إدخال معانٍ وصور حضرية رقيقة، وهو ما جعله أستاذ المحدثين.', 'تميز بشار بأنه حافظ على قوة اللغة الجاهلية (الجزالة) مع إدخال معانٍ وصور حضرية رقيقة، وهو ما جعله أستاذ المحدثين.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار بن برد', 'بشار بن برد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة', 'عنترة', FALSE);
    -- Question 157: q_ar_157
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من هو الذي أدرك جريراً وهجاه ولكن جرير لم يجبه؟', 'من هو الذي أدرك جريراً وهجاه ولكن جرير لم يجبه؟', 'حاول بشار في شبابه لفت الأنظار بهجاء جرير، لكن جرير استصغره وقال: "ما هذا بشيء"، وهو ما ندم عليه جرير لاحقاً بعد شهرة بشار.', 'حاول بشار في شبابه لفت الأنظار بهجاء جرير، لكن جرير استصغره وقال: "ما هذا بشيء"، وهو ما ندم عليه جرير لاحقاً بعد شهرة بشار.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار بن برد', 'بشار بن برد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأخطل', 'الأخطل', FALSE);
    -- Question 158: q_ar_158
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'فيمن قيل إن شعره هو الحد الأوسط بين القديم والحديث؟', 'فيمن قيل إن شعره هو الحد الأوسط بين القديم والحديث؟', 'يُعتبر بشار "حلقة الوصل"؛ فهو يشبه امرأ القيس في كونه فتح أبواباً جديدة للشعر لم يسبقه إليها أحد من طبقته.', 'يُعتبر بشار "حلقة الوصل"؛ فهو يشبه امرأ القيس في كونه فتح أبواباً جديدة للشعر لم يسبقه إليها أحد من طبقته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 159: q_ar_159
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'ولد أبو تمام في؟', 'ولد أبو تمام في؟', 'ولد في قرية "جاسم" (قرب دمشق في حوران بسوريا حالياً) وانتقل بعدها إلى مصر ثم العراق.', 'ولد في قرية "جاسم" (قرب دمشق في حوران بسوريا حالياً) وانتقل بعدها إلى مصر ثم العراق.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جاسم', 'جاسم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الموصل', 'الموصل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'العراق', 'العراق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'اليمن', 'اليمن', FALSE);
    -- Question 160: q_ar_160
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'توفي أبو تمام في؟', 'توفي أبو تمام في؟', 'توفي في مدينة الموصل (بالعراق) حيث كان يتولى بريدها في أواخر حياته.', 'توفي في مدينة الموصل (بالعراق) حيث كان يتولى بريدها في أواخر حياته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جاسم', 'جاسم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الموصل', 'الموصل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'العراق', 'العراق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'اليمن', 'اليمن', FALSE);
    -- Question 161: q_ar_161
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'أبو تمام هو رأس الطبقة....... من المولدين؟', 'أبو تمام هو رأس الطبقة....... من المولدين؟', 'يُصنف أبو تمام على أنه رأس الطبقة الأولى من المحدثين (المولدين) لقوة ابتكاره للمعاني الجديدة وإدخاله الفلسفة والمنطق في الشعر.', 'يُصنف أبو تمام على أنه رأس الطبقة الأولى من المحدثين (المولدين) لقوة ابتكاره للمعاني الجديدة وإدخاله الفلسفة والمنطق في الشعر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الثالثة', 'الثالثة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الرابعة', 'الرابعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الثانية', 'الثانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأولى', 'الأولى', TRUE);
    -- Question 162: q_ar_162
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الذي هو شاعر الصناعة اللفظية والمعنوية وعرف بشاعر "المعاني"؟', 'من هو الذي هو شاعر الصناعة اللفظية والمعنوية وعرف بشاعر "المعاني"؟', 'عُرف أبو تمام بشاعر "المعاني" لأنه كان يغوص في استخراج معانٍ دقيقة وغامضة، واهتم بالصناعة البديعية (الطباق والجناس).', 'عُرف أبو تمام بشاعر "المعاني" لأنه كان يغوص في استخراج معانٍ دقيقة وغامضة، واهتم بالصناعة البديعية (الطباق والجناس).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار', 'بشار', FALSE);
    -- Question 163: q_ar_163
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من قال للبحتري: "أنت والله يا بني أمير الشعراء غداً بعدي"؟', 'من قال للبحتري: "أنت والله يا بني أمير الشعراء غداً بعدي"؟', 'قالها أبو تمام عندما عرض عليه البحتري شعره في حمص، فأعجب به وتنبأ له بمستقبل عظيم في الشعر.', 'قالها أبو تمام عندما عرض عليه البحتري شعره في حمص، فأعجب به وتنبأ له بمستقبل عظيم في الشعر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المتنبي', 'المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار', 'بشار', FALSE);
    -- Question 164: q_ar_164
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'لقي البحتري مع أبو تمام في؟', 'لقي البحتري مع أبو تمام في؟', 'كان اللقاء التاريخي الذي غير مسيرة البحتري في مدينة حمص السورية، ومنها انطلق لمرافقة مدرسة أبو تمام.', 'كان اللقاء التاريخي الذي غير مسيرة البحتري في مدينة حمص السورية، ومنها انطلق لمرافقة مدرسة أبو تمام.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'العراق', 'العراق', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بغداد', 'بغداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البصرة', 'البصرة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'حمص (الإجابة في السؤال كانت الكوفة، لكن تاريخياً اللقاء تم في حمص)', 'حمص (الإجابة في السؤال كانت الكوفة، لكن تاريخياً اللقاء تم في حمص)', FALSE);
    -- Question 165: q_ar_165
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الذي مدح أكثر من ستين شخصاً طمعاً في المال والشهرة؟', 'من هو الذي مدح أكثر من ستين شخصاً طمعاً في المال والشهرة؟', 'عُرف البحتري بكثرة مديحه وكسبه الأموال الطائلة من الملوك والوزراء (خاصة المتوكل)، وكان يجمع المال بحرص شديد.', 'عُرف البحتري بكثرة مديحه وكسبه الأموال الطائلة من الملوك والوزراء (خاصة المتوكل)، وكان يجمع المال بحرص شديد.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار', 'بشار', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المتنبي', 'المتنبي', FALSE);
    -- Question 166: q_ar_166
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', '"لو رأيت أبا تمام لرأيت أكمل الناس عقلاً وأدباً وعلمت أن أقل شيء فيه شعره" من قال هذا؟', '"لو رأيت أبا تمام لرأيت أكمل الناس عقلاً وأدباً وعلمت أن أقل شيء فيه شعره" من قال هذا؟', 'هذه شهادة وفاء عظيمة من التلميذ (البحتري) لأستاذه (أبو تمام)، مبيناً أن ثقافة وعقل أبو تمام كانا أعظم حتى من شعره الجميل.', 'هذه شهادة وفاء عظيمة من التلميذ (البحتري) لأستاذه (أبو تمام)، مبيناً أن ثقافة وعقل أبو تمام كانا أعظم حتى من شعره الجميل.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المتنبي', 'المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار', 'بشار', FALSE);
    -- Question 167: q_ar_167
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'hard', 'من هو الذي كان قوي الذاكرة سريع الحفظ وقد رووا عنه في ذلك الأعاجيب فزعموا أنه كان يحفظ ما يفهم وما لا يفهم؟', 'من هو الذي كان قوي الذاكرة سريع الحفظ وقد رووا عنه في ذلك الأعاجيب فزعموا أنه كان يحفظ ما يفهم وما لا يفهم؟', 'عُرف المتنبي بذاكرة خارقة منذ صباه، ويُروى أنه كان يذهب إلى الوراقين (باعة الكتب) فيقرأ كتاباً كاملاً ضخماً في دكانهم مرة واحدة فيحفظه عن ظهر قلب دون الحاجة لشرائه.', 'عُرف المتنبي بذاكرة خارقة منذ صباه، ويُروى أنه كان يذهب إلى الوراقين (باعة الكتب) فيقرأ كتاباً كاملاً ضخماً في دكانهم مرة واحدة فيحفظه عن ظهر قلب دون الحاجة لشرائه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المتنبي', 'المتنبي', TRUE);
    -- Question 168: q_ar_168
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'ولد المتنبي سنة؟', 'ولد المتنبي سنة؟', 'ولد في محلة كِندة بالكوفة سنة 303 هـ، ونشأ في البادية ليتعلم فصاحة اللغة العربية.', 'ولد في محلة كِندة بالكوفة سنة 303 هـ، ونشأ في البادية ليتعلم فصاحة اللغة العربية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الهجري 303', 'الهجري 303', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الهجري 302', 'الهجري 302', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الهجري 308', 'الهجري 308', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الهجري 305', 'الهجري 305', FALSE);
    -- Question 169: q_ar_169
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'ينتمي المتنبي إلى قبيلة ....؟', 'ينتمي المتنبي إلى قبيلة ....؟', 'يُنسب المتنبي إلى قبيلة كِندة اليمنية العريقة لأنه ولد في محلتهم بالكوفة، ويُقال له الكوفي الكندي.', 'يُنسب المتنبي إلى قبيلة كِندة اليمنية العريقة لأنه ولد في محلتهم بالكوفة، ويُقال له الكوفي الكندي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'يمنية', 'يمنية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أزدية', 'أزدية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بكرية', 'بكرية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كندية', 'كندية', TRUE);
    -- Question 170: q_ar_170
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'ادعى المتنبي النبوة في الشام وفتن شرذمة من الناس بقوة أدبه وسحر بيانه في سنة ...؟؟', 'ادعى المتنبي النبوة في الشام وفتن شرذمة من الناس بقوة أدبه وسحر بيانه في سنة ...؟؟', 'في بادية الشام (قرب حمص)، التفت حوله جماعة من الأعراب لشدة تأثير كلامه وسحر بيانه، فادعى النبوة سنة 323 هـ وسجنه لؤلؤ أمير حمص بسبب ذلك حتى تاب ورجع عنها، ولهذا لُقب بـ "المتنبي".', 'في بادية الشام (قرب حمص)، التفت حوله جماعة من الأعراب لشدة تأثير كلامه وسحر بيانه، فادعى النبوة سنة 323 هـ وسجنه لؤلؤ أمير حمص بسبب ذلك حتى تاب ورجع عنها، ولهذا لُقب بـ "المتنبي".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الهجري 323', 'الهجري 323', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الهجري 324', 'الهجري 324', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الهجري 326', 'الهجري 326', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الهجري 328', 'الهجري 328', FALSE);
    -- Question 171: q_ar_171
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'من هو الذي نظم أول أشعاره من عمره في 9 سنوات؟', 'من هو الذي نظم أول أشعاره من عمره في 9 سنوات؟', 'ظهرت موهبة المتنبي الفذة وهو طفل صغير، حيث صاغ أبياتاً موزونة ومقفاة وهو في التاسعة من عمره ليعلن عن ولادة عبقرية شعرية فريدة.', 'ظهرت موهبة المتنبي الفذة وهو طفل صغير، حيث صاغ أبياتاً موزونة ومقفاة وهو في التاسعة من عمره ليعلن عن ولادة عبقرية شعرية فريدة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المتنبي', 'المتنبي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 172: q_ar_172
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'ألف أبو العلاء المعري "ذكرى حبيب" لشرح ديوان ...؟؟؟', 'ألف أبو العلاء المعري "ذكرى حبيب" لشرح ديوان ...؟؟؟', '"حبيب" في اسم الكتاب هو حبيب بن أوس الطائي (أبو تمام)، وقد وضع المعري هذا الكتاب لشرح وتفسير ديوانه لإعجابه بأسلوبه. (كما وضع كتاباً لشرح ديوان المتنبي سماه "معجز أحمد").', '"حبيب" في اسم الكتاب هو حبيب بن أوس الطائي (أبو تمام)، وقد وضع المعري هذا الكتاب لشرح وتفسير ديوانه لإعجابه بأسلوبه. (كما وضع كتاباً لشرح ديوان المتنبي سماه "معجز أحمد").', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المتنبي', 'المتنبي', FALSE);
    -- Question 173: q_ar_173
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'كتاب "الأيك والغصون" لمن؟', 'كتاب "الأيك والغصون" لمن؟', 'هذا الكتاب من مؤلفات المعري الضخمة في اللغة والأدب، ويُعرف أيضاً باسم "الهمزة والردف".', 'هذا الكتاب من مؤلفات المعري الضخمة في اللغة والأدب، ويُعرف أيضاً باسم "الهمزة والردف".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 174: q_ar_174
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', '"سقط الزند" لمن؟', '"سقط الزند" لمن؟', '"سقط الزند" هو الديوان الشعري الأول لأبي العلاء المعري، ونظمه في مرحلة شبابه قبل أن يعتزل الناس، ويتميز بقوة الديباجة وفصاحة الألفاظ.', '"سقط الزند" هو الديوان الشعري الأول لأبي العلاء المعري، ونظمه في مرحلة شبابه قبل أن يعتزل الناس، ويتميز بقوة الديباجة وفصاحة الألفاظ.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الفرزدق', 'الفرزدق', FALSE);
    -- Question 175: q_ar_175
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', '"رسالة الغفران" لمن؟', '"رسالة الغفران" لمن؟', 'هي أشهر عمل نثري فلسفي للمعري، كتبها رداً على رسالة ابن القارح، وتخيل فيها رحلة إلى الدار الآخرة (الجنة والنار)، وتُعد من روائع الأدب العالمي.', 'هي أشهر عمل نثري فلسفي للمعري، كتبها رداً على رسالة ابن القارح، وتخيل فيها رحلة إلى الدار الآخرة (الجنة والنار)، وتُعد من روائع الأدب العالمي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', FALSE);
    -- Question 176: q_ar_176
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'توفي أبو العلاء المعري سنة ؟', 'توفي أبو العلاء المعري سنة ؟', 'توفي في مسقط رأسه بمدينة "معرة النعمان" في الشام سنة 449 هـ، بعد أن قضا عقوداً من عمره زاهداً معتزلاً (رهين المحبسين: العمى والبيت).', 'توفي في مسقط رأسه بمدينة "معرة النعمان" في الشام سنة 449 هـ، بعد أن قضا عقوداً من عمره زاهداً معتزلاً (رهين المحبسين: العمى والبيت).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الهجري 449', 'الهجري 449', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الهجري 448', 'الهجري 448', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الهجري 445', 'الهجري 445', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الهجري 442', 'الهجري 442', FALSE);
    -- Question 177: q_ar_177
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي كان شاعراً من شعراء المعاني وفق بين الشعر والفلسفة وجعل أكثر عنايته بالمعنى؟', 'من هو الذي كان شاعراً من شعراء المعاني وفق بين الشعر والفلسفة وجعل أكثر عنايته بالمعنى؟', 'أبو تمام هو زعيم هذه المدرسة؛ حيث أدخل الفلسفة والمنطق وأفكار المعتزلة في صياغة المعاني الشعرية، فجعل الفكرة والعمق المعنوي يتقدمان على الصياغة اللفظية التقليدية، مما فتح باباً واسعاً 1. البحتري (الوليد بن عبيد الطائي)', 'أبو تمام هو زعيم هذه المدرسة؛ حيث أدخل الفلسفة والمنطق وأفكار المعتزلة في صياغة المعاني الشعرية، فجعل الفكرة والعمق المعنوي يتقدمان على الصياغة اللفظية التقليدية، مما فتح باباً واسعاً 1. البحتري (الوليد بن عبيد الطائي)', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المتنبي', 'المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الفرزدق', 'الفرزدق', FALSE);
    -- Question 178: q_ar_178
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'توفي البحتري سنة ؟', 'توفي البحتري سنة ؟', 'توفي البحتري سنة 284 هـ في مدينة منبج بالشام، بعد حياة حافلة بالشعر والتنقل بين بلاد الشام والعراق.', 'توفي البحتري سنة 284 هـ في مدينة منبج بالشام، بعد حياة حافلة بالشعر والتنقل بين بلاد الشام والعراق.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الهجري 284', 'الهجري 284', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الهجري 286', 'الهجري 286', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الهجري 287', 'الهجري 287', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الهجري 288', 'الهجري 288', FALSE);
    -- Question 179: q_ar_179
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'ولد البحتري في ؟', 'ولد البحتري في ؟', 'ولد البحتري في مدينة "منبج" بالشام (قرب حلب)، وتُكتب في بعض الأسئلة والخيارات القديمة محرفة أو إشارة لـ "منبج".', 'ولد البحتري في مدينة "منبج" بالشام (قرب حلب)، وتُكتب في بعض الأسئلة والخيارات القديمة محرفة أو إشارة لـ "منبج".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المسقط', 'المسقط', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المنيح (منبج)', 'المنيح (منبج)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الفارس', 'الفارس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الروم', 'الروم', FALSE);
    -- Question 180: q_ar_180
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'البحتري هو ؟', 'البحتري هو ؟', 'البحتري عربي خالص الأبوين ينتمي إلى قبيلة "طَيِّئ" العربية العريقة، ولقبه البحتري نسبة إلى "بحتر" وهو بطن من بطون طيئ.', 'البحتري عربي خالص الأبوين ينتمي إلى قبيلة "طَيِّئ" العربية العريقة، ولقبه البحتري نسبة إلى "بحتر" وهو بطن من بطون طيئ.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عربي الأصل', 'عربي الأصل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'فارسي الأصل', 'فارسي الأصل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'يمني الأصل', 'يمني الأصل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مغربي الأصل', 'مغربي الأصل', FALSE);
    -- Question 181: q_ar_181
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من قال "أنا وأبو تمام حكيمان والشاعر البحتري"؟', 'من قال "أنا وأبو تمام حكيمان والشاعر البحتري"؟', 'أطلق أبو الطيب المتنبي هذه المقولة النقدية الشهيرة ليصنف فيها أسلوبه وأسلوب أبي تمام في كفة "الحكمة والعمق الفكري"، بينما جعل البحتري هو "الشاعر" الحقيقي لتميزه بسلاسل اللفظ وديباجة الشعر الموسيقية التقليدية.', 'أطلق أبو الطيب المتنبي هذه المقولة النقدية الشهيرة ليصنف فيها أسلوبه وأسلوب أبي تمام في كفة "الحكمة والعمق الفكري"، بينما جعل البحتري هو "الشاعر" الحقيقي لتميزه بسلاسل اللفظ وديباجة الشعر الموسيقية التقليدية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار', 'بشار', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المتنبي', 'المتنبي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 182: q_ar_182
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي ظل في العراق يخدم المتوكل ووزيره الفتح بن خاقان لخمسة عشر عاماً؟', 'من هو الذي ظل في العراق يخدم المتوكل ووزيره الفتح بن خاقان لخمسة عشر عاماً؟', 'لازم البحتري الخليفة العباسي المتوكل ووزيره المقرب الفتح بن خاقان، وكان شاعر البلاط الأول لهما، ورثاهما رثاءً فاجعاً بعد مقتلهما في ليلة واحدة.', 'لازم البحتري الخليفة العباسي المتوكل ووزيره المقرب الفتح بن خاقان، وكان شاعر البلاط الأول لهما، ورثاهما رثاءً فاجعاً بعد مقتلهما في ليلة واحدة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البحتري', 'البحتري', TRUE);
    -- Question 183: q_ar_183
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي نشأ فقيراً وتوفي غنياً؟', 'من هو الذي نشأ فقيراً وتوفي غنياً؟', 'ولد البحتري في بيئة متواضعة، ولكنه استطاع بفضل مديحه للخلفاء والوزراء والولاة أن يجمع ثروة طائلة وأموالاً وعقارات، وعُرف عنه شدة الحرص على جمع المال.', 'ولد البحتري في بيئة متواضعة، ولكنه استطاع بفضل مديحه للخلفاء والوزراء والولاة أن يجمع ثروة طائلة وأموالاً وعقارات، وعُرف عنه شدة الحرص على جمع المال.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البحتري', 'البحتري', TRUE);
    -- Question 184: q_ar_184
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'دفن البحتري في ....؟', 'دفن البحتري في ....؟', 'بعد مقتل المتوكل واضطراب الأوضاع في بغداد، عاد البحتري إلى مسقط رأسه "منبج" وعاش فيها أواخر أيامه ودُفن هناك.', 'بعد مقتل المتوكل واضطراب الأوضاع في بغداد، عاد البحتري إلى مسقط رأسه "منبج" وعاش فيها أواخر أيامه ودُفن هناك.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الحلب', 'الحلب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المنبج (منبج)', 'المنبج (منبج)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'مدينة الباب', 'مدينة الباب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'العراق', 'العراق', FALSE);
    -- Question 185: q_ar_185
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'توفي ابن الرومي في......؟', 'توفي ابن الرومي في......؟', 'توفي في مدينة بغداد، وكان منزله في الجانب الشرقي منها، ويُذكر مكان وفاته تاريخياً بـ "بغداد" (وقد تشير الصافية إلى محلة أو منطقة قريبة منها بالروايات).', 'توفي في مدينة بغداد، وكان منزله في الجانب الشرقي منها، ويُذكر مكان وفاته تاريخياً بـ "بغداد" (وقد تشير الصافية إلى محلة أو منطقة قريبة منها بالروايات).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'العقيقة', 'العقيقة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الصافية', 'الصافية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البصرة', 'البصرة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الكوفة', 'الكوفة', FALSE);
    -- Question 186: q_ar_186
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الذي قرض أشعاراً كثيرة عن الطعام والشراب؟', 'من هو الذي قرض أشعاراً كثيرة عن الطعام والشراب؟', 'تميز ابن الرومي بالقدرة على وصف أدق تفاصيل الحياة اليومية، ومنها وصفه الشهير والبارع للأطعمة مثل (الرقاق، القطايف، الزلابية) والشراب، بطريقة لم يسبقه إليها أحد.', 'تميز ابن الرومي بالقدرة على وصف أدق تفاصيل الحياة اليومية، ومنها وصفه الشهير والبارع للأطعمة مثل (الرقاق، القطايف، الزلابية) والشراب، بطريقة لم يسبقه إليها أحد.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 187: q_ar_187
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'hard', 'من هو الذي كان شديد الطيرة (التشاؤم) يغلو فيها ويحتج لها ويقول "إن النبي صلى الله عليه وسلم كان يحب الفأل ويكره الطيرة"؟', 'من هو الذي كان شديد الطيرة (التشاؤم) يغلو فيها ويحتج لها ويقول "إن النبي صلى الله عليه وسلم كان يحب الفأل ويكره الطيرة"؟', 'كان ابن الرومي شخصية سيكولوجية معقدة، يفرط في التشاؤم (الطيرة) من الأسماء والأشكال والوجوه، وكان يعتزل الخروج من بيته لأيام إن رأى هلالاً أو شخصاً لا يعجبه ملامحه.', 'كان ابن الرومي شخصية سيكولوجية معقدة، يفرط في التشاؤم (الطيرة) من الأسماء والأشكال والوجوه، وكان يعتزل الخروج من بيته لأيام إن رأى هلالاً أو شخصاً لا يعجبه ملامحه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البحتري', 'البحتري', FALSE);
    -- Question 188: q_ar_188
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'hard', 'من الذي عندما أحس بالسم قام فقال له الوزير إلى أين؟ فقال "إلى الموضع الذي بعثت بي إليه" فقال له الوزير: "سلم على والدي" فقال: "ليس طريقي على النار"؟', 'من الذي عندما أحس بالسم قام فقال له الوزير إلى أين؟ فقال "إلى الموضع الذي بعثت بي إليه" فقال له الوزير: "سلم على والدي" فقال: "ليس طريقي على النار"؟', 'هذه الحادثة التاريخية جرت عندما سمه وزير المعتضد (القاسم بن عبيد الله) خوفاً من هجائه اللاذع، فلما أكل ابن الرومي الموز المسموم وأحس بـ مفعوله قام، فدار هذا الحوار التهكمي القاسي بينه وبين الوزير قبل أن يموت.', 'هذه الحادثة التاريخية جرت عندما سمه وزير المعتضد (القاسم بن عبيد الله) خوفاً من هجائه اللاذع، فلما أكل ابن الرومي الموز المسموم وأحس بـ مفعوله قام، فدار هذا الحوار التهكمي القاسي بينه وبين الوزير قبل أن يموت.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المتنبي', 'المتنبي', FALSE);
    -- Question 189: q_ar_189
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الذي هو شاعر الصناعة اللفظية والمعنوية وعرف بشاعر المعاني؟', 'من هو الذي هو شاعر الصناعة اللفظية والمعنوية وعرف بشاعر المعاني؟', 'أبو تمام هو إمام مدرسة البديع والصناعة المعنوية وتوليد الأفكار الغامضة.', 'أبو تمام هو إمام مدرسة البديع والصناعة المعنوية وتوليد الأفكار الغامضة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار', 'بشار', FALSE);
    -- Question 190: q_ar_190
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'فيمن قيل "إن اختياره أبلغ منه في شعره"؟', 'فيمن قيل "إن اختياره أبلغ منه في شعره"؟', 'قيلت هذه العبارة النقدية الشهيرة في حق أبي تمام بسبب كتابته لديوان "الحماسة"، حيث جمع فيه عيون الشعر العربي القديم بذكاء نقدي خارق فاق في حسن ذوقه بعض قصائده الشخصية.', 'قيلت هذه العبارة النقدية الشهيرة في حق أبي تمام بسبب كتابته لديوان "الحماسة"، حيث جمع فيه عيون الشعر العربي القديم بذكاء نقدي خارق فاق في حسن ذوقه بعض قصائده الشخصية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار', 'بشار', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 191: q_ar_191
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'ابن الرومي هو شاعر من شعراء القرن ... الهجري في العصر العباسي؟', 'ابن الرومي هو شاعر من شعراء القرن ... الهجري في العصر العباسي؟', 'عاش ابن الرومي في القرن الثالث الهجري (ولد 221 هـ وتوفي 283 هـ)، وعاصر خلافيات عباسية متعددة في عصر سامراء وبغداد.', 'عاش ابن الرومي في القرن الثالث الهجري (ولد 221 هـ وتوفي 283 هـ)، وعاصر خلافيات عباسية متعددة في عصر سامراء وبغداد.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الثاني', 'الثاني', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الثالث', 'الثالث', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الرابع', 'الرابع', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الخامس', 'الخامس', FALSE);
    -- Question 192: q_ar_192
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الذي قام بمدح أبي القاسم الشطراحي والقاسم بن عبد الله وزير المعتضد؟', 'من هو الذي قام بمدح أبي القاسم الشطراحي والقاسم بن عبد الله وزير المعتضد؟', 'مدح ابن الرومي هؤلاء الأعلام في بغداد، وكان يرجو نوالهم، والوزير القاسم بن عبيد الله هو نفسه الذي تسبب في قتله بالسم لاحقاً.', 'مدح ابن الرومي هؤلاء الأعلام في بغداد، وكان يرجو نوالهم، والوزير القاسم بن عبيد الله هو نفسه الذي تسبب في قتله بالسم لاحقاً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المتنبي', 'المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 193: q_ar_193
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الذي توفي مسموماً؟', 'من هو الذي توفي مسموماً؟', 'مات مقتولاً بالسم بتدبير من وزير الخليفة المعتضد خشية لسانه وهجائه.', 'مات مقتولاً بالسم بتدبير من وزير الخليفة المعتضد خشية لسانه وهجائه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المتنبي', 'المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 194: q_ar_194
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'أسلم ابن الرومي على يد؟', 'أسلم ابن الرومي على يد؟', 'يذكر الرواة والمؤرخون للأدب أن جده أو أباه أسلم على يد عيسى بن عبد الله بن جعفر العباسي، فصاروا موالي لهم.', 'يذكر الرواة والمؤرخون للأدب أن جده أو أباه أسلم على يد عيسى بن عبد الله بن جعفر العباسي، فصاروا موالي لهم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عبد الله بن عيسى بن جعفر', 'عبد الله بن عيسى بن جعفر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبيد الله بن عيسى بن جعفر', 'عبيد الله بن عيسى بن جعفر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عيسى بن عبيد الله بن جعفر', 'عيسى بن عبيد الله بن جعفر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عيسى بن عبد الله بن جعفر', 'عيسى بن عبد الله بن جعفر', TRUE);
    -- Question 195: q_ar_195
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'كان ابن الرومي لأبوين من؟', 'كان ابن الرومي لأبوين من؟', 'هو علي بن العباس، كان أبوه من أصل يوناني/رومي (لذا لُقب بابن الرومي) وأمه من أصل فارسي عُرفت بالثقافة والتدين. تزاوج الثقافتين منحه عقلية تحليلية فريدة في شعره.', 'هو علي بن العباس، كان أبوه من أصل يوناني/رومي (لذا لُقب بابن الرومي) وأمه من أصل فارسي عُرفت بالثقافة والتدين. تزاوج الثقافتين منحه عقلية تحليلية فريدة في شعره.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أب رومي وأم فارسية', 'أب رومي وأم فارسية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أب فارسي وأم رومية', 'أب فارسي وأم رومية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أب عربي وأم فارسية', 'أب عربي وأم فارسية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أب فارسي وأم عربية', 'أب فارسي وأم عربية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_5', 'للتجديد.', 'للتجديد.', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_6', 'EXTRA QUESTIONS.', 'EXTRA QUESTIONS.', FALSE);
    -- Question 196: q_ar_196
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'اختر العبارة الصحيحة:', 'اختر العبارة الصحيحة:', 'ينتمي امرؤ القيس إلى قبيلة "كِندة" وهي قبيلة يمنية الأصل، ولكن والده وأجداده أسسوا ملكهم في وسط الجزيرة العربية، فنشأ وعاش في "نجد".', 'ينتمي امرؤ القيس إلى قبيلة "كِندة" وهي قبيلة يمنية الأصل، ولكن والده وأجداده أسسوا ملكهم في وسط الجزيرة العربية، فنشأ وعاش في "نجد".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'نشأ امرؤ القيس نجدياً وإن كان يمنياً', 'نشأ امرؤ القيس نجدياً وإن كان يمنياً', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'نشأ امرؤ القيس يمنياً وإن كان نجدياً', 'نشأ امرؤ القيس يمنياً وإن كان نجدياً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'نشأ امرؤ القيس كندياً وإن كان نجدياً', 'نشأ امرؤ القيس كندياً وإن كان نجدياً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'نشأ امرؤ القيس نجدياً وإن كان عبسياً', 'نشأ امرؤ القيس نجدياً وإن كان عبسياً', FALSE);
    -- Question 197: q_ar_197
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من قال "ضيعني أبي صغيراً وحملني دمه كبيراً، لا صحو اليوم ولا سكر غداً، اليوم خمر وغداً أمر"؟', 'من قال "ضيعني أبي صغيراً وحملني دمه كبيراً، لا صحو اليوم ولا سكر غداً، اليوم خمر وغداً أمر"؟', 'قالها عندما جاءه خبر مقتل والده (الملك حُجر) على يد قبيلة بني أسد وهو يشرب الخمر، فرفض أن يقطع مجلسه، وأطلق هذه المقولة التاريخية التي تلتها حرب استرداد الملك.', 'قالها عندما جاءه خبر مقتل والده (الملك حُجر) على يد قبيلة بني أسد وهو يشرب الخمر، فرفض أن يقطع مجلسه، وأطلق هذه المقولة التاريخية التي تلتها حرب استرداد الملك.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'امرؤ القيس', 'امرؤ القيس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    -- Question 198: q_ar_198
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من الذي صاحب القصص الصريحي (القصص الغرامي الصريح) من شعراء المعلقات؟', 'من الذي صاحب القصص الصريحي (القصص الغرامي الصريح) من شعراء المعلقات؟', 'تميزت معلقة امرئ القيس بالإفراط في ذكر مغامراته القصصية والليلية الصريحة مع النساء (مثل قصته الشهيرة في دارة جُلجُل مع عنيزة).', 'تميزت معلقة امرئ القيس بالإفراط في ذكر مغامراته القصصية والليلية الصريحة مع النساء (مثل قصته الشهيرة في دارة جُلجُل مع عنيزة).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأعشى قيس', 'الأعشى قيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'امرؤ القيس', 'امرؤ القيس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    -- Question 199: q_ar_199
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الذي وقف على الأطلال وبكى على الديار وشبب بالنساء وشبههن بالمها والظباء؟', 'من هو الذي وقف على الأطلال وبكى على الديار وشبب بالنساء وشبههن بالمها والظباء؟', 'هو إمام الشعراء في "استيقاف الصحب" وبكاء الأطلال؛ حيث افتتح معلقته بـ "قفا نبك من ذكرى حبيب ومنزل"، وهو أول من شبّه النساء بظباء المها في التشبيهات الجاهلية المستقرة.', 'هو إمام الشعراء في "استيقاف الصحب" وبكاء الأطلال؛ حيث افتتح معلقته بـ "قفا نبك من ذكرى حبيب ومنزل"، وهو أول من شبّه النساء بظباء المها في التشبيهات الجاهلية المستقرة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'امرؤ القيس', 'امرؤ القيس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    -- Question 200: q_ar_200
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'أول شعر عُلق في الجاهلية هو شعر؟', 'أول شعر عُلق في الجاهلية هو شعر؟', 'يُجمع الرواة والنقاد على أن معلقة امرئ القيس كانت في مقدمة القصائد التي تم اختيارها لتُعلق على أستار الكعبة لعلو كعبها الأدبي.', 'يُجمع الرواة والنقاد على أن معلقة امرئ القيس كانت في مقدمة القصائد التي تم اختيارها لتُعلق على أستار الكعبة لعلو كعبها الأدبي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'امرؤ القيس', 'امرؤ القيس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'النابغة الذبياني', 'النابغة الذبياني', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    -- Question 201: q_ar_201
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الذي نشأ في نجد عبداً يرعى الإبل محتقراً في عين والده وأعمامه؟', 'من هو الذي نشأ في نجد عبداً يرعى الإبل محتقراً في عين والده وأعمامه؟', 'ولد عنترة لأب عربي (شداد العبسي) وأم أمة حبشية، فلَم يعترف به أبوه وفقاً لتقاليد الجاهلية، وظل يعامل كعبد يرعى الإبل حتى أثبت فروسيته في الدفاع عن القبيلة فاعترف به والده وحررّه.', 'ولد عنترة لأب عربي (شداد العبسي) وأم أمة حبشية، فلَم يعترف به أبوه وفقاً لتقاليد الجاهلية، وظل يعامل كعبد يرعى الإبل حتى أثبت فروسيته في الدفاع عن القبيلة فاعترف به والده وحررّه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'النابغة الذبياني', 'النابغة الذبياني', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'لبيد بن ربيعة', 'لبيد بن ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'طرفة بن العبد', 'طرفة بن العبد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة بن شداد', 'عنترة بن شداد', TRUE);
    -- Question 202: q_ar_202
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'هو من أصحاب المعلقات، اسم أمه زبيبة وهي جارية حبشية .... من؟', 'هو من أصحاب المعلقات، اسم أمه زبيبة وهي جارية حبشية .... من؟', 'أمه هي "زبيبة" الحبشية، ومنها ورث عنترة سواد لونه، وكان يُعد من "أغربة العرب" (الذين ورثوا السواد من أمهاتهم).', 'أمه هي "زبيبة" الحبشية، ومنها ورث عنترة سواد لونه، وكان يُعد من "أغربة العرب" (الذين ورثوا السواد من أمهاتهم).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حارث بن حلزة', 'حارث بن حلزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عنترة بن شداد', 'عنترة بن شداد', TRUE);
    -- Question 203: q_ar_203
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الذي نشأ بالجزيرة الفراتية بين ذوي الحسب اللباب من تغلب؟', 'من هو الذي نشأ بالجزيرة الفراتية بين ذوي الحسب اللباب من تغلب؟', 'عمرو بن كلثوم هو سيد قبيلة "تغلب" وفارسها، وكان موطن قبيلته يتمركز في الجزيرة الفراتية (بين العراق وسوريا حالياً)، وعُرف بمعلقته الفخرية الحماسية.', 'عمرو بن كلثوم هو سيد قبيلة "تغلب" وفارسها، وكان موطن قبيلته يتمركز في الجزيرة الفراتية (بين العراق وسوريا حالياً)، وعُرف بمعلقته الفخرية الحماسية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأعشى قيس', 'الأعشى قيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمرو بن كلثوم', 'عمرو بن كلثوم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    -- Question 204: q_ar_204
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'من هو الذي يمني الأصل وقحطاني النسب من هؤلاء الشعراء؟', 'من هو الذي يمني الأصل وقحطاني النسب من هؤلاء الشعراء؟', 'الشنفرى الأزدي ينتمي إلى قبيلة "الأزد" وهي قبيلة قحطانية يمنية الأصل شهيرة، وهو من فتاك العرب الصعاليك وصاحب "لامية العرب". (ملاحظة: إذا ورد هذا السؤال في نماذج الامتحانات، فالشنفرى الأزدي هو الإجابة الدقيقة للنسب القحطاني الصريح).', 'الشنفرى الأزدي ينتمي إلى قبيلة "الأزد" وهي قبيلة قحطانية يمنية الأصل شهيرة، وهو من فتاك العرب الصعاليك وصاحب "لامية العرب". (ملاحظة: إذا ورد هذا السؤال في نماذج الامتحانات، فالشنفرى الأزدي هو الإجابة الدقيقة للنسب القحطاني الصريح).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الشنفرى', 'الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأخطل', 'الأخطل', FALSE);
    -- Question 205: q_ar_205
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'ليس من العرب البائدة؟', 'ليس من العرب البائدة؟', 'العرب البائدة هم الذين بادوا وهلكوا قبل الإسلام بقرون (مثل عاد، وثمود، وطسم، وجديس، وجاسم). أما حمير فهم من العرب الباقية (العاربة القحطانية) في اليمن.', 'العرب البائدة هم الذين بادوا وهلكوا قبل الإسلام بقرون (مثل عاد، وثمود، وطسم، وجديس، وجاسم). أما حمير فهم من العرب الباقية (العاربة القحطانية) في اليمن.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عاد', 'عاد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جاسم', 'جاسم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'طسم', 'طسم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'حمير', 'حمير', TRUE);
    -- Question 206: q_ar_206
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'اختر الشاذ؟ (في أقسام العرب)', 'اختر الشاذ؟ (في أقسام العرب)', 'أقسام العرب التاريخية الثلاثة المشهورة هي: البائدة، والعاربة (القحطانية)، والمستعربة (العدنانية). لفظ "المستعرية" لفظ خاطئ وشاذ لا وجود له في التقسيم.', 'أقسام العرب التاريخية الثلاثة المشهورة هي: البائدة، والعاربة (القحطانية)، والمستعربة (العدنانية). لفظ "المستعرية" لفظ خاطئ وشاذ لا وجود له في التقسيم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'العرب العاربة', 'العرب العاربة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'العرب المستعرية', 'العرب المستعرية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'العرب المستعربة', 'العرب المستعربة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'العرب البائدة', 'العرب البائدة', FALSE);
    -- Question 207: q_ar_207
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'العرب العاربة هم يعرفون بـ.....؟', 'العرب العاربة هم يعرفون بـ.....؟', 'العرب العاربة هم القحطانيون وموطنهم الأصلي اليمن (الجنوب)، أما العرب المستعربة فهم العدنانيون ويعرفون بعرب الشمال.', 'العرب العاربة هم القحطانيون وموطنهم الأصلي اليمن (الجنوب)، أما العرب المستعربة فهم العدنانيون ويعرفون بعرب الشمال.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عرب الشمال', 'عرب الشمال', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عرب الجنوب', 'عرب الجنوب', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عرب الشرق', 'عرب الشرق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عرب الغرب', 'عرب الغرب', FALSE);
    -- Question 208: q_ar_208
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'اللغة العربية هي إحدى اللغات ....؟', 'اللغة العربية هي إحدى اللغات ....؟', 'تنتمي العربية إلى الأسرة اللغوية "السامية" (نسبة إلى سام بن نوح)، والتي تضم أيضاً العبرية، والآرامية، والأمهرية.', 'تنتمي العربية إلى الأسرة اللغوية "السامية" (نسبة إلى سام بن نوح)، والتي تضم أيضاً العبرية، والآرامية، والأمهرية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'السامية', 'السامية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأشورية', 'الأشورية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'السنسكريتية', 'السنسكريتية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'السريانية', 'السريانية', FALSE);
    -- Question 209: q_ar_209
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'ليس من اللغات الآرامية؟', 'ليس من اللغات الآرامية؟', 'العربية لغة سامية مستقلة برأسها (من الفرع الجنوبي الأوسط)، وليست فرعاً من اللغات الآرامية التي تفرعت منها السريانية والكلدانية.', 'العربية لغة سامية مستقلة برأسها (من الفرع الجنوبي الأوسط)، وليست فرعاً من اللغات الآرامية التي تفرعت منها السريانية والكلدانية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الكلدانية', 'الكلدانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الآشورية', 'الآشورية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'العربية', 'العربية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'السريانية', 'السريانية', FALSE);
    -- Question 210: q_ar_210
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'ليس من اللغات الأرية؟', 'ليس من اللغات الأرية؟', 'اللاتينية واليونانية والسنسكريتية (الهندية القديمة) لغات هندو-أوروبية (آرية). أما الآرامية فهي لغة سامية مئة بالمئة.', 'اللاتينية واليونانية والسنسكريتية (الهندية القديمة) لغات هندو-أوروبية (آرية). أما الآرامية فهي لغة سامية مئة بالمئة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الآرامية', 'الآرامية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'اللاتينية', 'اللاتينية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'اليونانية', 'اليونانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'السنسكريتية', 'السنسكريتية', FALSE);
    -- Question 211: q_ar_211
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'ليس من اللغات السامية؟', 'ليس من اللغات السامية؟', 'اليونانية لغة أوروبية (آرية) وليست سامية.', 'اليونانية لغة أوروبية (آرية) وليست سامية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الآرامية', 'الآرامية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الكنعانية', 'الكنعانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'اليونانية', 'اليونانية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'العربية', 'العربية', FALSE);
    -- Question 212: q_ar_212
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'اختر الشاذ؟ (في المجموعات اللغوية)', 'اختر الشاذ؟ (في المجموعات اللغوية)', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الآرامية', 'الآرامية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الكنعانية', 'الكنعانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'العربية', 'العربية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'العبرانية (ملاحظة: هذا السؤال مكرر بصيغة أخرى، وجميع الخيارات سامية، لكن تاريخياً قد يُقصد بـ العربية أنها من السامية الجنوبية بينما الآرامية والكنعانية والعبرية من السامية الشمالية الغربية، أو أن الشاذ هو لغة أخرى خارج المجموعة كاليونانية).', 'العبرانية (ملاحظة: هذا السؤال مكرر بصيغة أخرى، وجميع الخيارات سامية، لكن تاريخياً قد يُقصد بـ العربية أنها من السامية الجنوبية بينما الآرامية والكنعانية والعبرية من السامية الشمالية الغربية، أو أن الشاذ هو لغة أخرى خارج المجموعة كاليونانية).', TRUE);
    -- Question 213: q_ar_213
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'عاصمة مملكة المناذرة؟', 'عاصمة مملكة المناذرة؟', 'مملكة المناذرة (لخم) كان مقرها مدينة الحيرة في العراق وكانوا حلفاء للفرس، بينما كانت "بُصرى" عاصمة الغساسنة حلفاء الروم.', 'مملكة المناذرة (لخم) كان مقرها مدينة الحيرة في العراق وكانوا حلفاء للفرس، بينما كانت "بُصرى" عاصمة الغساسنة حلفاء الروم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'اليمن', 'اليمن', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الحيرة', 'الحيرة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'يثرب', 'يثرب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'مكة', 'مكة', FALSE);
    -- Question 214: q_ar_214
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'ليست من أسواق العرب؟', 'ليست من أسواق العرب؟', 'عكاظ، ومجنة، وذو المجاز هي أسواق أدبية وتجارية مشهورة في الجاهلية. أما ذي قار فهو اسم "معركة" مشهورة انتصر فيها العرب على الفرس، وليس سوقاً.', 'عكاظ، ومجنة، وذو المجاز هي أسواق أدبية وتجارية مشهورة في الجاهلية. أما ذي قار فهو اسم "معركة" مشهورة انتصر فيها العرب على الفرس، وليس سوقاً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عكاظ', 'عكاظ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ذو المجنة', 'ذو المجنة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ذي قار', 'ذي قار', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ذو المجاز', 'ذو المجاز', FALSE);
    -- Question 215: q_ar_215
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من خصائص الشعر أنه لا يعتمد على ....؟', 'من خصائص الشعر أنه لا يعتمد على ....؟', 'الشعر يقوم بالأساس على العاطفة، والخيال، والوجدان، والموسيقى، أما "المنطق" العقلي الجاف فهو من خصائص الفلسفة والعلوم والنثر العلمي.', 'الشعر يقوم بالأساس على العاطفة، والخيال، والوجدان، والموسيقى، أما "المنطق" العقلي الجاف فهو من خصائص الفلسفة والعلوم والنثر العلمي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الوجدان', 'الوجدان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الخيال', 'الخيال', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'العاطفة', 'العاطفة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المنطق', 'المنطق', TRUE);
    -- Question 216: q_ar_216
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من هو الشاعر الذي قتل ملك الحيرة؟', 'من هو الشاعر الذي قتل ملك الحيرة؟', 'قتل عمرو بن كلثوم ملك الحيرة عمرو بن هند في قصره وأمام حاشيته، دفاعاً عن كرامة أمه "ليلى بنت المهلهل" حين حاولت أم الملك استخدامها في الخدمة.', 'قتل عمرو بن كلثوم ملك الحيرة عمرو بن هند في قصره وأمام حاشيته، دفاعاً عن كرامة أمه "ليلى بنت المهلهل" حين حاولت أم الملك استخدامها في الخدمة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم', 'عمرو بن كلثوم', TRUE);
    -- Question 217: q_ar_217
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'ما اسم جد عمرو بن كلثوم (من جهة أمه)؟', 'ما اسم جد عمرو بن كلثوم (من جهة أمه)؟', 'أمه هي ليلى بنت المهلهل (عدي بن ربيعة) الشهير بـ "الزير سالم" بطل حرب البسوس، ومنه ورث عمرو بن كلثوم الفخر والفروسية.', 'أمه هي ليلى بنت المهلهل (عدي بن ربيعة) الشهير بـ "الزير سالم" بطل حرب البسوس، ومنه ورث عمرو بن كلثوم الفخر والفروسية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'مهلهل بن ربيعة', 'مهلهل بن ربيعة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حارث بن ظالم', 'حارث بن ظالم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عبيد بن جشم', 'عبيد بن جشم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أحمد بن تغلب', 'أحمد بن تغلب', FALSE);
    -- Question 218: q_ar_218
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', '١ - ليس لعمرو بن كلثوم ديوان معروف. ٢ - له أشعار متفرقة في الأغاني؟', '١ - ليس لعمرو بن كلثوم ديوان معروف. ٢ - له أشعار متفرقة في الأغاني؟', 'لم يصلنا ديوان مجموع ومنظم لعمرو بن كلثوم كبقية الشعراء، وإنما وصلت معلقته كاملة وضخمة، وتفرقت بقية أشعاره الحماسية في كتب الأدب والمجاميع مثل كتاب "الأغاني" للأصفهاني.', 'لم يصلنا ديوان مجموع ومنظم لعمرو بن كلثوم كبقية الشعراء، وإنما وصلت معلقته كاملة وضخمة، وتفرقت بقية أشعاره الحماسية في كتب الأدب والمجاميع مثل كتاب "الأغاني" للأصفهاني.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both statements are true (كلاهما صحيح)', 'Both statements are true (كلاهما صحيح)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both statements are false', 'Both statements are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement 1 is correct but 2 is incorrect', 'Statement 1 is correct but 2 is incorrect', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement 1 is incorrect but 2 is correct', 'Statement 1 is incorrect but 2 is correct', FALSE);
    -- Question 219: q_ar_219
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'hard', '"أَلاَ هُبِّي بِصَحْنِكِ فَاصْبَحِيْنَا... وَلاَ تُبْقِي خُمُـوْرَ الأَنْدَرِيْنَا"، هي من شعر عمرو بن كلثوم المشهور، نوعها؟', '"أَلاَ هُبِّي بِصَحْنِكِ فَاصْبَحِيْنَا... وَلاَ تُبْقِي خُمُـوْرَ الأَنْدَرِيْنَا"، هي من شعر عمرو بن كلثوم المشهور، نوعها؟', 'معلقة عمرو بن كلثوم بأكملها تُصنف كقصيدة "حماسية فخرية"، يفتخر فيها بنفسه وبقبيلته تغلب وقوتها وسيطرتها.', 'معلقة عمرو بن كلثوم بأكملها تُصنف كقصيدة "حماسية فخرية"، يفتخر فيها بنفسه وبقبيلته تغلب وقوتها وسيطرتها.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'هي حماسية مدحية', 'هي حماسية مدحية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'هي حماسية غزلية', 'هي حماسية غزلية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'هي حماسية فخرية', 'هي حماسية فخرية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'هي حماسية رثائية', 'هي حماسية رثائية', FALSE);
    -- Question 220: q_ar_220
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'كم سنة عاش عمرو بن كلثوم؟', 'كم سنة عاش عمرو بن كلثوم؟', 'يُعد عمرو بن كلثوم من "المُعمّرين" في الجاهلية، وترجح الروايات الأدبية أنه عاش قرابة 150 سنة.', 'يُعد عمرو بن كلثوم من "المُعمّرين" في الجاهلية، وترجح الروايات الأدبية أنه عاش قرابة 150 سنة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عاش 155 سنة', 'عاش 155 سنة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عاش 145 سنة', 'عاش 145 سنة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عاش 148 سنة', 'عاش 148 سنة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عاش 150 سنة', 'عاش 150 سنة', TRUE);
    -- Question 221: q_ar_221
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'بدأ عمرو بن كلثوم معلقته بـ؟', 'بدأ عمرو بن كلثوم معلقته بـ؟', 'شذَّ عمرو بن كلثوم عن بناء القصيدة الجاهلية التقليدية (التي تبدأ بالأطلال)، وافتتح معلقته مباشرة بطلب الخمر ووصف كؤوسها قاطفاً الأضواء من رفاقه.', 'شذَّ عمرو بن كلثوم عن بناء القصيدة الجاهلية التقليدية (التي تبدأ بالأطلال)، وافتتح معلقته مباشرة بطلب الخمر ووصف كؤوسها قاطفاً الأضواء من رفاقه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بوصف الخمر', 'بوصف الخمر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بوصف الحبيبة', 'بوصف الحبيبة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بوصف الأطلال', 'بوصف الأطلال', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بالحماسة', 'بالحماسة', FALSE);
    -- Question 222: q_ar_222
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', '"إذا بلغَ الفطامَ لنا صبيٌّ... تخرُّ لهُ الجبابرُ ساجدينا" قاله؟', '"إذا بلغَ الفطامَ لنا صبيٌّ... تخرُّ لهُ الجبابرُ ساجدينا" قاله؟', 'هذا البيت هو ذروة الفخر القبلي في معلقته، ويضرب به المثل في مبالغات الجاهلية الفخرية.', 'هذا البيت هو ذروة الفخر القبلي في معلقته، ويضرب به المثل في مبالغات الجاهلية الفخرية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'طرفة بن العبد', 'طرفة بن العبد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمرو بن كلثوم', 'عمرو بن كلثوم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'حاتم الطائي', 'حاتم الطائي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'السموأل بن عادياء', 'السموأل بن عادياء', FALSE);
    -- Question 223: q_ar_223
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'من أبو الفوارس؟', 'من أبو الفوارس؟', 'كُني عنترة بن شداد بـ "أبي الفوارس" لفروسيته وشجاعته وإقدامه اللامتناهي في المعارك.', 'كُني عنترة بن شداد بـ "أبي الفوارس" لفروسيته وشجاعته وإقدامه اللامتناهي في المعارك.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة بن شداد', 'عنترة بن شداد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    -- Question 224: q_ar_224
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'نصرانيان (مسيحيان) بين أصحاب المعلقات؟', 'نصرانيان (مسيحيان) بين أصحاب المعلقات؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمرو بن كلثوم والنابغة', 'عمرو بن كلثوم والنابغة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبيد بن الأبرص والنابغة', 'عبيد بن الأبرص والنابغة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'النابغة والأعشى', 'النابغة والأعشى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأعشى والحارث (المقصود الأعشى لوروده في بعض الروايات وفي خيارات أخرى الأعشى وعمرو بن كلثوم حسب بعض المراجع النقادية، ولكن الأدق في المراجع الأكاديمية للـ NET: الأعشى وحاتم الطائي أو الأعشى ولبيد، وفي الخيارات المتاحة هنا يُدرس تداخل النصرانية عند الأعشى والحارث بن حلزة أو عمرو بن كلثوم لقرابتهم من مناذرة الحيرة المسيحيين).', 'الأعشى والحارث (المقصود الأعشى لوروده في بعض الروايات وفي خيارات أخرى الأعشى وعمرو بن كلثوم حسب بعض المراجع النقادية، ولكن الأدق في المراجع الأكاديمية للـ NET: الأعشى وحاتم الطائي أو الأعشى ولبيد، وفي الخيارات المتاحة هنا يُدرس تداخل النصرانية عند الأعشى والحارث بن حلزة أو عمرو بن كلثوم لقرابتهم من مناذرة الحيرة المسيحيين).', TRUE);
    -- Question 225: q_ar_225
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'من كان فارساً في حرب داحس والغبراء؟', 'من كان فارساً في حرب داحس والغبراء؟', 'حرب داحس والغبراء قامت بين قبيلتي عبس وذبيان، وكان عنترة هو بطل قبيلة "عبس" وحامي حماها في هذه الحرب الطويلة.', 'حرب داحس والغبراء قامت بين قبيلتي عبس وذبيان، وكان عنترة هو بطل قبيلة "عبس" وحامي حماها في هذه الحرب الطويلة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عنترة بن شداد', 'عنترة بن شداد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    -- Question 226: q_ar_226
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'ثابت بن جابر بن سفيان الفهمي، هو؟', 'ثابت بن جابر بن سفيان الفهمي، هو؟', 'هذا هو الاسم الحقيقي للشاعر الصعلوك الشهير "تأبط شراً".', 'هذا هو الاسم الحقيقي للشاعر الصعلوك الشهير "تأبط شراً".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'تأبط شراً', 'تأبط شراً', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو خراش الهذلي', 'أبو خراش الهذلي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    -- Question 227: q_ar_227
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'قبيلة تأبط شراً؟', 'قبيلة تأبط شراً؟', 'ينتمي إلى قبيلة "فهم" المضريّة (من قيس عيلان).', 'ينتمي إلى قبيلة "فهم" المضريّة (من قيس عيلان).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الفهمي من قيس', 'الفهمي من قيس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بني عبس', 'بني عبس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أوس من قيس', 'أوس من قيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الخزرج', 'الخزرج', FALSE);
    -- Question 228: q_ar_228
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'تأبط شراً هو ابن أخت.......؟', 'تأبط شراً هو ابن أخت.......؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عروة بن الورد', 'عروة بن الورد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'مهلهل بن ربيعة', 'مهلهل بن ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الشنفرى', 'الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ثابت بن جابر', 'ثابت بن جابر', FALSE);
    -- Question 229: q_ar_229
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'hard', '١ - يروي عنه أنه تأبط سكيناً ذات يوم وخرج، فسئلت أمه فقالت "لا أدري إنه تأبط شراً وخرج". ٢ - حاولت أمه قتله بضع مرات؟', '١ - يروي عنه أنه تأبط سكيناً ذات يوم وخرج، فسئلت أمه فقالت "لا أدري إنه تأبط شراً وخرج". ٢ - حاولت أمه قتله بضع مرات؟', 'العبارة الأولى صحيحة وهي سبب تسميته بـ "تأبط شراً" (وقيل تأبط جراب أفاعٍ). أما العبارة الثانية فخاطئة؛ أمه لم تحاول قتله، بل كان باراً بها يحميها، وإنما تبرأ منه زوج أمه في بعض الروايات.', 'العبارة الأولى صحيحة وهي سبب تسميته بـ "تأبط شراً" (وقيل تأبط جراب أفاعٍ). أما العبارة الثانية فخاطئة؛ أمه لم تحاول قتله، بل كان باراً بها يحميها، وإنما تبرأ منه زوج أمه في بعض الروايات.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كلاهما خطأ', 'كلاهما خطأ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '١ فقط', '١ فقط', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '٢ فقط', '٢ فقط', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كلاهما صحيح', 'كلاهما صحيح', FALSE);
    -- Question 230: q_ar_230
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'hard', 'اختر الصحيح عن تأبط شراً: ١) كان ابن أمة حبشية (زنجية) سوداء فيعد في أغربة العرب. ٢) كان أسمع العرب وأبصرهم وأكيدهم.', 'اختر الصحيح عن تأبط شراً: ١) كان ابن أمة حبشية (زنجية) سوداء فيعد في أغربة العرب. ٢) كان أسمع العرب وأبصرهم وأكيدهم.', 'تأبط شراً لم يكن ابن أمة حبشية (عنترة وخفاف وسليك هم أغربة العرب). بينما العبارة الثانية صحيحة تماماً؛ فقد ضرب به المثل في حدة السمع والبصر والذكاء والمكر في الهروب من الأعداء والسرعة في الجري.', 'تأبط شراً لم يكن ابن أمة حبشية (عنترة وخفاف وسليك هم أغربة العرب). بينما العبارة الثانية صحيحة تماماً؛ فقد ضرب به المثل في حدة السمع والبصر والذكاء والمكر في الهروب من الأعداء والسرعة في الجري.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statements are true', 'Both Statements are true', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statements are false', 'Both Statements are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement 1 is true, 2 is false', 'Statement 1 is true, 2 is false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement 2 is true, 1 is false', 'Statement 2 is true, 1 is false', TRUE);
    -- Question 231: q_ar_231
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', '..... أشهر الشعراء إذا كَلِبَ (اشتدَّ هجاؤه أو جنونه) أو غضب؟', '..... أشهر الشعراء إذا كَلِبَ (اشتدَّ هجاؤه أو جنونه) أو غضب؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تأبط شراً', 'تأبط شراً', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم', 'عمرو بن كلثوم', TRUE);
    -- Question 232: q_ar_232
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', '"لامية العرب" لمن؟', '"لامية العرب" لمن؟', 'هي القصيدة الصعلوكية الفريدة التي تبدأ بـ "أقيموا بني أمي صدورَ مطيكم"، وسميت لامية العرب لأنها تعبر عن قيم الصبر والجلد والعروبة الجاهلية.', 'هي القصيدة الصعلوكية الفريدة التي تبدأ بـ "أقيموا بني أمي صدورَ مطيكم"، وسميت لامية العرب لأنها تعبر عن قيم الصبر والجلد والعروبة الجاهلية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الشنفرى', 'الشنفرى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الطغراءي', 'الطغراءي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كعب بن زهير', 'كعب بن زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البوصيري', 'البوصيري', FALSE);
    -- Question 233: q_ar_233
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', '"لامية العجم" لمن؟', '"لامية العجم" لمن؟', 'كتبها الشاعر الطغراءي في العصر العباسي المتأخر معارضاً بها لامية الشنفرى، وسميت بلامية العجم.', 'كتبها الشاعر الطغراءي في العصر العباسي المتأخر معارضاً بها لامية الشنفرى، وسميت بلامية العجم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الشنفرى', 'الشنفرى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الطغراءي', 'الطغراءي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كعب بن زهير', 'كعب بن زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البوصيري', 'البوصيري', FALSE);
    -- Question 234: q_ar_234
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'نظم الشنفرى "لامية العرب" في بحر؟', 'نظم الشنفرى "لامية العرب" في بحر؟', 'ووزنه: فعولن مفاعيلن فعولن مفاعيلن، وهو البحر الذي نُظمت عليه أغلب المطولات واللاميات الجاهلية.', 'ووزنه: فعولن مفاعيلن فعولن مفاعيلن، وهو البحر الذي نُظمت عليه أغلب المطولات واللاميات الجاهلية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الطويل', 'الطويل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الخفيف', 'الخفيف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البسيط', 'البسيط', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الوافر', 'الوافر', FALSE);
    -- Question 235: q_ar_235
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'قصيدة "بانت سعاد" لنظم كعب بن زهير في بحر .....؟', 'قصيدة "بانت سعاد" لنظم كعب بن زهير في بحر .....؟', 'قصيدة البردة الشهيرة لكعب بن زهير في مدح النبي ﷺ (بانت سعادُ فقلبي اليومَ متبولُ) صِيغت أيضاً على بحر الطويل.', 'قصيدة البردة الشهيرة لكعب بن زهير في مدح النبي ﷺ (بانت سعادُ فقلبي اليومَ متبولُ) صِيغت أيضاً على بحر الطويل.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الطويل', 'الطويل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الخفيف', 'الخفيف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الوافر', 'الوافر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البسيط', 'البسيط', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_5', 'MEGA MOCK TEST 2', 'MEGA MOCK TEST 2', FALSE);
    -- Question 236: q_ar_236
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', '"إن أبا تمام كان في اختياره الحماسة أشعر منه في شعره". من قال هذا؟', '"إن أبا تمام كان في اختياره الحماسة أشعر منه في شعره". من قال هذا؟', 'أطلق الناقد ابن رشيق القيرواني في كتابه "العمدة" هذه العبارة الشهيرة، دلالة على الذوق النقدي الخارق والرفيع الذي تمتع به أبو تمام في انتقاء عيون الشعر العربي داخل ديوان "الحماسة".', 'أطلق الناقد ابن رشيق القيرواني في كتابه "العمدة" هذه العبارة الشهيرة، دلالة على الذوق النقدي الخارق والرفيع الذي تمتع به أبو تمام في انتقاء عيون الشعر العربي داخل ديوان "الحماسة".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن رشيق', 'ابن رشيق', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'التبريزي', 'التبريزي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن خلدون', 'ابن خلدون', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'التفتازاني', 'التفتازاني', FALSE);
    -- Question 237: q_ar_237
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'كم نوعاً من الرثاء لأبي تمام؟', 'كم نوعاً من الرثاء لأبي تمام؟', 'قسّم النقاد رثاء أبي تمام إلى ثلاثة أنواع رئيسية: رثاء القادة والأبطال (وهو الأشهر مثل رثائه لمحمد بن حميد الطوسي)، ورثاء الأصدقاء والإخوان، ورثاء الأبناء والأقارب.', 'قسّم النقاد رثاء أبي تمام إلى ثلاثة أنواع رئيسية: رثاء القادة والأبطال (وهو الأشهر مثل رثائه لمحمد بن حميد الطوسي)، ورثاء الأصدقاء والإخوان، ورثاء الأبناء والأقارب.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ثلاثة', 'ثلاثة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'نوعان', 'نوعان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أربعة', 'أربعة', FALSE);
    -- Question 238: q_ar_238
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'وقد ولدته أمه أعمى فما نظر إلى الدنيا قط؟', 'وقد ولدته أمه أعمى فما نظر إلى الدنيا قط؟', 'ولد بشار بن برد أعمى (مكفوف البصر) وعاش طيلة حياته في الظلام، ومع ذلك أبدع في وصف الألوان واللوحات الحية في شعره كأنه يراها بقلبه.', 'ولد بشار بن برد أعمى (مكفوف البصر) وعاش طيلة حياته في الظلام، ومع ذلك أبدع في وصف الألوان واللوحات الحية في شعره كأنه يراها بقلبه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن المعتز', 'ابن المعتز', FALSE);
    -- Question 239: q_ar_239
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"بشار وأبو نواس معناهما واحد والعدة إثنان"، قاله؟', '"بشار وأبو نواس معناهما واحد والعدة إثنان"، قاله؟', 'قالها الجاحظ مشيراً إلى الترابط الفني الكبير بين الشاعرين في ريادة التجديد، والحضارة، والخروج عن عمود الشعر البدوي.', 'قالها الجاحظ مشيراً إلى الترابط الفني الكبير بين الشاعرين في ريادة التجديد، والحضارة، والخروج عن عمود الشعر البدوي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الجاحظ', 'الجاحظ', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن قتيبة', 'ابن قتيبة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'محمد مندور', 'محمد مندور', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ميخائيل نعيمة', 'ميخائيل نعيمة', FALSE);
    -- Question 240: q_ar_240
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'اشتهر جرير على الخصوص بمهاراته مع من؟', 'اشتهر جرير على الخصوص بمهاراته مع من؟', 'شكلت معارك الهجاء (النقائض) بين جرير والفرزدق ثنائياً شعرياً هو الأشهر في تاريخ الأدب العربي واستمرت قرابة أربعين عاماً.', 'شكلت معارك الهجاء (النقائض) بين جرير والفرزدق ثنائياً شعرياً هو الأشهر في تاريخ الأدب العربي واستمرت قرابة أربعين عاماً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الفرزدق', 'الفرزدق', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الحطيئة', 'الحطيئة', FALSE);
    -- Question 241: q_ar_241
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من أمر لجرير بمائة لقحة وثمانية من الرعاء؟', 'من أمر لجرير بمائة لقحة وثمانية من الرعاء؟', 'عندما دخل جرير على الخليفة عبد الملك بن مروان وأنشده قصيدته الرائعة التي مطلعها: "أتصحو أم فؤادك غير صاح" حتى وصل إلى قوله: "ألستم خير من ركب المطايا..."، اهتز الخليفة طرباً وأمر له بمائة ناقة (لقحة) وثمانية من الرعاة لإدارتها.', 'عندما دخل جرير على الخليفة عبد الملك بن مروان وأنشده قصيدته الرائعة التي مطلعها: "أتصحو أم فؤادك غير صاح" حتى وصل إلى قوله: "ألستم خير من ركب المطايا..."، اهتز الخليفة طرباً وأمر له بمائة ناقة (لقحة) وثمانية من الرعاة لإدارتها.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الحجاج بن يوسف', 'الحجاج بن يوسف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبد الملك بن مروان', 'عبد الملك بن مروان', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'معاوية بن أبي سفيان', 'معاوية بن أبي سفيان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الوليد بن عبد الملك', 'الوليد بن عبد الملك', FALSE);
    -- Question 242: q_ar_242
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'كانت جائزة جرير في عهد عبد الملك؟', 'كانت جائزة جرير في عهد عبد الملك؟', 'بالإضافة إلى النوق، تذكر الروايات التاريخية المعتمدة في امتحانات NET أن الصلة المالية المقررة له بلغت أربعة آلاف درهم.', 'بالإضافة إلى النوق، تذكر الروايات التاريخية المعتمدة في امتحانات NET أن الصلة المالية المقررة له بلغت أربعة آلاف درهم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أربعة آلاف درهم', 'أربعة آلاف درهم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ثلاثة آلاف درهم', 'ثلاثة آلاف درهم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'خمسة آلاف درهم', 'خمسة آلاف درهم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ستة آلاف درهم', 'ستة آلاف درهم', FALSE);
    -- Question 243: q_ar_243
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'قال المهدي: "والله لئن قلت بعد هذا بيتاً واحداً في تشبيب لآتين على روحك". لمن قيل هذا؟', 'قال المهدي: "والله لئن قلت بعد هذا بيتاً واحداً في تشبيب لآتين على روحك". لمن قيل هذا؟', 'هدد الخليفة العباسي المهدي الشاعر بشار بن برد بالقتل إن لم يتوقف عن التشبيب (الغزل الصريح) بالنساء، لما تسبب فيه شعره من فتنة بين نساء بغداد والبصرة.', 'هدد الخليفة العباسي المهدي الشاعر بشار بن برد بالقتل إن لم يتوقف عن التشبيب (الغزل الصريح) بالنساء، لما تسبب فيه شعره من فتنة بين نساء بغداد والبصرة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار', 'بشار', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 244: q_ar_244
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'كان جرير والفرزدق........؟', 'كان جرير والفرزدق........؟', 'ينتمي جرير والفرزدق معاً إلى قبيلة تميم العربية العريقة، وكان هجاؤهما يدور بالأساس حول الفخر بالفروع والبطون الداخلية للقبيلة (جرير من كليب، والفرزدق من مجاشع).', 'ينتمي جرير والفرزدق معاً إلى قبيلة تميم العربية العريقة، وكان هجاؤهما يدور بالأساس حول الفخر بالفروع والبطون الداخلية للقبيلة (جرير من كليب، والفرزدق من مجاشع).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ثعلبان', 'ثعلبان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبسان', 'عبسان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'تميميان', 'تميميان', TRUE);
    -- Question 245: q_ar_245
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من الذي يلقب بـ "المرعث"؟', 'من الذي يلقب بـ "المرعث"؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن المقفع', 'ابن المقفع', FALSE);
    -- Question 246: q_ar_246
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'hard', 'شاعر أموي لما أتى به أبوه يوماً إلى أمير المؤمنين ليكون شاعراً مجيداً، فقال أمير المؤمنين له "أن أقرأ القرآن". من هو هذا الشاعر؟', 'شاعر أموي لما أتى به أبوه يوماً إلى أمير المؤمنين ليكون شاعراً مجيداً، فقال أمير المؤمنين له "أن أقرأ القرآن". من هو هذا الشاعر؟', 'أتى به أبوه "غالب" إلى الخليفة علي بن أبي طالب رضي الله عنه في الكوفة، وقال له: "إن ابني هذا كاد يكون شاعراً"، فقال له الإمام علي: "علّمه القرآن فهو خير له"، فقام الفرزدق وقيد نفسه حتى حفظ القرآن.', 'أتى به أبوه "غالب" إلى الخليفة علي بن أبي طالب رضي الله عنه في الكوفة، وقال له: "إن ابني هذا كاد يكون شاعراً"، فقال له الإمام علي: "علّمه القرآن فهو خير له"، فقام الفرزدق وقيد نفسه حتى حفظ القرآن.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جميل بن معمر', 'جميل بن معمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الفرزدق', 'الفرزدق', TRUE);
    -- Question 247: q_ar_247
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'hard', 'عمرو بن كلثوم شاعر جاهلي ولد في الجزيرة الفراتية، وكذلك شاعر أموي من شعراء النقائض ولد في الجزيرة الفراتية، من هو؟', 'عمرو بن كلثوم شاعر جاهلي ولد في الجزيرة الفراتية، وكذلك شاعر أموي من شعراء النقائض ولد في الجزيرة الفراتية، من هو؟', 'الأخطل التغلبي ولد ونشأ في الجزيرة الفراتية (ديار بني تغلب)، وهي نفس المنطقة التي عاش فيها جده الجاهلي عمرو بن كلثوم التغلبي.', 'الأخطل التغلبي ولد ونشأ في الجزيرة الفراتية (ديار بني تغلب)، وهي نفس المنطقة التي عاش فيها جده الجاهلي عمرو بن كلثوم التغلبي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'جميل بثينة', 'جميل بثينة', FALSE);
    -- Question 248: q_ar_248
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"يا ذا البغاوة إن بشراً قد قضى... ألا تجوز حكومة النشوان"، من قال هذا الهجاء؟', '"يا ذا البغاوة إن بشراً قد قضى... ألا تجوز حكومة النشوان"، من قال هذا الهجاء؟', 'هذا البيت قاله جرير يهجو فيه الأخطل ويسخر منه لأنه كان يشرب الخمر، والبيت يتهكم من حكم الأخطل السكران في المفاضلة بين جرير والفرزدق.', 'هذا البيت قاله جرير يهجو فيه الأخطل ويسخر منه لأنه كان يشرب الخمر، والبيت يتهكم من حكم الأخطل السكران في المفاضلة بين جرير والفرزدق.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل على جرير', 'الأخطل على جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جرير على الفرزدق', 'جرير على الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير على الأخطل', 'جرير على الأخطل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأخطل على الفرزدق', 'الأخطل على الفرزدق', FALSE);
    -- Question 249: q_ar_249
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'من القائل: "وكنا إذا الجبار صَعَّرَ خدَّه... ضربناهُ حتى تستقيمَ الأخادعُ"؟', 'من القائل: "وكنا إذا الجبار صَعَّرَ خدَّه... ضربناهُ حتى تستقيمَ الأخادعُ"؟', 'هذا البيت من عيون شعر الفخر للفرزدق، يفتخر فيه بقوة ومنعة آبائه وأجداده في كسر شوكة الملوك والجبابرة إذا تكبروا.', 'هذا البيت من عيون شعر الفخر للفرزدق، يفتخر فيه بقوة ومنعة آبائه وأجداده في كسر شوكة الملوك والجبابرة إذا تكبروا.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الفرزدق', 'الفرزدق', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    -- Question 250: q_ar_250
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'عمر بن أبي ربيعة:', 'عمر بن أبي ربيعة:', 'عُرف عمر بن أبي ربيعة بأنه غزل محض؛ فلم يمدح، ولم يهجُ، ولم يركب الأطلال، بل وهب عبقريته الشعرية بالكامل لوصف المرأة والتشبيب بها.', 'عُرف عمر بن أبي ربيعة بأنه غزل محض؛ فلم يمدح، ولم يهجُ، ولم يركب الأطلال، بل وهب عبقريته الشعرية بالكامل لوصف المرأة والتشبيب بها.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'قصر شعره على وصف النساء وهجو بعض من أنداده', 'قصر شعره على وصف النساء وهجو بعض من أنداده', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'قصر شعره على وصف النساء ومدح الخلفاء', 'قصر شعره على وصف النساء ومدح الخلفاء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'قصر شعره على وصف النساء ولم يصف سواهن', 'قصر شعره على وصف النساء ولم يصف سواهن', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'قصر شعره على وصف النساء والطبيعة ولا غيرهما', 'قصر شعره على وصف النساء والطبيعة ولا غيرهما', FALSE);
    -- Question 251: q_ar_251
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'عمن هجا الحطيئة كثيراً؟', 'عمن هجا الحطيئة كثيراً؟', 'هجا الحطيئة الزبرقان بن بدر (وكان عاملاً للخليفة عمر بن الخطاب على صدقات قومه) ببيته الشهير: "دعِ المكارمَ لا ترحلْ لبغيتها... واقعدْ فإنّك أنتَ الطاعمُ الكاسي". فاشتكى الزبرقان لعمر وسجن الخليفةُ الحطيئةَ بسبب هذا الهجاء اللاذع.', 'هجا الحطيئة الزبرقان بن بدر (وكان عاملاً للخليفة عمر بن الخطاب على صدقات قومه) ببيته الشهير: "دعِ المكارمَ لا ترحلْ لبغيتها... واقعدْ فإنّك أنتَ الطاعمُ الكاسي". فاشتكى الزبرقان لعمر وسجن الخليفةُ الحطيئةَ بسبب هذا الهجاء اللاذع.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الزبرقان من عمال أبي بكر رضي الله عنه', 'الزبرقان من عمال أبي بكر رضي الله عنه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الزبرقان من عمال عمر رضي الله عنه', 'الزبرقان من عمال عمر رضي الله عنه', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الزبرقان من عمال عثمان رضي الله عنه', 'الزبرقان من عمال عثمان رضي الله عنه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الزبرقان من عمال علي رضي الله عنه', 'الزبرقان من عمال علي رضي الله عنه', FALSE);
    -- Question 252: q_ar_252
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'الحطيئة هو؟', 'الحطيئة هو؟', 'هذا هو الاسم الكامل والكنية الدقيقة للشاعر المخضرم الشهير بـ الحطيئة (لقب بذلك لقصر قامته وقربه من الأرض).', 'هذا هو الاسم الكامل والكنية الدقيقة للشاعر المخضرم الشهير بـ الحطيئة (لقب بذلك لقصر قامته وقربه من الأرض).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو مليكة جرول بن أوس بن مالك العبسي', 'أبو مليكة جرول بن أوس بن مالك العبسي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو مليكة جرول بن أوس بن مالك المعاوي', 'أبو مليكة جرول بن أوس بن مالك المعاوي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو مليكة جرول بن عمرو بن مالك العبسي', 'أبو مليكة جرول بن عمرو بن مالك العبسي', FALSE);
    -- Question 253: q_ar_253
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'اشتهرت الخنساء بـ..........؟', 'اشتهرت الخنساء بـ..........؟', 'تُعد الخنساء أشعر نساء العرب على الإطلاق، واشتهرت بـ الرثاء الفاجع والبكاء المستمر على أخويها (صخر ومعاوية) اللذين قتلا في الجاهلية.', 'تُعد الخنساء أشعر نساء العرب على الإطلاق، واشتهرت بـ الرثاء الفاجع والبكاء المستمر على أخويها (صخر ومعاوية) اللذين قتلا في الجاهلية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المدح', 'المدح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الهجاء', 'الهجاء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الرثاء', 'الرثاء', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الغزل', 'الغزل', FALSE);
    -- Question 254: q_ar_254
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'ليس من بني الخنساء؟', 'ليس من بني الخنساء؟', 'أولاد الخنساء الأربعة الذين استشهدوا في معركة القادسية هم: عمرة، عبد الله، معاوية، وزيد (أو بجير في بعض الروايات التاريخية لتسمية الأبناء)، بينما "عمر" ليس من الأسماء المشهورة في سياق أبنائها الأربعة المستشهدين معاً.', 'أولاد الخنساء الأربعة الذين استشهدوا في معركة القادسية هم: عمرة، عبد الله، معاوية، وزيد (أو بجير في بعض الروايات التاريخية لتسمية الأبناء)، بينما "عمر" ليس من الأسماء المشهورة في سياق أبنائها الأربعة المستشهدين معاً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عبد الله', 'عبد الله', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'معاوية', 'معاوية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمر', 'عمر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بجير', 'بجير', FALSE);
    -- Question 255: q_ar_255
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'السيدة تماضر بنت عمرو بن الشريد السلمية هي معروفة بـ؟', 'السيدة تماضر بنت عمرو بن الشريد السلمية هي معروفة بـ؟', 'الاسم الحقيقي للخنساء هو تماضر بنت عمرو، ولقبت بالخنساء لجمال أنفها (والخَنَس هو ارتفاع أرنبة الأنف وضيق منخريه وهو من علامات الجمال عند العرب).', 'الاسم الحقيقي للخنساء هو تماضر بنت عمرو، ولقبت بالخنساء لجمال أنفها (والخَنَس هو ارتفاع أرنبة الأنف وضيق منخريه وهو من علامات الجمال عند العرب).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ليلى الأخيلية', 'ليلى الأخيلية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الخنساء', 'الخنساء', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عائشة', 'عائشة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'فدوى طوقان', 'فدوى طوقان', FALSE);
    -- Question 256: q_ar_256
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'hard', 'أ) وأم حسان هي الفريعة بنت خالد. ب) وكان أبوه ثابت وجده المنذر من أشرف قومهم والحكام بين الأوس والخزرج؟', 'أ) وأم حسان هي الفريعة بنت خالد. ب) وكان أبوه ثابت وجده المنذر من أشرف قومهم والحكام بين الأوس والخزرج؟', 'العبارتان صحيحتان تماماً عن شاعر الرسول ﷺ حسان بن ثابت الأنصاري؛ فأمه هي الفريعة بنت خالد الخزرجية، ونسبه من جهة أبيه وجده يعود إلى بيوت الشرف والرئاسة والتحكيم في يثرب قبل الإسلام.', 'العبارتان صحيحتان تماماً عن شاعر الرسول ﷺ حسان بن ثابت الأنصاري؛ فأمه هي الفريعة بنت خالد الخزرجية، ونسبه من جهة أبيه وجده يعود إلى بيوت الشرف والرئاسة والتحكيم في يثرب قبل الإسلام.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Statement A is true, statement B is false', 'Statement A is true, statement B is false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Statement A is false, statement B is true', 'Statement A is false, statement B is true', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Both statements A & B are true', 'Both statements A & B are true', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Both statements A & B are false', 'Both statements A & B are false', FALSE);
    -- Question 257: q_ar_257
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'hard', 'اختر الصحيح من العبارات عن عروة بن الورد العبسي: (١. كان فارساً شجاعاً، ٢. كان صعلوكاً أي فقيراً مغامراً، ٣. كان مقدماً على الصعاليك لكرمه، ٤. هو أبو نجد)', 'اختر الصحيح من العبارات عن عروة بن الورد العبسي: (١. كان فارساً شجاعاً، ٢. كان صعلوكاً أي فقيراً مغامراً، ٣. كان مقدماً على الصعاليك لكرمه، ٤. هو أبو نجد)', 'عروة بن الورد هو "عروة الصعاليك"، كان فارساً كريماً يجمع الفقراء والصعاليك فيعتني بهم ويقودهم في الغزوات، وكان يلقب بأبي نجد لسيادته وشجاعته هناك.', 'عروة بن الورد هو "عروة الصعاليك"، كان فارساً كريماً يجمع الفقراء والصعاليك فيعتني بهم ويقودهم في الغزوات، وكان يلقب بأبي نجد لسيادته وشجاعته هناك.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '١&٢ صحيح', '١&٢ صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '٢&٣ صحيح', '٢&٣ صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '٢&٤ صحيح', '٢&٤ صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كلها صحيح', 'كلها صحيح', TRUE);
    -- Question 258: q_ar_258
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_suluk', 'mcq_single', 'medium', 'اختر الصحيح عن عروة: (وكان أبوه من شجعان قبيلته وأشرافهم / كان له دور بارز في حرب داحس والغبراء)', 'اختر الصحيح عن عروة: (وكان أبوه من شجعان قبيلته وأشرافهم / كان له دور بارز في حرب داحس والغبراء)', 'عروة من بيت شرف في عبس، وعاش حرب داحس والغبراء وكان له دور بارز فيها بفروسيته.', 'عروة من بيت شرف في عبس، وعاش حرب داحس والغبراء وكان له دور بارز فيها بفروسيته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both statements are true (كلاهما صحيح)', 'Both statements are true (كلاهما صحيح)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both statements are false', 'Both statements are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement 1 is true and 2 is false', 'Statement 1 is true and 2 is false', FALSE);
    -- Question 259: q_ar_259
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'جماعة من العرب في العصر الجاهلي الذين عاشوا وأطلقوا حركاتهم في الجزيرة العربية، من هم؟', 'جماعة من العرب في العصر الجاهلي الذين عاشوا وأطلقوا حركاتهم في الجزيرة العربية، من هم؟', 'هم الفقراء والمتمردون على نظم القبيلة في الجاهلية الذين اتخذوا من الصعلكة والغزو وسيلة للعيش.', 'هم الفقراء والمتمردون على نظم القبيلة في الجاهلية الذين اتخذوا من الصعلكة والغزو وسيلة للعيش.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'شعراء البلاط', 'شعراء البلاط', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'شعراء الجاهلية', 'شعراء الجاهلية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الشعراء الفرسان', 'الشعراء الفرسان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الشعراء الصعاليك', 'الشعراء الصعاليك', TRUE);
    -- Question 260: q_ar_260
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'hard', 'ماذا تقول لأفراخٍ بذِي مَرَخٍ... حُمْرِ الحَواصِلِ لا ماءٌ ولا شَجَرُ؟ هذا قول الحطيئة من سجنه إلى من؟', 'ماذا تقول لأفراخٍ بذِي مَرَخٍ... حُمْرِ الحَواصِلِ لا ماءٌ ولا شَجَرُ؟ هذا قول الحطيئة من سجنه إلى من؟', 'استعطف الحطيئة بهذه الأبيات المؤثرة الخليفة عمر بن الخطاب وهو في السجن (بسبب هجائه للزبرقان)، فرقّ له عمر وأخرجه من السجن بعد أن اشترط عليه ألا يهجو أحداً من المسلمين.', 'استعطف الحطيئة بهذه الأبيات المؤثرة الخليفة عمر بن الخطاب وهو في السجن (بسبب هجائه للزبرقان)، فرقّ له عمر وأخرجه من السجن بعد أن اشترط عليه ألا يهجو أحداً من المسلمين.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمر (ر)', 'عمر (ر)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عثمان (ر)', 'عثمان (ر)', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'علي (ر)', 'علي (ر)', FALSE);
    -- Question 261: q_ar_261
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'اسمه جرول، وهو من قبيلة عبس، وشعره يدور في المديح والهجاء:', 'اسمه جرول، وهو من قبيلة عبس، وشعره يدور في المديح والهجاء:', 'الاسم الكامل للحطيئة هو جرول بن أوس العبسي، وعُرف بتقلب شعره بين المدح المفرط والهجاء المقذع.', 'الاسم الكامل للحطيئة هو جرول بن أوس العبسي، وعُرف بتقلب شعره بين المدح المفرط والهجاء المقذع.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كعب', 'كعب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'حسان', 'حسان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الخنساء', 'الخنساء', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الحطيئة', 'الحطيئة', TRUE);
    -- Question 262: q_ar_262
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', '"بانت سعاد فقلبي اليوم متبول... متيم إثرها لم يفد مكبول"', '"بانت سعاد فقلبي اليوم متبول... متيم إثرها لم يفد مكبول"', 'هي قصيدة كعب بن زهير الشهيرة بـ "البردة"، التي ألقاها بين يدي النبي ﷺ معتذراً ومادحاً، فكساه النبي بردته الشريفة.', 'هي قصيدة كعب بن زهير الشهيرة بـ "البردة"، التي ألقاها بين يدي النبي ﷺ معتذراً ومادحاً، فكساه النبي بردته الشريفة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'قصيدة لامية العرب', 'قصيدة لامية العرب', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'مفضليات', 'مفضليات', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'قصيدة البردة', 'قصيدة البردة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'اللزوميات', 'اللزوميات', FALSE);
    -- Question 263: q_ar_263
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', '"لم تقل امرأة شعراً إلا ظهر الضعف فيه"، مَن القائل عن الخنساء؟', '"لم تقل امرأة شعراً إلا ظهر الضعف فيه"، مَن القائل عن الخنساء؟', 'قال بشار بن برد هذه العبارة النقدية واستثنى الخنساء قائلاً: "إلا الخنساء فإنها فوق كثير من الرجال".', 'قال بشار بن برد هذه العبارة النقدية واستثنى الخنساء قائلاً: "إلا الخنساء فإنها فوق كثير من الرجال".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو عبيدة', 'أبو عبيدة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأصمعي', 'الأصمعي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الجمحي', 'الجمحي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار بن برد', 'بشار بن برد', TRUE);
    -- Question 264: q_ar_264
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'لمن قالت الخنساء: "لقد كنت من قبل أبكي لهما من الثأر، وأنا اليوم أبكي لهما من النار"؟', 'لمن قالت الخنساء: "لقد كنت من قبل أبكي لهما من الثأر، وأنا اليوم أبكي لهما من النار"؟', 'دار هذا الحوار بين الخنساء والخليفة عمر بن الخطاب عندما رآها وهي عجوز لا تزال تبكي على أخويها صخر ومعاوية اللذين ماتا في الجاهلية على الشرك.', 'دار هذا الحوار بين الخنساء والخليفة عمر بن الخطاب عندما رآها وهي عجوز لا تزال تبكي على أخويها صخر ومعاوية اللذين ماتا في الجاهلية على الشرك.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'محمد رسول الله ﷺ', 'محمد رسول الله ﷺ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو بكر', 'أبو بكر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمر بن خطاب', 'عمر بن خطاب', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'علي بن أبي طالب', 'علي بن أبي طالب', FALSE);
    -- Question 265: q_ar_265
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'من قال عن الخنساء: "إنها أشعر الجن والإنس"؟', 'من قال عن الخنساء: "إنها أشعر الجن والإنس"؟', 'قالها النابغة الذبياني في سوق عكاظ عندما استمع إلى رثائها لأخيها صخر، وكان هو حَكَم الشعراء هناك.', 'قالها النابغة الذبياني في سوق عكاظ عندما استمع إلى رثائها لأخيها صخر، وكان هو حَكَم الشعراء هناك.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'النابغة', 'النابغة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمر', 'عمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'محمد رسول الله', 'محمد رسول الله', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'صخر', 'صخر', FALSE);
    -- Question 266: q_ar_266
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'كان معاوية أخ شقيق وصخر أخ لأبيها / كان أكثر بكائها على صخر:', 'كان معاوية أخ شقيق وصخر أخ لأبيها / كان أكثر بكائها على صخر:', 'معاوية هو شقيقها، وصخر هو أخوها لأبيها، ومع ذلك كان فجعها وبكاؤها على صخر أشد وأكثر لأنه كان باراً بها حليماً عليها ويقسم ماله معها.', 'معاوية هو شقيقها، وصخر هو أخوها لأبيها، ومع ذلك كان فجعها وبكاؤها على صخر أشد وأكثر لأنه كان باراً بها حليماً عليها ويقسم ماله معها.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both are incorrect', 'Both are incorrect', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both are correct', 'Both are correct', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'First is only correct', 'First is only correct', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Second is only correct', 'Second is only correct', FALSE);
    -- Question 267: q_ar_267
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'medium', 'أسلمت الخنساء في أواخر حياتها / رثاء الخنساء هو العاطفة الصادقة في حزنها:', 'أسلمت الخنساء في أواخر حياتها / رثاء الخنساء هو العاطفة الصادقة في حزنها:', 'العبارتان صحيحتان؛ فقد وفدت على النبي ﷺ مع قومها وأسلمت، ورثاؤها يضرب به المثل في صدق العاطفة اللوعة والحرقة الحقيقية.', 'العبارتان صحيحتان؛ فقد وفدت على النبي ﷺ مع قومها وأسلمت، ورثاؤها يضرب به المثل في صدق العاطفة اللوعة والحرقة الحقيقية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both true', 'Both true', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both incorrect', 'Both incorrect', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '1 true 2 incorrect', '1 true 2 incorrect', FALSE);
    -- Question 268: q_ar_268
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_mukhadramun', 'mcq_single', 'hard', 'أ. أكثر شعر حسان في المدح / ب. كان في شعره غزل قبل الإسلام، أما في الإسلام فصار يقتبس من القرآن والحديث / ج. قيل لو مزج البحر بشعره لمزجه:', 'أ. أكثر شعر حسان في المدح / ب. كان في شعره غزل قبل الإسلام، أما في الإسلام فصار يقتبس من القرآن والحديث / ج. قيل لو مزج البحر بشعره لمزجه:', 'انطبع شعر حسان بالمدح (الغساسنة في الجاهلية والنبي ﷺ في الإسلام)، وتأثرت ألفاظه بالقرآن، وشهد له النقاد بجزالة شعره وسعته كالبحر.', 'انطبع شعر حسان بالمدح (الغساسنة في الجاهلية والنبي ﷺ في الإسلام)، وتأثرت ألفاظه بالقرآن، وشهد له النقاد بجزالة شعره وسعته كالبحر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أ، ب صحيح', 'أ، ب صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ب، ج صحيح', 'ب، ج صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أ، ج صحيح', 'أ، ج صحيح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كله صحيح', 'كله صحيح', TRUE);
    -- Question 269: q_ar_269
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'hard', 'قول النقاد: "كان يفتقر إلى قوة الصياغة في الجاهلية، ولكن عندما أعلن إسلامه فإن أشعاره قد اتسمت بالرقة والسلاسة..." هو في حق مَن؟', 'قول النقاد: "كان يفتقر إلى قوة الصياغة في الجاهلية، ولكن عندما أعلن إسلامه فإن أشعاره قد اتسمت بالرقة والسلاسة..." هو في حق مَن؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كعب بن زهير', 'كعب بن زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'لبيد بن ربيعة', 'لبيد بن ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الحطيئة', 'الحطيئة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'حسان بن ثابت', 'حسان بن ثابت', TRUE);
    -- Question 270: q_ar_270
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'مَن القائل: "ما أرانا نقول إلا مُعاراً... أو مُعاداً من قولنا مكروراً"؟', 'مَن القائل: "ما أرانا نقول إلا مُعاراً... أو مُعاداً من قولنا مكروراً"؟', 'بيت شهير لـ زهير بن أبي سلمى يشتكي فيه من تكرار المعاني الشعرية وضيق الابتكار بالنسبة لمن سبقه من الشعراء.', 'بيت شهير لـ زهير بن أبي سلمى يشتكي فيه من تكرار المعاني الشعرية وضيق الابتكار بالنسبة لمن سبقه من الشعراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كعب بن زهير', 'كعب بن زهير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أمية بن أبي الصلت', 'أمية بن أبي الصلت', FALSE);
    -- Question 271: q_ar_271
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'medium', 'تزوج زهير أم أوفى وطلقها بسبب عقمها، ثم تزوج:', 'تزوج زهير أم أوفى وطلقها بسبب عقمها، ثم تزوج:', 'بعد طلاق أم أوفى (التي بدأ بها معلقته)، تزوج زهير من كبشة بنت عمار وهي أم أولاده الشعراء (كعب وبجير).', 'بعد طلاق أم أوفى (التي بدأ بها معلقته)، تزوج زهير من كبشة بنت عمار وهي أم أولاده الشعراء (كعب وبجير).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عيشة بنت عمار', 'عيشة بنت عمار', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبشة بنت عمر', 'عبشة بنت عمر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كبشة بنت عمار', 'كبشة بنت عمار', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كبشة بنت عمر', 'كبشة بنت عمر', FALSE);
    -- Question 272: q_ar_272
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_muallaqat', 'mcq_single', 'hard', '١- هو زهير بن أبي سلمى، ولد بنجد نحو سنة ٥٣٠ ونشأ في غطفان، وأخذ الشعر والحكمة عن بشامة خال أبيه. ٢- بيت زهير عريق في الشاعرية:', '١- هو زهير بن أبي سلمى، ولد بنجد نحو سنة ٥٣٠ ونشأ في غطفان، وأخذ الشعر والحكمة عن بشامة خال أبيه. ٢- بيت زهير عريق في الشاعرية:', 'العبارتان صحيحتان؛ فقد لُقّب بيته بـ "بيت الشعراء" لأن أباه وخاله وأخته (الخنساء بنت أبي سلمى) وولديه (كعب وبجير) وحفيده كانوا جميعاً شعراء.', 'العبارتان صحيحتان؛ فقد لُقّب بيته بـ "بيت الشعراء" لأن أباه وخاله وأخته (الخنساء بنت أبي سلمى) وولديه (كعب وبجير) وحفيده كانوا جميعاً شعراء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both statements are true (كلاهما صحيح)', 'Both statements are true (كلاهما صحيح)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both statements are false', 'Both statements are false', FALSE);
    -- Question 273: q_ar_273
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'كان رزيناً حكيماً داعياً إلى الخير والسلام.....؟', 'كان رزيناً حكيماً داعياً إلى الخير والسلام.....؟', 'عُرف زهير بـ "شاعر السلام" لأنه مدح هرم بن سنان والحارث بن عوف لتحملهما ديات حرب داحس والغبراء وحقن دماء العرب.', 'عُرف زهير بـ "شاعر السلام" لأنه مدح هرم بن سنان والحارث بن عوف لتحملهما ديات حرب داحس والغبراء وحقن دماء العرب.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عنترة بن شداد', 'عنترة بن شداد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'امرؤ القيس', 'امرؤ القيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', TRUE);
    -- Question 274: q_ar_274
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', '"يا دارَ عبلةَ بالجَواءِ تكلّمي... وعِمي صباحاً دارَ عبلةَ واسلَمي"', '"يا دارَ عبلةَ بالجَواءِ تكلّمي... وعِمي صباحاً دارَ عبلةَ واسلَمي"', 'هذا هو مطلع معلقة عنترة بن شداد العبسي الفخرية والغزلية الشهيرة بحب عبلة.', 'هذا هو مطلع معلقة عنترة بن شداد العبسي الفخرية والغزلية الشهيرة بحب عبلة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'امرؤ القيس', 'امرؤ القيس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عنترة بن شداد', 'عنترة بن شداد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'زهير بن أبي سلمى', 'زهير بن أبي سلمى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمرو بن كلثوم', 'عمرو بن كلثوم', FALSE);
    -- Question 275: q_ar_275
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'سوق عكاظ تقام من:', 'سوق عكاظ تقام من:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أول ذي الحجة إلى العشرين منه', 'أول ذي الحجة إلى العشرين منه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أول ذي القعدة إلى العشرين منه', 'أول ذي القعدة إلى العشرين منه', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أول ذي الحجة إلى العشرة منه', 'أول ذي الحجة إلى العشرة منه', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أول ذي القعدة إلى العشرة منه (تاريخياً تقام في شهر شوال أو ذي القعدة، والرواية الأكثر دقة للخيارات المتاحة للـ NET: من مطلع ذي القعدة إلى عشرين منه).', 'أول ذي القعدة إلى العشرة منه (تاريخياً تقام في شهر شوال أو ذي القعدة، والرواية الأكثر دقة للخيارات المتاحة للـ NET: من مطلع ذي القعدة إلى عشرين منه).', FALSE);
    -- Question 276: q_ar_276
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'هم أولاد إسماعيل (ع) الذين نزلوا بالحجاز؟', 'هم أولاد إسماعيل (ع) الذين نزلوا بالحجاز؟', 'العرب المستعربة هم العدنانيون من نسل سيدنا إسماعيل بن إبراهيم عليهما السلام، وسُمّوا بالمستعربة لأنهم جاوروا الجرهميين وتعلموا العربية منهم بالحجاز.', 'العرب المستعربة هم العدنانيون من نسل سيدنا إسماعيل بن إبراهيم عليهما السلام، وسُمّوا بالمستعربة لأنهم جاوروا الجرهميين وتعلموا العربية منهم بالحجاز.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البائدة', 'البائدة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'العاربة', 'العاربة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'القحطانية', 'القحطانية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المستعربة', 'المستعربة', TRUE);
    -- Question 277: q_ar_277
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'ليس من القبائل البائدة؟', 'ليس من القبائل البائدة؟', 'الأنباط مملكة عربية تاريخية شهيرة (أصحاب البتراء) عاشوا وتواجدوا في العصور المتأخرة، وليسوا من الأمم القديمة البائدة كـ ثمود وطسم وجاسم.', 'الأنباط مملكة عربية تاريخية شهيرة (أصحاب البتراء) عاشوا وتواجدوا في العصور المتأخرة، وليسوا من الأمم القديمة البائدة كـ ثمود وطسم وجاسم.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ثمود', 'ثمود', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'صحار', 'صحار', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأنباط', 'الأنباط', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'جاسم', 'جاسم', FALSE);
    -- Question 278: q_ar_278
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', '"إنه يمني من كندي، شعره قريشي اللغة" من قال هذا عن امرئ القيس....؟', '"إنه يمني من كندي، شعره قريشي اللغة" من قال هذا عن امرئ القيس....؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن قتيبة', 'ابن قتيبة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'طه حسين', 'طه حسين', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الصاحب بن عباد', 'الصاحب بن عباد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأصمعي', 'الأصمعي', FALSE);
    -- Question 279: q_ar_279
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'مَن قال هذا: "ما قلتُ الشعر حتى رويتُ لستين امرأة من العرب منهن الخنساء وليلى"؟', 'مَن قال هذا: "ما قلتُ الشعر حتى رويتُ لستين امرأة من العرب منهن الخنساء وليلى"؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'المتنبي', 'المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', FALSE);
    -- Question 280: q_ar_280
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'hard', '"هَذا الَّذي تَعرِفُ البَطحاءُ وَطأَتَهُ... وَالبَيتُ يَعرِفُهُ وَالحِلُّ وَالحَرَمُ" - إلى من يجيب الفرزدق بهذه الأبيات؟', '"هَذا الَّذي تَعرِفُ البَطحاءُ وَطأَتَهُ... وَالبَيتُ يَعرِفُهُ وَالحِلُّ وَالحَرَمُ" - إلى من يجيب الفرزدق بهذه الأبيات؟', 'ارتجل الفرزدق هذه القصيدة العظيمة في مكة عندما تظاهر هشام بن عبد الملك (قبل الخلافة) بأنه لا يعرف علي بن الحسين (زين العابدين) بسبب التفاف الناس حوله، فأنشد الفرزدق القصيدة معرفاً به ومفتخراً بآل البيت.', 'ارتجل الفرزدق هذه القصيدة العظيمة في مكة عندما تظاهر هشام بن عبد الملك (قبل الخلافة) بأنه لا يعرف علي بن الحسين (زين العابدين) بسبب التفاف الناس حوله، فأنشد الفرزدق القصيدة معرفاً به ومفتخراً بآل البيت.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عبد الملك بن مروان', 'عبد الملك بن مروان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'يزيد بن معاوية', 'يزيد بن معاوية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'هشام بن عبد الملك', 'هشام بن عبد الملك', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'علي بن أبي طالب', 'علي بن أبي طالب', FALSE);
    -- Question 281: q_ar_281
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'تعلم أبو نواس أصول الشعر من الشاعر:', 'تعلم أبو نواس أصول الشعر من الشاعر:', 'تبنى الشاعر والبة بن الحباب أبا نواس في صباه بالأهواز وبغداد، وهو الذي صقل موهبته وعلمه قول الشعر وأصوله.', 'تبنى الشاعر والبة بن الحباب أبا نواس في صباه بالأهواز وبغداد، وهو الذي صقل موهبته وعلمه قول الشعر وأصوله.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'والبة بن الحباب', 'والبة بن الحباب', TRUE);
    -- Question 282: q_ar_282
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'كان غزل أبو نواس لجارية اسمها:', 'كان غزل أبو نواس لجارية اسمها:', 'عُشق أبو نواس جاريتين شهيرتين، أشهرهم على الإطلاق والتي كلف بها ونظم فيها أرق غزلياته هي جنان.', 'عُشق أبو نواس جاريتين شهيرتين، أشهرهم على الإطلاق والتي كلف بها ونظم فيها أرق غزلياته هي جنان.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ليلى', 'ليلى', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'فاطمة', 'فاطمة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جنان', 'جنان', TRUE);
    -- Question 283: q_ar_283
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"ديوان الحماسة" كاتبه وجامعه هو:', '"ديوان الحماسة" كاتبه وجامعه هو:', 'ديوان الحماسة هو أشهر مجموعة مختارات شعرية في الأدب العربي، جمعها وصنفها الشاعر أبو تمام.', 'ديوان الحماسة هو أشهر مجموعة مختارات شعرية في الأدب العربي، جمعها وصنفها الشاعر أبو تمام.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', TRUE);
    -- Question 284: q_ar_284
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'رافق أبو تمام المعتصم إلى غزو ___ في منتصف السنة 223هـ.', 'رافق أبو تمام المعتصم إلى غزو ___ في منتصف السنة 223هـ.', 'رافق الخليفة المعتصم في فتح مدينة عمورية الرومية، وكتب هناك قصيدته السيفية الخالدة التي مطلعها: "السيف أصدق إنباءً من الكتب".', 'رافق الخليفة المعتصم في فتح مدينة عمورية الرومية، وكتب هناك قصيدته السيفية الخالدة التي مطلعها: "السيف أصدق إنباءً من الكتب".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أومرية', 'أومرية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أمريكية', 'أمريكية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كندية', 'كندية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمورية', 'عمورية', TRUE);
    -- Question 285: q_ar_285
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'مكث أبو تمام مدة يسيرة في بغداد وقصد خراسان ليمدح واليها ---', 'مكث أبو تمام مدة يسيرة في بغداد وقصد خراسان ليمدح واليها ---', 'ذهب أبو تمام إلى خراسان لمدح الأمير عبد الله بن طاهر (والي خراسان)، وكان من أعظم ممدوحيه وأجزل له العطاء.', 'ذهب أبو تمام إلى خراسان لمدح الأمير عبد الله بن طاهر (والي خراسان)، وكان من أعظم ممدوحيه وأجزل له العطاء.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عبد الله بن طاهر', 'عبد الله بن طاهر', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عياش بن لهيعة', 'عياش بن لهيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'المأمون', 'المأمون', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عتيبة بن عبد الكريم', 'عتيبة بن عبد الكريم', FALSE);
    -- Question 286: q_ar_286
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'الاسم الكامل للمتنبي؟', 'الاسم الكامل للمتنبي؟', 'هو أحمد بن الحسين بن الحسن بن عبد الصمد الجعفي الكوفي الكِندي، ويُكنى بـ "أبي الطيب".', 'هو أحمد بن الحسين بن الحسن بن عبد الصمد الجعفي الكوفي الكِندي، ويُكنى بـ "أبي الطيب".', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو الطيب أحمد بن الحسين المتنبي', 'أبو الطيب أحمد بن الحسين المتنبي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو الطيب أحمد بن حسين علي المتنبي', 'أبو الطيب أحمد بن حسين علي المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو الطيب أحمد بن الحسين العباس المتنبي', 'أبو الطيب أحمد بن الحسين العباس المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو الطيب أحمد بن الحسين عبيد المتنبي', 'أبو الطيب أحمد بن الحسين عبيد المتنبي', FALSE);
    -- Question 287: q_ar_287
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'معظم شعر المتنبي في أي موضوع؟', 'معظم شعر المتنبي في أي موضوع؟', 'على الرغم من تميز المتنبي بالحكمة ووصف المعارك (السيوفيات)، إلا أن المدح هو الغرض الأكبر عدداً في ديوانه؛ حيث قضى معظم حياته يتنقل مادحاً الملوك والأمراء (سيف الدولة، كافور الإخشيدي، وعضد الدولة).', 'على الرغم من تميز المتنبي بالحكمة ووصف المعارك (السيوفيات)، إلا أن المدح هو الغرض الأكبر عدداً في ديوانه؛ حيث قضى معظم حياته يتنقل مادحاً الملوك والأمراء (سيف الدولة، كافور الإخشيدي، وعضد الدولة).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'شعره في الطبيعة', 'شعره في الطبيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'شعره في وصف المعارك', 'شعره في وصف المعارك', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'شعره في الحكمة وفلسفة الحياة ووصف الحياة', 'شعره في الحكمة وفلسفة الحياة ووصف الحياة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'شعره في المدح', 'شعره في المدح', TRUE);
    -- Question 288: q_ar_288
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'أقام المتنبي عند سيف الدولة __ سنوات؟', 'أقام المتنبي عند سيف الدولة __ سنوات؟', 'أمضى المتنبي في بلاط سيف الدولة الحمداني بحلب 9 سنوات (من 337 هـ إلى 346 هـ)، وهي أزهى وأشهر فترات حياته الشعرية.', 'أمضى المتنبي في بلاط سيف الدولة الحمداني بحلب 9 سنوات (من 337 هـ إلى 346 هـ)، وهي أزهى وأشهر فترات حياته الشعرية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '9 سنوات', '9 سنوات', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '6 سنوات', '6 سنوات', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '4 سنوات', '4 سنوات', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '8 سنوات', '8 سنوات', FALSE);
    -- Question 289: q_ar_289
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'ولد المتنبي في؟', 'ولد المتنبي في؟', 'ولد في محلة كِندة بمدينة الكوفة في العراق سنة 303 هـ.', 'ولد في محلة كِندة بمدينة الكوفة في العراق سنة 303 هـ.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الكوفة', 'الكوفة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البصرة', 'البصرة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'خراسان', 'خراسان', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بغداد', 'بغداد', FALSE);
    -- Question 290: q_ar_290
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'قتل المتنبي سنة؟', 'قتل المتنبي سنة؟', 'قُتل المتنبي في شهر رمضان سنة 354 هـ على يد فاتك بن أبي جهل الأسدي بالقرب من بغداد، بسبب قصيدة هجا فيها ابن أخت فاتك (ضبة).', 'قُتل المتنبي في شهر رمضان سنة 354 هـ على يد فاتك بن أبي جهل الأسدي بالقرب من بغداد، بسبب قصيدة هجا فيها ابن أخت فاتك (ضبة).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'رمضان ٣٥٠', 'رمضان ٣٥٠', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'رمضان ٣٥٣', 'رمضان ٣٥٣', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'رمضان ٣٥٥', 'رمضان ٣٥٥', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'رمضان ٣٥٤', 'رمضان ٣٥٤', TRUE);
    -- Question 291: q_ar_291
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'وقع جمع ديوان المتنبي ورتب على حروف الأبجدية / طبع ديوانه في الهند ومصر والشام وغيرها.', 'وقع جمع ديوان المتنبي ورتب على حروف الأبجدية / طبع ديوانه في الهند ومصر والشام وغيرها.', 'جُمع ديوانه وشُرح من قِبل كبار العلماء (كالواحدي وابن جني) ورُتب أبجدياً، وحظي بعناية فائقة فـطُبع في مختلف أقطار العالم الإسلامي لشهرته وسيرورته.', 'جُمع ديوانه وشُرح من قِبل كبار العلماء (كالواحدي وابن جني) ورُتب أبجدياً، وحظي بعناية فائقة فـطُبع في مختلف أقطار العالم الإسلامي لشهرته وسيرورته.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both statements are true (كلاهما صحيح)', 'Both statements are true (كلاهما صحيح)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both statements are false', 'Both statements are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement 1 is true, 2 is false', 'Statement 1 is true, 2 is false', FALSE);
    -- Question 292: q_ar_292
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'يعرف أبوه بعبدان السقاء / أنه صنف كلاماً عارض به القرآن.', 'يعرف أبوه بعبدان السقاء / أنه صنف كلاماً عارض به القرآن.', 'كان والده يُعرف تاريخياً بـ "عبدان السقاء" في الكوفة، وتذكر الروايات الأدبية أن المتنبي في فترة ادعائه النبوة بالبادية صنف كلاماً سجعياً حاول به محاكاة الأسلوب القرآني ليفتن الأعراب.', 'كان والده يُعرف تاريخياً بـ "عبدان السقاء" في الكوفة، وتذكر الروايات الأدبية أن المتنبي في فترة ادعائه النبوة بالبادية صنف كلاماً سجعياً حاول به محاكاة الأسلوب القرآني ليفتن الأعراب.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both statements are true (كلاهما صحيح)', 'Both statements are true (كلاهما صحيح)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both statements are false', 'Both statements are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement 1 is true, 2 is false', 'Statement 1 is true, 2 is false', FALSE);
    -- Question 293: q_ar_293
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'إمام الطريقة الابتداعية في الشعر / كان أكثر عنايته باللفظ.', 'إمام الطريقة الابتداعية في الشعر / كان أكثر عنايته باللفظ.', 'المتنبي ليس إمام الطريقة الابتداعية (بشار وأبو تمام هما من فتحا باب الابتداع والبديع)، ولم تكن عنايته باللفظ على حساب المعنى، بل عُرف بقدرته الجبارة على صهر اللفظ القوي بالمعنى العميق والحكمة الشاملة.', 'المتنبي ليس إمام الطريقة الابتداعية (بشار وأبو تمام هما من فتحا باب الابتداع والبديع)، ولم تكن عنايته باللفظ على حساب المعنى، بل عُرف بقدرته الجبارة على صهر اللفظ القوي بالمعنى العميق والحكمة الشاملة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both statements are true', 'Both statements are true', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both statements are false (كلاهما خطأ)', 'Both statements are false (كلاهما خطأ)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement 1 is true, 2 is false', 'Statement 1 is true, 2 is false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement 2 is true, 1 is false', 'Statement 2 is true, 1 is false', FALSE);
    -- Question 294: q_ar_294
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'كان شاعراً من شعراء المعاني / إنه أطلق الشعر من القيود التي قيده بها أبو تمام وشيعته.', 'كان شاعراً من شعراء المعاني / إنه أطلق الشعر من القيود التي قيده بها أبو تمام وشيعته.', 'اعتمد المتنبي على توليد المعاني والحكم، وأعاد للشعر ديباجته العربية المطبوعة متخلصاً من الإغراق الفلسفي والتكلف البديعي الصارم الذي التزمه أبو تمام.', 'اعتمد المتنبي على توليد المعاني والحكم، وأعاد للشعر ديباجته العربية المطبوعة متخلصاً من الإغراق الفلسفي والتكلف البديعي الصارم الذي التزمه أبو تمام.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both statements are true (كلاهما صحيح)', 'Both statements are true (كلاهما صحيح)', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both statements are false', 'Both statements are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement 1 is true, 2 is false', 'Statement 1 is true, 2 is false', FALSE);
    -- Question 295: q_ar_295
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'ولد بالبصرة من أبوين فقيرين / أنه وفق بين الشعر والفلسفة.', 'ولد بالبصرة من أبوين فقيرين / أنه وفق بين الشعر والفلسفة.', 'العبارة الأولى خاطئة لأنه ولد في الكوفة وليس البصرة. والعبارة الثانية صحيحة؛ حيث امتزج شعره بفلسفة الحياة والوجود ونظرات حكيمة عميقة.', 'العبارة الأولى خاطئة لأنه ولد في الكوفة وليس البصرة. والعبارة الثانية صحيحة؛ حيث امتزج شعره بفلسفة الحياة والوجود ونظرات حكيمة عميقة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both statements are true', 'Both statements are true', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both statements are false', 'Both statements are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement 1 is true, 2 is false', 'Statement 1 is true, 2 is false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement 2 is true, 1 is false', 'Statement 2 is true, 1 is false', TRUE);
    -- Question 296: q_ar_296
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'معلم المعري في النحو؟', 'معلم المعري في النحو؟', 'تلقى أبو العلاء المعري أصول النحو واللغة في مسقط رأسه (المعرة) على يد شيوخ بلده، وكان أبرزهم محمد بن عبد الله بن سعد الأزهري.', 'تلقى أبو العلاء المعري أصول النحو واللغة في مسقط رأسه (المعرة) على يد شيوخ بلده، وكان أبرزهم محمد بن عبد الله بن سعد الأزهري.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'محمد بن عبد الله بن سعد', 'محمد بن عبد الله بن سعد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'محمد بن يزيد بن عبد الأكبر', 'محمد بن يزيد بن عبد الأكبر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'معروف بن عبد الغني بن محمود', 'معروف بن عبد الغني بن محمود', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'محمد بن حافظ بن إبراهيم', 'محمد بن حافظ بن إبراهيم', FALSE);
    -- Question 297: q_ar_297
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'من الشاعر الذي فقد بصره نتيجة لمرض الجدري؟', 'من الشاعر الذي فقد بصره نتيجة لمرض الجدري؟', 'أصيب أبو العلاء المعري بمرض الجدري وهو في الرابعة من عمره، مما أدى إلى فقدان بصره بالكامل (وعاش طوال حياته ضريراً ولُقب برهين المحبسين).', 'أصيب أبو العلاء المعري بمرض الجدري وهو في الرابعة من عمره، مما أدى إلى فقدان بصره بالكامل (وعاش طوال حياته ضريراً ولُقب برهين المحبسين).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المعري', 'المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المتنبي', 'المتنبي', FALSE);
    -- Question 298: q_ar_298
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'من هو فاتحة شعراء العصر العباسي الثالث؟', 'من هو فاتحة شعراء العصر العباسي الثالث؟', 'يُصنف مؤرخو الأدب (مثل شوقي ضيف) المتنبي بأنه يمثل "فاتحة" وذروة العصر العباسي الثالث (عصر الدويلات والحمدانيين) لقوة إنتاجه وتعبيره عن روح العصر.', 'يُصنف مؤرخو الأدب (مثل شوقي ضيف) المتنبي بأنه يمثل "فاتحة" وذروة العصر العباسي الثالث (عصر الدويلات والحمدانيين) لقوة إنتاجه وتعبيره عن روح العصر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو فراس الحمداني', 'أبو فراس الحمداني', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الشريف الرضي', 'الشريف الرضي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المتنبي', 'المتنبي', TRUE);
    -- Question 299: q_ar_299
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'من هو خاتمة شعراء العصر العباسي الثالث؟', 'من هو خاتمة شعراء العصر العباسي الثالث؟', 'يُعتبر الفيلسوف الشاعر أبو العلاء المعري (المتوفى 449 هـ) هو "خاتمة" العمالقة الكبار في هذا العصر، لتبدأ بعده مرحلة أدبية يغلب عليها الضعف والتكلف اللفظي.', 'يُعتبر الفيلسوف الشاعر أبو العلاء المعري (المتوفى 449 هـ) هو "خاتمة" العمالقة الكبار في هذا العصر، لتبدأ بعده مرحلة أدبية يغلب عليها الضعف والتكلف اللفظي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المتنبي', 'المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المعري', 'المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'مهيار الديلمي', 'مهيار الديلمي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', FALSE);
    -- Question 300: q_ar_300
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', '١ .هو ابو الطيب احمد بن حسين المتنبي ، ولد في بغداد / 2. كان ابوه سقاء في البصرة', '١ .هو ابو الطيب احمد بن حسين المتنبي ، ولد في بغداد / 2. كان ابوه سقاء في البصرة', 'المتنبي ولد في الكوفة (وليس بغداد)، وأبوه كان سقاءً في الكوفة (وليس البصرة).', 'المتنبي ولد في الكوفة (وليس بغداد)، وأبوه كان سقاءً في الكوفة (وليس البصرة).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement I is true but Statement II is false', 'Statement I is true but Statement II is false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement II is correct but Statement I is false', 'Statement II is correct but Statement I is false', FALSE);
    -- Question 301: q_ar_301
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', '"الخيل والليل والبيداء تعرفني... والسيف والرمح والقرطاس والقلم"', '"الخيل والليل والبيداء تعرفني... والسيف والرمح والقرطاس والقلم"', 'هذا أشهر بيت للمتنبي، وهو البيت الذي تسبب في مقتله عندما أراد الفرار من أعدائه فذكّره غلامه بهذا البيت فاستحيا وعاد للقتال حتى قُتل.', 'هذا أشهر بيت للمتنبي، وهو البيت الذي تسبب في مقتله عندما أراد الفرار من أعدائه فذكّره غلامه بهذا البيت فاستحيا وعاد للقتال حتى قُتل.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المتنبي', 'المتنبي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 302: q_ar_302
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', '"وما الدهر إلا من رواة قصائدي... إذا قلت شعراً أصبح الدهر منشداً" صاحب هذا البيت:', '"وما الدهر إلا من رواة قصائدي... إذا قلت شعراً أصبح الدهر منشداً" صاحب هذا البيت:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '- المتنبي', '- المتنبي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', FALSE);
    -- Question 303: q_ar_303
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'الشاعر الذي قتله شعره، هذه مقولة مشهورة عن الشاعر:', 'الشاعر الذي قتله شعره، هذه مقولة مشهورة عن الشاعر:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '٢ - المتنبي', '٢ - المتنبي', TRUE);
    -- Question 304: q_ar_304
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'كان والده يعرف "بعبدان السقاء":', 'كان والده يعرف "بعبدان السقاء":', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'المتنبي', 'المتنبي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 305: q_ar_305
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'اسم عاشقة أبو الطيب المتنبي:', 'اسم عاشقة أبو الطيب المتنبي:', 'هي خولة أخت سيف الدولة الحمداني، وله فيها مراثٍ فجيعة تدل على مكانتها عنده.', 'هي خولة أخت سيف الدولة الحمداني، وله فيها مراثٍ فجيعة تدل على مكانتها عنده.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'خولة', 'خولة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 306: q_ar_306
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', '"وقد حمل الناس بلسانه على بره وتكرمته، إما رغبة ورهبة"؟', '"وقد حمل الناس بلسانه على بره وتكرمته، إما رغبة ورهبة"؟', 'قيلت في المعري لشدة تمكنه من اللغة والشعر والذكاء، فكان الناس يكرمونه ويهابون لسانه وهجاءه أو يرجون مدحه ونقده.', 'قيلت في المعري لشدة تمكنه من اللغة والشعر والذكاء، فكان الناس يكرمونه ويهابون لسانه وهجاءه أو يرجون مدحه ونقده.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المعري', 'المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 307: q_ar_307
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'أين ولد المعري؟', 'أين ولد المعري؟', 'ولد في معرة النعمان بالشام (سوريا حالياً) وإليها يُنسب.', 'ولد في معرة النعمان بالشام (سوريا حالياً) وإليها يُنسب.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'في معرة', 'في معرة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 308: q_ar_308
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'اسم أبو العلاء المعري:', 'اسم أبو العلاء المعري:', 'اسمه الكامل: أحمد بن عبد الله بن سليمان التنوخي.', 'اسمه الكامل: أحمد بن عبد الله بن سليمان التنوخي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أحمد بن عبد الله', 'أحمد بن عبد الله', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    -- Question 309: q_ar_309
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'فلما بلغ _ من عمره أصيب المعري بالجدري:', 'فلما بلغ _ من عمره أصيب المعري بالجدري:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '٤', '٤', TRUE);
    -- Question 310: q_ar_310
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'من المعروف بلقب برهين المحبسين:', 'من المعروف بلقب برهين المحبسين:', 'المحبسان هما: العمى (محبس البصر) والمنزل (حيث اعتزل الناس بعد عودته من بغداد).', 'المحبسان هما: العمى (محبس البصر) والمنزل (حيث اعتزل الناس بعد عودته من بغداد).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', TRUE);
    -- Question 311: q_ar_311
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'مؤلفة أبو العلاء المعري:', 'مؤلفة أبو العلاء المعري:', 'هي درته النثرية الخالدة التي يصف فيها رحلة خيالية إلى الدار الآخرة.', 'هي درته النثرية الخالدة التي يصف فيها رحلة خيالية إلى الدار الآخرة.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'رسالة الغفران', 'رسالة الغفران', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 312: q_ar_312
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'صاحب "الدرعيات والفصول والغايات وديوان الرسائل ورسالة الملائكة":', 'صاحب "الدرعيات والفصول والغايات وديوان الرسائل ورسالة الملائكة":', 'كتاب "الفصول والغايات في تمجيد الله والمواعظ" هو من أشهر كتبه النثرية.', 'كتاب "الفصول والغايات في تمجيد الله والمواعظ" هو من أشهر كتبه النثرية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المعري', 'المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 313: q_ar_313
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'من مؤلف "رسالة الهناء":', 'من مؤلف "رسالة الهناء":', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المعري', 'المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 314: q_ar_314
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'ليس من مؤلفات أبو العلاء..؟', 'ليس من مؤلفات أبو العلاء..؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'رسالة الحجاب', 'رسالة الحجاب', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 315: q_ar_315
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'من أوصى بكتابة البيت التالي على قبره: "هذا جناه أبي عليّ... وما جنيتُ على أحد"', 'من أوصى بكتابة البيت التالي على قبره: "هذا جناه أبي عليّ... وما جنيتُ على أحد"', 'يعبر البيت عن فلسفته التشاؤمية ونظرته إلى الإنجاب، حيث رأى أن والده جنى عليه بإيجاده في هذه الدنيا المليئة بالشرور والآلام، وهو لم يجنِ على أحد لأنه لم ينجب أولاداً.', 'يعبر البيت عن فلسفته التشاؤمية ونظرته إلى الإنجاب، حيث رأى أن والده جنى عليه بإيجاده في هذه الدنيا المليئة بالشرور والآلام، وهو لم يجنِ على أحد لأنه لم ينجب أولاداً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 316: q_ar_316
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'ينقسم شعر أبي العلاء إلى قسمين:', 'ينقسم شعر أبي العلاء إلى قسمين:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '٢) شعر الشباب، شعر الكهولة', '٢) شعر الشباب، شعر الكهولة', TRUE);
    -- Question 317: q_ar_317
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'hard', '١) أكثر مؤلفات المعري ذهبت بها ريح الحروب الصليبية... ٢) ينقسم شعر أبي العلاء إلى قسمين ١شعر الشباب ٢شعر الحر', '١) أكثر مؤلفات المعري ذهبت بها ريح الحروب الصليبية... ٢) ينقسم شعر أبي العلاء إلى قسمين ١شعر الشباب ٢شعر الحر', 'العبارة الأولى صحيحة تماماً (فُقد الكثير من كتبه بسبب الحروب)، أما الثانية فخاطئة لأن التقسيم (شباب وكهولة) وليس (شعر حر).', 'العبارة الأولى صحيحة تماماً (فُقد الكثير من كتبه بسبب الحروب)، أما الثانية فخاطئة لأن التقسيم (شباب وكهولة) وليس (شعر حر).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'statement 1 is correct and statement 2 is incorrect', 'statement 1 is correct and statement 2 is incorrect', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 318: q_ar_318
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_mutanabbi', 'mcq_single', 'medium', 'ممن أخذ المعري شعر المتنبي؟', 'ممن أخذ المعري شعر المتنبي؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'معروف بن عبد الغني بن محمود', 'معروف بن عبد الغني بن محمود', TRUE);
    -- Question 319: q_ar_319
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من الذي شرح ديوان البحتري وسماه "عبث الوليد"', 'من الذي شرح ديوان البحتري وسماه "عبث الوليد"', '"عبث الوليد" هو كتاب نقدي وشرح وضعه المعري لديوان البحتري (والوليد هو اسم البحتري: الوليد بن عبيد).', '"عبث الوليد" هو كتاب نقدي وشرح وضعه المعري لديوان البحتري (والوليد هو اسم البحتري: الوليد بن عبيد).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 320: q_ar_320
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من الشاعر الذي ابتدع كتابة مناجاة الحيوانات في شعره؟', 'من الشاعر الذي ابتدع كتابة مناجاة الحيوانات في شعره؟', 'ظهر ذلك جلياً في رسالة الغفران ورسالة الصاهل والشاحج (وهي مناجاة على لسان الحصان والحمار).', 'ظهر ذلك جلياً في رسالة الغفران ورسالة الصاهل والشاحج (وهي مناجاة على لسان الحصان والحمار).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    -- Question 321: q_ar_321
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'هو أبو الحسن علي بن عباس وكان مولى عبد الله بن عيسى...', 'هو أبو الحسن علي بن عباس وكان مولى عبد الله بن عيسى...', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن المعتز', 'ابن المعتز', FALSE);
    -- Question 322: q_ar_322
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'hard', 'هو أبو الحسن علي بن العباس، ولد في بغداد، وله أشعار كثيرة في الطعام والشراب، وكان شديد الطيرة يغلو فيها:', 'هو أبو الحسن علي بن العباس، ولد في بغداد، وله أشعار كثيرة في الطعام والشراب، وكان شديد الطيرة يغلو فيها:', 'عُرف ابن الرومي بالتشاؤم المفرط الشديد (الطيرة)، كما تميز بوصف المأكولات (مثل وصف الرقاق والقطايف).', 'عُرف ابن الرومي بالتشاؤم المفرط الشديد (الطيرة)، كما تميز بوصف المأكولات (مثل وصف الرقاق والقطايف).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البحتري', 'البحتري', FALSE);
    -- Question 323: q_ar_323
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو الذي سمي أولاً بابن الرومي؟', 'من هو الذي سمي أولاً بابن الرومي؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', ': القاسم بن عبيد الله', ': القاسم بن عبيد الله', TRUE);
    -- Question 324: q_ar_324
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'عن ابن الرومي: (كانت أمه من أصل الروم / عاصر ثمانية من الخلفاء العباسيين)', 'عن ابن الرومي: (كانت أمه من أصل الروم / عاصر ثمانية من الخلفاء العباسيين)', 'العبارة الأولى خاطئة لأن أبوه هو الذي من أصل رومي، أما أمه فكانت من أصل فارسي (من جهة أسرتها). وعاصر بالفعل ثمانية من خلفاء بني العباس.', 'العبارة الأولى خاطئة لأن أبوه هو الذي من أصل رومي، أما أمه فكانت من أصل فارسي (من جهة أسرتها). وعاصر بالفعل ثمانية من خلفاء بني العباس.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'first one is false & Second one is true', 'first one is false & Second one is true', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 325: q_ar_325
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'عن ابن الرومي: (وُلد بالعقيقة في البغداد / توفي ابن رومي مسموماً)', 'عن ابن الرومي: (وُلد بالعقيقة في البغداد / توفي ابن رومي مسموماً)', 'ولد في بغداد في منطقة العقيقة (أو العقيق)، ومات مسموماً بـمؤامرة من الوزير القاسم بن عبيد الله.', 'ولد في بغداد في منطقة العقيقة (أو العقيق)، ومات مسموماً بـمؤامرة من الوزير القاسم بن عبيد الله.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement I is true but Statement II is false', 'Statement I is true but Statement II is false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement II is correct but Statement I is false', 'Statement II is correct but Statement I is false', FALSE);
    -- Question 326: q_ar_326
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'شاعر وصف الطبيعة:', 'شاعر وصف الطبيعة:', 'البحتري هو أمير وصف الطبيعة (وصف البركة، ووصف الربيع: "أتاك الربيع الطلق يختال ضاحكاً").', 'البحتري هو أمير وصف الطبيعة (وصف البركة، ووصف الربيع: "أتاك الربيع الطلق يختال ضاحكاً").', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البحتري', 'البحتري', TRUE);
    -- Question 327: q_ar_327
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'شعر مَن يمتاز في وصف إيوان كسرى وبركة المتوكل وقصر المعتز بالله؟', 'شعر مَن يمتاز في وصف إيوان كسرى وبركة المتوكل وقصر المعتز بالله؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بحتري', 'بحتري', TRUE);
    -- Question 328: q_ar_328
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من جمع ديوان البحتري؟', 'من جمع ديوان البحتري؟', 'قام العالم الكبير أبو بكر الصولي بجمع وترتيب ديوان البحتري على الحروف الأبجدية.', 'قام العالم الكبير أبو بكر الصولي بجمع وترتيب ديوان البحتري على الحروف الأبجدية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو بكر الصولي', 'أبو بكر الصولي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار بن برد', 'بشار بن برد', FALSE);
    -- Question 329: q_ar_329
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'حماسة أبي تمام مؤلفة من ...... باب وحماسة البحتري من ...... باباً.', 'حماسة أبي تمام مؤلفة من ...... باب وحماسة البحتري من ...... باباً.', 'حماسة أبي تمام تحتوي على 10 أبواب (أولها وأكبرها باب الحماسة)، أما حماسة البحتري فصيغت على نظام الأبواب القصيرة الكثيرة وعددها 174 باباً.', 'حماسة أبي تمام تحتوي على 10 أبواب (أولها وأكبرها باب الحماسة)، أما حماسة البحتري فصيغت على نظام الأبواب القصيرة الكثيرة وعددها 174 باباً.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '١٠، ١٧٤', '١٠، ١٧٤', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار بن برد', 'بشار بن برد', FALSE);
    -- Question 330: q_ar_330
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'رحل أبو تمام إلى مصر طلباً للتكسب في السنة ____؟', 'رحل أبو تمام إلى مصر طلباً للتكسب في السنة ____؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '207 هـ', '207 هـ', TRUE);
    -- Question 331: q_ar_331
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'قام بحتري في العراق في خدمة................؟', 'قام بحتري في العراق في خدمة................؟', 'كان البحتري هو الشاعر الأثير والمقرب جداً من الخليفة العباسي المتوكل على الله.', 'كان البحتري هو الشاعر الأثير والمقرب جداً من الخليفة العباسي المتوكل على الله.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'المتوكل', 'المتوكل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 332: q_ar_332
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من كانت عاشقة بحتري؟', 'من كانت عاشقة بحتري؟', 'تغنى البحتري في فواتح قصائده بـ علوة الحلبية.', 'تغنى البحتري في فواتح قصائده بـ علوة الحلبية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'علوة بنت زريقة', 'علوة بنت زريقة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 333: q_ar_333
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'هوى بشار بن برد جارية تسمى..', 'هوى بشار بن برد جارية تسمى..', 'تشتهر "عبدة" في شعر بشار بن برد كما تشتهر علوة في شعر البحتري.', 'تشتهر "عبدة" في شعر بشار بن برد كما تشتهر علوة في شعر البحتري.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبدة', 'عبدة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البحتري', 'البحتري', FALSE);
    -- Question 334: q_ar_334
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'الاسم الكامل لأبي نواس:', 'الاسم الكامل لأبي نواس:', 'هو الحسن بن هانئ الحكمي الدمشقي.', 'هو الحسن بن هانئ الحكمي الدمشقي.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الحسن بن هانئ', 'الحسن بن هانئ', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 335: q_ar_335
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'شاعر عباسي، كان أبوه من جند مروان بن محمد آخر خلفاء بني أمية:', 'شاعر عباسي، كان أبوه من جند مروان بن محمد آخر خلفاء بني أمية:', 'كان والده هانئ من جند مروان بن محمد وانتقل بعد ذلك إلى الأهواز حيث ولد أبو نواس.', 'كان والده هانئ من جند مروان بن محمد وانتقل بعد ذلك إلى الأهواز حيث ولد أبو نواس.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 336: q_ar_336
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من هو خاتمة شعراء العصر العباسي الثالث؟', 'من هو خاتمة شعراء العصر العباسي الثالث؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المعري', 'المعري', TRUE);
    -- Question 337: q_ar_337
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'أول ما تكلم بشار من أنواع الشعر؟', 'أول ما تكلم بشار من أنواع الشعر؟', 'بدأ بشار بن برد حياته الشعرية منذ طفولته المبكرة بـ الهجاء، وكان يهجو الناس وجيرانه، بل وهجا جريراً وهو صبي صغير ليلفت الانتباه إليه.', 'بدأ بشار بن برد حياته الشعرية منذ طفولته المبكرة بـ الهجاء، وكان يهجو الناس وجيرانه، بل وهجا جريراً وهو صبي صغير ليلفت الانتباه إليه.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'وصف', 'وصف', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'مدح', 'مدح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'فخر', 'فخر', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الهجاء', 'الهجاء', TRUE);
    -- Question 338: q_ar_338
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'كان الشاعر العباسي على أدبه وفضله ورقته من أوسع خلق الله ثوباً وأبخلهم على نفسه وغيره، مَن؟', 'كان الشاعر العباسي على أدبه وفضله ورقته من أوسع خلق الله ثوباً وأبخلهم على نفسه وغيره، مَن؟', 'اشتُهر البحتري في كتب التاريخ والتراجم بالتناقض العجيب؛ فقد كان شعره في غاية الرقة والديباجة الموسيقية، وكان يلبس ثياباً واسعة وفضفاضة جداً، لكنه كان معروفاً بالشُّح والبخل الشديد على نفسه وعلى عياله رغبةً في جمع المال.', 'اشتُهر البحتري في كتب التاريخ والتراجم بالتناقض العجيب؛ فقد كان شعره في غاية الرقة والديباجة الموسيقية، وكان يلبس ثياباً واسعة وفضفاضة جداً، لكنه كان معروفاً بالشُّح والبخل الشديد على نفسه وعلى عياله رغبةً في جمع المال.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بحتري', 'بحتري', TRUE);
    -- Question 339: q_ar_339
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'hard', 'يمتاز بالإجادة في المدح والقصد فيه، والقدرة على تصوير أخلاق الممدوح، والإبداع في وصف القصور الفخمة والأبنية العجيبة، هذه العبارة عن؟', 'يمتاز بالإجادة في المدح والقصد فيه، والقدرة على تصوير أخلاق الممدوح، والإبداع في وصف القصور الفخمة والأبنية العجيبة، هذه العبارة عن؟', 'البحتري هو الشاعر الوصاف الأبرز لهذه المظاهر العمرانية في العصر العباسي، ومنها وصفه الشهير لقصر الجعفري وبركة المتوكل وإيوان كسرى.', 'البحتري هو الشاعر الوصاف الأبرز لهذه المظاهر العمرانية في العصر العباسي، ومنها وصفه الشهير لقصر الجعفري وبركة المتوكل وإيوان كسرى.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بحتري', 'بحتري', TRUE);
    -- Question 340: q_ar_340
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', '"أبو نواس حلّ من الطبع بحيث يصل شعره إلى القلب بغير إذن" مَن قائل هذه العبارة؟', '"أبو نواس حلّ من الطبع بحيث يصل شعره إلى القلب بغير إذن" مَن قائل هذه العبارة؟', 'أطلق أبو العلاء المعري هذا الحكم النقدي على أبي نواس في كتابه "رسالة الغفران" مادحاً سلاسة طبعه وسهولته وعفويته اللغوية.', 'أطلق أبو العلاء المعري هذا الحكم النقدي على أبي نواس في كتابه "رسالة الغفران" مادحاً سلاسة طبعه وسهولته وعفويته اللغوية.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جاحظ', 'جاحظ', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن جريج', 'ابن جريج', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو هلال العسكري', 'أبو هلال العسكري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', TRUE);
    -- Question 341: q_ar_341
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'ابن الأثير: "إن مكانته من الشعراء لا يُجهل" عمّن قال هذا؟', 'ابن الأثير: "إن مكانته من الشعراء لا يُجهل" عمّن قال هذا؟', 'أنصف ابن الأثير الشاعر ابن الرومي في كتابه النبيل (المثل السائر) مبيناً قدرته الاستثنائية على توليد المعاني الغريبة والإطالة فيها وتدقيق الأوصاف بشكل لا يجهله ناظر في الشعر.', 'أنصف ابن الأثير الشاعر ابن الرومي في كتابه النبيل (المثل السائر) مبيناً قدرته الاستثنائية على توليد المعاني الغريبة والإطالة فيها وتدقيق الأوصاف بشكل لا يجهله ناظر في الشعر.', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المتنبي', 'المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 342: q_ar_342
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'assertion_reason', 'hard', 'تصريح عن أبي تمام:
▪️ ولد في أهواز، اسمه أبو عبادة وليد بن عبيد. (خطأ: هذا هو البحتري)
▪️ "أنت والله يا بني أمير الشعراء غداً بعدي". هذا قوله للبحتري. (صحيح: قاله أبو تمام للبحتري متبنياً ومبشراً بمستقبله)', 'تصريح عن أبي تمام:
▪️ ولد في أهواز، اسمه أبو عبادة وليد بن عبيد. (خطأ: هذا هو البحتري)
▪️ "أنت والله يا بني أمير الشعراء غداً بعدي". هذا قوله للبحتري. (صحيح: قاله أبو تمام للبحتري متبنياً ومبشراً بمستقبله)', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement II is incorrect but Statement I is true', 'Statement II is incorrect but Statement I is true', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement II is correct but 1 is false', 'Statement II is correct but 1 is false', TRUE);
    -- Question 343: q_ar_343
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'assertion_reason', 'hard', 'تصريح عن أبي نواس:
▪️ قال والبة بن الحباب لأبي نواس: إني أرى فيك مخايل أرى لا تضيعها. (صحيح: عندما رآه والبة أول مرة واكتشف موهبته)
▪️ كان أبو نواس يود لو يتصل بوالبة بن الحباب ليأخذه. (صحيح: كان أبو نواس يتمنى الخروج من عطارته بالبصرة والانطلاق مع شاعر شهير)', 'تصريح عن أبي نواس:
▪️ قال والبة بن الحباب لأبي نواس: إني أرى فيك مخايل أرى لا تضيعها. (صحيح: عندما رآه والبة أول مرة واكتشف موهبته)
▪️ كان أبو نواس يود لو يتصل بوالبة بن الحباب ليأخذه. (صحيح: كان أبو نواس يتمنى الخروج من عطارته بالبصرة والانطلاق مع شاعر شهير)', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement II is incorrect but Statement I is true', 'Statement II is incorrect but Statement I is true', FALSE);
    -- Question 344: q_ar_344
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'assertion_reason', 'hard', 'التصريح عن أبي تمام:
▪️ كان أبو تمام أسمر اللون طويل القامة فصيخاً حلو الكلام فيه تمتمة يسيرة. (صحيح: هذه هي صفته الخِلقية التراثية المذكورة في الأغاني وتاريخ بغداد)
▪️ إنه كان يحفظ أربعة عشر ألف أرجوزة غير القصائد والمقطوعات. (صحيح: عُرف بحافظته الخارقة للأراجيز الجاهلية والإسلامية)', 'التصريح عن أبي تمام:
▪️ كان أبو تمام أسمر اللون طويل القامة فصيخاً حلو الكلام فيه تمتمة يسيرة. (صحيح: هذه هي صفته الخِلقية التراثية المذكورة في الأغاني وتاريخ بغداد)
▪️ إنه كان يحفظ أربعة عشر ألف أرجوزة غير القصائد والمقطوعات. (صحيح: عُرف بحافظته الخارقة للأراجيز الجاهلية والإسلامية)', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', TRUE);
    -- Question 345: q_ar_345
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'assertion_reason', 'hard', 'تصريح عن أبي تمام:
▪️ أبو تمام لقي بحتري في حمص وتلمذ البحتري منه. (صحيح: التقيا بحمص وتأثر البحتري بأبي تمام وجعل له راتباً شهرياً)
▪️ حماسة أبي تمام مؤلفة من خمسة عشر أبواباً. (خطأ: حماسة أبي تمام مؤلفة من عشرة أبواب فقط)', 'تصريح عن أبي تمام:
▪️ أبو تمام لقي بحتري في حمص وتلمذ البحتري منه. (صحيح: التقيا بحمص وتأثر البحتري بأبي تمام وجعل له راتباً شهرياً)
▪️ حماسة أبي تمام مؤلفة من خمسة عشر أبواباً. (خطأ: حماسة أبي تمام مؤلفة من عشرة أبواب فقط)', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement II is incorrect but Statement I is true', 'Statement II is incorrect but Statement I is true', TRUE);
    -- Question 346: q_ar_346
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'assertion_reason', 'hard', 'تصريحان عن البحتري:
▪️ أقام في بغداد دهراً طويلاً ثم عاد إلى الشام. (صحيح: أقام في خدمة المتوكل والفتح بن خاقان ببغداد وسامراء، ثم رجع إلى الشام ومات بمنبج)
▪️ قال أبو تمام له: أنت أشعر من أنشدني. (صحيح: قالها له إعجاباً بقصيدته وتثبيتاً لمكانته)', 'تصريحان عن البحتري:
▪️ أقام في بغداد دهراً طويلاً ثم عاد إلى الشام. (صحيح: أقام في خدمة المتوكل والفتح بن خاقان ببغداد وسامراء، ثم رجع إلى الشام ومات بمنبج)
▪️ قال أبو تمام له: أنت أشعر من أنشدني. (صحيح: قالها له إعجاباً بقصيدته وتثبيتاً لمكانته)', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', TRUE);
    -- Question 347: q_ar_347
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'قال عنه أبو تمام: "أنت والله يا بني أمير الشعراء من بعدي"... عمن قال هذا؟', 'قال عنه أبو تمام: "أنت والله يا بني أمير الشعراء من بعدي"... عمن قال هذا؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بحتري', 'بحتري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 348: q_ar_348
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'معنى كلمة "البحتري":', 'معنى كلمة "البحتري":', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'قصير القامة', 'قصير القامة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 349: q_ar_349
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'يعد ___ رأس الطبقة الثانية من المولدين:', 'يعد ___ رأس الطبقة الثانية من المولدين:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '١. البحتري', '١. البحتري', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'ابن الرومي', 'ابن الرومي', FALSE);
    -- Question 350: q_ar_350
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'هو مختارات من أشعار العرب الجاهلية والإسلام:', 'هو مختارات من أشعار العرب الجاهلية والإسلام:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '٢. كتاب الحماسة أو ديوان الحماسة', '٢. كتاب الحماسة أو ديوان الحماسة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 351: q_ar_351
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'أقدم من حاول تقسيم الشعر العربي إلى موضوعات ونظمه في عشرة موضوعات هو:___', 'أقدم من حاول تقسيم الشعر العربي إلى موضوعات ونظمه في عشرة موضوعات هو:___', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', '٢. أبو تمام', '٢. أبو تمام', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 352: q_ar_352
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', '"أنا وأبو تمام حكيمان والشاعر البحتري" من قال هذا؟', '"أنا وأبو تمام حكيمان والشاعر البحتري" من قال هذا؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'b) المتنبي', 'b) المتنبي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', FALSE);
    -- Question 353: q_ar_353
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'أين ولد البحتري؟', 'أين ولد البحتري؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'c) منبج', 'c) منبج', TRUE);
    -- Question 354: q_ar_354
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'اسم الكامل البحتري؟', 'اسم الكامل البحتري؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'a) أبو عبادة الوليد بن عبيد الطائي', 'a) أبو عبادة الوليد بن عبيد الطائي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    -- Question 355: q_ar_355
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', '"ولا أعرف أحداً بعد أبي تمام أشعر من البحتري" من قال هذا؟', '"ولا أعرف أحداً بعد أبي تمام أشعر من البحتري" من قال هذا؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'b) الصولي', 'b) الصولي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'بشار بن برد', 'بشار بن برد', FALSE);
    -- Question 356: q_ar_356
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'اختر الشاذ:', 'اختر الشاذ:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بشار بن برد', 'بشار بن برد', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كتاب المجنون', 'كتاب المجنون', TRUE);
    -- Question 357: q_ar_357
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'وفي القصيدة أبو تمام فن غنائي وفن ملحمي. ما اسم القصيدة؟', 'وفي القصيدة أبو تمام فن غنائي وفن ملحمي. ما اسم القصيدة؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المزيج', 'المزيج', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    -- Question 358: q_ar_358
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'معظم شعر أبي تمام في……', 'معظم شعر أبي تمام في……', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'مدح', 'مدح', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 359: q_ar_359
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'هو حبيب بن أوس الطّائى. المعروف بمن؟', 'هو حبيب بن أوس الطّائى. المعروف بمن؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن الرومي', 'ابن الرومي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', TRUE);
    -- Question 360: q_ar_360
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'يقال إن أبا نواس لم يصدق في حب امرأة غيرها. عن أي امرأة قال هذا؟', 'يقال إن أبا نواس لم يصدق في حب امرأة غيرها. عن أي امرأة قال هذا؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', '٢....... جنان', '٢....... جنان', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو نواس', 'أبو نواس', FALSE);
    -- Question 361: q_ar_361
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'توصل بشار بن برد إلى الخليفة العباسي ومدحه:', 'توصل بشار بن برد إلى الخليفة العباسي ومدحه:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'المهدي', 'المهدي', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    -- Question 362: q_ar_362
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'شاعر عباسي، كنيته أبو معاذ لقبه المرعث لأنه كان في أذنيه رعثة:', 'شاعر عباسي، كنيته أبو معاذ لقبه المرعث لأنه كان في أذنيه رعثة:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو الطيب المتنبي', 'أبو الطيب المتنبي', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار بن برد', 'بشار بن برد', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    -- Question 363: q_ar_363
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'وكان لـ ....... صلة بين عهدين: القديم والجديد:', 'وكان لـ ....... صلة بين عهدين: القديم والجديد:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'بشار', 'بشار', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', FALSE);
    -- Question 364: q_ar_364
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_abbasid', 'top_abbasid_poets', 'mcq_single', 'medium', 'من الخليفة العباسي الذي قتل بشار بن برد بتهمة الزندقة؟', 'من الخليفة العباسي الذي قتل بشار بن برد بتهمة الزندقة؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'المهدي', 'المهدي', TRUE);
    -- Question 365: q_ar_365
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"بشار وأبو نواس معناهما واحد والعدة إثنان"، قاله:', '"بشار وأبو نواس معناهما واحد والعدة إثنان"، قاله:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الجاحظ', 'الجاحظ', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأخطل', 'الأخطل', FALSE);
    -- Question 366: q_ar_366
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'مات فرزدق في سنة:', 'مات فرزدق في سنة:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', '١. ١١٤ هـ', '١. ١١٤ هـ', TRUE);
    -- Question 367: q_ar_367
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'اسم الكامل لجرير:', 'اسم الكامل لجرير:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كثير عزة', 'كثير عزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'جرير بن عطية بن الخطفي', 'جرير بن عطية بن الخطفي', TRUE);
    -- Question 368: q_ar_368
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '* جرير بن عطية نشأ في البادية أيام معاوية. / * جرير وهو من الشعراء العباسيين', '* جرير بن عطية نشأ في البادية أيام معاوية. / * جرير وهو من الشعراء العباسيين', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'first one is true and the second false', 'first one is true and the second false', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'كثير عزة', 'كثير عزة', FALSE);
    -- Question 369: q_ar_369
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'لمن مدح جرير بهذا البيت: "ألستم خير من ركب المطايا... وأندى العالمين بطون راح"', 'لمن مدح جرير بهذا البيت: "ألستم خير من ركب المطايا... وأندى العالمين بطون راح"', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'كثير عزة', 'كثير عزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عبد الملك بن مروان', 'عبد الملك بن مروان', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'جرير', 'جرير', FALSE);
    -- Question 370: q_ar_370
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'دفن جرير في --', 'دفن جرير في --', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'يمامة', 'يمامة', TRUE);
    -- Question 371: q_ar_371
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'نشأ جرير في بادية أيام -------', 'نشأ جرير في بادية أيام -------', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'معاوية', 'معاوية', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأخطل', 'الأخطل', FALSE);
    -- Question 372: q_ar_372
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'دفن....... في اليمامة حيث قبر الأعشى.', 'دفن....... في اليمامة حيث قبر الأعشى.', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'جرير', 'جرير', TRUE);
    -- Question 373: q_ar_373
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'ما معنى الفرزدق؟', 'ما معنى الفرزدق؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الرغيف', 'الرغيف', TRUE);
    -- Question 374: q_ar_374
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'قد روي أن ....... هو الذي أطلق عليه لقب "الأخطل" لما رأى فيه من شر:', 'قد روي أن ....... هو الذي أطلق عليه لقب "الأخطل" لما رأى فيه من شر:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كعب بن جعيل', 'كعب بن جعيل', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'قيس بن الملوح', 'قيس بن الملوح', FALSE);
    -- Question 375: q_ar_375
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"نفسي فداء أمير المؤمنين إذا... أبدى النواجذ يوماً عارم ذكر" هذا للأخطل في..', '"نفسي فداء أمير المؤمنين إذا... أبدى النواجذ يوماً عارم ذكر" هذا للأخطل في..', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'المدح', 'المدح', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    -- Question 376: q_ar_376
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"خلوا المكارم لستم من أهلها... وخذوا مساحيكم بني النجار"', '"خلوا المكارم لستم من أهلها... وخذوا مساحيكم بني النجار"', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الأخطل', 'الأخطل', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    -- Question 377: q_ar_377
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'عن الأخطل: (كان فخوراً بنفسه / أنه كان يجري على أسلوب أعشى)', 'عن الأخطل: (كان فخوراً بنفسه / أنه كان يجري على أسلوب أعشى)', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement I is true but Statement II is false', 'Statement I is true but Statement II is false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement II is correct but Statement I is false', 'Statement II is correct but Statement I is false', FALSE);
    -- Question 378: q_ar_378
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'ماذا تمنع الأخطل عن إعلان إسلامه؟', 'ماذا تمنع الأخطل عن إعلان إسلامه؟', 'عندما فكر في الإسلام وقيل له إنه يحرم الخمر والزنا، تراجع وقال أبياتاً في تفضيل الخمر ومات نصرانياً).', 'عندما فكر في الإسلام وقيل له إنه يحرم الخمر والزنا، تراجع وقال أبياتاً في تفضيل الخمر ومات نصرانياً).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'قيس بن الملوح', 'قيس بن الملوح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كثير عزة', 'كثير عزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'لكونه شغوفاً بالخمر', 'لكونه شغوفاً بالخمر', TRUE);
    -- Question 379: q_ar_379
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'hard', 'بيانان فيما يلي: ( كانت بثينة ابنة عم جميل بن معمر ولها أخت اسمها أم الجسير... / * أحب جميل بن معمر بثينة فخطبها إلى أبيها ولكن أباها رده)*', 'بيانان فيما يلي: ( كانت بثينة ابنة عم جميل بن معمر ولها أخت اسمها أم الجسير... / * أحب جميل بن معمر بثينة فخطبها إلى أبيها ولكن أباها رده)*', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'جميل بثينة', 'جميل بثينة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'كثير عزة', 'كثير عزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الأول والثاني صحيحان', 'الأول والثاني صحيحان', TRUE);
    -- Question 380: q_ar_380
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'hard', 'عندما أقبل جميل بن معمر يخطب بثينة رده أهلها خائباً فهجاهم فاستعدوا عليه مروان بن الحكم فتوعده الوالي وأهدر دمه فذهب إلى اليمن ثم إلى الشام ثم:', 'عندما أقبل جميل بن معمر يخطب بثينة رده أهلها خائباً فهجاهم فاستعدوا عليه مروان بن الحكم فتوعده الوالي وأهدر دمه فذهب إلى اليمن ثم إلى الشام ثم:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'مصر حيث مات', 'مصر حيث مات', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'قيس بن الملوح', 'قيس بن الملوح', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'الفرزدق', 'الفرزدق', FALSE);
    -- Question 381: q_ar_381
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'كتب جميل بن معمر قصائد في مدح قبيلة ونال منها عطاءً جزيلاً وهذه القبيلة هي:', 'كتب جميل بن معمر قصائد في مدح قبيلة ونال منها عطاءً جزيلاً وهذه القبيلة هي:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'بنو مخزوم', 'بنو مخزوم', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'جميل بثينة', 'جميل بثينة', FALSE);
    -- Question 382: q_ar_382
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"أمن آل نعم أنت غاد فمبكر... غداة غد أم رائح فمهجر"', '"أمن آل نعم أنت غاد فمبكر... غداة غد أم رائح فمهجر"', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'الفرزدق', 'الفرزدق', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'كثير عزة', 'كثير عزة', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'جرير', 'جرير', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'عمر بن أبي ربيعة', 'عمر بن أبي ربيعة', TRUE);
    -- Question 383: q_ar_383
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', '"أي حق رُفع وأي باطل وُضع" مَن قال هذا عن عمر بن أبي ربيعة؟', '"أي حق رُفع وأي باطل وُضع" مَن قال هذا عن عمر بن أبي ربيعة؟', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'البحتري', 'البحتري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'عمر بن عبد العزيز', 'عمر بن عبد العزيز', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'أبو تمام', 'أبو تمام', FALSE);
    -- Question 384: q_ar_384
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'medium', 'اسم الكامل لعمر بن أبي ربيعة:', 'اسم الكامل لعمر بن أبي ربيعة:', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العلاء المعري', 'أبو العلاء المعري', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'أبو تمام', 'أبو تمام', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', '١. أبو الخطاب عبد الله بن أبي ربيعة', '١. أبو الخطاب عبد الله بن أبي ربيعة', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'البحتري', 'البحتري', FALSE);
    -- Question 385: q_ar_385
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_classical', 'top_origins_jahili', 'mcq_single', 'medium', 'كان دهلك جزر البحر الأحمر بين بلاد.....', 'كان دهلك جزر البحر الأحمر بين بلاد.....', '', '', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'أبو العتاهية', 'أبو العتاهية', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'ابن المعتز', 'ابن المعتز', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'أبو نواس', 'أبو نواس', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'اليمن والحبشة', 'اليمن والحبشة', TRUE);
    -- Question 386: q_ar_386
    v_qid := uuid_generate_v4();
    INSERT INTO public.questions (id, exam_id, subject_id, chapter_id, topic_id, type, difficulty, question_text, question_text_arabic, explanation, explanation_arabic, is_pyq, pyq_paper, review_status)
    VALUES (v_qid, 'ugc_net', 'sub_ugc_arabic', 'chap_arabic_umayyad', 'top_naqaid_ghazal', 'mcq_single', 'hard', 'عن عمر بن أبي ربيعة: (ومن الناس من يقول إن عمراً كان عفيفاً يصف ولا يقف / أنه زهد وتنسك بعد عودته من دهلك)', 'عن عمر بن أبي ربيعة: (ومن الناس من يقول إن عمراً كان عفيفاً يصف ولا يقف / أنه زهد وتنسك بعد عودته من دهلك)', 'دافع عنه ابن عباس وغيره بأنه عفيف اللسان "يصف ولا يقف عند الحرام الفعلي"، وأنه في أخريات حياته بعد التوبة والعودة من المنفى نسك وترك الغزل تماماً).', 'دافع عنه ابن عباس وغيره بأنه عفيف اللسان "يصف ولا يقف عند الحرام الفعلي"، وأنه في أخريات حياته بعد التوبة والعودة من المنفى نسك وترك الغزل تماماً).', true, 'UGC NET Arabic Literature', 'approved');
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_1', 'Both Statement I and Statement II are true', 'Both Statement I and Statement II are true', TRUE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_2', 'Both Statement I and Statement II are false', 'Both Statement I and Statement II are false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_3', 'Statement I is true but Statement II is false', 'Statement I is true but Statement II is false', FALSE);
    INSERT INTO public.question_options (question_id, option_key, option_text, option_text_arabic, is_correct)
    VALUES (v_qid, 'opt_4', 'Statement II is correct but Statement I is false', 'Statement II is correct but Statement I is false', FALSE);
END $$;

-- 7. Update total question count in subjects table
UPDATE public.subjects SET total_questions = (SELECT COUNT(*) FROM public.questions WHERE subject_id = 'sub_ugc_arabic'), total_chapters = 4 WHERE id = 'sub_ugc_arabic';