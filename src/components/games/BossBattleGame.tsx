import React, { useState, useEffect } from 'react';
import { Swords, Heart, Shield, Award, Sparkles, RotateCcw, ChevronRight, Zap } from 'lucide-react';
import type { Question } from '../../types';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import { useGame } from '../../context/GameContext';
import { useAuth } from '../../context/AuthContext';

interface BossBattleGameProps {
  onExit: () => void;
  chapterId?: string;
}

export const BossBattleGame: React.FC<BossBattleGameProps> = ({ onExit }) => {
  const { user } = useAuth();
  const { fireConfetti } = useGame();

  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [bossHp, setBossHp] = useState(100);
  const [playerLives, setPlayerLives] = useState(3);
  const [selectedOptionId, setSelectedOptionId] = useState<string | null>(null);
  const [isAnswerSubmitted, setIsAnswerSubmitted] = useState(false);
  const [battleLog, setBattleLog] = useState<string>('The Chapter Boss emerges! Answer correctly to deplete Boss HP.');
  const [isVictory, setIsVictory] = useState(false);
  const [isDefeated, setIsDefeated] = useState(false);

  const bossData = {
    name: 'Al-Mutanabbi: Sovereign of Verses',
    title: 'Abbasid Golden Era Climax Titan',
    avatar: '⚔️',
    totalHp: 100,
    damagePerHit: 25
  };

  useEffect(() => {
    const all = storage.getQuestions();
    const shuffled = [...all].sort(() => 0.5 - Math.random()).slice(0, 5);
    setQuestions(shuffled);
    setCurrentIndex(0);
    setBossHp(100);
    setPlayerLives(3);
    setIsVictory(false);
    setIsDefeated(false);
  }, []);

  const currentQ = questions[currentIndex];

  const handleSelectOption = (optId: string) => {
    if (isAnswerSubmitted || !currentQ) return;
    setIsAnswerSubmitted(true);
    setSelectedOptionId(optId);

    const opt = currentQ.options.find(o => o.id === optId);
    const isCorrect = !!opt?.isCorrect;

    if (isCorrect) {
      soundFX.playBossHit();
      const newHp = Math.max(0, bossHp - bossData.damagePerHit);
      setBossHp(newHp);
      setBattleLog(`💥 Critical Reasoning! You dealt ${bossData.damagePerHit} damage to ${bossData.name}!`);

      // Award XP
      storage.awardXp(20, 'Boss Battle direct strike', 'boss_defeat');

      if (newHp <= 0) {
        setIsVictory(true);
        soundFX.playLevelUp();
        fireConfetti();
        storage.awardXp(100, `Defeated Boss: ${bossData.name}`, 'boss_defeat');
      }
    } else {
      soundFX.playIncorrect();
      const nextLives = playerLives - 1;
      setPlayerLives(nextLives);
      setBattleLog(`🛡️ Incorrect! ${bossData.name} retaliated! You lost 1 heart.`);

      if (nextLives <= 0) {
        setIsDefeated(true);
      }
    }
  };

  const handleNextTurn = () => {
    if (currentIndex + 1 >= questions.length && bossHp > 0) {
      // Loop or finish
      if (playerLives > 0 && bossHp <= 25) {
        setIsVictory(true);
        fireConfetti();
      } else {
        setIsDefeated(true);
      }
      return;
    }

    setCurrentIndex(i => i + 1);
    setSelectedOptionId(null);
    setIsAnswerSubmitted(false);
  };

  if (!currentQ && !isVictory && !isDefeated) {
    return (
      <div className="p-8 text-center text-slate-400">
        <p>Summoning Chapter Boss...</p>
      </div>
    );
  }

  // --- VICTORY SCREEN ---
  if (isVictory) {
    return (
      <div className="max-w-xl mx-auto p-8 rounded-3xl bg-gradient-to-b from-indigo-950/80 via-slate-900 to-slate-950 border-2 border-amber-500/60 text-center shadow-2xl animate-in zoom-in-95">
        <div className="w-20 h-20 rounded-full bg-gradient-to-tr from-amber-500 to-orange-500 p-1 mx-auto mb-4 shadow-xl shadow-amber-500/30">
          <div className="w-full h-full rounded-full bg-slate-950 flex items-center justify-center text-3xl">
            🏆
          </div>
        </div>
        <span className="text-[10px] uppercase font-black tracking-widest text-amber-400 bg-amber-500/10 px-3 py-1 rounded-full border border-amber-500/30">
          Chapter Challenge Cleared
        </span>
        <h2 className="text-3xl font-black text-white font-['Outfit'] mt-3 mb-2">
          Boss Vanquished!
        </h2>
        <p className="text-xs text-slate-300 max-w-md mx-auto mb-6 leading-relaxed">
          You successfully defeated <span className="text-amber-300 font-bold">{bossData.name}</span>! Your chapter mastery and academic accuracy have been certified.
        </p>

        <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 mb-6 flex items-center justify-around">
          <div>
            <p className="text-[10px] text-slate-500 uppercase font-bold">Reward</p>
            <p className="text-lg font-black text-amber-400">+100 XP</p>
          </div>
          <div>
            <p className="text-[10px] text-slate-500 uppercase font-bold">Lives Preserved</p>
            <p className="text-lg font-black text-rose-400">{playerLives} / 3</p>
          </div>
          <div>
            <p className="text-[10px] text-slate-500 uppercase font-bold">Badge Unlocked</p>
            <p className="text-xs font-bold text-indigo-300">Boss Slayer</p>
          </div>
        </div>

        <button
          onClick={onExit}
          className="w-full py-3.5 rounded-2xl bg-gradient-to-r from-indigo-600 to-indigo-500 hover:from-indigo-500 hover:to-indigo-600 text-white font-bold text-sm shadow-xl shadow-indigo-600/30 transition-all hover:scale-[1.01]"
        >
          Return to Learning Path
        </button>
      </div>
    );
  }

  // --- DEFEAT SCREEN ---
  if (isDefeated) {
    return (
      <div className="max-w-xl mx-auto p-8 rounded-3xl bg-slate-900 border border-slate-800 text-center shadow-2xl animate-in zoom-in-95">
        <div className="w-16 h-16 rounded-2xl bg-rose-500/20 text-rose-400 flex items-center justify-center mx-auto mb-4 border border-rose-500/30 text-3xl">
          💀
        </div>
        <h2 className="text-2xl font-black text-white font-['Outfit'] mb-2">
          Out of Hearts!
        </h2>
        <p className="text-xs text-slate-300 max-w-sm mx-auto mb-6">
          The Boss overpowered your defenses. Review the chapter concepts or your Mistake Notebook before attempting again.
        </p>
        <div className="flex gap-3">
          <button
            onClick={() => {
              setBossHp(100);
              setPlayerLives(3);
              setCurrentIndex(0);
              setIsDefeated(false);
              setIsAnswerSubmitted(false);
            }}
            className="flex-1 py-3 rounded-xl bg-slate-800 hover:bg-slate-700 text-white font-bold text-xs flex items-center justify-center gap-2"
          >
            <RotateCcw className="w-4 h-4" />
            <span>Retry Boss</span>
          </button>
          <button
            onClick={onExit}
            className="flex-1 py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs"
          >
            Review Chapters
          </button>
        </div>
      </div>
    );
  }

  // --- ACTIVE BATTLE INTERFACE ---
  return (
    <div className="max-w-2xl mx-auto space-y-4 animate-in fade-in">
      
      {/* Top Bar */}
      <div className="flex items-center justify-between text-xs px-1">
        <button onClick={onExit} className="text-slate-400 hover:text-white">✕ Retract</button>
        <span className="font-bold text-amber-400 uppercase tracking-widest flex items-center gap-1">
          <Swords className="w-3.5 h-3.5" />
          <span>Boss Climax Encounter</span>
        </span>
        <div className="flex items-center gap-1">
          {[1, 2, 3].map(h => (
            <Heart 
              key={h}
              className={`w-4 h-4 transition-all ${
                h <= playerLives ? 'text-rose-500 fill-rose-500 scale-110' : 'text-slate-700'
              }`}
            />
          ))}
        </div>
      </div>

      {/* Boss Arena Card */}
      <div className="p-5 rounded-3xl bg-gradient-to-b from-indigo-950/40 via-slate-900 to-slate-950 border border-slate-800 shadow-xl relative overflow-hidden">
        
        {/* Boss Visual Header */}
        <div className="flex items-center gap-4 mb-4">
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-rose-600 to-red-800 flex items-center justify-center text-3xl shadow-lg shadow-rose-900/40 shrink-0">
            {bossData.avatar}
          </div>
          <div className="flex-1 min-w-0">
            <h3 className="text-base font-extrabold text-white truncate">{bossData.name}</h3>
            <p className="text-[11px] text-slate-400 truncate mb-2">{bossData.title}</p>
            
            {/* Boss HP Bar */}
            <div className="flex items-center gap-2">
              <div className="flex-1 h-3 rounded-full bg-slate-950 border border-slate-800 overflow-hidden">
                <div 
                  className="h-full bg-gradient-to-r from-red-600 via-rose-500 to-pink-500 transition-all duration-500"
                  style={{ width: `${bossHp}%` }}
                />
              </div>
              <span className="text-[11px] font-mono font-bold text-rose-400 shrink-0">{bossHp} HP</span>
            </div>
          </div>
        </div>

        {/* Battle Log ticker */}
        <div className="px-3.5 py-2 rounded-xl bg-slate-950/80 border border-slate-800/80 text-xs text-slate-300 font-mono mb-5 flex items-center gap-2">
          <Zap className="w-3.5 h-3.5 text-amber-400 shrink-0" />
          <span className="truncate">{battleLog}</span>
        </div>

        {/* Question Item */}
        <div className="pt-2 border-t border-slate-800/80">
          <span className="text-[10px] font-bold uppercase tracking-wider text-indigo-400 block mb-1">
            Question #{currentIndex + 1}
          </span>
          <p className="text-sm font-bold text-white mb-4 leading-relaxed">
            {currentQ.questionText}
          </p>

          {/* Options */}
          <div className="space-y-2.5 mb-4">
            {currentQ.options.map(opt => {
              let btnClass = 'border-slate-800 bg-slate-950/70 text-slate-200 hover:border-indigo-500/60';
              if (isAnswerSubmitted) {
                if (opt.isCorrect) {
                  btnClass = 'border-emerald-500 bg-emerald-500/20 text-emerald-300 font-bold';
                } else if (selectedOptionId === opt.id) {
                  btnClass = 'border-rose-500 bg-rose-500/20 text-rose-300 font-bold';
                } else {
                  btnClass = 'border-slate-800 bg-slate-950/30 text-slate-500';
                }
              }

              return (
                <button
                  key={opt.id}
                  disabled={isAnswerSubmitted}
                  onClick={() => handleSelectOption(opt.id)}
                  className={`w-full text-left p-3.5 rounded-2xl border text-xs sm:text-sm transition-all flex items-center justify-between ${btnClass}`}
                >
                  <span>{opt.text}</span>
                </button>
              );
            })}
          </div>

          {/* Turn Continuation */}
          {isAnswerSubmitted && (
            <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 animate-in fade-in">
              <p className="text-xs text-slate-300 mb-3">{currentQ.explanation}</p>
              <button
                onClick={handleNextTurn}
                className="w-full py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs flex items-center justify-center gap-1.5"
              >
                <span>Continue Battle</span>
                <ChevronRight className="w-4 h-4" />
              </button>
            </div>
          )}
        </div>

      </div>

    </div>
  );
};
