import React, { useState } from 'react';
import { 
  RotateCcw, 
  CheckCircle2, 
  Bookmark, 
  Search, 
  Filter, 
  Clock, 
  Sparkles, 
  Check, 
  BookOpen,
  ArrowRight
} from 'lucide-react';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import type { Question, MistakeEntry } from '../../types';

interface MistakeNotebookViewProps {
  onStartRevisionGame: () => void;
}

export const MistakeNotebookView: React.FC<MistakeNotebookViewProps> = ({ onStartRevisionGame }) => {
  const [filterResolved, setFilterResolved] = useState<'all' | 'due' | 'resolved'>('due');
  const [searchQuery, setSearchQuery] = useState('');

  const mistakes = storage.getMistakes();
  const allQuestions = storage.getQuestions();

  // Join mistake entries with question details
  const joinedItems = mistakes.map(m => {
    const q = allQuestions.find(item => item.id === m.questionId);
    return {
      mistake: m,
      question: q
    };
  }).filter(item => item.question !== undefined) as { mistake: MistakeEntry; question: Question }[];

  const filteredItems = joinedItems.filter(item => {
    if (filterResolved === 'due' && item.mistake.isResolved) return false;
    if (filterResolved === 'resolved' && !item.mistake.isResolved) return false;

    if (searchQuery) {
      const qText = item.question.questionText.toLowerCase();
      const expl = item.question.explanation.toLowerCase();
      const s = searchQuery.toLowerCase();
      return qText.includes(s) || expl.includes(s);
    }
    return true;
  });

  const dueCount = mistakes.filter(m => !m.isResolved).length;

  const handleMarkResolved = (questionId: string) => {
    soundFX.playCorrect();
    // Mark as resolved in storage
    const msts = storage.getMistakes();
    const entry = msts.find(m => m.questionId === questionId);
    if (entry) {
      entry.isResolved = true;
      entry.repetitionIntervalDays = Math.round(entry.repetitionIntervalDays * entry.easeFactor);
      localStorage.setItem('netace_mistakes', JSON.stringify(msts));
      storage.awardXp(25, 'Mastered question in Mistake Notebook', 'achievement');
      // trigger re-render
      setFilterResolved(f => f);
    }
  };

  return (
    <div className="space-y-6 pb-12 animate-in fade-in">
      
      {/* Header Banner */}
      <div className="p-6 rounded-3xl bg-gradient-to-r from-rose-950/60 via-slate-900 to-slate-900 border border-rose-500/30 shadow-xl flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-rose-500/10 border border-rose-500/30 text-rose-300 text-xs font-bold mb-2">
            <RotateCcw className="w-3.5 h-3.5" />
            <span>SM-2 SPACED REPETITION ENGINE</span>
          </div>
          <h2 className="text-2xl sm:text-3xl font-black text-white font-['Outfit']">
            Mistake Notebook & Revision
          </h2>
          <p className="text-xs sm:text-sm text-slate-300 mt-1 max-w-xl">
            Questions you missed during study games are automatically cataloged here with their complete explanations for targeted mastery.
          </p>
        </div>

        <button
          onClick={onStartRevisionGame}
          disabled={dueCount === 0}
          className="px-6 py-3 rounded-2xl bg-gradient-to-r from-rose-600 to-pink-600 hover:from-rose-500 hover:to-pink-500 disabled:opacity-40 text-white font-black text-xs shadow-lg shadow-rose-600/30 flex items-center justify-center gap-2 transition-all hover:scale-105 shrink-0"
        >
          <RotateCcw className="w-4 h-4" />
          <span>Revise Due Queue ({dueCount})</span>
        </button>
      </div>

      {/* Filter and Search Bar */}
      <div className="flex flex-col sm:flex-row items-center justify-between gap-3 text-xs">
        <div className="flex items-center gap-2 w-full sm:w-auto">
          {[
            { id: 'due', label: `Due for Revision (${dueCount})` },
            { id: 'resolved', label: 'Mastered / Resolved' },
            { id: 'all', label: `All Missed (${mistakes.length})` }
          ].map(tab => (
            <button
              key={tab.id}
              onClick={() => setFilterResolved(tab.id as 'all' | 'due' | 'resolved')}
              className={`px-3.5 py-1.5 rounded-xl font-bold transition-colors ${
                filterResolved === tab.id
                  ? 'bg-indigo-600 text-white shadow-md'
                  : 'bg-slate-900 border border-slate-800 text-slate-400 hover:text-white'
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>

        <div className="relative w-full sm:w-64">
          <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
          <input
            type="text"
            placeholder="Search mistakes..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-9 pr-3 py-2 rounded-xl bg-slate-900 border border-slate-800 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-indigo-500"
          />
        </div>
      </div>

      {/* Question Items List */}
      <div className="space-y-4">
        {filteredItems.length === 0 ? (
          <div className="p-12 rounded-3xl bg-slate-900 border border-slate-800 text-center text-slate-400">
            <CheckCircle2 className="w-12 h-12 text-emerald-400 mx-auto mb-3" />
            <h3 className="text-base font-bold text-white mb-1">No Mistakes in this View!</h3>
            <p className="text-xs text-slate-500 max-w-sm mx-auto">
              You have resolved all scheduled revisions. Play more games to discover new concepts and keep your edge sharp.
            </p>
          </div>
        ) : (
          filteredItems.map(({ mistake, question }) => {
            const correctOpt = question.options.find(o => o.isCorrect);

            return (
              <div 
                key={question.id}
                className="p-5 rounded-3xl bg-slate-900 border border-slate-800 space-y-3 hover:border-slate-700 transition-colors"
              >
                <div className="flex items-center justify-between text-xs">
                  <div className="flex items-center gap-2">
                    <span className="text-[10px] font-bold uppercase tracking-wider px-2 py-0.5 rounded bg-rose-500/10 text-rose-400 border border-rose-500/30">
                      Missed {mistake.attemptCount} time(s)
                    </span>
                    <span className="text-[10px] font-mono text-slate-400">
                      Interval: {mistake.repetitionIntervalDays}d (Ease: {mistake.easeFactor})
                    </span>
                  </div>

                  {mistake.isResolved ? (
                    <span className="text-emerald-400 text-xs font-bold flex items-center gap-1">
                      <Check className="w-3.5 h-3.5" />
                      <span>Mastered</span>
                    </span>
                  ) : (
                    <button
                      onClick={() => handleMarkResolved(question.id)}
                      className="px-3 py-1 rounded-lg bg-emerald-600/20 hover:bg-emerald-600/30 border border-emerald-500/40 text-emerald-300 text-xs font-bold transition-colors"
                    >
                      Mark as Understood
                    </button>
                  )}
                </div>

                <p className="text-sm font-bold text-white leading-relaxed">
                  {question.questionText}
                </p>

                <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 text-xs space-y-1.5">
                  <p className="text-emerald-400 font-bold">
                    ✓ Correct Answer: {correctOpt?.text || question.correctAnswerText}
                  </p>
                  <p className="text-slate-300 leading-relaxed text-[11px] pt-1 border-t border-slate-900">
                    <strong className="text-indigo-400">Explanation:</strong> {question.explanation}
                  </p>
                </div>
              </div>
            );
          })
        )}
      </div>

    </div>
  );
};
