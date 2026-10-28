import React, { useState, useEffect } from 'react';
import { Swords, Clock, Trophy, Award, Zap, ChevronRight, RotateCcw, Check, X } from 'lucide-react';
import type { Question } from '../../types';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import { useAuth } from '../../context/AuthContext';
import { useGame } from '../../context/GameContext';

interface Battle1v1GameProps {
  onExit: () => void;
}

export const Battle1v1Game: React.FC<Battle1v1GameProps> = ({ onExit }) => {
  const { user } = useAuth();
  const { fireConfetti } = useGame();

  const [matchmakingState, setMatchmakingState] = useState<'searching' | 'matched' | 'battling' | 'finished'>('searching');
  const [opponent, setOpponent] = useState({
    name: 'Dr. Fathima Zahra',
    avatar: '👩‍🏫',
    level: 24,
    score: 0
  });

  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [playerScore, setPlayerScore] = useState(0);
  const [opponentScore, setOpponentScore] = useState(0);
  const [timerRemaining, setTimerRemaining] = useState(15);
  const [playerSelectedOpt, setPlayerSelectedOpt] = useState<string | null>(null);
  const [roundCompleted, setRoundCompleted] = useState(false);
  const [roundResults, setRoundResults] = useState<{ qText: string; playerCorrect: boolean; opponentCorrect: boolean }[]>([]);

  // 1. Matchmaking simulation
  useEffect(() => {
    const questionsPool = storage.getQuestions().slice(0, 5);
    setQuestions(questionsPool);

    const timer = setTimeout(() => {
      setMatchmakingState('matched');
      soundFX.playClick();
      const battleTimer = setTimeout(() => {
        setMatchmakingState('battling');
        setCurrentIndex(0);
        setPlayerScore(0);
        setOpponentScore(0);
        setTimerRemaining(15);
      }, 1800);
      return () => clearTimeout(battleTimer);
    }, 2000);

    return () => clearTimeout(timer);
  }, []);

  // 2. Round Timer
  useEffect(() => {
    if (matchmakingState !== 'battling' || roundCompleted) return;

    const interval = setInterval(() => {
      setTimerRemaining(t => {
        if (t <= 1) {
          handleRoundTimeout();
          return 0;
        }
        return t - 1;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [matchmakingState, roundCompleted, currentIndex]);

  const handleRoundTimeout = () => {
    handlePlayerAnswer(null);
  };

  const currentQ = questions[currentIndex];

  const handlePlayerAnswer = (optId: string | null) => {
    if (roundCompleted || !currentQ) return;
    setRoundCompleted(true);
    setPlayerSelectedOpt(optId);

    const opt = currentQ.options.find(o => o.id === optId);
    const isPlayerCorrect = !!opt?.isCorrect;

    // Simulate opponent response (75% probability of correct answer)
    const isOpponentCorrect = Math.random() < 0.75;

    let nextPlayerScore = playerScore;
    let nextOpponentScore = opponentScore;

    if (isPlayerCorrect) {
      soundFX.playCorrect();
      nextPlayerScore += 10 + Math.floor(timerRemaining / 2); // speed bonus
      setPlayerScore(nextPlayerScore);
    } else {
      soundFX.playIncorrect();
    }

    if (isOpponentCorrect) {
      nextOpponentScore += 10 + Math.floor(Math.random() * 5);
      setOpponentScore(nextOpponentScore);
    }

    setRoundResults(prev => [
      ...prev,
      {
        qText: currentQ.questionText,
        playerCorrect: isPlayerCorrect,
        opponentCorrect: isOpponentCorrect
      }
    ]);
  };

  const handleNextRound = () => {
    if (currentIndex + 1 >= questions.length) {
      setMatchmakingState('finished');
      if (playerScore >= opponentScore) {
        soundFX.playLevelUp();
        fireConfetti();
        storage.awardXp(80, '1v1 Battle Victory', 'battle');
      } else {
        storage.awardXp(30, '1v1 Battle Participation', 'battle');
      }
      return;
    }

    setCurrentIndex(i => i + 1);
    setPlayerSelectedOpt(null);
    setRoundCompleted(false);
    setTimerRemaining(15);
  };

  // --- MATCHMAKING RADAR SCREEN ---
  if (matchmakingState === 'searching' || matchmakingState === 'matched') {
    return (
      <div className="max-w-md mx-auto p-8 rounded-3xl bg-slate-900 border border-slate-800 text-center shadow-2xl">
        <div className="relative w-32 h-32 mx-auto mb-6 flex items-center justify-center">
          <div className="absolute inset-0 rounded-full border-2 border-indigo-500/30 animate-ping"></div>
          <div className="absolute inset-4 rounded-full border border-indigo-500/50 animate-pulse"></div>
          <div className="w-20 h-20 rounded-full bg-gradient-to-tr from-indigo-600 to-purple-600 flex items-center justify-center text-3xl shadow-xl shadow-indigo-500/30">
            <Swords className="w-10 h-10 text-white" />
          </div>
        </div>

        <h3 className="text-xl font-black text-white font-['Outfit'] mb-1">
          {matchmakingState === 'searching' ? 'Searching for Match...' : 'Opponent Found!'}
        </h3>
        <p className="text-xs text-slate-400 mb-6">
          {matchmakingState === 'searching' 
            ? 'Matching with a peer in your examination division...' 
            : `Matched with ${opponent.name} (Level ${opponent.level})`}
        </p>

        <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 flex items-center justify-around text-xs">
          <div className="flex items-center gap-2">
            <span className="text-xl">{user.avatar}</span>
            <span className="font-bold text-white">{user.name}</span>
          </div>
          <span className="font-black text-indigo-400">VS</span>
          <div className="flex items-center gap-2">
            <span className="text-xl">{opponent.avatar}</span>
            <span className="font-bold text-slate-300">{opponent.name}</span>
          </div>
        </div>
      </div>
    );
  }

  // --- FINAL COMPARISON SCREEN ---
  if (matchmakingState === 'finished') {
    const isWin = playerScore > opponentScore;
    const isTie = playerScore === opponentScore;

    return (
      <div className="max-w-xl mx-auto p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-2xl animate-in zoom-in-95">
        <div className="text-center mb-6">
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-amber-500 to-orange-500 flex items-center justify-center mx-auto mb-3 text-white shadow-xl shadow-amber-500/30">
            <Trophy className="w-8 h-8" />
          </div>
          <h2 className="text-2xl font-black text-white font-['Outfit']">
            {isWin ? 'Victory! You Won the Battle!' : isTie ? 'Honorable Tie!' : 'Battle Concluded'}
          </h2>
          <p className="text-xs text-slate-400 mt-1">
            {isWin ? 'Bonus +80 XP awarded for triumphing in live synchronous combat.' : 'Keep honing your accuracy for the next duel.'}
          </p>
        </div>

        {/* Scoreboard Bar */}
        <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 mb-6">
          <div className="flex items-center justify-between text-xs font-bold mb-2">
            <span className="text-indigo-400">{user.name}: {playerScore} pts</span>
            <span className="text-rose-400">{opponent.name}: {opponentScore} pts</span>
          </div>
          <div className="h-3 rounded-full bg-slate-900 overflow-hidden flex">
            <div 
              className="bg-indigo-500 transition-all duration-500"
              style={{ width: `${(playerScore / (playerScore + opponentScore || 1)) * 100}%` }}
            />
            <div 
              className="bg-rose-500 transition-all duration-500"
              style={{ width: `${(opponentScore / (playerScore + opponentScore || 1)) * 100}%` }}
            />
          </div>
        </div>

        {/* Round by Round comparison */}
        <div className="space-y-2 mb-6">
          <p className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2">Round by Round Summary:</p>
          {roundResults.map((res, idx) => (
            <div key={idx} className="p-3 rounded-xl bg-slate-950/70 border border-slate-800 flex items-center justify-between text-xs">
              <span className="font-semibold text-slate-300 truncate max-w-[240px]">Q{idx + 1}: {res.qText}</span>
              <div className="flex items-center gap-4 shrink-0 font-mono text-[11px]">
                <span className={res.playerCorrect ? 'text-emerald-400' : 'text-rose-400'}>
                  You: {res.playerCorrect ? '✓' : '✗'}
                </span>
                <span className={res.opponentCorrect ? 'text-emerald-400' : 'text-rose-400'}>
                  Opp: {res.opponentCorrect ? '✓' : '✗'}
                </span>
              </div>
            </div>
          ))}
        </div>

        <button
          onClick={onExit}
          className="w-full py-3.5 rounded-2xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs"
        >
          Back to Game Arena
        </button>
      </div>
    );
  }

  // --- ACTIVE BATTLE INTERFACE ---
  return (
    <div className="max-w-2xl mx-auto space-y-4 animate-in fade-in">
      
      {/* Top Real-time Battle Header */}
      <div className="p-4 rounded-2xl bg-slate-900 border border-slate-800 shadow-lg">
        <div className="flex items-center justify-between mb-3 text-xs">
          <div className="flex items-center gap-2">
            <span className="text-base">{user.avatar}</span>
            <div>
              <p className="font-bold text-white">{user.name}</p>
              <p className="text-indigo-400 font-mono font-black">{playerScore} pts</p>
            </div>
          </div>

          {/* Synchronized Round Timer */}
          <div className="flex flex-col items-center">
            <div className="w-10 h-10 rounded-full bg-slate-950 border border-amber-500/40 flex items-center justify-center font-mono font-black text-amber-400 text-sm">
              {timerRemaining}
            </div>
            <span className="text-[9px] text-slate-500 mt-0.5 uppercase tracking-wider">Round {currentIndex + 1}/5</span>
          </div>

          <div className="flex items-center gap-2 text-right">
            <div>
              <p className="font-bold text-slate-300">{opponent.name}</p>
              <p className="text-rose-400 font-mono font-black">{opponentScore} pts</p>
            </div>
            <span className="text-base">{opponent.avatar}</span>
          </div>
        </div>

        {/* Live Tug of War Progress Bar */}
        <div className="h-2 rounded-full bg-slate-950 overflow-hidden flex">
          <div 
            className="bg-indigo-500 transition-all duration-300"
            style={{ width: `${(playerScore / (playerScore + opponentScore || 1)) * 100}%` }}
          />
          <div 
            className="bg-rose-500 transition-all duration-300"
            style={{ width: `${(opponentScore / (playerScore + opponentScore || 1)) * 100}%` }}
          />
        </div>
      </div>

      {/* Synchronized Question Card */}
      {currentQ && (
        <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl">
          <h3 className="text-base sm:text-lg font-bold text-white mb-6 leading-relaxed">
            {currentQ.questionText}
          </h3>

          <div className="space-y-2.5 mb-4">
            {currentQ.options.map(opt => {
              let btnClass = 'border-slate-800 bg-slate-950/70 text-slate-200 hover:border-indigo-500/60';
              if (roundCompleted) {
                if (opt.isCorrect) {
                  btnClass = 'border-emerald-500 bg-emerald-500/20 text-emerald-300 font-bold';
                } else if (playerSelectedOpt === opt.id) {
                  btnClass = 'border-rose-500 bg-rose-500/20 text-rose-300 font-bold';
                } else {
                  btnClass = 'border-slate-800 bg-slate-950/30 text-slate-500';
                }
              }

              return (
                <button
                  key={opt.id}
                  disabled={roundCompleted}
                  onClick={() => handlePlayerAnswer(opt.id)}
                  className={`w-full text-left p-3.5 rounded-2xl border text-xs sm:text-sm transition-all flex items-center justify-between ${btnClass}`}
                >
                  <span>{opt.text}</span>
                </button>
              );
            })}
          </div>

          {roundCompleted && (
            <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 animate-in fade-in">
              <p className="text-xs text-slate-300 mb-3">{currentQ.explanation}</p>
              <button
                onClick={handleNextRound}
                className="w-full py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs flex items-center justify-center gap-1.5"
              >
                <span>{currentIndex + 1 >= questions.length ? 'See Final Comparison' : 'Next Round'}</span>
                <ChevronRight className="w-4 h-4" />
              </button>
            </div>
          )}
        </div>
      )}

    </div>
  );
};
