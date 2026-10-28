import React, { useState } from 'react';
import { BookOpen, RotateCcw, Check, Clock, Award, Sparkles, ChevronRight } from 'lucide-react';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import { useGame } from '../../context/GameContext';

interface Flashcard {
  id: string;
  front: string;
  back: string;
  subject: string;
  category: string;
}

interface FlashcardArenaGameProps {
  onExit: () => void;
}

export const FlashcardArenaGame: React.FC<FlashcardArenaGameProps> = ({ onExit }) => {
  const { fireConfetti } = useGame();

  const [cards] = useState<Flashcard[]>([
    {
      id: 'fc_1',
      front: 'Maurice P. Hunt: Reflective Level of Teaching (RLT)',
      back: 'Focuses on authentic problem-solving, cognitive autonomy, open-ended critical inquiry, and self-evaluation.',
      subject: 'Teaching Aptitude',
      category: 'Pedagogy'
    },
    {
      id: 'fc_2',
      front: 'Jahiliyyah Mu’allaqat: Author of "Qifa Nabki"',
      back: 'Imru’ al-Qays ibn Hujr al-Kindi (امرؤ القيس) — The Vagabond King. Opens with the weeping over deserted dunes at Siqt al-Liwa.',
      subject: 'UGC NET Arabic',
      category: 'Classical Literature'
    },
    {
      id: 'fc_3',
      front: '1907 Veenapoovu (വീണപൂവ്) Significance',
      back: 'Written by Mahakavi Kumaran Asan. Inaugurated the Romantic movement (കാല്പനികത) in modern Malayalam poetry.',
      subject: 'UGC NET Malayalam',
      category: 'Poetry Movements'
    },
    {
      id: 'fc_4',
      front: 'Optimum Road Banking Velocity (v_opt)',
      back: 'v = √(R * g * tan θ), where R is radius of curvature, g is gravitational acceleration, and θ is the angle of banking.',
      subject: 'JEE Main Physics',
      category: 'Mechanics'
    },
    {
      id: 'fc_5',
      front: 'Zone of Proximal Development (ZPD)',
      back: 'Lev Vygotsky: The distance between actual development level determined by independent problem solving and the potential level achieved through scaffolding.',
      subject: 'KTET Pedagogy',
      category: 'Cognitive Theories'
    }
  ]);

  const [currentIndex, setCurrentIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [reviewedCount, setReviewedCount] = useState(0);
  const [isCompleted, setIsCompleted] = useState(false);

  const currentCard = cards[currentIndex];

  const handleRating = (rating: 'again' | 'hard' | 'good' | 'easy') => {
    soundFX.playClick();
    let earnedXp = 5;
    if (rating === 'easy') earnedXp = 15;
    else if (rating === 'good') earnedXp = 10;

    storage.awardXp(earnedXp, `Flashcard review (${rating})`, 'quiz');

    setReviewedCount(c => c + 1);

    if (currentIndex + 1 >= cards.length) {
      setIsCompleted(true);
      soundFX.playLevelUp();
      fireConfetti();
    } else {
      setCurrentIndex(i => i + 1);
      setIsFlipped(false);
    }
  };

  if (isCompleted) {
    return (
      <div className="max-w-xl mx-auto p-8 rounded-3xl bg-slate-900 border border-slate-800 text-center shadow-2xl animate-in zoom-in-95">
        <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-violet-600 to-fuchsia-600 flex items-center justify-center mx-auto mb-4 text-white shadow-lg">
          <Award className="w-8 h-8" />
        </div>
        <h2 className="text-2xl font-black text-white font-['Outfit'] mb-2">
          Arena Review Session Completed!
        </h2>
        <p className="text-xs text-slate-300 mb-6">
          You reviewed all {cards.length} spaced repetition concept cards. Concepts rated "Again" and "Hard" are queued for tomorrow.
        </p>
        <button
          onClick={onExit}
          className="w-full py-3.5 rounded-2xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs"
        >
          Return to Games
        </button>
      </div>
    );
  }

  return (
    <div className="max-w-xl mx-auto space-y-4 animate-in fade-in">
      
      {/* Top Bar */}
      <div className="flex items-center justify-between text-xs px-1">
        <button onClick={onExit} className="text-slate-400 hover:text-white">✕ Exit</button>
        <span className="text-indigo-400 font-bold uppercase tracking-wider">Formula & Flashcards</span>
        <span className="font-mono text-slate-400">Card {currentIndex + 1} of {cards.length}</span>
      </div>

      {/* Progress */}
      <div className="w-full h-1.5 rounded-full bg-slate-900 overflow-hidden">
        <div 
          className="h-full bg-gradient-to-r from-violet-500 to-fuchsia-500 transition-all"
          style={{ width: `${((currentIndex + 1) / cards.length) * 100}%` }}
        />
      </div>

      {/* Flashcard Item with 3D Flip */}
      <div
        onClick={() => { setIsFlipped(!isFlipped); soundFX.playClick(); }}
        className="cursor-pointer min-h-[280px] rounded-3xl bg-gradient-to-b from-slate-900 via-slate-900 to-slate-950 border-2 border-slate-700/80 hover:border-violet-500/50 p-6 flex flex-col justify-between shadow-2xl transition-all select-none"
      >
        <div className="flex items-center justify-between">
          <span className="text-[10px] uppercase font-bold tracking-wider px-2.5 py-0.5 rounded-full bg-violet-500/20 text-violet-300 border border-violet-500/30">
            {currentCard.subject} • {currentCard.category}
          </span>
          <span className="text-[11px] text-slate-500">Tap to flip ↺</span>
        </div>

        <div className="my-auto text-center py-4">
          {!isFlipped ? (
            <div>
              <p className="text-[11px] text-slate-400 uppercase tracking-widest font-bold mb-2">Prompt / Term</p>
              <h3 className="text-xl sm:text-2xl font-black text-white leading-relaxed font-['Outfit']">
                {currentCard.front}
              </h3>
            </div>
          ) : (
            <div className="animate-in fade-in duration-200">
              <p className="text-[11px] text-emerald-400 uppercase tracking-widest font-bold mb-2">Definition / Law / Solution</p>
              <p className="text-base text-slate-200 leading-relaxed font-medium">
                {currentCard.back}
              </p>
            </div>
          )}
        </div>

        <p className="text-[10px] text-center text-slate-500">
          {!isFlipped ? 'Reveal definition & explanation' : 'Rate your memory retention below'}
        </p>
      </div>

      {/* SM-2 Spaced Repetition Rating Buttons */}
      {isFlipped ? (
        <div className="grid grid-cols-4 gap-2 pt-2 animate-in fade-in">
          <button
            onClick={() => handleRating('again')}
            className="p-3 rounded-2xl bg-rose-950/40 border border-rose-500/40 hover:bg-rose-900/60 text-center transition-colors"
          >
            <p className="text-xs font-bold text-rose-300">Again</p>
            <p className="text-[10px] text-slate-400 mt-0.5">&lt; 10 min</p>
          </button>
          <button
            onClick={() => handleRating('hard')}
            className="p-3 rounded-2xl bg-amber-950/40 border border-amber-500/40 hover:bg-amber-900/60 text-center transition-colors"
          >
            <p className="text-xs font-bold text-amber-300">Hard</p>
            <p className="text-[10px] text-slate-400 mt-0.5">1 Day</p>
          </button>
          <button
            onClick={() => handleRating('good')}
            className="p-3 rounded-2xl bg-blue-950/40 border border-blue-500/40 hover:bg-blue-900/60 text-center transition-colors"
          >
            <p className="text-xs font-bold text-blue-300">Good</p>
            <p className="text-[10px] text-slate-400 mt-0.5">3 Days</p>
          </button>
          <button
            onClick={() => handleRating('easy')}
            className="p-3 rounded-2xl bg-emerald-950/40 border border-emerald-500/40 hover:bg-emerald-900/60 text-center transition-colors"
          >
            <p className="text-xs font-bold text-emerald-300">Easy</p>
            <p className="text-[10px] text-slate-400 mt-0.5">7 Days</p>
          </button>
        </div>
      ) : (
        <div className="text-center py-2">
          <span className="text-xs text-slate-400">Click the card to reveal the reverse side and schedule next review</span>
        </div>
      )}

    </div>
  );
};
