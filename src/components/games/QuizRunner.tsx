import React, { useState, useEffect } from 'react';
import { 
  Zap, 
  Clock, 
  Heart, 
  Sparkles, 
  Bookmark, 
  CheckCircle2, 
  XCircle, 
  ArrowRight, 
  RotateCcw, 
  HelpCircle, 
  Award,
  ChevronRight,
  ShieldAlert
} from 'lucide-react';
import type { Question, QuestionAttempt } from '../../types';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import { useGame } from '../../context/GameContext';
import { useAuth } from '../../context/AuthContext';

interface QuizRunnerProps {
  gameMode: string;
  onExit: () => void;
  topicId?: string;
}

export const QuizRunner: React.FC<QuizRunnerProps> = ({ gameMode, onExit, topicId }) => {
  const { user, refreshUser } = useAuth();
  const { fireConfetti, triggerLevelUp } = useGame();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedOptionId, setSelectedOptionId] = useState<string | null>(null);
  const [numericalInput, setNumericalInput] = useState<string>('');
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [eliminatedOptionIds, setEliminatedOptionIds] = useState<string[]>([]);
  const [lifelineUsed, setLifelineUsed] = useState(false);

  // Survival mode lives
  const [livesRemaining, setLivesRemaining] = useState(3);
  
  // Timers
  const isSpeedRush = gameMode === 'speed_rush';
  const [questionTimeRemaining, setQuestionTimeRemaining] = useState(isSpeedRush ? 20 : 0);
  const [totalElapsedTime, setTotalElapsedTime] = useState(0);

  // Session stats
  const [sessionAttempts, setSessionAttempts] = useState<QuestionAttempt[]>([]);
  const [isGameOver, setIsGameOver] = useState(false);
  const [bookmarkedMap, setBookmarkedMap] = useState<Record<string, boolean>>({});

  // 1. Load questions according to game mode
  useEffect(() => {
    let pool: Question[] = [];
    const all = storage.getQuestions();

    if (gameMode === 'weak_topic_rescue') {
      const mistakeIds = storage.getMistakes().filter(m => !m.isResolved).map(m => m.questionId);
      pool = all.filter(q => mistakeIds.includes(q.id));
      if (pool.length === 0) pool = all.slice(0, 5);
    } else if (gameMode === 'pyq_machine') {
      pool = all.filter(q => q.isPyq);
    } else if (gameMode === 'true_false') {
      pool = all.filter(q => q.type === 'true_false' || q.type === 'mcq_single');
    } else {
      pool = storage.getQuestionsForGame(user.targetExamId, undefined, undefined, 10);
    }

    if (pool.length === 0) {
      pool = all.slice(0, 5);
    }

    setQuestions(pool);
    setCurrentIndex(0);
    setSessionAttempts([]);
    setIsGameOver(false);

    // Initial bookmark status
    const bms = storage.getBookmarks();
    const map: Record<string, boolean> = {};
    bms.forEach(b => { map[b.questionId] = true; });
    setBookmarkedMap(map);
  }, [gameMode, user.targetExamId, topicId]);

  // 2. Timer Loop
  useEffect(() => {
    if (isGameOver || isSubmitted || questions.length === 0) return;

    const interval = setInterval(() => {
      setTotalElapsedTime(t => t + 1);

      if (isSpeedRush) {
        setQuestionTimeRemaining(prev => {
          if (prev <= 1) {
            handleTimeExpiry();
            return 0;
          }
          if (prev <= 5) soundFX.playTick();
          return prev - 1;
        });
      }
    }, 1000);

    return () => clearInterval(interval);
  }, [isGameOver, isSubmitted, isSpeedRush, currentIndex, questions]);

  const handleTimeExpiry = () => {
    // Timed out in Speed Rush
    handleSubmitAnswer(null);
  };

  const currentQ = questions[currentIndex];

  // 3. Handle Answer Submission
  const handleSubmitAnswer = (chosenOptId: string | null) => {
    if (!currentQ || isSubmitted) return;
    setIsSubmitted(true);

    let isCorrect = false;

    if (currentQ.type === 'numerical' || currentQ.type === 'fill_gap') {
      const correctVal = (currentQ.correctAnswerText || '').trim().toLowerCase();
      isCorrect = numericalInput.trim().toLowerCase() === correctVal;
    } else if (chosenOptId) {
      const opt = currentQ.options.find(o => o.id === chosenOptId);
      isCorrect = !!opt?.isCorrect;
    }

    // Calculate XP
    let xpEarned = isCorrect ? 10 : 0;
    if (isCorrect && isSpeedRush && questionTimeRemaining > 10) {
      xpEarned += 5; // speed bonus
    }

    if (isCorrect) {
      soundFX.playCorrect();
    } else {
      soundFX.playIncorrect();
      if (gameMode === 'survival') {
        const nextLives = livesRemaining - 1;
        setLivesRemaining(nextLives);
        if (nextLives <= 0) {
          // Trigger game over after review
        }
      }
    }

    // Record Attempt in DB
    const attempt = storage.recordAttempt({
      userId: user.id,
      questionId: currentQ.id,
      gameMode,
      selectedOptionIds: chosenOptId ? [chosenOptId] : [],
      givenAnswerText: numericalInput,
      isCorrect,
      timeSpentSeconds: isSpeedRush ? (20 - questionTimeRemaining) : 5,
      awardedXp: xpEarned
    });

    // Award XP
    if (xpEarned > 0) {
      const res = storage.awardXp(xpEarned, `Correct answer in ${gameMode.replace('_', ' ')}`, 'quiz');
      if (res.leveledUp) {
        triggerLevelUp({
          oldLevel: res.oldLevel,
          newLevel: res.newLevel,
          title: user.levelTitle
        });
      }
    }

    setSessionAttempts(prev => [...prev, attempt]);
  };

  // 4. Lifeline 50:50 (Elimination Challenge)
  const handleUseLifeline = () => {
    if (!currentQ || lifelineUsed) return;
    const incorrectOpts = currentQ.options.filter(o => !o.isCorrect);
    const toEliminate = incorrectOpts.slice(0, 2).map(o => o.id);
    setEliminatedOptionIds(toEliminate);
    setLifelineUsed(true);
    soundFX.playClick();
  };

  // 5. Next Question or End Game
  const handleNext = () => {
    if (gameMode === 'survival' && livesRemaining <= 0) {
      setIsGameOver(true);
      return;
    }

    if (currentIndex + 1 >= questions.length) {
      setIsGameOver(true);
      fireConfetti();
      refreshUser();
    } else {
      setCurrentIndex(i => i + 1);
      setSelectedOptionId(null);
      setNumericalInput('');
      setIsSubmitted(false);
      setEliminatedOptionIds([]);
      setLifelineUsed(false);
      if (isSpeedRush) setQuestionTimeRemaining(20);
    }
  };

  // Bookmark toggle
  const handleToggleBookmark = () => {
    if (!currentQ) return;
    const nowBookmarked = storage.toggleBookmark(currentQ.id);
    setBookmarkedMap(prev => ({ ...prev, [currentQ.id]: nowBookmarked }));
    soundFX.playClick();
  };

  if (!currentQ && !isGameOver) {
    return (
      <div className="p-8 text-center text-slate-400">
        <p>Loading examination questions...</p>
      </div>
    );
  }

  // --- RESULTS SCREEN ---
  if (isGameOver) {
    const total = sessionAttempts.length;
    const correct = sessionAttempts.filter(a => a.isCorrect).length;
    const accuracy = total > 0 ? Math.round((correct / total) * 100) : 0;
    const totalXp = sessionAttempts.reduce((sum, a) => sum + a.awardedXp, 0);

    return (
      <div className="max-w-2xl mx-auto p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-2xl animate-in zoom-in-95">
        <div className="text-center mb-6">
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-indigo-500 to-amber-500 flex items-center justify-center mx-auto mb-3 text-white shadow-xl shadow-indigo-500/20">
            <Award className="w-8 h-8" />
          </div>
          <h2 className="text-2xl font-black text-white font-['Outfit']">
            {accuracy >= 80 ? 'Exceptional Performance!' : accuracy >= 50 ? 'Good Effort!' : 'Keep Practicing!'}
          </h2>
          <p className="text-xs text-slate-400 mt-1 capitalize">
            {gameMode.replace('_', ' ')} Session Completed
          </p>
        </div>

        {/* Scorecard Grid */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-6">
          <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 text-center">
            <p className="text-[10px] uppercase font-bold text-slate-500">Accuracy</p>
            <p className={`text-2xl font-black mt-1 ${accuracy >= 75 ? 'text-emerald-400' : 'text-amber-400'}`}>
              {accuracy}%
            </p>
          </div>
          <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 text-center">
            <p className="text-[10px] uppercase font-bold text-slate-500">Correct</p>
            <p className="text-2xl font-black text-white mt-1">
              {correct} <span className="text-xs text-slate-500">/ {total}</span>
            </p>
          </div>
          <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 text-center">
            <p className="text-[10px] uppercase font-bold text-slate-500">Time</p>
            <p className="text-2xl font-black text-indigo-400 mt-1">
              {totalElapsedTime}s
            </p>
          </div>
          <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 text-center">
            <p className="text-[10px] uppercase font-bold text-slate-500">XP Earned</p>
            <p className="text-2xl font-black text-amber-400 mt-1">
              +{totalXp}
            </p>
          </div>
        </div>

        {/* Mistakes Review */}
        {total - correct > 0 && (
          <div className="mb-6 p-4 rounded-2xl bg-rose-950/20 border border-rose-500/30">
            <div className="flex items-center gap-2 mb-2 text-rose-400 text-xs font-bold">
              <RotateCcw className="w-4 h-4" />
              <span>{total - correct} Question(s) Saved to Mistake Notebook</span>
            </div>
            <p className="text-[11px] text-slate-300 leading-relaxed">
              These concepts will automatically resurface during your spaced repetition revision sessions.
            </p>
          </div>
        )}

        {/* Action Buttons */}
        <div className="flex flex-col sm:flex-row items-center gap-3">
          <button
            onClick={() => {
              setCurrentIndex(0);
              setSelectedOptionId(null);
              setIsSubmitted(false);
              setIsGameOver(false);
              setSessionAttempts([]);
              setLivesRemaining(3);
            }}
            className="w-full sm:w-1/2 py-3 rounded-xl bg-slate-800 hover:bg-slate-700 text-white font-bold text-xs flex items-center justify-center gap-2 transition-colors"
          >
            <RotateCcw className="w-4 h-4" />
            <span>Play Again</span>
          </button>

          <button
            onClick={onExit}
            className="w-full sm:w-1/2 py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs flex items-center justify-center gap-2 transition-all shadow-md shadow-indigo-600/30"
          >
            <span>Continue Learning</span>
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>
      </div>
    );
  }

  // --- ACTIVE QUIZ QUESTION VIEW ---
  return (
    <div className="max-w-2xl mx-auto space-y-4 animate-in fade-in">
      
      {/* Top Game Bar */}
      <div className="flex items-center justify-between text-xs font-semibold px-1">
        <button 
          onClick={onExit}
          className="text-slate-400 hover:text-white transition-colors"
        >
          ✕ Quit Game
        </button>

        {/* Survival Hearts */}
        {gameMode === 'survival' && (
          <div className="flex items-center gap-1">
            {[1, 2, 3].map(h => (
              <Heart 
                key={h}
                className={`w-4 h-4 transition-all ${
                  h <= livesRemaining ? 'text-rose-500 fill-rose-500 scale-110' : 'text-slate-700'
                }`}
              />
            ))}
          </div>
        )}

        {/* Speed Rush Countdown */}
        {isSpeedRush && (
          <div className="flex items-center gap-1.5 px-2.5 py-1 rounded-lg bg-amber-500/10 border border-amber-500/30 text-amber-400 font-mono font-bold">
            <Clock className="w-3.5 h-3.5" />
            <span>{questionTimeRemaining}s</span>
          </div>
        )}

        <span className="font-mono text-slate-400">
          Question {currentIndex + 1} of {questions.length}
        </span>
      </div>

      {/* Progress Bar */}
      <div className="w-full h-2 rounded-full bg-slate-900 border border-slate-800 overflow-hidden">
        <div 
          className="h-full bg-gradient-to-r from-indigo-500 to-amber-400 transition-all duration-300"
          style={{ width: `${((currentIndex + 1) / questions.length) * 100}%` }}
        />
      </div>

      {/* Question Card */}
      <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl">
        
        {/* Meta Header */}
        <div className="flex items-center justify-between gap-2 mb-4">
          <div className="flex items-center gap-2">
            <span className="text-[10px] font-bold uppercase tracking-wider px-2.5 py-0.5 rounded-full bg-indigo-500/20 text-indigo-300 border border-indigo-500/30">
              {currentQ.difficulty.toUpperCase()}
            </span>
            {currentQ.isPyq && (
              <span className="text-[10px] font-bold uppercase tracking-wider px-2 py-0.5 rounded-full bg-amber-500/20 text-amber-300 border border-amber-500/30">
                Official PYQ {currentQ.pyqYear}
              </span>
            )}
          </div>

          <button
            onClick={handleToggleBookmark}
            title="Bookmark this question"
            className="p-1.5 rounded-lg bg-slate-800 text-slate-400 hover:text-amber-400 transition-colors"
          >
            <Bookmark className={`w-4 h-4 ${bookmarkedMap[currentQ.id] ? 'text-amber-400 fill-amber-400' : ''}`} />
          </button>
        </div>

        {/* Assertion & Reason Special Layout */}
        {currentQ.type === 'assertion_reason' && (
          <div className="mb-4 space-y-2 p-3.5 rounded-2xl bg-slate-950/80 border border-slate-800 text-xs">
            <p><span className="font-bold text-indigo-400">Assertion (A):</span> {currentQ.assertionText}</p>
            <p><span className="font-bold text-amber-400">Reason (R):</span> {currentQ.reasonText}</p>
          </div>
        )}

        {/* Main Question Text (Supports Arabic / Malayalam font rendering) */}
        <h3 className="text-base sm:text-lg font-bold text-white mb-6 leading-relaxed">
          {currentQ.questionText}
        </h3>

        {/* Arabic sub-text if present */}
        {currentQ.questionTextArabic && (
          <p className="text-base font-['Amiri'] text-emerald-300 mb-6 leading-loose text-right dir-rtl">
            {currentQ.questionTextArabic}
          </p>
        )}

        {/* Options / Input Field */}
        {currentQ.type === 'numerical' ? (
          <div className="space-y-3 mb-6">
            <label className="text-xs text-slate-400 font-semibold">Enter your numerical answer:</label>
            <input 
              type="text"
              disabled={isSubmitted}
              placeholder="e.g. 3"
              value={numericalInput}
              onChange={(e) => setNumericalInput(e.target.value)}
              className="w-full p-3.5 rounded-2xl bg-slate-950 border border-slate-700 text-white font-mono text-base focus:outline-none focus:border-indigo-500"
            />
            {!isSubmitted && (
              <button
                onClick={() => handleSubmitAnswer(null)}
                className="w-full py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs"
              >
                Submit Numerical Value
              </button>
            )}
          </div>
        ) : (
          <div className="space-y-2.5 mb-6">
            {currentQ.options.map(opt => {
              const isEliminated = eliminatedOptionIds.includes(opt.id);
              let btnClass = 'border-slate-800 bg-slate-950/70 text-slate-200 hover:border-indigo-500/60';

              if (isSubmitted) {
                if (opt.isCorrect) {
                  btnClass = 'border-emerald-500 bg-emerald-500/20 text-emerald-300 font-bold';
                } else if (selectedOptionId === opt.id) {
                  btnClass = 'border-rose-500 bg-rose-500/20 text-rose-300 font-bold';
                } else {
                  btnClass = 'border-slate-800 bg-slate-950/30 text-slate-500';
                }
              }

              if (isEliminated) {
                btnClass = 'border-slate-800/40 bg-slate-950/20 text-slate-600 line-through cursor-not-allowed opacity-40';
              }

              return (
                <button
                  key={opt.id}
                  disabled={isSubmitted || isEliminated}
                  onClick={() => {
                    setSelectedOptionId(opt.id);
                    handleSubmitAnswer(opt.id);
                  }}
                  className={`w-full text-left p-3.5 rounded-2xl border text-xs sm:text-sm transition-all flex items-center justify-between ${btnClass}`}
                >
                  <span className="leading-snug">{opt.text}</span>
                  {isSubmitted && opt.isCorrect && (
                    <CheckCircle2 className="w-5 h-5 text-emerald-400 shrink-0 ml-2" />
                  )}
                  {isSubmitted && selectedOptionId === opt.id && !opt.isCorrect && (
                    <XCircle className="w-5 h-5 text-rose-400 shrink-0 ml-2" />
                  )}
                </button>
              );
            })}
          </div>
        )}

        {/* Lifeline Button (Elimination Challenge) */}
        {gameMode === 'elimination' && !lifelineUsed && !isSubmitted && (
          <div className="mb-4 text-center">
            <button
              onClick={handleUseLifeline}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-amber-500/10 border border-amber-500/30 text-amber-400 text-xs font-bold hover:bg-amber-500/20"
            >
              <ShieldAlert className="w-3.5 h-3.5" />
              <span>Use 50:50 Lifeline (Eliminate 2 options)</span>
            </button>
          </div>
        )}

        {/* Academic Explanation Reveal */}
        {isSubmitted && (
          <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 text-xs animate-in fade-in">
            <div className="flex items-center gap-1.5 font-bold mb-1.5 text-indigo-400">
              <Sparkles className="w-4 h-4 text-amber-400" />
              <span>Academic Solution & Explanation</span>
            </div>
            <p className="text-slate-300 leading-relaxed mb-4">
              {currentQ.explanation}
            </p>
            {currentQ.hint && (
              <p className="text-[11px] text-slate-500 italic mb-3">
                💡 Note: {currentQ.hint}
              </p>
            )}
            <button
              onClick={handleNext}
              className="w-full py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs flex items-center justify-center gap-2 transition-all shadow-md shadow-indigo-600/30"
            >
              <span>{currentIndex + 1 >= questions.length ? 'View Results' : 'Next Question'}</span>
              <ArrowRight className="w-4 h-4" />
            </button>
          </div>
        )}

      </div>

    </div>
  );
};
