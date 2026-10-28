import React, { useState, useEffect } from 'react';
import { Layers, Clock, RotateCcw, Award, CheckCircle2 } from 'lucide-react';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import { useGame } from '../../context/GameContext';

interface MemoryCard {
  id: string;
  pairId: string;
  text: string;
  isFlipped: boolean;
  isMatched: boolean;
}

interface MemoryMatchGameProps {
  onExit: () => void;
}

export const MemoryMatchGame: React.FC<MemoryMatchGameProps> = ({ onExit }) => {
  const { fireConfetti } = useGame();
  const [cards, setCards] = useState<MemoryCard[]>([]);
  const [flippedCards, setFlippedCards] = useState<number[]>([]);
  const [matchedPairsCount, setMatchedPairsCount] = useState(0);
  const [flipsCount, setFlipsCount] = useState(0);
  const [elapsedTime, setElapsedTime] = useState(0);
  const [isCompleted, setIsCompleted] = useState(false);

  // Pre-configured authentic concepts pairs (Arabic, Malayalam, Teaching, Physics)
  const conceptPairs = [
    { id: 'p1', a: 'Imru’ al-Qays', b: 'Qifa Nabki (Mu’allaqah)' },
    { id: 'p2', a: 'Johann Herbart', b: 'Memory Level of Teaching' },
    { id: 'p3', a: 'Al-Jahiz', b: 'Kitab al-Bukhala' },
    { id: 'p4', a: 'Kumaran Asan', b: 'Veenapoovu (1907)' },
    { id: 'p5', a: 'Lev Vygotsky', b: 'Zone of Proximal Dev (ZPD)' },
    { id: 'p6', a: 'Isaac Newton', b: 'Laws of Motion (Principia)' }
  ];

  const totalPairs = conceptPairs.length;

  useEffect(() => {
    initDeck();
  }, []);

  const initDeck = () => {
    const deck: MemoryCard[] = [];
    conceptPairs.forEach((cp, idx) => {
      deck.push({
        id: `card_${idx}_a`,
        pairId: cp.id,
        text: cp.a,
        isFlipped: false,
        isMatched: false
      });
      deck.push({
        id: `card_${idx}_b`,
        pairId: cp.id,
        text: cp.b,
        isFlipped: false,
        isMatched: false
      });
    });

    // Shuffle deck
    deck.sort(() => 0.5 - Math.random());
    setCards(deck);
    setFlippedCards([]);
    setMatchedPairsCount(0);
    setFlipsCount(0);
    setElapsedTime(0);
    setIsCompleted(false);
  };

  // Timer
  useEffect(() => {
    if (isCompleted) return;
    const interval = setInterval(() => {
      setElapsedTime(t => t + 1);
    }, 1000);
    return () => clearInterval(interval);
  }, [isCompleted]);

  const handleCardClick = (index: number) => {
    if (cards[index].isFlipped || cards[index].isMatched || flippedCards.length >= 2) return;

    soundFX.playClick();
    const newCards = [...cards];
    newCards[index].isFlipped = true;
    setCards(newCards);

    const nextFlipped = [...flippedCards, index];
    setFlippedCards(nextFlipped);
    setFlipsCount(c => c + 1);

    if (nextFlipped.length === 2) {
      const firstIdx = nextFlipped[0];
      const secondIdx = nextFlipped[1];

      if (newCards[firstIdx].pairId === newCards[secondIdx].pairId) {
        // Match found!
        soundFX.playCorrect();
        newCards[firstIdx].isMatched = true;
        newCards[secondIdx].isMatched = true;
        setCards(newCards);
        setFlippedCards([]);
        const newCount = matchedPairsCount + 1;
        setMatchedPairsCount(newCount);

        if (newCount === totalPairs) {
          setIsCompleted(true);
          soundFX.playLevelUp();
          fireConfetti();
          storage.awardXp(60, 'Completed Memory Match Game', 'achievement');
        }
      } else {
        // Not a match, flip back after delay
        soundFX.playIncorrect();
        setTimeout(() => {
          const resetCards = [...newCards];
          resetCards[firstIdx].isFlipped = false;
          resetCards[secondIdx].isFlipped = false;
          setCards(resetCards);
          setFlippedCards([]);
        }, 900);
      }
    }
  };

  return (
    <div className="max-w-2xl mx-auto space-y-4 animate-in fade-in">
      
      {/* Top Header */}
      <div className="flex items-center justify-between text-xs px-1">
        <button onClick={onExit} className="text-slate-400 hover:text-white">✕ Quit</button>
        <div className="flex items-center gap-4">
          <span className="font-mono text-slate-300">Flips: {flipsCount}</span>
          <span className="flex items-center gap-1 font-mono text-amber-400 font-bold">
            <Clock className="w-3.5 h-3.5" />
            <span>{elapsedTime}s</span>
          </span>
          <span className="text-emerald-400 font-bold">Pairs: {matchedPairsCount}/{totalPairs}</span>
        </div>
      </div>

      {/* Completion View */}
      {isCompleted ? (
        <div className="p-8 rounded-3xl bg-slate-900 border border-slate-800 text-center shadow-2xl animate-in zoom-in-95">
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-purple-600 to-indigo-600 flex items-center justify-center mx-auto mb-4 text-white shadow-lg">
            <Award className="w-8 h-8" />
          </div>
          <h2 className="text-2xl font-black text-white font-['Outfit'] mb-1">
            Memory Match Mastered!
          </h2>
          <p className="text-xs text-slate-300 mb-6">
            You paired all {totalPairs} academic concepts in {elapsedTime} seconds with {flipsCount} flips.
          </p>

          {/* Matched Concepts Review */}
          <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 text-left mb-6 space-y-2">
            <p className="text-[11px] font-bold text-indigo-400 uppercase tracking-wider mb-2">Matched Key Relationships:</p>
            {conceptPairs.map(cp => (
              <div key={cp.id} className="flex items-center justify-between text-xs border-b border-slate-900 pb-1.5">
                <span className="font-semibold text-white">{cp.a}</span>
                <span className="text-slate-400">↔ {cp.b}</span>
              </div>
            ))}
          </div>

          <div className="flex gap-3">
            <button
              onClick={initDeck}
              className="flex-1 py-3 rounded-xl bg-slate-800 hover:bg-slate-700 text-white font-bold text-xs flex items-center justify-center gap-2"
            >
              <RotateCcw className="w-4 h-4" />
              <span>Shuffle & Play Again</span>
            </button>
            <button
              onClick={onExit}
              className="flex-1 py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs"
            >
              Back to Games
            </button>
          </div>
        </div>
      ) : (
        /* Card Grid */
        <div className="grid grid-cols-3 sm:grid-cols-4 gap-3">
          {cards.map((card, idx) => (
            <div
              key={card.id}
              onClick={() => handleCardClick(idx)}
              className={`cursor-pointer h-24 rounded-2xl border p-2 flex items-center justify-center text-center transition-all duration-300 select-none ${
                card.isMatched
                  ? 'bg-emerald-950/40 border-emerald-500/50 text-emerald-300 font-bold scale-95 shadow-inner'
                  : card.isFlipped
                  ? 'bg-indigo-900/60 border-indigo-400 text-white font-semibold shadow-lg'
                  : 'bg-slate-900 border-slate-800 hover:border-slate-700 hover:bg-slate-850 text-slate-500'
              }`}
            >
              {card.isFlipped || card.isMatched ? (
                <span className="text-xs leading-tight animate-in fade-in">
                  {card.text}
                </span>
              ) : (
                <Layers className="w-5 h-5 text-slate-700" />
              )}
            </div>
          ))}
        </div>
      )}

    </div>
  );
};
