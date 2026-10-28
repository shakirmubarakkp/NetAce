import type {
  UserProfile,
  Question,
  QuestionAttempt,
  MistakeEntry,
  Bookmark,
  Badge,
  XpLedgerEntry,
  DailyQuestItem,
  LeaderboardUser,
  Subject,
  Chapter,
  Topic,
  SystemAuditLog,
  OcrJobItem
} from '../types';

import {
  DEFAULT_USER_PROFILE,
  INITIAL_QUESTIONS,
  INITIAL_BADGES,
  INITIAL_DAILY_QUESTS,
  INITIAL_LEADERBOARD,
  INITIAL_SUBJECTS,
  INITIAL_CHAPTERS,
  INITIAL_TOPICS
} from '../data/initialData';

const KEYS = {
  USER: 'netace_user_profile',
  QUESTIONS: 'netace_questions',
  ATTEMPTS: 'netace_attempts',
  MISTAKES: 'netace_mistakes',
  BOOKMARKS: 'netace_bookmarks',
  BADGES: 'netace_badges',
  XP_LEDGER: 'netace_xp_ledger',
  DAILY_QUESTS: 'netace_daily_quests',
  LEADERBOARD: 'netace_leaderboard',
  SUBJECTS: 'netace_subjects',
  CHAPTERS: 'netace_chapters',
  TOPICS: 'netace_topics',
  CLASSROOMS: 'netace_classrooms',
  ASSIGNMENTS: 'netace_assignments',
  AUDIT_LOGS: 'netace_audit_logs',
  OCR_JOBS: 'netace_ocr_jobs'
};

export class StorageService {
  // Helper for safe JSON parse
  private get<T>(key: string, defaultValue: T): T {
    try {
      const item = localStorage.getItem(key);
      return item ? JSON.parse(item) : defaultValue;
    } catch {
      return defaultValue;
    }
  }

  private set<T>(key: string, value: T): void {
    try {
      localStorage.setItem(key, JSON.stringify(value));
    } catch (e) {
      console.warn('Storage quota exceeded or unavailable', e);
    }
  }

  // --- USER PROFILE ---
  public getUser(): UserProfile {
    const user = this.get<UserProfile>(KEYS.USER, DEFAULT_USER_PROFILE);
    return user;
  }

  public saveUser(user: UserProfile): void {
    this.set(KEYS.USER, user);
  }

  // Level calculation
  public getLevelFromXp(xp: number): { level: number; title: string; nextLevelXp: number; prevLevelXp: number } {
    if (xp >= 100000) return { level: 50, title: 'Legend', nextLevelXp: 150000, prevLevelXp: 100000 };
    if (xp >= 20000) {
      const lvl = 30 + Math.floor((xp - 20000) / 4000);
      return { level: Math.min(lvl, 49), title: 'Master', nextLevelXp: 100000, prevLevelXp: 20000 };
    }
    if (xp >= 8000) {
      const lvl = 20 + Math.floor((xp - 8000) / 1200);
      return { level: lvl, title: 'Expert', nextLevelXp: 20000, prevLevelXp: 8000 };
    }
    if (xp >= 2000) {
      const lvl = 10 + Math.floor((xp - 2000) / 600);
      return { level: lvl, title: 'Scholar', nextLevelXp: 8000, prevLevelXp: 2000 };
    }
    if (xp >= 500) {
      const lvl = 5 + Math.floor((xp - 500) / 300);
      return { level: lvl, title: 'Practitioner', nextLevelXp: 2000, prevLevelXp: 500 };
    }
    const lvl = 1 + Math.floor(xp / 125);
    return { level: Math.max(1, lvl), title: 'Beginner', nextLevelXp: 500, prevLevelXp: 0 };
  }

  // Award XP with audit ledger
  public awardXp(amount: number, reason: string, sourceType: XpLedgerEntry['sourceType']): { leveledUp: boolean; newLevel: number; oldLevel: number } {
    const user = this.getUser();
    const oldLevel = user.level;
    user.xp += amount;
    user.coins += Math.max(1, Math.floor(amount / 5));

    const { level, title } = this.getLevelFromXp(user.xp);
    user.level = level;
    user.levelTitle = title;

    // Check streak updates
    this.touchStreak(user);

    this.saveUser(user);

    // Save ledger entry
    const ledger = this.getXpLedger();
    ledger.unshift({
      id: 'xp_' + Date.now() + '_' + Math.random().toString(36).substring(2, 6),
      userId: user.id,
      amount,
      reason,
      timestamp: new Date().toISOString(),
      sourceType
    });
    this.set(KEYS.XP_LEDGER, ledger.slice(0, 100));

    // Update daily quests
    this.updateDailyQuestProgress('questions', 1);

    const leveledUp = level > oldLevel;
    return { leveledUp, newLevel: level, oldLevel };
  }

  // Safe daily streak update
  private touchStreak(user: UserProfile): void {
    const today = new Date().toISOString().split('T')[0];
    if (user.lastActiveDate === today) {
      return; // already updated for today
    }

    const last = new Date(user.lastActiveDate);
    const curr = new Date(today);
    const diffDays = Math.round((curr.getTime() - last.getTime()) / (1000 * 3600 * 24));

    if (diffDays === 1) {
      // consecutive day!
      user.streakDays += 1;
    } else if (diffDays > 1 && !user.streakFrozen) {
      // streak reset
      user.streakDays = 1;
    }
    user.lastActiveDate = today;
  }

  // --- QUESTIONS ---
  public getQuestions(): Question[] {
    const stored = this.get<Question[]>(KEYS.QUESTIONS, []);
    if (!stored || stored.length === 0) {
      this.set(KEYS.QUESTIONS, INITIAL_QUESTIONS);
      return INITIAL_QUESTIONS;
    }
    const storedIds = new Set(stored.map(q => q.id));
    const missing = INITIAL_QUESTIONS.filter(q => !storedIds.has(q.id));
    if (missing.length > 0) {
      const merged = [...stored, ...missing];
      this.set(KEYS.QUESTIONS, merged);
      return merged;
    }
    return stored;
  }

  public saveQuestion(question: Question): void {
    const questions = this.getQuestions();
    const idx = questions.findIndex(q => q.id === question.id);
    if (idx >= 0) {
      questions[idx] = question;
    } else {
      questions.unshift(question);
    }
    this.set(KEYS.QUESTIONS, questions);
    this.addAuditLog('QUESTION_SAVE', `Saved question "${question.questionText.slice(0, 30)}..." (status: ${question.reviewStatus})`);
  }

  public deleteQuestion(id: string): void {
    const questions = this.getQuestions().filter(q => q.id !== id);
    this.set(KEYS.QUESTIONS, questions);
    this.addAuditLog('QUESTION_DELETE', `Deleted question with ID ${id}`);
  }

  // Filter questions for a game
  public getQuestionsForGame(examId?: string, subjectId?: string, chapterId?: string, count: number = 10): Question[] {
    let pool = this.getQuestions().filter(q => q.reviewStatus === 'approved');
    if (examId) pool = pool.filter(q => q.examId === examId);
    if (subjectId) pool = pool.filter(q => q.subjectId === subjectId);
    if (chapterId) pool = pool.filter(q => q.chapterId === chapterId);

    // If filtered set is too small, fallback to subject or exam pool
    if (pool.length < count) {
      pool = this.getQuestions().filter(q => q.reviewStatus === 'approved');
    }

    // Shuffle
    const shuffled = [...pool].sort(() => 0.5 - Math.random());
    return shuffled.slice(0, count);
  }

  // --- ATTEMPTS ---
  public recordAttempt(attempt: Omit<QuestionAttempt, 'id' | 'timestamp'>): QuestionAttempt {
    const attempts = this.getAttempts();
    const fullAttempt: QuestionAttempt = {
      ...attempt,
      id: 'att_' + Date.now() + '_' + Math.random().toString(36).substring(2, 6),
      timestamp: new Date().toISOString()
    };
    attempts.unshift(fullAttempt);
    this.set(KEYS.ATTEMPTS, attempts.slice(0, 500));

    // Update user daily questions
    const user = this.getUser();
    user.todayQuestionsAnswered += 1;
    this.saveUser(user);

    // If incorrect, add to mistake notebook
    if (!attempt.isCorrect) {
      this.recordMistake(attempt.userId, attempt.questionId);
    } else {
      // Check if this was a mistake revision that got solved
      this.markMistakeResolvedIfApplicable(attempt.userId, attempt.questionId);
    }

    return fullAttempt;
  }

  public getAttempts(): QuestionAttempt[] {
    return this.get<QuestionAttempt[]>(KEYS.ATTEMPTS, []);
  }

  // --- MISTAKE NOTEBOOK (Spaced Repetition) ---
  public getMistakes(): MistakeEntry[] {
    return this.get<MistakeEntry[]>(KEYS.MISTAKES, []);
  }

  private recordMistake(userId: string, questionId: string): void {
    const mistakes = this.getMistakes();
    const existing = mistakes.find(m => m.questionId === questionId && m.userId === userId);

    if (existing) {
      existing.attemptCount += 1;
      existing.isResolved = false;
      existing.lastAttemptAt = new Date().toISOString();
      existing.repetitionIntervalDays = 1; // reset to 1 day on mistake
    } else {
      mistakes.unshift({
        id: 'mst_' + Date.now(),
        userId,
        questionId,
        attemptCount: 1,
        isResolved: false,
        lastAttemptAt: new Date().toISOString(),
        nextReviewAt: new Date(Date.now() + 86400000).toISOString(),
        repetitionIntervalDays: 1,
        easeFactor: 2.5
      });
    }
    this.set(KEYS.MISTAKES, mistakes);
  }

  private markMistakeResolvedIfApplicable(userId: string, questionId: string): void {
    const mistakes = this.getMistakes();
    const existing = mistakes.find(m => m.questionId === questionId && m.userId === userId);
    if (existing) {
      existing.isResolved = true;
      existing.repetitionIntervalDays = Math.round(existing.repetitionIntervalDays * existing.easeFactor);
      existing.nextReviewAt = new Date(Date.now() + existing.repetitionIntervalDays * 86400000).toISOString();
      this.set(KEYS.MISTAKES, mistakes);
      this.updateDailyQuestProgress('revision', 1);
    }
  }

  // --- BOOKMARKS ---
  public getBookmarks(): Bookmark[] {
    return this.get<Bookmark[]>(KEYS.BOOKMARKS, []);
  }

  public toggleBookmark(questionId: string, note?: string): boolean {
    const user = this.getUser();
    let bookmarks = this.getBookmarks();
    const exists = bookmarks.some(b => b.questionId === questionId);

    if (exists) {
      bookmarks = bookmarks.filter(b => b.questionId !== questionId);
      this.set(KEYS.BOOKMARKS, bookmarks);
      return false;
    } else {
      bookmarks.unshift({
        id: 'bm_' + Date.now(),
        userId: user.id,
        questionId,
        note,
        createdAt: new Date().toISOString()
      });
      this.set(KEYS.BOOKMARKS, bookmarks);
      return true;
    }
  }

  // --- BADGES ---
  public getBadges(): Badge[] {
    return this.get<Badge[]>(KEYS.BADGES, INITIAL_BADGES);
  }

  // --- DAILY QUESTS ---
  public getDailyQuests(): DailyQuestItem[] {
    return this.get<DailyQuestItem[]>(KEYS.DAILY_QUESTS, INITIAL_DAILY_QUESTS);
  }

  public updateDailyQuestProgress(category: DailyQuestItem['category'], amount: number = 1): void {
    const quests = this.getDailyQuests();
    let changed = false;
    quests.forEach(q => {
      if (q.category === category && !q.isClaimed && q.currentCount < q.targetCount) {
        q.currentCount = Math.min(q.targetCount, q.currentCount + amount);
        changed = true;
      }
    });
    if (changed) {
      this.set(KEYS.DAILY_QUESTS, quests);
    }
  }

  public claimDailyQuest(questId: string): number {
    const quests = this.getDailyQuests();
    const quest = quests.find(q => q.id === questId);
    if (quest && !quest.isClaimed && quest.currentCount >= quest.targetCount) {
      quest.isClaimed = true;
      this.set(KEYS.DAILY_QUESTS, quests);
      this.awardXp(quest.rewardXp, `Completed Daily Quest: ${quest.title}`, 'quest');
      return quest.rewardXp;
    }
    return 0;
  }

  // --- XP LEDGER ---
  public getXpLedger(): XpLedgerEntry[] {
    return this.get<XpLedgerEntry[]>(KEYS.XP_LEDGER, [
      { id: 'xp_init_1', userId: 'current_user', amount: 50, reason: 'Welcome to NetAce starter bonus', timestamp: '2024-01-01T00:00:00.000Z', sourceType: 'quiz' },
      { id: 'xp_init_2', userId: 'current_user', amount: 200, reason: '7-Day Streak milestone reward', timestamp: '2024-02-14T00:00:00.000Z', sourceType: 'streak' }
    ]);
  }

  // --- LEADERBOARD ---
  public getLeaderboard(): LeaderboardUser[] {
    const board = this.get<LeaderboardUser[]>(KEYS.LEADERBOARD, INITIAL_LEADERBOARD);
    const user = this.getUser();
    // sync current user score
    const me = board.find(u => u.userId === 'current_user');
    if (me) {
      me.score = user.xp;
      me.level = user.level;
      me.levelTitle = user.levelTitle;
      me.streak = user.streakDays;
    }
    return board.sort((a, b) => b.score - a.score).map((item, idx) => ({ ...item, rank: idx + 1 }));
  }

  // --- SUBJECTS, CHAPTERS, TOPICS ---
  public getSubjects(): Subject[] {
    const stored = this.get<Subject[]>(KEYS.SUBJECTS, []);
    let subjects = stored;
    if (!stored || stored.length === 0) {
      subjects = INITIAL_SUBJECTS;
      this.set(KEYS.SUBJECTS, INITIAL_SUBJECTS);
    } else {
      const storedIds = new Set(stored.map(s => s.id));
      const missing = INITIAL_SUBJECTS.filter(s => !storedIds.has(s.id));
      subjects = subjects.map(s => {
        const init = INITIAL_SUBJECTS.find(i => i.id === s.id);
        return init ? { ...s, totalQuestions: init.totalQuestions, totalChapters: init.totalChapters } : s;
      });
      if (missing.length > 0) {
        subjects = [...subjects, ...missing];
      }
      this.set(KEYS.SUBJECTS, subjects);
    }
    return subjects;
  }

  public getChapters(subjectId?: string): Chapter[] {
    const stored = this.get<Chapter[]>(KEYS.CHAPTERS, []);
    let chapters = stored;
    if (!stored || stored.length === 0) {
      chapters = INITIAL_CHAPTERS;
      this.set(KEYS.CHAPTERS, INITIAL_CHAPTERS);
    } else {
      const storedIds = new Set(stored.map(c => c.id));
      const missing = INITIAL_CHAPTERS.filter(c => !storedIds.has(c.id));
      if (missing.length > 0) {
        chapters = [...chapters, ...missing];
        this.set(KEYS.CHAPTERS, chapters);
      }
    }
    if (subjectId) return chapters.filter(c => c.subjectId === subjectId);
    return chapters;
  }

  public getTopics(chapterId?: string): Topic[] {
    const stored = this.get<Topic[]>(KEYS.TOPICS, []);
    let topics = stored;
    if (!stored || stored.length === 0) {
      topics = INITIAL_TOPICS;
      this.set(KEYS.TOPICS, INITIAL_TOPICS);
    } else {
      const storedIds = new Set(stored.map(t => t.id));
      const missing = INITIAL_TOPICS.filter(t => !storedIds.has(t.id));
      if (missing.length > 0) {
        topics = [...topics, ...missing];
        this.set(KEYS.TOPICS, topics);
      }
    }
    if (chapterId) return topics.filter(t => t.chapterId === chapterId);
    return topics;
  }

  // --- AUDIT LOGS ---
  public getAuditLogs(): SystemAuditLog[] {
    return this.get<SystemAuditLog[]>(KEYS.AUDIT_LOGS, [
      { id: 'log_1', timestamp: new Date(Date.now() - 3600000).toISOString(), actorName: 'System Admin', actorRole: 'admin', action: 'SYSTEM_BOOT', details: 'NetAce database & game engine verified' }
    ]);
  }

  public addAuditLog(action: string, details: string): void {
    const logs = this.getAuditLogs();
    const user = this.getUser();
    logs.unshift({
      id: 'log_' + Date.now(),
      timestamp: new Date().toISOString(),
      actorName: user.name,
      actorRole: user.role,
      action,
      details
    });
    this.set(KEYS.AUDIT_LOGS, logs.slice(0, 100));
  }

  // --- OCR JOBS ---
  public getOcrJobs(): OcrJobItem[] {
    return this.get<OcrJobItem[]>(KEYS.OCR_JOBS, [
      {
        id: 'ocr_job_101',
        fileName: 'UGC_NET_Dec2023_Arabic_Paper2_Scanned.pdf',
        fileSize: '4.8 MB',
        status: 'ready_for_review',
        extractedQuestionsCount: 12,
        confidenceScore: 94.6,
        uploadedAt: '2024-02-18T10:30:00.000Z',
        assignedExamId: 'ugc_net',
        assignedSubjectId: 'sub_ugc_arabic'
      },
      {
        id: 'ocr_job_102',
        fileName: 'KTET_Pedagogy_2022_QP.pdf',
        fileSize: '2.4 MB',
        status: 'approved',
        extractedQuestionsCount: 15,
        confidenceScore: 98.2,
        uploadedAt: '2024-02-14T14:15:00.000Z',
        assignedExamId: 'ktet',
        assignedSubjectId: 'sub_ktet_pedagogy'
      }
    ]);
  }

  public addOcrJob(job: OcrJobItem): void {
    const jobs = this.getOcrJobs();
    jobs.unshift(job);
    this.set(KEYS.OCR_JOBS, jobs);
  }

  public updateOcrJobStatus(id: string, status: OcrJobItem['status']): void {
    const jobs = this.getOcrJobs();
    const job = jobs.find(j => j.id === id);
    if (job) {
      job.status = status;
      this.set(KEYS.OCR_JOBS, jobs);
    }
  }

  // Reset demo data
  public resetToDefault(): void {
    Object.values(KEYS).forEach(key => localStorage.removeItem(key));
    this.saveUser(DEFAULT_USER_PROFILE);
    this.set(KEYS.QUESTIONS, INITIAL_QUESTIONS);
    this.set(KEYS.BADGES, INITIAL_BADGES);
    this.set(KEYS.DAILY_QUESTS, INITIAL_DAILY_QUESTS);
    this.set(KEYS.LEADERBOARD, INITIAL_LEADERBOARD);
    this.set(KEYS.SUBJECTS, INITIAL_SUBJECTS);
    this.set(KEYS.CHAPTERS, INITIAL_CHAPTERS);
    this.set(KEYS.TOPICS, INITIAL_TOPICS);
  }
}

export const storage = new StorageService();
