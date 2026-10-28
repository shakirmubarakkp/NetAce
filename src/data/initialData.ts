import type { 
  Examination, 
  ExamPaper, 
  Subject, 
  Chapter, 
  Topic, 
  Question, 
  Badge, 
  UserProfile, 
  LeaderboardUser,
  DailyQuestItem
} from '../types';
import { ARABIC_QUESTIONS } from './arabicQuestionsData';

export const INITIAL_EXAMINATIONS: Examination[] = [
  {
    id: 'ugc_net',
    name: 'UGC NET / JRF',
    shortCode: 'UGC-NET',
    description: 'National Eligibility Test for Assistant Professor and Junior Research Fellowship by NTA.',
    category: 'Teaching & Research',
    icon: 'GraduationCap',
    badgeColor: 'from-blue-600 to-indigo-700',
    papersCount: 2,
    isPopular: true
  },
  {
    id: 'ktet',
    name: 'KTET (Kerala TET)',
    shortCode: 'KTET',
    description: 'Kerala Teacher Eligibility Test conducted by Pareeksha Bhavan for LP, UP & High School.',
    category: 'State Teaching Eligibility',
    icon: 'BookOpen',
    badgeColor: 'from-emerald-600 to-teal-700',
    papersCount: 3,
    isPopular: true
  },
  {
    id: 'jee_main',
    name: 'JEE Main',
    shortCode: 'JEE-MAIN',
    description: 'Joint Entrance Examination for premier Engineering Institutions (NITs, IIITs, CFTIs).',
    category: 'Engineering Entrance',
    icon: 'Atom',
    badgeColor: 'from-amber-600 to-orange-700',
    papersCount: 1,
    isPopular: true
  },
  {
    id: 'banking',
    name: 'Bank PO & Clerk',
    shortCode: 'IBPS/SBI',
    description: 'IBPS, SBI PO & Clerk national banking officer recruitment examinations.',
    category: 'Banking & Finance',
    icon: 'Building2',
    badgeColor: 'from-violet-600 to-purple-800',
    papersCount: 2
  },
  {
    id: 'general_recruitment',
    name: 'SSC & State PSC',
    shortCode: 'PSC/SSC',
    description: 'Combined Graduate Level and State Public Service Commission officer tests.',
    category: 'Civil & Govt Services',
    icon: 'Landmark',
    badgeColor: 'from-rose-600 to-pink-700',
    papersCount: 2
  }
];

export const INITIAL_PAPERS: ExamPaper[] = [
  { id: 'ugc_p1', examId: 'ugc_net', name: 'Paper I: Teaching & Research Aptitude', code: 'PAPER-1', description: 'Mandatory general paper for all candidates (50 questions, 100 marks)' },
  { id: 'ugc_p2', examId: 'ugc_net', name: 'Paper II: Subject Specialization', code: 'PAPER-2', description: 'Core domain paper (100 questions, 200 marks)' },
  { id: 'ktet_cat1', examId: 'ktet', name: 'Category I (Lower Primary)', code: 'CAT-1', description: 'Classes 1 to 5 teacher eligibility' },
  { id: 'ktet_cat2', examId: 'ktet', name: 'Category II (Upper Primary)', code: 'CAT-2', description: 'Classes 6 to 8 teacher eligibility' },
  { id: 'jee_paper1', examId: 'jee_main', name: 'B.E. / B.Tech Paper', code: 'PAPER-1', description: 'Physics, Chemistry, and Mathematics' }
];

export const INITIAL_SUBJECTS: Subject[] = [
  // UGC NET Paper 1
  {
    id: 'sub_ugc_p1',
    paperId: 'ugc_p1',
    examId: 'ugc_net',
    name: 'General Paper on Teaching & Research',
    description: 'Teaching Aptitude, Research Methodology, ICT, Higher Education System, and Environment.',
    icon: 'Brain',
    color: 'from-indigo-500 to-blue-600',
    isFreePreview: true,
    totalChapters: 5,
    totalQuestions: 24
  },
  // UGC NET Arabic
  {
    id: 'sub_ugc_arabic',
    paperId: 'ugc_p2',
    examId: 'ugc_net',
    name: 'Arabic (اللغة العربية وآدابها)',
    nameArabic: 'اللغة العربية وآدابها',
    description: 'Classical, Umayyad, Abbasid & Modern Literature, Literary Criticism, Balaghah, and Nahw.',
    icon: 'Languages',
    color: 'from-emerald-500 to-teal-700',
    isFreePreview: true,
    totalChapters: 4,
    totalQuestions: 390
  },
  // UGC NET Malayalam
  {
    id: 'sub_ugc_malayalam',
    paperId: 'ugc_p2',
    examId: 'ugc_net',
    name: 'Malayalam (മലയാള സാഹിത്യം)',
    nameMalayalam: 'മലയാള സാഹിത്യം',
    description: 'Ancient & Medieval Poetry, Modern Movements, Novel, Drama, Criticism, and Linguistics.',
    icon: 'Feather',
    color: 'from-amber-500 to-rose-600',
    isFreePreview: true,
    totalChapters: 5,
    totalQuestions: 26
  },
  // UGC NET English
  {
    id: 'sub_ugc_english',
    paperId: 'ugc_p2',
    examId: 'ugc_net',
    name: 'English Literature & Theory',
    description: 'British Literature, Postcolonialism, Structuralism, Deconstruction, Cultural Studies, ELT.',
    icon: 'BookOpen',
    color: 'from-purple-500 to-indigo-700',
    isFreePreview: false,
    totalChapters: 6,
    totalQuestions: 25
  },
  // KTET
  {
    id: 'sub_ktet_pedagogy',
    paperId: 'ktet_cat1',
    examId: 'ktet',
    name: 'Child Development & Pedagogy',
    nameMalayalam: 'ശിശുവികസനവും അധ്യാപനശാസ്ത്രവും',
    description: 'Piaget, Vygotsky, Bruner, inclusive education, learning theories, and evaluation techniques.',
    icon: 'Sparkles',
    color: 'from-cyan-500 to-blue-600',
    isFreePreview: true,
    totalChapters: 4,
    totalQuestions: 18
  },
  // JEE Main Physics
  {
    id: 'sub_jee_physics',
    paperId: 'jee_paper1',
    examId: 'jee_main',
    name: 'Physics: Mechanics & Laws',
    description: 'Kinematics, Newton Laws of Motion, Work Energy Power, Rotational Dynamics, Gravitation.',
    icon: 'Compass',
    color: 'from-orange-500 to-red-600',
    isFreePreview: true,
    totalChapters: 5,
    totalQuestions: 20
  }
];

export const INITIAL_CHAPTERS: Chapter[] = [
  // UGC NET Paper 1 Chapters
  {
    id: 'chap_ugc_teaching',
    subjectId: 'sub_ugc_p1',
    name: 'Teaching Aptitude & Pedagogy',
    unitNumber: 1,
    description: 'Levels of teaching, learner characteristics, CBCS, and modern evaluation systems.',
    isFree: true,
    order: 1,
    estimatedMinutes: 45,
    bossName: 'Pedagogy Overlord: Bloom-Vygotsky',
    bossAvatar: '🧙‍♂️'
  },
  {
    id: 'chap_ugc_research',
    subjectId: 'sub_ugc_p1',
    name: 'Research Methodology & Ethics',
    unitNumber: 2,
    description: 'Qualitative vs Quantitative, Positivism, sampling methods, hypothesis testing, plagiarism.',
    isFree: true,
    order: 2,
    estimatedMinutes: 50,
    bossName: 'The Empirical Mastermind',
    bossAvatar: '🔬'
  },
  {
    id: 'chap_ugc_ict',
    subjectId: 'sub_ugc_p1',
    name: 'Information & Communication Tech (ICT)',
    unitNumber: 3,
    description: 'Swayam, Swayam Prabha, digital higher education initiatives, memory, networking basics.',
    isFree: false,
    order: 3,
    estimatedMinutes: 40,
    bossName: 'Cyber Sentinel',
    bossAvatar: '🤖'
  },
  // UGC NET Arabic Chapters
  {
    id: 'chap_arabic_classical',
    subjectId: 'sub_ugc_arabic',
    name: 'Pre-Islamic & Early Islamic Literature (الأدب الجاهلي والإسلامي)',
    unitNumber: 1,
    description: 'Al-Mu’allaqat, Imru’ al-Qays, Hassan ibn Thabit, characteristics of Jahili poetry and Su’luk.',
    isFree: true,
    order: 1,
    estimatedMinutes: 60,
    bossName: 'Imru’ al-Qays the Vagabond King (الملك الضليل)',
    bossAvatar: '👑'
  },
  {
    id: 'chap_arabic_abbasid',
    subjectId: 'sub_ugc_arabic',
    name: 'Abbasid Golden Era & Criticism (العصر العباسي والنقد الأدبي)',
    unitNumber: 2,
    description: 'Al-Mutanabbi, Abu Tammam, Al-Jahiz, Ibn al-Muqaffa, and evolution of Arabic literary theory.',
    isFree: true,
    order: 2,
    estimatedMinutes: 65,
    bossName: 'Al-Mutanabbi: The Undefeated Poet (المتنبي)',
    bossAvatar: '⚔️'
  },
  {
    id: 'chap_arabic_nahw',
    subjectId: 'sub_ugc_arabic',
    name: 'Grammar, Morphology & Rhetoric (النحو والصرف والبلاغة)',
    unitNumber: 3,
    description: 'I’rab rules, Nawasikh, Majaz, Kinayah, Badi’, and Sibawayh grammatical school principles.',
    isFree: false,
    order: 3,
    estimatedMinutes: 70,
    bossName: 'Sibawayh: Sovereign of Grammatical I’rab (سيبويه)',
    bossAvatar: '📜'
  },
  {
    id: 'chap_arabic_umayyad',
    subjectId: 'sub_ugc_arabic',
    name: 'Umayyad Poetry, Naqa’id & Ghazal (العصر الأموي والنقائض والغزل)',
    unitNumber: 4,
    description: 'Jarir, Al-Farazdaq, Al-Akhtal (Naqa’id), Ghazal Udri & Sarih (Jamil Buthayna, Umar ibn Abi Rabi’ah).',
    isFree: true,
    order: 4,
    estimatedMinutes: 55,
    bossName: 'Jarir & Farazdaq: Duelists of Naqa’id (صقرا النقائض)',
    bossAvatar: '🦅'
  },
  // UGC NET Malayalam Chapters
  {
    id: 'chap_mal_poetry',
    subjectId: 'sub_ugc_malayalam',
    name: 'പ്രാചീന-മധ്യകാല കവിത (Early & Medieval Poetry)',
    unitNumber: 1,
    description: 'പാട്ട് പ്രസ്ഥാനം, മണിപ്രവാളം, കണ്ണശ്ശ രാമായണം, എഴുത്തച്ഛന്റെ കിളിപ്പാട്ട് രീതി.',
    isFree: true,
    order: 1,
    estimatedMinutes: 50,
    bossName: 'തുഞ്ചത്തെഴുത്തച്ഛൻ (Thunchath Ezhuthachan)',
    bossAvatar: '🦜'
  },
  {
    id: 'chap_mal_modern',
    subjectId: 'sub_ugc_malayalam',
    name: 'ആധുനിക കവിത്രയവും ഭാവഗീത പ്രസ്ഥാനവും (Modern Trio)',
    unitNumber: 2,
    description: 'കുമാരനാശാൻ, വള്ളത്തോൾ, ഉള്ളൂർ — സാമൂഹിക നവോത്ഥാനവും സൗന്ദര്യശാസ്ത്രവും.',
    isFree: true,
    order: 2,
    estimatedMinutes: 55,
    bossName: 'മഹാകവി കുമാരനാശാൻ (Kumaran Asan)',
    bossAvatar: '🌸'
  },
  // UGC NET English Chapters
  {
    id: 'chap_eng_theory',
    subjectId: 'sub_ugc_english',
    name: 'Literary Theory & Criticism',
    unitNumber: 1,
    description: 'New Criticism, Structuralism, Derridean Deconstruction, Foucault, Said’s Orientalism.',
    isFree: false,
    order: 1,
    estimatedMinutes: 60,
    bossName: 'The Hermeneutic Titan (Derrida & Foucault)',
    bossAvatar: '🏛️'
  },
  // KTET
  {
    id: 'chap_ktet_theories',
    subjectId: 'sub_ktet_pedagogy',
    name: 'Learning Theories & Cognitive Development',
    unitNumber: 1,
    description: 'Piaget stages, Vygotsky ZPD and Scaffolding, Kohlberg Moral stages, Bloom Revised.',
    isFree: true,
    order: 1,
    estimatedMinutes: 40,
    bossName: 'Jean Piaget the Cognitive Master',
    bossAvatar: '🧠'
  },
  // JEE Main
  {
    id: 'chap_jee_mechanics',
    subjectId: 'sub_jee_physics',
    name: 'Newton’s Laws & Circular Dynamics',
    unitNumber: 1,
    description: 'Free body diagrams, frictional constraints, banking of roads, non-inertial pseudo forces.',
    isFree: true,
    order: 1,
    estimatedMinutes: 55,
    bossName: 'Sir Isaac Newton: Master of Principia',
    bossAvatar: '🍎'
  }
];

export const INITIAL_TOPICS: Topic[] = [
  // UGC NET P1 Topics
  { id: 'top_levels_teaching', chapterId: 'chap_ugc_teaching', name: 'Levels of Teaching (Memory, Understanding, Reflective)', order: 1, status: 'available', summaryNote: 'Memory level by Herbart, Understanding by Morrison, Reflective by Hunt.' },
  { id: 'top_eval_systems', chapterId: 'chap_ugc_teaching', name: 'Evaluation Systems & CBCS in Higher Education', order: 2, status: 'available' },
  { id: 'top_qual_quant', chapterId: 'chap_ugc_research', name: 'Qualitative vs Quantitative Research Paradigms', order: 1, status: 'available' },
  { id: 'top_research_ethics', chapterId: 'chap_ugc_research', name: 'Research Ethics, APA/MLA Referencing & Plagiarism', order: 2, status: 'locked' },
  { id: 'top_digital_edu', chapterId: 'chap_ugc_ict', name: 'SWAYAM, MOOCs & National Digital Library Initiatives', order: 1, status: 'locked' },
  
  // UGC NET Arabic Topics
  { id: 'top_origins_jahili', chapterId: 'chap_arabic_classical', name: 'Arab Origins & Pre-Islamic Literature (أصول العرب والأدب الجاهلي)', order: 1, status: 'available' },
  { id: 'top_muallaqat', chapterId: 'chap_arabic_classical', name: 'The Seven Mu’allaqat & As-habuha (المعلقات وأصحابها)', order: 2, status: 'available', summaryNote: 'Imru al-Qays (Qifa Nabki), Tarafa, Zuhayr, Labid, Antara, Amr ibn Kulthum, Harith ibn Hilliza.' },
  { id: 'top_suluk', chapterId: 'chap_arabic_classical', name: 'Su’luk Poets (الشعراء الصعاليك: الشنفرى وتأبط شرا)', order: 3, status: 'available' },
  { id: 'top_mukhadramun', chapterId: 'chap_arabic_classical', name: 'Islamic & Mukhadramun Poets (الشعراء المخضرمون والإسلاميون)', order: 4, status: 'available' },
  { id: 'top_naqaid_ghazal', chapterId: 'chap_arabic_umayyad', name: 'Naqa’id & Umayyad Ghazal (شعر النقائض والغزل الأموي)', order: 1, status: 'available' },
  { id: 'top_mutanabbi', chapterId: 'chap_arabic_abbasid', name: 'Al-Mutanabbi & Al-Ma’arri (المتنبي والمعري)', order: 1, status: 'available' },
  { id: 'top_abbasid_poets', chapterId: 'chap_arabic_abbasid', name: 'Abbasid Innovator Poets (بشار، أبو نواس، أبو تمام، البحتري، ابن الرومي)', order: 2, status: 'available' },
  { id: 'top_jahiz_prose', chapterId: 'chap_arabic_abbasid', name: 'Al-Jahiz & Abbasid Art of Prose (الجاحظ وكتاب البخلاء)', order: 3, status: 'available' },
  { id: 'top_nawasikh', chapterId: 'chap_arabic_nahw', name: 'Inna and Kana Nawasikh Rules (النواسخ: إن وأخواتها وكان وأخواتها)', order: 1, status: 'locked' },

  // UGC NET Malayalam Topics
  { id: 'top_manipravalam', chapterId: 'chap_mal_poetry', name: 'മണിപ്രവാള പ്രസ്ഥാനവും ലീലാതിലകവും', order: 1, status: 'available' },
  { id: 'top_ezhuthachan', chapterId: 'chap_mal_poetry', name: 'എഴുത്തച്ഛന്റെ ഭാഷാപരമായ സംഭാവനകൾ', order: 2, status: 'available' },
  { id: 'top_asan', chapterId: 'chap_mal_modern', name: 'കുമാരനാശാന്റെ വീണപൂവും ഖണ്ഡകാവ്യങ്ങളും', order: 1, status: 'available' },

  // UGC NET English Topics
  { id: 'top_poststructuralism', chapterId: 'chap_eng_theory', name: 'Derrida: Différance & Deconstruction', order: 1, status: 'locked' },
  { id: 'top_orientalism', chapterId: 'chap_eng_theory', name: 'Edward Said: Orientalism & Discourse', order: 2, status: 'locked' },

  // KTET
  { id: 'top_piaget_vygotsky', chapterId: 'chap_ktet_theories', name: 'Piaget vs Vygotsky Cognitive Comparison', order: 1, status: 'available' },

  // JEE Main
  { id: 'top_newton_fbd', chapterId: 'chap_jee_mechanics', name: 'Free Body Diagrams & Pulley Systems', order: 1, status: 'available' },
  { id: 'top_friction_banking', chapterId: 'chap_jee_mechanics', name: 'Frictional Forces & Curved Banking of Roads', order: 2, status: 'available' }
];

export const INITIAL_QUESTIONS: Question[] = [
  // --- UGC NET Paper 1 Questions ---
  {
    id: 'q_ugc_p1_01',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_p1',
    chapterId: 'chap_ugc_teaching',
    topicId: 'top_levels_teaching',
    type: 'mcq_single',
    difficulty: 'medium',
    questionText: 'Which level of teaching involves the highest cognitive interaction, where learners identify problems, analyze alternatives, and formulate original solutions?',
    options: [
      { id: 'opt_1', text: 'Memory Level of Teaching (MLT)', isCorrect: false },
      { id: 'opt_2', text: 'Understanding Level of Teaching (ULT)', isCorrect: false },
      { id: 'opt_3', text: 'Reflective Level of Teaching (RLT)', isCorrect: true },
      { id: 'opt_4', text: 'Autonomous Development Level', isCorrect: false }
    ],
    explanation: 'Reflective Level of Teaching (propounded by Hunt) is the highest, most thoughtful level. It focuses on problem-solving, critical analysis, and autonomous evaluation rather than rote retention.',
    hint: 'This level was propounded by Hunt and requires deep metacognition.',
    isPyq: true,
    pyqYear: 2023,
    pyqPaper: 'UGC NET Dec 2023 Shift 1',
    pyqQuestionNo: 4,
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-10T00:00:00.000Z'
  },
  {
    id: 'q_ugc_p1_02',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_p1',
    chapterId: 'chap_ugc_teaching',
    topicId: 'top_levels_teaching',
    type: 'match_pairs',
    difficulty: 'hard',
    questionText: 'Match the Level of Teaching in Column A with its chief proponent in Column B:',
    options: [],
    matchPairs: [
      { left: 'Memory Level (MLT)', right: 'Johann Friedrich Herbart' },
      { left: 'Understanding Level (ULT)', right: 'H. C. Morrison' },
      { left: 'Reflective Level (RLT)', right: 'Maurice P. Hunt' }
    ],
    explanation: 'Herbart developed the 5 steps for Memory level; Morrison formulated the Mastery model for Understanding level; Hunt designed the problem-centered Reflective level.',
    isPyq: true,
    pyqYear: 2022,
    pyqPaper: 'UGC NET June 2022',
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-11T00:00:00.000Z'
  },
  {
    id: 'q_ugc_p1_03',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_p1',
    chapterId: 'chap_ugc_research',
    topicId: 'top_qual_quant',
    type: 'assertion_reason',
    difficulty: 'medium',
    questionText: 'Analyze the following Assertion and Reason regarding Research Paradigms:',
    assertionText: 'Qualitative research relies predominantly on an inductive approach to theory generation.',
    reasonText: 'Positivist researchers assume reality is subjective, multiple, and socially constructed.',
    options: [
      { id: 'ar_1', text: 'Both Assertion and Reason are true, and Reason is the correct explanation of Assertion.', isCorrect: false },
      { id: 'ar_2', text: 'Both Assertion and Reason are true, but Reason is NOT the correct explanation.', isCorrect: false },
      { id: 'ar_3', text: 'Assertion is true, but Reason is FALSE.', isCorrect: true },
      { id: 'ar_4', text: 'Assertion is false, but Reason is true.', isCorrect: false }
    ],
    explanation: 'The Assertion is true: Qualitative research typically proceeds bottom-up (inductive). The Reason is FALSE: Positivism assumes an objective, singular, and measurable reality; it is Constructivism/Interpretivism that views reality as subjective.',
    isPyq: true,
    pyqYear: 2021,
    pyqPaper: 'UGC NET Nov 2021',
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-12T00:00:00.000Z'
  },
  {
    id: 'q_ugc_p1_04',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_p1',
    chapterId: 'chap_ugc_teaching',
    topicId: 'top_eval_systems',
    type: 'true_false',
    difficulty: 'easy',
    questionText: 'Formative evaluation is conducted primarily at the end of an academic term to certify or grade the overall achievement of learners.',
    options: [
      { id: 'tf_1', text: 'True', isCorrect: false },
      { id: 'tf_2', text: 'False', isCorrect: true }
    ],
    explanation: 'False. Summative evaluation happens at the end to certify or assign grades. Formative evaluation takes place *during* instruction to provide ongoing diagnostic feedback.',
    isPyq: false,
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-15T00:00:00.000Z'
  },
  {
    id: 'q_ugc_p1_05',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_p1',
    chapterId: 'chap_ugc_ict',
    topicId: 'top_digital_edu',
    type: 'fill_gap',
    difficulty: 'medium',
    questionText: 'The Government of India initiative SWAYAM stands for Study Webs of Active-Learning for _____ Minds.',
    correctAnswerText: 'Young Aspiring',
    options: [
      { id: 'fg_1', text: 'Young Aspiring', isCorrect: true },
      { id: 'fg_2', text: 'Youth Academic', isCorrect: false },
      { id: 'fg_3', text: 'Young Advanced', isCorrect: false }
    ],
    explanation: 'SWAYAM stands for Study Webs of Active-Learning for Young Aspiring Minds, launched by the Ministry of Education to provide free, high-quality online courses.',
    isPyq: true,
    pyqYear: 2023,
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-16T00:00:00.000Z'
  },

  // --- UGC NET Arabic Questions ---
  ...ARABIC_QUESTIONS,
  {
    id: 'q_ugc_ar_01',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_arabic',
    chapterId: 'chap_arabic_classical',
    topicId: 'top_muallaqat',
    type: 'mcq_single',
    difficulty: 'medium',
    questionText: 'Who is the author of the famous Mu’allaqah beginning with: "قِفَا نَبْكِ مِنْ ذِكْرَى حَبِيبٍ وَمَنْزِلِ / بِسِقْطِ اللِّوَى بَيْنَ الدَّخُولِ فَحَوْمَلِ" ?',
    questionTextArabic: 'من هو صاحب المعلقة الشهيرة التي مطلعها: "قِفَا نَبْكِ مِنْ ذِكْرَى حَبِيبٍ وَمَنْزِلِ بِسِقْطِ اللِّوَى بَيْنَ الدَّخُولِ فَحَوْمَلِ"؟',
    options: [
      { id: 'ar_opt1', text: 'Tarafah ibn al-Abd (طرفة بن العبد)', isCorrect: false },
      { id: 'ar_opt2', text: 'Imru’ al-Qays (امرؤ القيس بن حُجر الكندي)', isCorrect: true },
      { id: 'ar_opt3', text: 'Zuhayr ibn Abi Sulma (زهير بن أبي سلمى)', isCorrect: false },
      { id: 'ar_opt4', text: 'Antarah ibn Shaddad (عنترة بن شداد)', isCorrect: false }
    ],
    explanation: 'Imru’ al-Qays, known as the "Vagabond King" (الملك الضليل), opened his Mu’allaqah with the iconic weeping over the deserted encampment (الأطلال) at Siqt al-Liwa.',
    explanationArabic: 'صاحب المعلقة هو امرؤ القيس بن حجر الكندي، الملقب بالملك الضليل وذي القروح، وتعد معلقته في طليعة المعلقات السبع وتستهل بالوقوف على الأطلال.',
    isPyq: true,
    pyqYear: 2023,
    pyqPaper: 'UGC NET Arabic Dec 2023',
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-18T00:00:00.000Z'
  },
  {
    id: 'q_ugc_ar_02',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_arabic',
    chapterId: 'chap_arabic_classical',
    topicId: 'top_suluk',
    type: 'mcq_single',
    difficulty: 'hard',
    questionText: 'Which iconic pre-Islamic poet was famous as the leader of the Su’luk (Brigand) poets and composed the legendary poem "Lamiyyat al-Arab" (لامية العرب)?',
    questionTextArabic: 'من هو الشاعر الصعلوك صاحب القصيدة الذائعة الصيت "لامية العرب" التي مطلعها: "أقِيمُوا بَنِي أُمِّي صُدُورَ مَطِيِّكُمْ"؟',
    options: [
      { id: 's_opt1', text: 'Ta’abbata Sharran (تأبط شراً)', isCorrect: false },
      { id: 's_opt2', text: 'Al-Shanfara al-Azdi (الشنفرى الأزدي)', isCorrect: true },
      { id: 's_opt3', text: 'Urwah ibn al-Ward (عروة بن الورد)', isCorrect: false },
      { id: 's_opt4', text: 'Al-Samaw’al (السموأل)', isCorrect: false }
    ],
    explanation: 'Al-Shanfara al-Azdi is the celebrated author of Lamiyyat al-Arab, describing the fierce life, solitary speed, and resilience of the Su’luk in the desert.',
    isPyq: true,
    pyqYear: 2022,
    pyqPaper: 'UGC NET Arabic June 2022',
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-20T00:00:00.000Z'
  },
  {
    id: 'q_ugc_ar_03',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_arabic',
    chapterId: 'chap_arabic_abbasid',
    topicId: 'top_mutanabbi',
    type: 'match_pairs',
    difficulty: 'medium',
    questionText: 'Match each famous Arabic author with their magnum opus:',
    options: [],
    matchPairs: [
      { left: 'Al-Jahiz (الجاحظ)', right: 'Kitab al-Bukhala (كتاب البخلاء)' },
      { left: 'Ibn al-Muqaffa (ابن المقفع)', right: 'Kalilah wa Dimnah (كليلة ودمنة)' },
      { left: 'Abu al-Faraj al-Isfahani (أبو الفرج الأصفهاني)', right: 'Kitab al-Aghani (كتاب الأغاني)' }
    ],
    explanation: 'Al-Jahiz authored Al-Bukhala and Al-Bayan wa al-Tabyin; Ibn al-Muqaffa translated and polished Kalilah wa Dimnah into classical Arabic; Al-Isfahani compiled the 24 volumes of Kitab al-Aghani.',
    isPyq: true,
    pyqYear: 2021,
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-22T00:00:00.000Z'
  },
  {
    id: 'q_ugc_ar_04',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_arabic',
    chapterId: 'chap_arabic_nahw',
    topicId: 'top_nawasikh',
    type: 'mcq_single',
    difficulty: 'easy',
    questionText: 'What is the grammatical rule of "Inna and its sisters" (إن وأخواتها) when entering upon a nominal sentence (الجملة الاسمية)?',
    questionTextArabic: 'ما هو العمل الإعرابي لـ "إنّ وأخواتها" عند دخولها على المبتدأ والخبر؟',
    options: [
      { id: 'nw_1', text: 'تنصب المبتدأ ويسمى اسمها، وترفع الخبر ويسمى خبرها (Accusative ism, Nominative khabar)', isCorrect: true },
      { id: 'nw_2', text: 'ترفع المبتدأ وتنصب الخبر (Nominative ism, Accusative khabar)', isCorrect: false },
      { id: 'nw_3', text: 'تجزم الفعلين معاً', isCorrect: false },
      { id: 'nw_4', text: 'تجر الاسمين بحرف الجر المقدر', isCorrect: false }
    ],
    explanation: 'Inna and its sisters (الحروف الناسخة) render the mubtada in the accusative (Mansub) as their Ism, and keep/render the khabar in the nominative (Marfu).',
    isPyq: false,
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-25T00:00:00.000Z'
  },

  // --- UGC NET Malayalam Questions ---
  {
    id: 'q_ugc_mal_01',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_malayalam',
    chapterId: 'chap_mal_poetry',
    topicId: 'top_manipravalam',
    type: 'mcq_single',
    difficulty: 'medium',
    questionText: 'ലീലാതിലകം മണിപ്രവാളത്തെ നിർവചിച്ചിരിക്കുന്നത് ഏതുവിധമാണ്?',
    options: [
      { id: 'm_1', text: 'ഭാഷാ സംസ്കൃത യോഗോ മണിപ്രവാളം (Bhasha-Samskrita Yogo Manipravalam)', isCorrect: true },
      { id: 'm_2', text: 'ദ്രമിഡ സംഘാത രൂപം മണിപ്രവാളം', isCorrect: false },
      { id: 'm_3', text: 'അക്ഷര ശ്ലോക സമ്മിശ്രം മണിപ്രവാളം', isCorrect: false },
      { id: 'm_4', text: 'കേരള ഭാഷാ ഗാന വിശേഷം', isCorrect: false }
    ],
    explanation: 'പതിനാലാം നൂറ്റാണ്ടിലെ വ്യാകരണ ലക്ഷണ ഗ്രന്ഥമായ ലീലതിലകത്തിന്റെ പ്രഥമ ശില്പത്തിലെ ആദ്യ സൂത്രമാണിത്: "ഭാഷാസംസ്കൃതയോഗോ മണിപ്രവാളം" (ഭാഷയും സംസ്കൃതവും തമ്മിലുള്ള രത്ന-പവിഴ സംയോജനമാണ് മണിപ്രവാളം).',
    isPyq: true,
    pyqYear: 2023,
    pyqPaper: 'UGC NET Malayalam Dec 2023',
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-26T00:00:00.000Z'
  },
  {
    id: 'q_ugc_mal_02',
    examId: 'ugc_net',
    subjectId: 'sub_ugc_malayalam',
    chapterId: 'chap_mal_modern',
    topicId: 'top_asan',
    type: 'mcq_single',
    difficulty: 'medium',
    questionText: '"ഹാ പുഷ്പമേ, അധികതുംഗപദത്തിലെത്ര ശോഭിച്ചിരുന്നിതൊരു രാജ്ഞികണക്കയേ നീ" — ഈ വരികൾ ഏത് പ്രസിദ്ധ കാവ്യത്തിലേതാണ്?',
    options: [
      { id: 'ma_1', text: 'ചണ്ഡാലഭിക്ഷുകി (Chandalabhikshuki)', isCorrect: false },
      { id: 'ma_2', text: 'വീണപൂവ് (Veenapoovu - Kumaran Asan)', isCorrect: true },
      { id: 'ma_3', text: 'കരുണ (Karuna)', isCorrect: false },
      { id: 'ma_4', text: 'ദുരവസ്ഥ (Duravastha)', isCorrect: false }
    ],
    explanation: '1907-ൽ മിതവാദി പത്രത്തിൽ പ്രസിദ്ധീകരിക്കപ്പെട്ട മഹാകവി കുമാരനാശാന്റെ കാല്പനിക വസന്തത്തിന് തുടക്കം കുറിച്ച "വീണപൂവ്" എന്ന അനശ്വര ഖണ്ഡകാവ്യത്തിലെ വരികളാണിത്.',
    isPyq: true,
    pyqYear: 2022,
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-27T00:00:00.000Z'
  },

  // --- KTET Child Development & Pedagogy Questions ---
  {
    id: 'q_ktet_01',
    examId: 'ktet',
    subjectId: 'sub_ktet_pedagogy',
    chapterId: 'chap_ktet_theories',
    topicId: 'top_piaget_vygotsky',
    type: 'mcq_single',
    difficulty: 'medium',
    questionText: 'According to Lev Vygotsky, the difference between what a child can do independently and what they can achieve with the guidance of a More Knowledgeable Other (MKO) is called:',
    options: [
      { id: 'k_1', text: 'Cognitive Equilibrium', isCorrect: false },
      { id: 'k_2', text: 'Zone of Proximal Development (ZPD)', isCorrect: true },
      { id: 'k_3', text: 'Assimilation Matrix', isCorrect: false },
      { id: 'k_4', text: 'Sensorimotor Boundary', isCorrect: false }
    ],
    explanation: 'The Zone of Proximal Development (ZPD) is Vygotsky’s core concept designating the learning zone where scaffolding enables higher cognitive achievement.',
    isPyq: true,
    pyqYear: 2023,
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-28T00:00:00.000Z'
  },

  // --- JEE Main Physics Questions ---
  {
    id: 'q_jee_phy_01',
    examId: 'jee_main',
    subjectId: 'sub_jee_physics',
    chapterId: 'chap_jee_mechanics',
    topicId: 'top_newton_fbd',
    type: 'numerical',
    difficulty: 'hard',
    questionText: 'A block of mass 5 kg is kept on a smooth horizontal surface and pulled with a constant horizontal force of 20 N. If a constant frictional resistance force of 5 N opposes the motion, what is the acceleration of the block in m/s²?',
    correctAnswerText: '3',
    options: [
      { id: 'jee_1', text: '3 m/s²', isCorrect: true },
      { id: 'jee_2', text: '4 m/s²', isCorrect: false },
      { id: 'jee_3', text: '5 m/s²', isCorrect: false },
      { id: 'jee_4', text: '1 m/s²', isCorrect: false }
    ],
    explanation: 'Net force F_net = Applied Force - Frictional Force = 20 N - 5 N = 15 N. Acceleration a = F_net / m = 15 N / 5 kg = 3 m/s².',
    isPyq: true,
    pyqYear: 2023,
    pyqPaper: 'JEE Main 2023 Jan Session',
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-01-30T00:00:00.000Z'
  },
  {
    id: 'q_jee_error_01',
    examId: 'jee_main',
    subjectId: 'sub_jee_physics',
    chapterId: 'chap_jee_mechanics',
    topicId: 'top_friction_banking',
    type: 'mcq_single',
    difficulty: 'hard',
    questionText: 'Error Hunter Challenge: Identify which step in the student’s derivation of optimum banking velocity v = √(R g tan θ) contains the physical error:',
    flawedSolution: {
      steps: [
        { stepNo: 1, content: 'Resolved Normal Reaction N into components: N cos θ vertically upward and N sin θ horizontally toward center.', hasFlaw: false },
        { stepNo: 2, content: 'Equated vertical forces: N cos θ = m * g.', hasFlaw: false },
        { stepNo: 3, content: 'Set horizontal centripetal requirement: N sin θ = m * v² * R (multiplied by R instead of dividing).', hasFlaw: true },
        { stepNo: 4, content: 'Divided Step 3 by Step 2 to obtain tan θ expression.', hasFlaw: false }
      ],
      flawExplanation: 'Centripetal force formula is F_c = m * v² / R, not m * v² * R. Step 3 inverted the dimensional radius dependence.'
    },
    options: [
      { id: 'err_step1', text: 'Step 1: Normal reaction component breakdown', isCorrect: false },
      { id: 'err_step2', text: 'Step 2: Vertical equilibrium equation', isCorrect: false },
      { id: 'err_step3', text: 'Step 3: Horizontal centripetal acceleration relationship', isCorrect: true },
      { id: 'err_step4', text: 'Step 4: Division of trigonometric equations', isCorrect: false }
    ],
    explanation: 'In Step 3, centripetal force must be m*v²/R. Multiplying by R is dimensionally incorrect (kg·m³/s² instead of kg·m/s²).',
    isPyq: false,
    reviewStatus: 'approved',
    creatorId: 'system_admin',
    createdAt: '2024-02-01T00:00:00.000Z'
  }
];

export const INITIAL_BADGES: Badge[] = [
  {
    id: 'badge_first_step',
    title: 'First Step',
    description: 'Completed your very first study game in NetAce.',
    icon: 'Footprints',
    category: 'learning',
    rarity: 'common',
    unlockedAt: '2024-02-15T00:00:00.000Z',
    progressCurrent: 1,
    progressTarget: 1
  },
  {
    id: 'badge_on_fire',
    title: 'On Fire!',
    description: 'Maintained a 7-day consecutive daily study streak.',
    icon: 'Flame',
    category: 'streak',
    rarity: 'rare',
    unlockedAt: '2024-02-21T00:00:00.000Z',
    progressCurrent: 7,
    progressTarget: 7
  },
  {
    id: 'badge_sharpshooter',
    title: 'Sharpshooter',
    description: 'Achieved 90% or higher accuracy across 20+ questions.',
    icon: 'Target',
    category: 'accuracy',
    rarity: 'rare',
    progressCurrent: 14,
    progressTarget: 20
  },
  {
    id: 'badge_century',
    title: 'Century Master',
    description: 'Answered 100 questions on your examination path.',
    icon: 'Award',
    category: 'learning',
    rarity: 'epic',
    progressCurrent: 68,
    progressTarget: 100
  },
  {
    id: 'badge_gladiator',
    title: 'Arena Gladiator',
    description: 'Won 5 1v1 live quiz battles.',
    icon: 'Swords',
    category: 'battle',
    rarity: 'epic',
    progressCurrent: 3,
    progressTarget: 5
  },
  {
    id: 'badge_boss_slayer',
    title: 'Boss Vanquisher',
    description: 'Defeated a Chapter Boss with 0 mistakes remaining.',
    icon: 'Crown',
    category: 'mastery',
    rarity: 'legendary',
    progressCurrent: 1,
    progressTarget: 1,
    unlockedAt: '2024-02-18T00:00:00.000Z'
  }
];

export const INITIAL_DAILY_QUESTS: DailyQuestItem[] = [
  {
    id: 'quest_1',
    title: 'Target Practice',
    description: 'Answer 10 practice questions correctly.',
    rewardXp: 50,
    targetCount: 10,
    currentCount: 7,
    isClaimed: false,
    category: 'questions'
  },
  {
    id: 'quest_2',
    title: 'Mistake Eliminator',
    description: 'Revise 3 questions from your Mistake Notebook.',
    rewardXp: 40,
    targetCount: 3,
    currentCount: 3,
    isClaimed: true,
    category: 'revision'
  },
  {
    id: 'quest_3',
    title: 'Speedster Sprint',
    description: 'Play 1 session of Speed Rush or Survival Mode.',
    rewardXp: 60,
    targetCount: 1,
    currentCount: 1,
    isClaimed: false,
    category: 'game'
  }
];

export const INITIAL_LEADERBOARD: LeaderboardUser[] = [
  { rank: 1, userId: 'u_1', name: 'Dr. Fathima Zahra', avatar: '👩‍🏫', level: 24, levelTitle: 'Expert', score: 9450, streak: 28, badgeIcon: 'Crown', targetExam: 'UGC NET Arabic' },
  { rank: 2, userId: 'u_2', name: 'Arjun Nambiar', avatar: '👨‍🎓', level: 19, levelTitle: 'Scholar', score: 8120, streak: 19, badgeIcon: 'Medal', targetExam: 'UGC NET Malayalam' },
  { rank: 3, userId: 'u_3', name: 'Rohan Sharma', avatar: '⚡', level: 17, levelTitle: 'Scholar', score: 7650, streak: 14, badgeIcon: 'Award', targetExam: 'JEE Main' },
  { rank: 4, userId: 'current_user', name: 'Ameen Rayan (You)', avatar: '🚀', level: 8, levelTitle: 'Practitioner', score: 2850, streak: 7, isCurrentUser: true, badgeIcon: 'Flame', targetExam: 'UGC NET' },
  { rank: 5, userId: 'u_5', name: 'Ananya S.', avatar: '🎯', level: 7, levelTitle: 'Practitioner', score: 2420, streak: 9, targetExam: 'KTET' },
  { rank: 6, userId: 'u_6', name: 'Mohammed Bilal', avatar: '📚', level: 6, levelTitle: 'Practitioner', score: 1980, streak: 5, targetExam: 'UGC NET Arabic' },
  { rank: 7, userId: 'u_7', name: 'Kavitha P.', avatar: '⭐', level: 5, levelTitle: 'Practitioner', score: 1650, streak: 4, targetExam: 'UGC NET Malayalam' }
];

export const DEFAULT_USER_PROFILE: UserProfile = {
  id: 'current_user',
  name: 'Ameen Rayan',
  email: 'ameen@netace.edu',
  avatar: '🚀',
  role: 'free_student',
  targetExamId: 'ugc_net',
  preferredSubjectIds: ['sub_ugc_p1', 'sub_ugc_arabic', 'sub_ugc_malayalam'],
  xp: 2850,
  level: 8,
  levelTitle: 'Practitioner',
  streakDays: 7,
  lastActiveDate: new Date().toISOString().split('T')[0],
  streakFrozen: false,
  dailyGoal: 15,
  todayQuestionsAnswered: 8,
  coins: 420,
  isPremium: false,
  planId: 'free',
  createdAt: '2024-01-01T00:00:00.000Z'
};
