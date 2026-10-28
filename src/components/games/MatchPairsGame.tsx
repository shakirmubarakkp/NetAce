import React, { useState } from 'react';
import { Layers, CheckCircle2, RotateCcw, Award, Check } from 'lucide-react';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import { useGame } from '../../context/GameContext';

interface MatchPairsGameProps {
  onExit: () => void;
}

export const MatchPairsGame: React.FC<MatchPairsGameProps> = ({ onExit }) => {
  const { fireConfetti } = useGame();

  const pairs = [
    { id: '1', left: 'Johann Friedrich Herbart', right: 'Memory Level of Teaching (MLT)' },
    { id: '2', left: 'Al-Mutanabbi', right: 'Sayf al-Dawla Hamdani Circle' },
    { id: '3', left: 'Kumaran Asan', right: 'Veenapoovu (വീണപൂവ് 1907)' },
    { id: '4', left: 'Jean Piaget', right: 'Sensorimotor & Concrete Operations' },
    { id: '5', left: 'Sibawayh', right: 'Al-Kitab (Foundational Arabic Grammar)' }
  ];

  const [selectedLeft, setSelectedLeft] = useState<string | null>(null);
  const [matchedIds, setMatchedIds] = useState<string[]>([]);
  const [isCompleted, setIsCompleted] = useState(false);
  const [shuffledRights] = useState(() => [...pairs].sort(() => 0.5 - Math.random()));

  const handleLeftClick = (id: string) => {
    if (matchedIds.includes(id)) return;
    soundFX.playClick();
    setSelectedLeft(id);
  };

  const handleRightClick = (id: string) => {
    if (!selectedLeft || matchedIds.includes(id)) return;

    if (selectedLeft === id) {
      soundFX.playCorrect();
      const updated = [...matchedIds, id];
      setMatchedIds(updated);
      setSelectedLeft(null);

      if (updated.length === pairs.length) {
        setIsCompleted(true);
        soundFX.playLevelUp();
        fireConfetti();
        storage.awardXp(50, 'Completed Match the Pairs Game', 'achievement');
      }
    } else {
      soundFX.playIncorrect();
      setSelectedLeft(null);
    }
  };

  const handleReset = () => {
    setMatchedIds([]);
    setSelectedLeft(null);
    setIsCompleted(false);
  };

  return (
    <div className="max-w-2xl mx-auto space-y-4 animate-in fade-in">
      
      {/* Top Bar */}
      <div className="flex items-center justify-between text-xs px-1">
        <button onClick={onExit} className="text-slate-400 hover:text-white">✕ Exit</button>
        <span className="text-indigo-400 font-bold uppercase tracking-wider">Match the Pairs (Two Columns)</span>
        <span className="text-emerald-400 font-bold font-mono">
          {matchedIds.length} of {pairs.length} Paired
        </span>
      </div>

      {isCompleted ? (
        <div className="p-8 rounded-3xl bg-slate-900 border border-slate-800 text-center shadow-2xl animate-in zoom-in-95">
          <div className="w-16 h-16 rounded-2xl bg-indigo-600 flex items-center justify-center mx-auto mb-4 text-white shadow-xl">
            <Award className="w-8 h-8" />
          </div>
          <h2 className="text-2xl font-black text-white font-['Outfit'] mb-1">
            All Pairs Successfully Connected!
          </h2>
          <p className="text-xs text-slate-300 mb-6">
            You matched all academic authors and core conceptual milestones with zero errors remaining.
          </p>
          <div className="flex gap-3">
            <button
              onClick={handleReset}
              className="flex-1 py-3 rounded-xl bg-slate-800 hover:bg-slate-700 text-white font-bold text-xs flex items-center justify-center gap-2"
            >
              <RotateCcw className="w-4 h-4" />
              <span>Retry</span>
            </button>
            <button
              onClick={onExit}
              className="flex-1 py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs"
            >
              Back to Game Arena
            </button>
          </div>
        </div>
      ) : (
        <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl space-y-4">
          <p className="text-xs text-slate-400">
            Tap an item in Column A (Proponent/Scholar), then tap its corresponding concept in Column B:
          </p>

          <div className="grid grid-cols-2 gap-4">
            {/* Column A (Left) */}
            <div className="space-y-2.5">
              <span className="text-[11px] font-bold text-indigo-400 uppercase tracking-wider block mb-1">
                Column A (Scholars)
              </span>
              {pairs.map(p => {
                const isMatched = matchedIds.includes(p.id);
                const isSelected = selectedLeft === p.id;

                return (
                  <button
                    key={p.id}
                    disabled={isMatched}
                    onClick={() => handleLeftClick(p.id)}
                    className={`w-full text-left p-3.5 rounded-2xl border text-xs font-semibold transition-all ${
                      isMatched
                        ? 'bg-emerald-950/40 border-emerald-500/50 text-emerald-300 line-through opacity-70'
                        : isSelected
                        ? 'bg-indigo-600 text-white border-indigo-400 shadow-md ring-2 ring-indigo-400/40'
                        : 'bg-slate-950/70 border-slate-800 text-slate-200 hover:border-slate-700'
                    }`}
                  >
                    <span>{p.left}</span>
                  </button>
                );
              })}
            </div>

            {/* Column B (Right) */}
            <div className="space-y-2.5">
              <span className="text-[11px] font-bold text-amber-400 uppercase tracking-wider block mb-1">
                Column B (Concepts & Works)
              </span>
              {shuffledRights.map(p => {
                const isMatched = matchedIds.includes(p.id);

                return (
                  <button
                    key={p.id}
                    disabled={isMatched}
                    onClick={() => handleRightClick(p.id)}
                    className={`w-full text-left p-3.5 rounded-2xl border text-xs font-semibold transition-all ${
                      isMatched
                        ? 'bg-emerald-950/40 border-emerald-500/50 text-emerald-300 line-through opacity-70'
                        : 'bg-slate-950/70 border-slate-800 text-slate-200 hover:border-amber-500/60'
                    }`}
                  >
                    <span>{p.right}</span>
                  </button>
                );
              })}
            </div>
          </div>
        </div>
      )}

    </div>
  );
};
