export type UserRole = 'guest' | 'free_student' | 'premium_student' | 'moderator' | 'admin';

export type ExamHierarchyType = 
  | 'ugc_net'
  | 'ktet'
  | 'jee_main'
  | 'jee_advanced'
  | 'banking'
  | 'general_recruitment';

export type QuestionType = 
  | 'mcq_single' 
  | 'mcq_multiple' 
  | 'numerical' 
  | 'assertion_reason' 
  | 'match_pairs' 
  | 'true_false' 
  | 'fill_gap';

export type DifficultyLevel = 'easy' | 'medium' | 'hard';

export type ReviewStatus = 'approved' | 'pending_review' | 'rejected' | 'needs_edit';

export type TopicNodeStatus = 'locked' | 'available' | 'in_progress' | 'completed' | 'mastered' | 'needs_revision';

export interface UserProfile {
  id: string;
  name: string;
  email: string;
  avatar: string;
  role: UserRole;
  targetExamId: string;
  preferredSubjectIds: string[];
  xp: number;
  level: number;
  levelTitle: string;
  streakDays: number;
  lastActiveDate: string;
  streakFrozen: boolean;
  dailyGoal: number; // e.g. 15 questions
  todayQuestionsAnswered: number;
  coins: number;
  isPremium: boolean;
  premiumExpiresAt?: string;
  planId?: 'free' | 'monthly' | 'annual';
  onboardingComplete?: boolean;
  targetExamDate?: string;
  preferredStudyModes?: string[];
  createdAt: string;
}

export interface Examination {
  id: string;
  name: string;
  shortCode: string;
  description: string;
  category: string;
  icon: string;
  badgeColor: string;
  papersCount: number;
  isPopular?: boolean;
}

export interface ExamPaper {
  id: string;
  examId: string;
  name: string;
  code: string;
  description: string;
}

export interface Subject {
  id: string;
  paperId: string;
  examId: string;
  name: string;
  nameMalayalam?: string;
  nameArabic?: string;
  description: string;
  icon: string;
  color: string;
  isFreePreview: boolean;
  totalChapters: number;
  totalQuestions: number;
}

export interface Chapter {
  id: string;
  subjectId: string;
  name: string;
  unitNumber: number;
  description: string;
  isFree: boolean;
  order: number;
  estimatedMinutes: number;
  bossName?: string;
  bossAvatar?: string;
}

export interface Topic {
  id: string;
  chapterId: string;
  name: string;
  order: number;
  isCompleted?: boolean;
  accuracy?: number;
  status: TopicNodeStatus;
  keyFormulas?: string[];
  summaryNote?: string;
}

export interface QuestionOption {
  id: string;
  text: string;
  textMalayalam?: string;
  textArabic?: string;
  isCorrect: boolean;
}

export interface MatchPairItem {
  left: string;
  right: string;
}

export interface Question {
  id: string;
  examId: string;
  subjectId: string;
  chapterId: string;
  topicId: string;
  type: QuestionType;
  difficulty: DifficultyLevel;
  questionText: string;
  questionTextMalayalam?: string;
  questionTextArabic?: string;
  options: QuestionOption[];
  correctAnswerText?: string; // for numerical or fill_gap
  matchPairs?: MatchPairItem[]; // for match_pairs
  assertionText?: string;
  reasonText?: string;
  explanation: string;
  explanationMalayalam?: string;
  explanationArabic?: string;
  hint?: string;
  isPyq: boolean;
  pyqYear?: number;
  pyqPaper?: string;
  pyqQuestionNo?: number;
  reviewStatus: ReviewStatus;
  creatorId: string;
  createdAt: string;
  flawedSolution?: {
    steps: { stepNo: number; content: string; hasFlaw: boolean }[];
    flawExplanation: string;
  };
}

export interface QuestionAttempt {
  id: string;
  userId: string;
  questionId: string;
  gameMode: string;
  selectedOptionIds: string[];
  givenAnswerText?: string;
  isCorrect: boolean;
  timeSpentSeconds: number;
  timestamp: string;
  awardedXp: number;
}

export interface Bookmark {
  id: string;
  userId: string;
  questionId: string;
  note?: string;
  tags?: string[];
  createdAt: string;
}

export interface MistakeEntry {
  id: string;
  userId: string;
  questionId: string;
  attemptCount: number;
  lastAttemptAt: string;
  isResolved: boolean;
  nextReviewAt: string;
  repetitionIntervalDays: number;
  easeFactor: number;
}

export interface Badge {
  id: string;
  title: string;
  description: string;
  icon: string;
  category: 'learning' | 'streak' | 'accuracy' | 'battle' | 'mastery';
  rarity: 'common' | 'rare' | 'epic' | 'legendary';
  unlockedAt?: string;
  progressCurrent: number;
  progressTarget: number;
}

export interface XpLedgerEntry {
  id: string;
  userId: string;
  amount: number;
  reason: string;
  timestamp: string;
  sourceType: 'quiz' | 'streak' | 'quest' | 'battle' | 'achievement' | 'boss_defeat';
}

export interface DailyQuestItem {
  id: string;
  title: string;
  description: string;
  rewardXp: number;
  targetCount: number;
  currentCount: number;
  isClaimed: boolean;
  category: 'questions' | 'accuracy' | 'revision' | 'game';
}

export interface LeaderboardUser {
  rank: number;
  userId: string;
  name: string;
  avatar: string;
  level: number;
  levelTitle: string;
  score: number;
  streak: number;
  isCurrentUser?: boolean;
  badgeIcon?: string;
  targetExam?: string;
}

export interface BattlePlayer {
  id: string;
  name: string;
  avatar: string;
  score: number;
  streak: number;
  currentAnswer?: string;
  isReady: boolean;
  isBot?: boolean;
}

export interface Classroom {
  id: string;
  name: string;
  instituteName: string;
  teacherName: string;
  inviteCode: string;
  examId: string;
  studentCount: number;
  activeAssignmentsCount: number;
}

export interface ClassroomAssignment {
  id: string;
  classroomId: string;
  title: string;
  subjectName: string;
  chapterName: string;
  questionsCount: number;
  deadline: string;
  isCompletedByStudent: boolean;
  studentScore?: number;
}

export interface OcrJobItem {
  id: string;
  fileName: string;
  fileSize: string;
  status: 'processing' | 'ready_for_review' | 'approved' | 'failed';
  extractedQuestionsCount: number;
  confidenceScore: number;
  uploadedAt: string;
  assignedExamId: string;
  assignedSubjectId: string;
}

export interface SystemAuditLog {
  id: string;
  timestamp: string;
  actorName: string;
  actorRole: UserRole;
  action: string;
  details: string;
  ipAddress?: string;
}
