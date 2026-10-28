import React, { useState, useEffect } from 'react';
import { 
  Clock, 
  Bookmark, 
  CheckCircle2, 
  AlertCircle, 
  ChevronLeft, 
  ChevronRight, 
  RotateCcw,
  Award,
  FileText
} from 'lucide-react';
import type { Question } from '../../types';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import { useAuth } from '../../context/AuthContext';
import { useGame } from '../../context/GameContext';

interface MockExamGameProps {
  onExit: () => void;
}

type QuestionStatus = 'answered' | 'unanswered' | 'marked_for_review' | 'not_visited';

export const MockExamGame: React.FC<MockExamGameProps> = ({ onExit }) => {
  const { user } = useAuth();
  const { fireConfetti } = useGame();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [responses, setResponses] = useState<Record<number, string>>({}); // index -> optionId
  const [statuses, setStatuses] = useState<Record<number, QuestionStatus>>({});
  const [timeRemainingSeconds, setTimeRemainingSeconds] = useState(600); // 10 minutes simulated
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [showConfirmModal, setShowConfirmModal] = useState(false);

  // Load questions
  useEffect(() => {
    const all = storage.getQuestions();
    const mockSet = all.slice(0, 10);
    setQuestions(mockSet);

    // Initial statuses
    const initialStatus: Record<number, QuestionStatus> = {};
    mockSet.forEach((_, idx) => {
      initialStatus[idx] = idx === 0 ? 'unanswered' : 'not_visited';
    });
    setStatuses(initialStatus);
  }, []);

  // Timer countdown
  useEffect(() => {
    if (isSubmitted) return;
    const interval = setInterval(() => {
      setTimeRemainingSeconds(prev => {
        if (prev <= 1) {
          handleAutoSubmit();
          return 0;
        }
        return prev - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [isSubmitted]);

  const handleAutoSubmit = () => {
    setIsSubmitted(true);
    soundFX.playLevelUp();
    fireConfetti();
  };

  const currentQ = questions[currentIndex];

  const handleSelectOption = (optId: string) => {
    if (isSubmitted) return;
    soundFX.playClick();
    setResponses(prev => ({ ...prev, [currentIndex]: optId }));
    setStatuses(prev => ({
      ...prev,
      [currentIndex]: prev[currentIndex] === 'marked_for_review' ? 'marked_for_review' : 'answered'
    }));
  };

  const handleClearResponse = () => {
    if (isSubmitted) return;
    const newResponses = { ...responses };
    delete newResponses[currentIndex];
    setResponses(newResponses);
    setStatuses(prev => ({ ...prev, [currentIndex]: 'unanswered' }));
  };

  const handleMarkForReview = () => {
    if (isSubmitted) return;
    setStatuses(prev => ({ ...prev, [currentIndex]: 'marked_for_review' }));
    handleNext();
  };

  const handleSaveAndNext = () => {
    if (isSubmitted) return;
    if (responses[currentIndex]) {
      setStatuses(prev => ({ ...prev, [currentIndex]: 'answered' }));
    } else {
      setStatuses(prev => ({ ...prev, [currentIndex]: 'unanswered' }));
    }
    handleNext();
  };

  const handleNext = () => {
    if (currentIndex + 1 < questions.length) {
      const nextIdx = currentIndex + 1;
      setCurrentIndex(nextIdx);
      if (statuses[nextIdx] === 'not_visited') {
        setStatuses(prev => ({ ...prev, [nextIdx]: 'unanswered' }));
      }
    }
  };

  const handleJumpToQuestion = (idx: number) => {
    setCurrentIndex(idx);
    if (statuses[idx] === 'not_visited') {
      setStatuses(prev => ({ ...prev, [idx]: 'unanswered' }));
    }
  };

  // Format Time
  const formatTime = (secs: number) => {
    const m = Math.floor(secs / 60);
    const s = secs % 60;
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  };

  // Calculate Results
  const answeredCount = Object.keys(responses).length;
  const markedCount = Object.values(statuses).filter(s => s === 'marked_for_review').length;

  let totalScore = 0;
  let correctCount = 0;
  let incorrectCount = 0;

  if (isSubmitted) {
    questions.forEach((q, idx) => {
      const chosen = responses[idx];
      if (chosen) {
        const opt = q.options.find(o => o.id === chosen);
        if (opt?.isCorrect) {
          correctCount++;
          totalScore += 2; // +2 marks
        } else {
          incorrectCount++;
          // negative marking 0 for UGC NET, -0.5 for JEE
          totalScore = Math.max(0, totalScore - 0.5);
        }
      }
    });
  }

  // --- SCORECARD VIEW AFTER SUBMISSION ---
  if (isSubmitted) {
    const accuracy = answeredCount > 0 ? Math.round((correctCount / answeredCount) * 100) : 0;

    return (
      <div className="max-w-3xl mx-auto p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-2xl animate-in zoom-in-95 space-y-6">
        <div className="text-center">
          <div className="w-16 h-16 rounded-2xl bg-indigo-600 flex items-center justify-center mx-auto mb-3 text-white shadow-xl">
            <Award className="w-8 h-8" />
          </div>
          <h2 className="text-2xl font-black text-white font-['Outfit']">
            Official Mock Exam Scorecard
          </h2>
          <p className="text-xs text-slate-400 mt-1">
            Exam Pattern: UGC NET / NTA Testing Service Standard Scheme (+2 / -0.5)
          </p>
        </div>

        {/* Scorecard Grid */}
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 text-center">
            <p className="text-[10px] text-slate-500 font-bold uppercase">Total Score</p>
            <p className="text-3xl font-black text-amber-400 mt-1">{totalScore} <span className="text-xs text-slate-500">/ 20</span></p>
          </div>
          <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 text-center">
            <p className="text-[10px] text-slate-500 font-bold uppercase">Accuracy</p>
            <p className="text-3xl font-black text-emerald-400 mt-1">{accuracy}%</p>
          </div>
          <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 text-center">
            <p className="text-[10px] text-slate-500 font-bold uppercase">Correct Answers</p>
            <p className="text-3xl font-black text-white mt-1">{correctCount} <span className="text-xs text-slate-500">/ {questions.length}</span></p>
          </div>
          <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 text-center">
            <p className="text-[10px] text-slate-500 font-bold uppercase">Incorrect</p>
            <p className="text-3xl font-black text-rose-400 mt-1">{incorrectCount}</p>
          </div>
        </div>

        {/* Detailed Solutions Section */}
        <div className="space-y-3">
          <p className="text-xs font-bold text-slate-300 uppercase tracking-wider">Detailed Solution & Answer Key:</p>
          {questions.map((q, idx) => {
            const chosenId = responses[idx];
            const chosenOpt = q.options.find(o => o.id === chosenId);
            const correctOpt = q.options.find(o => o.isCorrect);
            const isQCorrect = !!chosenOpt?.isCorrect;

            return (
              <div key={q.id} className="p-4 rounded-2xl bg-slate-950/80 border border-slate-800 space-y-2">
                <div className="flex items-center justify-between text-xs">
                  <span className="font-bold text-white">Q{idx + 1}: {q.questionText}</span>
                  <span className={`px-2 py-0.5 rounded text-[10px] font-bold ${
                    isQCorrect ? 'bg-emerald-500/20 text-emerald-400' : 'bg-rose-500/20 text-rose-400'
                  }`}>
                    {isQCorrect ? 'Correct (+2)' : chosenId ? 'Incorrect (-0.5)' : 'Unattempted (0)'}
                  </span>
                </div>
                <div className="text-xs text-slate-400 flex flex-col sm:flex-row gap-4 font-mono">
                  <span>Your Answer: <strong className="text-white">{chosenOpt ? chosenOpt.text : 'None'}</strong></span>
                  <span>Correct Key: <strong className="text-emerald-400">{correctOpt?.text}</strong></span>
                </div>
                <p className="text-[11px] text-slate-300 leading-relaxed pt-1 border-t border-slate-900">
                  {q.explanation}
                </p>
              </div>
            );
          })}
        </div>

        <button
          onClick={onExit}
          className="w-full py-3.5 rounded-2xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs"
        >
          Exit Mock Exam Challenge
        </button>
      </div>
    );
  }

  // --- ACTIVE MOCK EXAM INTERFACE ---
  return (
    <div className="space-y-4 animate-in fade-in max-w-5xl mx-auto">
      
      {/* Top NTA Style Header Bar */}
      <div className="p-4 rounded-2xl bg-slate-900 border border-slate-800 flex items-center justify-between">
        <div>
          <span className="text-[10px] uppercase font-bold tracking-wider text-indigo-400">NTA Standard Exam Replica</span>
          <h2 className="text-sm sm:text-base font-extrabold text-white">
            UGC NET / KTET Full-Length Mock Simulation
          </h2>
        </div>

        <div className="flex items-center gap-4">
          <div className="flex items-center gap-1.5 px-3 py-1.5 rounded-xl bg-slate-950 border border-amber-500/40 text-amber-400 font-mono font-bold text-xs">
            <Clock className="w-4 h-4" />
            <span>Time Left: {formatTime(timeRemainingSeconds)}</span>
          </div>

          <button
            onClick={() => setShowConfirmModal(true)}
            className="px-4 py-2 rounded-xl bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white font-black text-xs shadow-md"
          >
            Submit Test
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-5">
        
        {/* Left: Question Viewer (8 cols) */}
        <div className="lg:col-span-8 p-6 rounded-3xl bg-slate-900 border border-slate-800 flex flex-col justify-between">
          <div>
            <div className="flex items-center justify-between pb-3 mb-4 border-b border-slate-800 text-xs">
              <span className="font-bold text-slate-300">Question #{currentIndex + 1} of {questions.length}</span>
              <span className="text-[11px] text-slate-400 font-mono">Marking: +2 / -0.5</span>
            </div>

            {currentQ && (
              <>
                <p className="text-sm sm:text-base font-bold text-white mb-6 leading-relaxed">
                  {currentQ.questionText}
                </p>

                {/* Options */}
                <div className="space-y-3 mb-6">
                  {currentQ.options.map((opt, i) => {
                    const isSelected = responses[currentIndex] === opt.id;
                    return (
                      <button
                        key={opt.id}
                        onClick={() => handleSelectOption(opt.id)}
                        className={`w-full text-left p-3.5 rounded-2xl border text-xs sm:text-sm transition-all flex items-center justify-between ${
                          isSelected
                            ? 'border-indigo-500 bg-indigo-500/20 text-white font-bold'
                            : 'border-slate-800 bg-slate-950/70 text-slate-300 hover:border-slate-700'
                        }`}
                      >
                        <div className="flex items-center gap-3">
                          <span className={`w-6 h-6 rounded-full flex items-center justify-center font-bold text-xs ${
                            isSelected ? 'bg-indigo-500 text-white' : 'bg-slate-800 text-slate-400'
                          }`}>
                            {String.fromCharCode(65 + i)}
                          </span>
                          <span>{opt.text}</span>
                        </div>
                      </button>
                    );
                  })}
                </div>
              </>
            )}
          </div>

          {/* Navigation Controls */}
          <div className="pt-4 border-t border-slate-800 flex flex-wrap items-center justify-between gap-2">
            <div className="flex items-center gap-2">
              <button
                onClick={handleClearResponse}
                className="px-3 py-2 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-semibold"
              >
                Clear Response
              </button>
              <button
                onClick={handleMarkForReview}
                className="px-3 py-2 rounded-xl bg-purple-600/20 hover:bg-purple-600/30 border border-purple-500/40 text-purple-300 text-xs font-bold"
              >
                Mark for Review & Next
              </button>
            </div>

            <div className="flex items-center gap-2">
              <button
                disabled={currentIndex === 0}
                onClick={() => setCurrentIndex(i => Math.max(0, i - 1))}
                className="p-2 rounded-xl bg-slate-800 disabled:opacity-40 text-slate-300"
              >
                <ChevronLeft className="w-4 h-4" />
              </button>
              <button
                onClick={handleSaveAndNext}
                className="px-5 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-md shadow-indigo-600/30 flex items-center gap-1.5"
              >
                <span>Save & Next</span>
                <ChevronRight className="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>

        {/* Right: Question Palette (4 cols per NTA Standard) */}
        <div className="lg:col-span-4 p-5 rounded-3xl bg-slate-900 border border-slate-800 space-y-4">
          <h3 className="font-bold text-sm text-white">Question Palette</h3>

          {/* Palette Legend */}
          <div className="grid grid-cols-2 gap-2 text-[11px] pb-3 border-b border-slate-800">
            <div className="flex items-center gap-2">
              <span className="w-4 h-4 rounded-full bg-emerald-500 text-[10px] text-white flex items-center justify-center font-bold">✓</span>
              <span className="text-slate-300">Answered ({answeredCount})</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="w-4 h-4 rounded-full bg-rose-500 text-[10px] text-white flex items-center justify-center font-bold">!</span>
              <span className="text-slate-300">Not Answered</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="w-4 h-4 rounded-full bg-purple-500 text-[10px] text-white flex items-center justify-center font-bold">?</span>
              <span className="text-slate-300">Review ({markedCount})</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="w-4 h-4 rounded-full bg-slate-700 text-[10px] text-white flex items-center justify-center font-bold">-</span>
              <span className="text-slate-300">Not Visited</span>
            </div>
          </div>

          {/* Question Grid Buttons */}
          <div className="grid grid-cols-5 gap-2 max-h-64 overflow-y-auto pr-1">
            {questions.map((_, idx) => {
              const status = statuses[idx];
              const isCurrent = currentIndex === idx;

              let style = 'bg-slate-800 text-slate-400';
              if (status === 'answered') style = 'bg-emerald-600 text-white font-bold';
              else if (status === 'marked_for_review') style = 'bg-purple-600 text-white font-bold';
              else if (status === 'unanswered') style = 'bg-rose-600/80 text-white font-bold';

              return (
                <button
                  key={idx}
                  onClick={() => handleJumpToQuestion(idx)}
                  className={`h-9 rounded-xl text-xs flex items-center justify-center transition-all ${style} ${
                    isCurrent ? 'ring-2 ring-white scale-105' : ''
                  }`}
                >
                  {idx + 1}
                </button>
              );
            })}
          </div>

          <button
            onClick={() => setShowConfirmModal(true)}
            className="w-full py-3 rounded-xl bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white font-black text-xs shadow-lg mt-4"
          >
            Submit Entire Test
          </button>
        </div>

      </div>

      {/* Confirmation Modal */}
      {showConfirmModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-sm animate-in fade-in">
          <div className="w-full max-w-sm rounded-3xl bg-slate-900 border border-slate-700 p-6 text-center space-y-4">
            <h3 className="text-lg font-black text-white">Confirm Test Submission</h3>
            <p className="text-xs text-slate-300">
              You have answered <strong className="text-emerald-400">{answeredCount}</strong> of <strong className="text-white">{questions.length}</strong> questions.
              {markedCount > 0 && <span> ({markedCount} marked for review).</span>}
            </p>
            <div className="flex gap-2">
              <button
                onClick={() => setShowConfirmModal(false)}
                className="flex-1 py-2.5 rounded-xl bg-slate-800 text-slate-300 text-xs font-semibold"
              >
                Back to Exam
              </button>
              <button
                onClick={() => {
                  setShowConfirmModal(false);
                  handleAutoSubmit();
                }}
                className="flex-1 py-2.5 rounded-xl bg-emerald-600 hover:bg-emerald-500 text-white text-xs font-bold"
              >
                Yes, Submit
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
};
