import React from 'react';
import { Award, Zap, ChevronRight } from 'lucide-react';
import { useGame } from '../../context/GameContext';

export const LevelUpModal: React.FC = () => {
  const { levelUpData, closeLevelUp } = useGame();

  if (!levelUpData) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-md animate-in fade-in">
      <div className="relative w-full max-w-sm rounded-3xl bg-gradient-to-b from-indigo-900 via-slate-900 to-slate-950 border-2 border-indigo-500/60 p-6 text-center shadow-2xl shadow-indigo-500/30 overflow-hidden">
        
        {/* Glow backdrop */}
        <div className="absolute top-0 left-1/2 -translate-x-1/2 w-48 h-48 bg-indigo-500/20 rounded-full blur-3xl pointer-events-none"></div>

        {/* Level Up Badge */}
        <div className="relative mx-auto w-24 h-24 rounded-full bg-gradient-to-tr from-amber-500 via-yellow-400 to-amber-600 p-1 shadow-xl shadow-amber-500/30 mb-4 animate-bounce">
          <div className="w-full h-full rounded-full bg-slate-950 flex flex-col items-center justify-center">
            <Award className="w-10 h-10 text-amber-400" />
            <span className="text-[10px] font-black uppercase tracking-widest text-amber-300">Level</span>
            <span className="text-xl font-black text-white">{levelUpData.newLevel}</span>
          </div>
        </div>

        <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-amber-500/20 text-amber-400 text-xs font-bold mb-2">
          <Zap className="w-3.5 h-3.5 fill-amber-400" />
          <span>LEVEL ADVANCEMENT</span>
        </div>

        <h3 className="text-2xl font-black text-white font-['Outfit'] mb-1">
          {levelUpData.title}!
        </h3>
        <p className="text-xs text-slate-300 mb-6">
          Congratulations! You ascended from Level {levelUpData.oldLevel} to Level {levelUpData.newLevel}. Your consistency and accuracy are paying off.
        </p>

        <button
          onClick={closeLevelUp}
          className="w-full py-3 rounded-2xl bg-gradient-to-r from-indigo-500 via-indigo-600 to-indigo-700 hover:from-indigo-400 hover:to-indigo-600 text-white font-bold text-sm shadow-lg shadow-indigo-600/30 flex items-center justify-center gap-2 transition-all hover:scale-[1.02]"
        >
          <span>Continue Learning</span>
          <ChevronRight className="w-4 h-4" />
        </button>
      </div>
    </div>
  );
};
