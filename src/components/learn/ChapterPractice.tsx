import React, { useEffect, useMemo, useRef, useState } from 'react';
import {
  ArrowLeft, ArrowRight, BookOpen, Check, CheckCircle2, Circle, Clock3, Flag,
  RotateCcw, Target, X, Zap
} from 'lucide-react';
import type { DifficultyLevel, Question } from '../../types';
import { INITIAL_EXAMINATIONS, INITIAL_PAPERS } from '../../data/initialData';
import { storage } from '../../services/storageService';
import { getChapterPracticeSessions, saveChapterPracticeSession, type SavedChapterPracticeSession } from '../../services/chapterPracticeService';
import { useAuth } from '../../context/AuthContext';

type PracticeMode = 'learn' | 'timed' | 'simulation' | 'revision';
type QuestionSource = 'all' | 'pyq' | 'saved' | 'incorrect' | 'unattempted';
type Screen = 'browse' | 'setup' | 'session' | 'results';

interface AnswerState {
  selectedOptionIds: string[];
  givenAnswerText: string;
  isCorrect: boolean | null;
  markedForReview: boolean;
}

const emptyAnswer = (): AnswerState => ({
  selectedOptionIds: [],
  givenAnswerText: '',
  isCorrect: null,
  markedForReview: false
});

const shuffle = <T,>(items: T[]): T[] => {
  const shuffled = [...items];
  for (let index = shuffled.length - 1; index > 0; index -= 1) {
    const target = Math.floor(Math.random() * (index + 1));
    [shuffled[index], shuffled[target]] = [shuffled[target], shuffled[index]];
  }
  return shuffled;
};

const formatTime = (seconds: number) => `${Math.floor(seconds / 60).toString().padStart(2, '0')}:${(seconds % 60).toString().padStart(2, '0')}`;

const modeNames: Record<PracticeMode, string> = {
  learn: 'Learn Mode',
  timed: 'Timed Practice',
  simulation: 'Exam Simulation',
  revision: 'Revision Mode'
};

const sourceNames: Record<QuestionSource, string> = {
  all: 'All approved questions',
  pyq: 'Questions tagged as previous-year',
  saved: 'Saved questions',
  incorrect: 'Incorrect questions',
  unattempted: 'Unattempted questions'
};

export const ChapterPractice: React.FC<{ onNavigate: (route: string) => void }> = ({ onNavigate }) => {
  const { user, isPremium } = useAuth();
  const [screen, setScreen] = useState<Screen>('browse');
  const [examId, setExamId] = useState(user.targetExamId);
  const [paperId, setPaperId] = useState('');
  const [subjectId, setSubjectId] = useState('');
  const [chapterId, setChapterId] = useState('');
  const [topicId, setTopicId] = useState('');
  const [source, setSource] = useState<QuestionSource>('all');
  const [difficulty, setDifficulty] = useState<DifficultyLevel | 'mixed'>('mixed');
  const [mode, setMode] = useState<PracticeMode>('learn');
  const [questionCount, setQuestionCount] = useState(5);
  const [timeLimitMinutes, setTimeLimitMinutes] = useState(10);
  const [questions, setQuestions] = useState<Question[]>([]);
  const [answers, setAnswers] = useState<Record<string, AnswerState>>({});
  const [activeIndex, setActiveIndex] = useState(0);
  const [remainingSeconds, setRemainingSeconds] = useState(0);
  const [elapsedSeconds, setElapsedSeconds] = useState(0);
  const [sessions, setSessions] = useState<SavedChapterPracticeSession[]>([]);
  const [loadingSessions, setLoadingSessions] = useState(true);
  const [saving, setSaving] = useState(false);
  const [pageError, setPageError] = useState('');
  const finished = useRef(false);

  const allQuestions = storage.getQuestions().filter(question => question.reviewStatus === 'approved');
  const allSubjects = storage.getSubjects();
  const allChapters = storage.getChapters();
  const allTopics = storage.getTopics();
  const exams = INITIAL_EXAMINATIONS;
  const papers = INITIAL_PAPERS.filter(paper => paper.examId === examId);
  const subjectsForExam = allSubjects.filter(subject => subject.examId === examId);
  const subjectsForPaper = subjectsForExam.filter(subject => !paperId || subject.paperId === paperId);
  const activeSubject = allSubjects.find(subject => subject.id === subjectId);
  const chaptersForSubject = allChapters.filter(chapter => chapter.subjectId === subjectId).sort((a, b) => a.order - b.order);
  const activeChapter = allChapters.find(chapter => chapter.id === chapterId);
  const topicsForChapter = allTopics.filter(topic => topic.chapterId === chapterId).sort((a, b) => a.order - b.order);
  const savedQuestionIds = new Set(storage.getBookmarks().filter(bookmark => bookmark.userId === user.id).map(bookmark => bookmark.questionId));
  const incorrectQuestionIds = new Set(storage.getMistakes().filter(mistake => mistake.userId === user.id && !mistake.isResolved).map(mistake => mistake.questionId));
  const attemptedQuestionIds = new Set(storage.getAttempts().filter(attempt => attempt.userId === user.id).map(attempt => attempt.questionId));

  const chapterQuestions = useMemo(() =>
    allQuestions.filter(question =>
      question.examId === examId &&
      question.subjectId === subjectId &&
      question.chapterId === chapterId
    ), [allQuestions, chapterId, examId, subjectId]);

  const eligibleQuestions = useMemo(() => chapterQuestions.filter(question => {
    if (topicId && question.topicId !== topicId) return false;
    if (difficulty !== 'mixed' && question.difficulty !== difficulty) return false;
    if (source === 'pyq' && !question.isPyq) return false;
    if (source === 'saved' && !savedQuestionIds.has(question.id)) return false;
    if (source === 'incorrect' && !incorrectQuestionIds.has(question.id)) return false;
    if (source === 'unattempted' && attemptedQuestionIds.has(question.id)) return false;
    return true;
  }), [attemptedQuestionIds, chapterQuestions, difficulty, incorrectQuestionIds, savedQuestionIds, source, topicId]);

  useEffect(() => {
    if (eligibleQuestions.length > 0 && questionCount > eligibleQuestions.length) {
      setQuestionCount(eligibleQuestions.length);
    }
  }, [eligibleQuestions.length, questionCount]);

  useEffect(() => {
    let active = true;
    setLoadingSessions(true);
    setPageError('');
    void getChapterPracticeSessions(user.id)
      .then(saved => { if (active) setSessions(saved); })
      .catch(error => {
        if (active) setPageError(error instanceof Error ? error.message : 'Unable to load saved chapter progress.');
      })
      .finally(() => { if (active) setLoadingSessions(false); });
    return () => { active = false; };
  }, [user.id]);

  useEffect(() => {
    if (screen !== 'session') return;
    const timer = window.setInterval(() => {
      setElapsedSeconds(value => value + 1);
      if (mode === 'timed' || mode === 'simulation') setRemainingSeconds(value => Math.max(0, value - 1));
    }, 1000);
    return () => window.clearInterval(timer);
  }, [mode, screen]);

  useEffect(() => {
    if (screen === 'session' && (mode === 'timed' || mode === 'simulation') && remainingSeconds === 0) {
      void finishSession();
    }
  }, [remainingSeconds, screen, mode]);

  const currentQuestion = questions[activeIndex];
  const currentAnswer = currentQuestion ? answers[currentQuestion.id] || emptyAnswer() : emptyAnswer();
  const chapterHistory = sessions.filter(session => session.chapter_id === chapterId);
  const latestSession = chapterHistory[0];
  const questionPoolCount = chapterQuestions.length;
  const diffCounts = {
    easy: chapterQuestions.filter(question => question.difficulty === 'easy').length,
    medium: chapterQuestions.filter(question => question.difficulty === 'medium').length,
    hard: chapterQuestions.filter(question => question.difficulty === 'hard').length
  };
  const mastered = Boolean(latestSession && latestSession.total_questions > 0 &&
    latestSession.answered_count === latestSession.total_questions &&
    latestSession.accuracy_percentage >= 85 &&
    chapterHistory.some(session => session.total_questions >= questionPoolCount));
  const needsRevision = Boolean(latestSession && latestSession.accuracy_percentage < 60);
  const completionStatus = mastered ? 'Mastered' : needsRevision ? 'Needs Revision' : latestSession ? 'In Progress' : 'Not Started';

  const setAnswer = (questionId: string, next: Partial<AnswerState>) => {
    setAnswers(current => ({
      ...current,
      [questionId]: { ...(current[questionId] || emptyAnswer()), ...next }
    }));
  };

  const startSession = () => {
    setPageError('');
    if (!activeChapter || !activeSubject) {
      setPageError('Select a subject and chapter before starting a session.');
      return;
    }
    if (!activeChapter.isFree && !isPremium) {
      setPageError('This chapter requires a premium subscription.');
      return;
    }
    if (eligibleQuestions.length === 0) {
      setPageError('There are no approved questions matching these filters. Change your source, topic, or difficulty.');
      return;
    }
    const selected = shuffle(eligibleQuestions).slice(0, questionCount);
    setQuestions(selected);
    setAnswers({});
    setActiveIndex(0);
    setElapsedSeconds(0);
    setRemainingSeconds(timeLimitMinutes * 60);
    finished.current = false;
    setScreen('session');
  };

  async function finishSession() {
    if (finished.current || questions.length === 0 || !activeSubject || !activeChapter) return;
    finished.current = true;
    setSaving(true);
    setPageError('');

    const results = questions.map(question => {
      const answer = answers[question.id] || emptyAnswer();
      return {
        question_id: question.id,
        selected_option_ids: answer.selectedOptionIds,
        given_answer_text: answer.givenAnswerText,
        is_correct: answer.isCorrect,
        marked_for_review: answer.markedForReview
      };
    });
    const answeredCount = results.filter(result => result.is_correct !== null).length;
    const finalCorrect = results.filter(result => result.is_correct === true).length;
    const sessionId = crypto.randomUUID();

    try {
      const session: Omit<SavedChapterPracticeSession, 'created_at'> = {
        id: sessionId,
        user_id: user.id,
        exam_id: examId,
        paper_id: activeSubject.paperId || paperId || null,
        subject_id: subjectId,
        chapter_id: chapterId,
        mode,
        source,
        total_questions: questions.length,
        answered_count: answeredCount,
        correct_count: finalCorrect,
        accuracy_percentage: answeredCount ? Math.round((finalCorrect / answeredCount) * 100) : 0,
        time_spent_seconds: elapsedSeconds,
        question_results: results
      };

      await saveChapterPracticeSession(session);
      for (const result of results) {
        if (result.is_correct === null) continue;
        storage.recordAttempt({
          userId: user.id,
          questionId: result.question_id,
          gameMode: `chapter_${mode}`,
          selectedOptionIds: result.selected_option_ids,
          givenAnswerText: result.given_answer_text || undefined,
          isCorrect: result.is_correct,
          timeSpentSeconds: Math.floor(elapsedSeconds / Math.max(1, questions.length)),
          awardedXp: 0
        });
      }
      setSessions(current => [{
        ...session,
        created_at: new Date().toISOString()
      }, ...current]);
      setScreen('results');
    } catch (error) {
      finished.current = false;
      setPageError(error instanceof Error ? error.message : 'Unable to save this practice session.');
    } finally {
      setSaving(false);
    }
  }

  const submitAnswer = () => {
    if (!currentQuestion) return;
    const correctIds = currentQuestion.options.filter(option => option.isCorrect).map(option => option.id).sort();
    const selectedIds = [...currentAnswer.selectedOptionIds].sort();
    const correct =
      currentQuestion.correctAnswerText !== undefined && currentQuestion.correctAnswerText !== ''
        ? currentAnswer.givenAnswerText.trim().toLocaleLowerCase() === currentQuestion.correctAnswerText.trim().toLocaleLowerCase()
        : JSON.stringify(correctIds) === JSON.stringify(selectedIds);
    setAnswer(currentQuestion.id, { isCorrect: correct });
    if (mode === 'learn' || mode === 'revision') return;
  };

  const advance = () => {
    if (activeIndex === questions.length - 1) {
      void finishSession();
    } else {
      setActiveIndex(index => index + 1);
    }
  };

  const toggleOption = (optionId: string) => {
    const selected = currentAnswer.selectedOptionIds;
    if (currentQuestion?.type === 'mcq_multiple') {
      setAnswer(currentQuestion.id, {
        selectedOptionIds: selected.includes(optionId) ? selected.filter(id => id !== optionId) : [...selected, optionId]
      });
    } else {
      setAnswer(currentQuestion!.id, { selectedOptionIds: [optionId] });
    }
  };

  const toggleMarkForReview = () => {
    if (!currentQuestion) return;
    setAnswer(currentQuestion.id, { markedForReview: !currentAnswer.markedForReview });
  };

  const beginRevision = () => {
    setSource('incorrect');
    setMode('revision');
    setScreen('setup');
  };

  const renderBrowse = () => (
    <div className="space-y-6">
      <header className="rounded-3xl border border-indigo-500/25 bg-gradient-to-br from-indigo-950/80 to-slate-900 p-5 sm:p-7">
        <p className="mb-2 flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-indigo-300"><BookOpen className="h-4 w-4" /> Practice by curriculum</p>
        <h1 className="text-2xl font-black text-white sm:text-3xl">Chapter-wise Practice</h1>
        <p className="mt-2 max-w-2xl text-sm leading-6 text-slate-400">Choose an examination, paper or subject, and chapter. Start with approved questions and track your saved attempts.</p>
      </header>

      <div className="grid gap-3 sm:grid-cols-3">
        <SelectField label="Examination" value={examId} onChange={value => {
          setExamId(value);
          setPaperId('');
          setSubjectId('');
          setChapterId('');
        }}>
          {exams.map(exam => <option key={exam.id} value={exam.id}>{exam.name}</option>)}
        </SelectField>
        {papers.length > 0 && (
          <SelectField label="Paper" value={paperId} onChange={value => {
            setPaperId(value);
            setSubjectId('');
            setChapterId('');
          }}>
            <option value="">All papers</option>
            {papers.map(paper => <option key={paper.id} value={paper.id}>{paper.name}</option>)}
          </SelectField>
        )}
        {subjectsForPaper.length > 0 && (
          <SelectField label="Subject" value={subjectId} onChange={value => {
            setSubjectId(value);
            setChapterId('');
          }}>
            <option value="">Select a subject</option>
            {subjectsForPaper.map(subject => <option key={subject.id} value={subject.id}>{subject.name}</option>)}
          </SelectField>
        )}
      </div>

      {activeSubject && (
        <div>
          <div className="mb-3 flex items-end justify-between gap-3">
            <div>
              <p className="text-xs font-semibold text-slate-500">{activeSubject.paperId ? INITIAL_PAPERS.find(paper => paper.id === activeSubject.paperId)?.name : 'Subject'}</p>
              <h2 className="text-lg font-extrabold text-white">{activeSubject.name}</h2>
            </div>
            {chapterId && <button className="text-xs font-bold text-indigo-300 hover:text-white" onClick={() => setChapterId('')}>Clear chapter selection</button>}
          </div>
          {chaptersForSubject.length === 0 ? (
            <EmptyState text="No chapters are configured for this subject yet." />
          ) : (
            <div className="space-y-3">
              {chaptersForSubject.map(chapter => {
                const count = allQuestions.filter(question => question.chapterId === chapter.id && question.reviewStatus === 'approved').length;
                const saved = sessions.find(session => session.chapter_id === chapter.id);
                const chapterIsMastered = Boolean(saved && saved.accuracy_percentage >= 85 && saved.total_questions >= count);
                const chapterNeedsRevision = Boolean(saved && saved.accuracy_percentage < 60);
                const isLocked = !chapter.isFree && !isPremium;
                const status = isLocked ? 'Locked' : chapterIsMastered ? 'Mastered' : chapterNeedsRevision ? 'Needs Revision' : saved ? 'In Progress' : 'Not Started';
                return (
                  <article key={chapter.id} className={`rounded-2xl border p-4 transition ${chapterId === chapter.id ? 'border-indigo-500/70 bg-indigo-950/20' : 'border-slate-800 bg-slate-900'}`}>
                    <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                      <button className="min-w-0 text-left" onClick={() => {
                        setChapterId(chapter.id);
                        setTopicId('');
                        setScreen('setup');
                      }}>
                        <div className="mb-1 flex flex-wrap items-center gap-2">
                          <span className="rounded-md bg-slate-800 px-2 py-1 text-[10px] font-bold text-slate-300">Chapter {chapter.unitNumber}</span>
                          <span className={`rounded-md px-2 py-1 text-[10px] font-bold ${
                            status === 'Mastered' ? 'bg-emerald-500/15 text-emerald-300' :
                              status === 'Needs Revision' ? 'bg-rose-500/15 text-rose-300' :
                                status === 'Locked' ? 'bg-slate-800 text-slate-500' :
                                  saved ? 'bg-amber-500/15 text-amber-300' : 'bg-slate-800 text-slate-400'
                          }`}>{status}</span>
                        </div>
                        <h3 className="truncate font-bold text-white">{chapter.name}</h3>
                        <p className="mt-1 text-xs leading-5 text-slate-400">{chapter.description}</p>
                      </button>
                      <div className="flex shrink-0 items-center gap-4 sm:flex-col sm:items-end sm:gap-2">
                        <div className="text-right text-[11px] text-slate-400">
                          <p><span className="font-bold text-white">{count}</span> approved questions</p>
                          {saved && <p>Latest: {saved.accuracy_percentage}% · {saved.answered_count}/{saved.total_questions}</p>}
                        </div>
                        <button onClick={() => {
                          setChapterId(chapter.id);
                          setTopicId('');
                          setScreen('setup');
                        }} disabled={!count || isLocked} className="rounded-xl bg-indigo-600 px-4 py-2 text-xs font-bold text-white hover:bg-indigo-500 disabled:cursor-not-allowed disabled:bg-slate-800 disabled:text-slate-500">
                          {isLocked ? 'Premium chapter' : saved ? 'Practice Again' : 'Start Practice'}
                        </button>
                      </div>
                    </div>
                  </article>
                );
              })}
            </div>
          )}
        </div>
      )}
      {!activeSubject && <EmptyState text="Select a subject to browse its independent chapter list." />}
    </div>
  );

  const renderSetup = () => (
    <div className="mx-auto max-w-3xl space-y-5">
      <button onClick={() => setScreen('browse')} className="inline-flex items-center gap-2 text-xs font-semibold text-slate-400 hover:text-white"><ArrowLeft className="h-4 w-4" /> Back to chapters</button>
      <header>
        <p className="text-xs font-semibold text-indigo-300">{activeSubject?.name}</p>
        <h1 className="mt-1 text-2xl font-black text-white">{activeChapter?.name || 'Practice setup'}</h1>
        <p className="mt-2 text-sm text-slate-400">{activeChapter?.description}</p>
      </header>
      <div className="grid gap-3 sm:grid-cols-2">
        <SelectField label="Question source" value={source} onChange={value => setSource(value as QuestionSource)}>
          {Object.entries(sourceNames).map(([key, label]) => <option key={key} value={key}>{label}</option>)}
        </SelectField>
        <SelectField label="Topic (optional)" value={topicId} onChange={setTopicId}>
          <option value="">All topics in chapter</option>
          {topicsForChapter.map(topic => <option key={topic.id} value={topic.id}>{topic.name}</option>)}
        </SelectField>
        <SelectField label="Difficulty" value={difficulty} onChange={value => setDifficulty(value as DifficultyLevel | 'mixed')}>
          <option value="mixed">Mixed difficulty</option>
          <option value="easy">Easy</option>
          <option value="medium">Medium</option>
          <option value="hard">Hard</option>
        </SelectField>
        <SelectField label="Practice mode" value={mode} onChange={value => setMode(value as PracticeMode)}>
          {Object.entries(modeNames).map(([key, label]) => <option key={key} value={key}>{label}</option>)}
        </SelectField>
      </div>
      <div className="grid gap-3 sm:grid-cols-2">
        <SelectField label={`Question count (${eligibleQuestions.length} available)`} value={questionCount === eligibleQuestions.length ? 'all' : String(questionCount)} onChange={value => setQuestionCount(value === 'all' ? Math.max(1, eligibleQuestions.length) : Number(value))}>
          {[5, 10, 20, 30].filter(count => count <= eligibleQuestions.length).map(count => <option key={count} value={count}>{count} questions</option>)}
          {eligibleQuestions.length > 0 && <option value="all">All available ({eligibleQuestions.length})</option>}
        </SelectField>
        {(mode === 'timed' || mode === 'simulation') && (
          <SelectField label="Time limit" value={timeLimitMinutes} onChange={value => setTimeLimitMinutes(Number(value))}>
            {[5, 10, 20, 30, 60].map(minutes => <option key={minutes} value={minutes}>{minutes} minutes</option>)}
          </SelectField>
        )}
      </div>
      {mode === 'simulation' && <p className="rounded-xl border border-amber-500/20 bg-amber-500/5 p-3 text-xs leading-5 text-amber-200">Answers and explanations stay hidden until submission. No negative-marking value is configured for this exam, so no negative marks will be applied.</p>}
      <div className="rounded-xl border border-slate-800 bg-slate-900 p-4">
        <p className="text-sm font-bold text-white">{eligibleQuestions.length} eligible questions</p>
        <p className="mt-1 text-xs text-slate-400">Easy {diffCounts.easy} · Medium {diffCounts.medium} · Hard {diffCounts.hard}. Questions will not be duplicated to meet the requested count.</p>
      </div>
      {pageError && <p role="alert" className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-3 text-xs text-rose-200">{pageError}</p>}
      <button onClick={startSession} disabled={eligibleQuestions.length === 0} className="flex w-full items-center justify-center gap-2 rounded-xl bg-indigo-600 py-3 text-sm font-bold text-white hover:bg-indigo-500 disabled:cursor-not-allowed disabled:bg-slate-800 disabled:text-slate-500">
        <Zap className="h-4 w-4" /> Start {modeNames[mode]}
      </button>
    </div>
  );

  const renderSession = () => currentQuestion ? (
    <div className="mx-auto max-w-3xl space-y-5">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <button onClick={() => {
          if (window.confirm('Exit this session? Your current answers will not be saved.')) {
            finished.current = true;
            setScreen('setup');
          }
        }} className="inline-flex items-center gap-2 text-xs font-semibold text-slate-400 hover:text-white"><X className="h-4 w-4" /> Exit session</button>
        <div className="flex items-center gap-3 text-xs font-bold text-slate-300">
          <span>{activeIndex + 1} / {questions.length}</span>
          <span className="inline-flex items-center gap-1"><Clock3 className="h-4 w-4 text-amber-300" />{formatTime(mode === 'learn' || mode === 'revision' ? elapsedSeconds : remainingSeconds)}</span>
        </div>
      </div>
      <div className="h-2 overflow-hidden rounded-full bg-slate-800"><div className="h-full rounded-full bg-indigo-500 transition-all" style={{ width: `${((activeIndex + 1) / questions.length) * 100}%` }} /></div>

      {mode === 'simulation' && (
        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-4">
          <div className="mb-3 flex items-center justify-between">
            <p className="text-xs font-bold text-slate-300">Question palette</p>
            <button onClick={toggleMarkForReview} className={`inline-flex items-center gap-1 rounded-lg px-2 py-1 text-[10px] font-bold ${currentAnswer.markedForReview ? 'bg-amber-500/20 text-amber-200' : 'bg-slate-800 text-slate-400'}`}><Flag className="h-3 w-3" />{currentAnswer.markedForReview ? 'Marked' : 'Mark for review'}</button>
          </div>
          <div className="flex flex-wrap gap-2">
            {questions.map((question, index) => {
              const answer = answers[question.id];
              return <button key={question.id} onClick={() => setActiveIndex(index)} className={`h-8 w-8 rounded-lg text-[11px] font-bold ${
                index === activeIndex ? 'bg-indigo-500 text-white' :
                  answer?.markedForReview ? 'bg-amber-500/20 text-amber-200' :
                    answer?.selectedOptionIds.length || answer?.givenAnswerText ? 'bg-emerald-500/20 text-emerald-200' : 'bg-slate-800 text-slate-400'
              }`}>{index + 1}</button>;
            })}
          </div>
        </div>
      )}

      <article className="rounded-3xl border border-slate-800 bg-slate-900 p-5 sm:p-7">
        <div className="mb-4 flex flex-wrap items-center gap-2 text-[10px] font-bold uppercase tracking-wider text-slate-400">
          <span className="rounded-md bg-slate-800 px-2 py-1">{currentQuestion.difficulty}</span>
          <span className="rounded-md bg-slate-800 px-2 py-1">{currentQuestion.type.replace('_', ' ')}</span>
          {currentQuestion.isPyq && <span className="rounded-md bg-emerald-500/10 px-2 py-1 text-emerald-300">PYQ-tagged · source not independently verified</span>}
        </div>
        <h2 className="text-base font-bold leading-7 text-white sm:text-lg">{currentQuestion.questionText}</h2>
        {currentQuestion.isPyq && (currentQuestion.pyqPaper || currentQuestion.pyqYear || currentQuestion.pyqQuestionNo) && (
          <p className="mt-2 text-[11px] text-slate-500">
            Source metadata: {[currentQuestion.pyqPaper, currentQuestion.pyqYear, currentQuestion.pyqQuestionNo ? `Question ${currentQuestion.pyqQuestionNo}` : undefined].filter(Boolean).join(' · ')} · pending independent verification
          </p>
        )}
        {currentQuestion.assertionText && <p className="mt-3 text-sm leading-6 text-slate-300">{currentQuestion.assertionText}</p>}
        {currentQuestion.reasonText && <p className="mt-2 text-sm leading-6 text-slate-300">{currentQuestion.reasonText}</p>}
        {currentQuestion.correctAnswerText !== undefined && currentQuestion.options.length === 0 ? (
          <input value={currentAnswer.givenAnswerText} disabled={currentAnswer.isCorrect !== null} onChange={event => setAnswer(currentQuestion.id, { givenAnswerText: event.target.value })} className="mt-5 w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none focus:border-indigo-500" placeholder="Enter your answer" />
        ) : (
          <div className="mt-5 space-y-2">
            {currentQuestion.options.map(option => {
              const selected = currentAnswer.selectedOptionIds.includes(option.id);
              const reveal = (mode === 'learn' || mode === 'revision') && currentAnswer.isCorrect !== null;
              return (
                <button key={option.id} disabled={reveal} onClick={() => toggleOption(option.id)} className={`flex w-full items-center gap-3 rounded-xl border p-3 text-left text-sm transition ${
                  reveal && option.isCorrect ? 'border-emerald-500/50 bg-emerald-500/10 text-emerald-100' :
                    reveal && selected ? 'border-rose-500/50 bg-rose-500/10 text-rose-100' :
                      selected ? 'border-indigo-500/60 bg-indigo-500/10 text-white' : 'border-slate-800 bg-slate-950 text-slate-300 hover:border-slate-600'
                }`}>
                  {selected ? <CheckCircle2 className="h-4 w-4 shrink-0 text-indigo-300" /> : <Circle className="h-4 w-4 shrink-0 text-slate-600" />}
                  <span>{option.text}</span>
                </button>
              );
            })}
          </div>
        )}
        {(mode === 'learn' || mode === 'revision') && currentAnswer.isCorrect !== null && (
          <div className={`mt-4 rounded-xl border p-4 ${currentAnswer.isCorrect ? 'border-emerald-500/30 bg-emerald-500/5' : 'border-rose-500/30 bg-rose-500/5'}`}>
            <p className={`mb-1 flex items-center gap-2 text-sm font-bold ${currentAnswer.isCorrect ? 'text-emerald-300' : 'text-rose-300'}`}>
              {currentAnswer.isCorrect ? <Check className="h-4 w-4" /> : <X className="h-4 w-4" />}
              {currentAnswer.isCorrect ? 'Correct' : 'Not quite'}
            </p>
            <p className="text-xs leading-5 text-slate-300">{currentQuestion.explanation || 'No explanation has been added for this question.'}</p>
          </div>
        )}
      </article>

      <div className="flex flex-wrap items-center justify-between gap-3">
        {mode !== 'learn' && mode !== 'revision' && (
          <button onClick={toggleMarkForReview} className={`inline-flex items-center gap-2 rounded-xl px-3 py-2 text-xs font-bold ${currentAnswer.markedForReview ? 'bg-amber-500/20 text-amber-200' : 'bg-slate-800 text-slate-300'}`}><Flag className="h-4 w-4" />{currentAnswer.markedForReview ? 'Marked for review' : 'Mark for review'}</button>
        )}
        {mode === 'simulation' ? (
          <div className="ml-auto flex gap-2">
            <button onClick={() => setActiveIndex(index => Math.max(0, index - 1))} disabled={activeIndex === 0} className="rounded-xl bg-slate-800 px-4 py-2 text-xs font-bold text-white disabled:opacity-40">Previous</button>
            <button onClick={() => activeIndex < questions.length - 1 ? setActiveIndex(index => index + 1) : window.confirm('Submit this exam simulation?') && void finishSession()} className="rounded-xl bg-indigo-600 px-4 py-2 text-xs font-bold text-white">{activeIndex < questions.length - 1 ? 'Next' : 'Submit exam'}</button>
          </div>
        ) : (mode === 'learn' || mode === 'revision') && currentAnswer.isCorrect === null ? (
          <button onClick={submitAnswer} disabled={!currentAnswer.selectedOptionIds.length && !currentAnswer.givenAnswerText.trim()} className="ml-auto rounded-xl bg-indigo-600 px-5 py-2.5 text-xs font-bold text-white disabled:cursor-not-allowed disabled:opacity-50">Check answer</button>
        ) : (mode === 'learn' || mode === 'revision') ? (
          <button onClick={advance} disabled={saving} className="ml-auto inline-flex items-center gap-2 rounded-xl bg-indigo-600 px-5 py-2.5 text-xs font-bold text-white disabled:opacity-50">
            {activeIndex === questions.length - 1 ? 'Finish session' : 'Next question'} <ArrowRight className="h-4 w-4" />
          </button>
        ) : mode === 'timed' ? (
          <div className="ml-auto flex gap-2">
            <button onClick={() => setActiveIndex(index => Math.max(0, index - 1))} disabled={activeIndex === 0} className="rounded-xl bg-slate-800 px-4 py-2 text-xs font-bold text-white disabled:opacity-40">Previous</button>
            {currentAnswer.isCorrect === null && <button onClick={submitAnswer} disabled={!currentAnswer.selectedOptionIds.length && !currentAnswer.givenAnswerText.trim()} className="rounded-xl bg-slate-800 px-4 py-2 text-xs font-bold text-white disabled:cursor-not-allowed disabled:opacity-50">Save answer</button>}
            <button
              disabled={currentAnswer.isCorrect === null && (currentAnswer.selectedOptionIds.length > 0 || currentAnswer.givenAnswerText.trim().length > 0)}
              onClick={() => activeIndex < questions.length - 1 ? setActiveIndex(index => index + 1) : window.confirm('Finish and review this timed practice?') && void finishSession()}
              className="rounded-xl bg-indigo-600 px-4 py-2 text-xs font-bold text-white disabled:cursor-not-allowed disabled:opacity-50"
            >{activeIndex < questions.length - 1 ? 'Next' : 'Submit'}</button>
          </div>
        ) : (
          <button onClick={submitAnswer} disabled={!currentAnswer.selectedOptionIds.length && !currentAnswer.givenAnswerText.trim()} className="ml-auto rounded-xl bg-indigo-600 px-5 py-2.5 text-xs font-bold text-white disabled:cursor-not-allowed disabled:opacity-50">{currentAnswer.isCorrect !== null ? 'Answer saved' : 'Save answer'}</button>
        )}
      </div>
      {pageError && <p role="alert" className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-3 text-xs text-rose-200">{pageError}</p>}
      {mode !== 'learn' && mode !== 'revision' && mode !== 'simulation' && (
        <button onClick={() => window.confirm('Finish and review this timed practice now?') && void finishSession()} className="w-full rounded-xl border border-slate-700 py-2.5 text-xs font-bold text-slate-300 hover:bg-slate-900">End timed practice</button>
      )}
    </div>
  ) : null;

  const renderResults = () => {
    const savedResult = sessions[0];
    const resultCount = savedResult?.total_questions || questions.length;
    const answered = savedResult?.answered_count || 0;
    const correct = savedResult?.correct_count || 0;
    const accuracy = answered ? Math.round(correct / answered * 100) : 0;
    const incorrect = answered - correct;
    const unanswered = resultCount - answered;
    const resultsById = new Map((savedResult?.question_results || []).map(result => [result.question_id, result]));
    return (
      <div className="mx-auto max-w-3xl space-y-5">
        <header className="rounded-3xl border border-emerald-500/25 bg-gradient-to-br from-emerald-950/40 to-slate-900 p-6 text-center">
          <CheckCircle2 className="mx-auto mb-2 h-9 w-9 text-emerald-300" />
          <p className="text-xs font-bold uppercase tracking-wider text-emerald-300">Session saved</p>
          <h1 className="mt-1 text-2xl font-black text-white">Practice complete</h1>
          <p className="mt-1 text-xs text-slate-400">{activeChapter?.name} · {modeNames[mode]}</p>
        </header>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
          <Metric label="Total" value={resultCount} />
          <Metric label="Correct" value={correct} color="text-emerald-300" />
          <Metric label="Incorrect" value={incorrect} color="text-rose-300" />
          <Metric label="Unanswered" value={unanswered} color="text-amber-200" />
        </div>
        <div className="rounded-2xl border border-slate-800 bg-slate-900 p-4">
          <div className="flex items-center justify-between text-xs text-slate-400"><span>Accuracy</span><strong className="text-lg text-white">{accuracy}%</strong></div>
          <div className="mt-2 h-2 overflow-hidden rounded-full bg-slate-800"><div className="h-full bg-emerald-500" style={{ width: `${accuracy}%` }} /></div>
          <div className="mt-3 flex flex-wrap justify-between gap-2 text-[11px] text-slate-400"><span>Time taken: {formatTime(savedResult?.time_spent_seconds || elapsedSeconds)}</span><span>XP is not awarded for these sessions until server-authoritative scoring is configured.</span></div>
        </div>
        {questions.map((question, index) => {
          const result = resultsById.get(question.id);
          return (
            <article key={question.id} className="rounded-2xl border border-slate-800 bg-slate-900 p-4">
              <div className="mb-2 flex items-start justify-between gap-3">
                <p className="text-sm font-bold leading-6 text-white"><span className="mr-2 text-slate-500">{index + 1}.</span>{question.questionText}</p>
                <span className={`shrink-0 rounded px-2 py-1 text-[10px] font-bold ${result?.is_correct === true ? 'bg-emerald-500/10 text-emerald-300' : result?.is_correct === false ? 'bg-rose-500/10 text-rose-300' : 'bg-slate-800 text-slate-400'}`}>
                  {result?.is_correct === true ? 'Correct' : result?.is_correct === false ? 'Incorrect' : 'Unanswered'}
                </span>
              </div>
              {question.options.map(option => <p key={option.id} className={`text-xs leading-5 ${option.isCorrect ? 'text-emerald-300' : result?.selected_option_ids.includes(option.id) ? 'text-rose-300' : 'text-slate-500'}`}>{option.isCorrect ? '✓ ' : result?.selected_option_ids.includes(option.id) ? 'Your answer: ' : ''}{option.text}</p>)}
              <p className="mt-3 text-xs leading-5 text-slate-300">{question.explanation || 'No explanation is available.'}</p>
            </article>
          );
        })}
        <div className="grid gap-2 sm:grid-cols-3">
          {incorrect > 0 && <button onClick={beginRevision} className="inline-flex items-center justify-center gap-2 rounded-xl bg-rose-500/15 px-4 py-3 text-xs font-bold text-rose-200 hover:bg-rose-500/25"><RotateCcw className="h-4 w-4" /> Revise mistakes</button>}
          <button onClick={() => setScreen('setup')} className="rounded-xl bg-indigo-600 px-4 py-3 text-xs font-bold text-white hover:bg-indigo-500">Practice again</button>
          <button onClick={() => {
            const nextChapter = chaptersForSubject.find(chapter => chapter.order > (activeChapter?.order || 0));
            if (nextChapter) {
              setChapterId(nextChapter.id);
              setTopicId('');
              setScreen('setup');
            } else {
              setScreen('browse');
            }
          }} className="rounded-xl bg-slate-800 px-4 py-3 text-xs font-bold text-white hover:bg-slate-700">Continue to next chapter</button>
        </div>
      </div>
    );
  };

  return (
    <section className="space-y-5 pb-12">
      {screen !== 'session' && screen !== 'results' && (
        <div className="flex flex-wrap items-center justify-between gap-3">
          <button onClick={() => onNavigate('dashboard')} className="inline-flex items-center gap-2 text-xs font-semibold text-slate-400 hover:text-white"><ArrowLeft className="h-4 w-4" /> Dashboard</button>
          <div className="flex items-center gap-2 text-[11px] text-slate-400"><Target className="h-4 w-4 text-indigo-300" /> Saved progress across devices</div>
        </div>
      )}
      {loadingSessions && <p className="text-xs text-slate-500">Loading saved practice history…</p>}
      {pageError && screen !== 'session' && <p role="alert" className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-3 text-xs text-rose-200">{pageError}</p>}
      {screen === 'browse' && renderBrowse()}
      {screen === 'setup' && renderSetup()}
      {screen === 'session' && renderSession()}
      {screen === 'results' && renderResults()}
      {screen === 'browse' && activeChapter && latestSession && (
        <div className="rounded-xl border border-slate-800 bg-slate-900 p-3 text-xs text-slate-400">
          Selected chapter: <strong className="text-white">{completionStatus}</strong> · latest score {latestSession.accuracy_percentage}% · {chapterHistory.length} saved session(s)
        </div>
      )}
    </section>
  );
};

const SelectField: React.FC<{
  label: string;
  value: string | number;
  onChange: (value: string) => void;
  children: React.ReactNode;
}> = ({ label, value, onChange, children }) => (
  <label className="block space-y-1.5 text-xs font-semibold text-slate-300">
    {label}
    <select value={value} onChange={event => onChange(event.target.value)} className="w-full rounded-xl border border-slate-800 bg-slate-900 px-3 py-3 text-sm text-white outline-none focus:border-indigo-500">
      {children}
    </select>
  </label>
);

const EmptyState: React.FC<{ text: string }> = ({ text }) => <div className="rounded-2xl border border-dashed border-slate-700 bg-slate-900/50 p-8 text-center text-sm text-slate-400">{text}</div>;

const Metric: React.FC<{ label: string; value: number; color?: string }> = ({ label, value, color = 'text-white' }) => (
  <div className="rounded-2xl border border-slate-800 bg-slate-900 p-4">
    <p className="text-[11px] font-semibold text-slate-500">{label}</p>
    <p className={`mt-1 text-2xl font-black ${color}`}>{value}</p>
  </div>
);
