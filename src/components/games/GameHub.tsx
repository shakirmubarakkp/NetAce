import React, { useState } from 'react';
import { 
  Zap, 
  Clock, 
  Swords, 
  Layers, 
  RotateCcw, 
  GraduationCap, 
  Sparkles, 
  ShieldAlert, 
  Users, 
  Flame, 
  Search, 
  Lock, 
  CheckCircle2, 
  Award,
  BookOpen,
  ArrowRight,
  Trophy
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useGame } from '../../context/GameContext';

interface GameHubProps {
  onSelectGame: (gameMode: string) => void;
}

export const GameHub: React.FC<GameHubProps> = ({ onSelectGame }) => {
  const { isPremium } = useAuth();
  const { openUpgradeModal } = useGame();
  const [filterCategory, setFilterCategory] = useState<string>('all');
  const [searchQuery, setSearchQuery] = useState<string>('');

  const games = [
    {
      id: 'quick_quiz',
      title: '1. Quick Quiz',
      category: 'solo',
      desc: 'Answer 5, 10, or 20 curated questions with instant solutions, accuracy, and XP rewards.',
      icon: Zap,
      color: 'from-blue-600 to-indigo-700',
      badge: 'Starter',
      isFree: true
    },
    {
      id: 'speed_rush',
      title: '2. Speed Rush',
      category: 'rapid',
      desc: 'Beat the ticking clock! Rapid answers earn time bonus multipliers. Includes relaxed mode.',
      icon: Clock,
      color: 'from-amber-500 to-orange-600',
      badge: 'Timed',
      isFree: true
    },
    {
      id: 'knowledge_ladder',
      title: '4. Knowledge Ladder',
      category: 'challenge',
      desc: 'Ascend through Easy, Medium, and Hard rungs. Reach 75% accuracy to unlock the next rung.',
      icon: Award,
      color: 'from-emerald-600 to-teal-700',
      badge: 'Mastery',
      isFree: true
    },
    {
      id: 'boss_battle',
      title: '5. Chapter Boss Battle',
      category: 'challenge',
      desc: 'Face the end-of-chapter academic titan. Manage 3 lives, deplete Boss HP, and win exclusive badges.',
      icon: Swords,
      color: 'from-rose-600 to-red-800',
      badge: 'Epic',
      isFree: true
    },
    {
      id: 'memory_match',
      title: '6. Memory Match',
      category: 'rapid',
      desc: 'Flip and match authors, books, formulas, and terminology pairs against time.',
      icon: Layers,
      color: 'from-purple-600 to-indigo-800',
      badge: 'Memory',
      isFree: true
    },
    {
      id: 'fill_the_gap',
      title: '7. Fill the Gap',
      category: 'solo',
      desc: 'Identify the missing academic keyword, definition token, or formula variable.',
      icon: CheckCircle2,
      color: 'from-cyan-600 to-blue-700',
      badge: 'Core',
      isFree: true
    },
    {
      id: 'true_false',
      title: '8. True or False Challenge',
      category: 'rapid',
      desc: 'Rapid-fire concept drill. Evaluate academic statements under time pressure.',
      icon: Zap,
      color: 'from-emerald-500 to-green-700',
      badge: 'Fast',
      isFree: true
    },
    {
      id: 'elimination',
      title: '9. Elimination Challenge',
      category: 'challenge',
      desc: 'Use 50:50 lifelines to eliminate distractor options and cultivate deduction skills.',
      icon: ShieldAlert,
      color: 'from-amber-600 to-yellow-700',
      badge: 'Lifelines',
      isFree: true
    },
    {
      id: 'match_pairs',
      title: '10. Match the Pairs',
      category: 'solo',
      desc: 'Connect matching columns: Classical authors, dates, laws, and Malayalam/Arabic works.',
      icon: Layers,
      color: 'from-indigo-600 to-violet-800',
      badge: 'Pairs',
      isFree: true
    },
    {
      id: 'survival',
      title: '11. Survival Mode',
      category: 'challenge',
      desc: 'Endless question gauntlet. 3 mistakes and game over. How high can you climb?',
      icon: Flame,
      color: 'from-orange-600 to-rose-700',
      badge: 'Hardcore',
      isFree: false
    },
    {
      id: 'weak_topic_rescue',
      title: '12. Weak Topic Rescue',
      category: 'revision',
      desc: 'Customized revision generated strictly from past mistakes and low-accuracy topics.',
      icon: RotateCcw,
      color: 'from-rose-500 to-pink-700',
      badge: 'Spaced',
      isFree: true
    },
    {
      id: 'pyq_machine',
      title: '13. PYQ Time Machine',
      category: 'revision',
      desc: 'Select 2023, 2022, or 2021 official examination papers and test with verified PYQs.',
      icon: GraduationCap,
      color: 'from-blue-700 to-indigo-900',
      badge: 'Official PYQ',
      isFree: false
    },
    {
      id: 'battle_1v1',
      title: '14. 1v1 Quiz Battle',
      category: 'multiplayer',
      desc: 'Synchronous real-time battle against peers or smart bots with live score synchronization.',
      icon: Swords,
      color: 'from-indigo-600 to-purple-800',
      badge: 'Live PVP',
      isFree: false
    },
    {
      id: 'team_battle',
      title: '15. Team Battle',
      category: 'multiplayer',
      desc: 'Create or join a team room code. Pool collective correct answers for group victory.',
      icon: Users,
      color: 'from-emerald-600 to-cyan-700',
      badge: 'Co-op',
      isFree: false
    },
    {
      id: 'flashcard_arena',
      title: '17. Formula & Flashcards',
      category: 'revision',
      desc: 'Spaced repetition flashcards with SM-2 scheduling (Again, Hard, Good, Easy ratings).',
      icon: BookOpen,
      color: 'from-violet-600 to-fuchsia-700',
      badge: 'SM-2 Repetition',
      isFree: true
    },
    {
      id: 'mock_exam',
      title: '18. Full NTA Mock Exam',
      category: 'challenge',
      desc: 'Official exam replica: question palette (Answered, Unanswered, Marked for Review), negative marking.',
      icon: Clock,
      color: 'from-slate-700 to-slate-900',
      badge: 'Simulated Exam',
      isFree: false
    },
    {
      id: 'daily_tournament',
      title: '19. Daily Tournament',
      category: 'multiplayer',
      desc: 'Compete in the scheduled daily global quiz tournament with prize XP pools.',
      icon: Trophy,
      color: 'from-amber-500 to-yellow-600',
      badge: 'Global Prize',
      isFree: false
    },
    {
      id: 'error_hunter',
      title: '20. Error Hunter',
      category: 'challenge',
      desc: 'Inspect worked derivations and academic arguments to spot intentional flaws.',
      icon: Sparkles,
      color: 'from-pink-600 to-rose-700',
      badge: 'Critical Mind',
      isFree: true
    }
  ];

  const filteredGames = games.filter(g => {
    const matchesCat = filterCategory === 'all' || g.category === filterCategory;
    const matchesSearch = g.title.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          g.desc.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCat && matchesSearch;
  });

  const handleLaunch = (game: typeof games[0]) => {
    if (!game.isFree && !isPremium) {
      openUpgradeModal(game.title);
      return;
    }
    onSelectGame(game.id);
  };

  return (
    <div className="space-y-6 pb-12 animate-in fade-in">
      
      {/* Header Banner */}
      <div className="rounded-3xl bg-gradient-to-r from-indigo-900/60 via-slate-900 to-indigo-950/40 border border-indigo-500/30 p-6 shadow-xl flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-indigo-500/10 border border-indigo-500/30 text-indigo-300 text-xs font-bold mb-2">
            <Sparkles className="w-3.5 h-3.5 text-amber-400" />
            <span>20 EDUCATIONAL GAME MODES</span>
          </div>
          <h2 className="text-2xl sm:text-3xl font-black text-white font-['Outfit']">
            Study Games Arena
          </h2>
          <p className="text-xs sm:text-sm text-slate-300 mt-1 max-w-xl">
            Choose a game mode that matches your study mood: fast-paced speed drills, deep boss battles, flashcards, or real-time 1v1 duels.
          </p>
        </div>

        {/* Search Input */}
        <div className="relative w-full md:w-64">
          <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
          <input 
            type="text"
            placeholder="Search game modes..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-9 pr-3 py-2 rounded-xl bg-slate-950 border border-slate-700 text-xs text-white placeholder-slate-500 focus:outline-none focus:border-indigo-500"
          />
        </div>
      </div>

      {/* Category Pills */}
      <div className="flex items-center gap-2 overflow-x-auto pb-1 text-xs">
        {[
          { id: 'all', label: 'All 20 Modes' },
          { id: 'solo', label: 'Solo Practice' },
          { id: 'rapid', label: 'Speed & Memory' },
          { id: 'challenge', label: 'Bosses & Ladders' },
          { id: 'revision', label: 'Revision & PYQs' },
          { id: 'multiplayer', label: 'Multiplayer Battles' }
        ].map(cat => (
          <button
            key={cat.id}
            onClick={() => setFilterCategory(cat.id)}
            className={`px-3.5 py-1.5 rounded-xl font-bold whitespace-nowrap transition-colors ${
              filterCategory === cat.id
                ? 'bg-indigo-600 text-white shadow-md shadow-indigo-600/30'
                : 'bg-slate-900 border border-slate-800 text-slate-400 hover:text-white'
            }`}
          >
            {cat.label}
          </button>
        ))}
      </div>

      {/* Game Cards Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredGames.map(game => {
          const Icon = game.icon;
          const isLocked = !game.isFree && !isPremium;

          return (
            <div
              key={game.id}
              onClick={() => handleLaunch(game)}
              className={`cursor-pointer group relative p-5 rounded-2xl bg-slate-900 border transition-all hover:-translate-y-1 shadow-lg ${
                isLocked 
                  ? 'border-slate-800 hover:border-amber-500/50' 
                  : 'border-slate-800 hover:border-indigo-500/50'
              }`}
            >
              <div className="flex items-start justify-between mb-4">
                <div className={`w-12 h-12 rounded-xl bg-gradient-to-tr ${game.color} flex items-center justify-center text-white shadow-md group-hover:scale-105 transition-transform`}>
                  <Icon className="w-6 h-6" />
                </div>
                <div className="flex items-center gap-1.5">
                  <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-slate-800 text-slate-300 border border-slate-700">
                    {game.badge}
                  </span>
                  {isLocked && (
                    <span className="p-1 rounded-full bg-amber-500/20 text-amber-400 border border-amber-500/40">
                      <Lock className="w-3 h-3" />
                    </span>
                  )}
                </div>
              </div>

              <h3 className="text-base font-bold text-white group-hover:text-indigo-300 transition-colors mb-1.5">
                {game.title}
              </h3>
              <p className="text-xs text-slate-400 leading-relaxed mb-4 min-h-[36px]">
                {game.desc}
              </p>

              <div className="flex items-center justify-between text-xs pt-3 border-t border-slate-800/80">
                <span className={`font-bold ${isLocked ? 'text-amber-400' : 'text-emerald-400'}`}>
                  {isLocked ? 'PRO Feature' : 'Free Play'}
                </span>
                <span className="flex items-center gap-1 text-slate-300 group-hover:translate-x-1 transition-transform font-semibold">
                  <span>{isLocked ? 'Unlock' : 'Play Now'}</span>
                  <ArrowRight className="w-3.5 h-3.5 text-indigo-400" />
                </span>
              </div>
            </div>
          );
        })}
      </div>

    </div>
  );
};
