import React, { useState } from 'react';
import { 
  Flame, 
  Award, 
  Target, 
  Gamepad2, 
  Compass,
  Sparkles, 
  ChevronRight, 
  RotateCcw, 
  Clock, 
  Trophy, 
  TrendingUp, 
  ArrowUpRight, 
  Crown, 
  FileText,
  Zap,
  Swords,
  BookOpen,
  CheckCircle2,
  Calendar
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useGame } from '../../context/GameContext';
import { storage } from '../../services/storageService';
import { PdfService } from '../../services/pdfService';
import { INITIAL_EXAMINATIONS } from '../../data/initialData';

interface StudentDashboardProps {
  onNavigate: (route: string) => void;
  onLaunchGame: (gameMode: string, topicId?: string) => void;
}

export const StudentDashboard: React.FC<StudentDashboardProps> = ({ onNavigate, onLaunchGame }) => {
  const { user, isPremium, refreshUser } = useAuth();
  const { openUpgradeModal, fireConfetti } = useGame();

  const [quests, setQuests] = useState(() => storage.getDailyQuests());
  const attempts = storage.getAttempts();
  const mistakes = storage.getMistakes().filter(m => !m.isResolved);
  const badges = storage.getBadges();
  const leaderboard = storage.getLeaderboard();

  const currentExam = INITIAL_EXAMINATIONS.find(e => e.id === user.targetExamId) || INITIAL_EXAMINATIONS[0];
  const levelInfo = storage.getLevelFromXp(user.xp);
  const currentLevelProgress = Math.min(100, Math.round(((user.xp - levelInfo.prevLevelXp) / (levelInfo.nextLevelXp - levelInfo.prevLevelXp)) * 100));

  // Daily goal progress
  const dailyGoalPct = Math.min(100, Math.round((user.todayQuestionsAnswered / user.dailyGoal) * 100));

  // Overall accuracy
  const totalAtt = attempts.length;
  const correctAtt = attempts.filter(a => a.isCorrect).length;
  const overallAccuracy = totalAtt > 0 ? Math.round((correctAtt / totalAtt) * 100) : 78; // baseline demo default

  const handleClaimQuest = (questId: string) => {
    const xp = storage.claimDailyQuest(questId);
    if (xp > 0) {
      fireConfetti();
      setQuests(storage.getDailyQuests());
      refreshUser();
    }
  };

  const handleDownloadPdf = () => {
    PdfService.generatePerformanceReport(user, attempts);
  };

  // Days of week for activity heatmap
  const weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  const todayDayIdx = (new Date().getDay() + 6) % 7; // Monday = 0

  return (
    <div className="space-y-6 pb-12 animate-in fade-in">
      
      {/* 1. WELCOME & EXAM TARGET HEADER */}
      <div className="rounded-3xl bg-gradient-to-r from-indigo-900/60 via-slate-900 to-indigo-950/40 border border-indigo-500/30 p-5 sm:p-6 shadow-xl relative overflow-hidden">
        <div className="relative z-10 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
          <div className="flex items-center gap-3.5">
            <div className="w-14 h-14 rounded-2xl bg-gradient-to-tr from-indigo-600 to-amber-500 p-0.5 shadow-lg">
              <div className="w-full h-full bg-slate-950 rounded-[14px] flex items-center justify-center text-2xl">
                {user.avatar}
              </div>
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h2 className="text-xl sm:text-2xl font-black text-white font-['Outfit']">
                  Welcome back, {user.name}!
                </h2>
                {isPremium && (
                  <span className="px-2 py-0.5 rounded-full bg-amber-500/20 text-amber-400 border border-amber-500/40 text-[10px] font-bold flex items-center gap-1">
                    <Crown className="w-3 h-3 fill-amber-400" />
                    <span>PRO</span>
                  </span>
                )}
              </div>
              <p className="text-xs text-slate-300 mt-0.5">
                Target Exam: <span className="font-bold text-amber-300">{currentExam.name}</span>
              </p>
            </div>
          </div>

          <div className="flex items-center gap-2.5">
            <button
              onClick={() => onNavigate('learn')}
              className="px-5 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-md shadow-indigo-600/30 flex items-center gap-2 transition-all hover:scale-105"
            >
              <Compass className="w-4 h-4" />
              <span>Continue Learning</span>
            </button>
            <button
              onClick={() => onNavigate('chapter-practice')}
              className="px-4 py-2.5 rounded-xl bg-slate-800 hover:bg-slate-700 border border-slate-700 text-slate-100 font-bold text-xs flex items-center gap-2 transition-colors"
            >
              <BookOpen className="w-4 h-4 text-emerald-300" />
              <span>Chapter Practice</span>
            </button>
            <button
              onClick={handleDownloadPdf}
              title="Download Official Diagnostic PDF"
              className="px-3.5 py-2.5 rounded-xl bg-slate-800 hover:bg-slate-700 border border-slate-700 text-slate-200 text-xs font-bold flex items-center gap-1.5 transition-colors"
            >
              <FileText className="w-4 h-4 text-indigo-400" />
              <span className="hidden sm:inline">PDF Report</span>
            </button>
          </div>
        </div>

        {/* Level XP Progress Bar */}
        <div className="mt-5 pt-4 border-t border-slate-800/80">
          <div className="flex items-center justify-between text-xs mb-1.5 font-semibold">
            <div className="flex items-center gap-1.5 text-indigo-300">
              <Award className="w-4 h-4 text-amber-400" />
              <span>Level {user.level}: {user.levelTitle}</span>
            </div>
            <span className="text-slate-400 font-mono">
              {user.xp.toLocaleString()} / {levelInfo.nextLevelXp.toLocaleString()} XP ({currentLevelProgress}%)
            </span>
          </div>
          <div className="w-full h-2.5 rounded-full bg-slate-950 border border-slate-800 overflow-hidden">
            <div 
              className="h-full rounded-full bg-gradient-to-r from-indigo-500 via-amber-400 to-orange-400 transition-all duration-500"
              style={{ width: `${currentLevelProgress}%` }}
            />
          </div>
        </div>
      </div>

      {/* 2. STATS & DAILY GOAL & STREAK CARDS */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        
        {/* Daily Goal Card */}
        <div className="p-4 rounded-2xl bg-slate-900 border border-slate-800">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-bold text-slate-400">Daily Study Goal</span>
            <Target className="w-4 h-4 text-indigo-400" />
          </div>
          <div className="flex items-baseline gap-1.5 mb-1">
            <span className="text-2xl font-black text-white">{user.todayQuestionsAnswered}</span>
            <span className="text-xs text-slate-400">/ {user.dailyGoal} questions</span>
          </div>
          <div className="w-full h-2 rounded-full bg-slate-950 overflow-hidden mt-2">
            <div 
              className="h-full rounded-full bg-indigo-500 transition-all"
              style={{ width: `${dailyGoalPct}%` }}
            />
          </div>
          <p className="text-[10px] text-slate-500 mt-1.5 text-right">{dailyGoalPct}% Completed</p>
        </div>

        {/* Streak & Activity Heatmap */}
        <div className="p-4 rounded-2xl bg-slate-900 border border-slate-800">
          <div className="flex items-center justify-between mb-1.5">
            <span className="text-xs font-bold text-slate-400">Current Streak</span>
            <Flame className="w-4 h-4 text-amber-400 fill-amber-400" />
          </div>
          <div className="flex items-baseline gap-1.5 mb-2">
            <span className="text-2xl font-black text-amber-400">{user.streakDays}</span>
            <span className="text-xs text-slate-300">Days Active</span>
          </div>
          {/* Mini 7-day activity week */}
          <div className="flex items-center justify-between pt-1">
            {weekDays.map((d, idx) => {
              const isPastOrToday = idx <= todayDayIdx;
              return (
                <div key={idx} className="flex flex-col items-center gap-1">
                  <div className={`w-6 h-6 rounded-lg flex items-center justify-center text-[10px] font-bold ${
                    isPastOrToday ? 'bg-amber-500/20 text-amber-400 border border-amber-500/40' : 'bg-slate-950 text-slate-600'
                  }`}>
                    {isPastOrToday ? '✓' : ''}
                  </div>
                  <span className="text-[9px] text-slate-500 font-semibold">{d}</span>
                </div>
              );
            })}
          </div>
        </div>

        {/* Accuracy Summary */}
        <div className="p-4 rounded-2xl bg-slate-900 border border-slate-800">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-bold text-slate-400">Overall Accuracy</span>
            <TrendingUp className="w-4 h-4 text-emerald-400" />
          </div>
          <div className="flex items-baseline gap-1.5 mb-1">
            <span className="text-2xl font-black text-emerald-400">{overallAccuracy}%</span>
            <span className="text-xs text-slate-400">({correctAtt}/{totalAtt || 10} correct)</span>
          </div>
          <p className="text-[11px] text-slate-400 mt-2">
            {overallAccuracy >= 75 ? '🔥 High exam readiness pace' : '⚡ Focus on weak chapter revisions'}
          </p>
        </div>

        {/* Weekly Leaderboard Position */}
        <div 
          onClick={() => onNavigate('leaderboard')}
          className="cursor-pointer p-4 rounded-2xl bg-slate-900 border border-slate-800 hover:border-indigo-500/40 transition-colors group"
        >
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs font-bold text-slate-400">Weekly Division Rank</span>
            <Trophy className="w-4 h-4 text-amber-400 group-hover:scale-110 transition-transform" />
          </div>
          <div className="flex items-baseline gap-2 mb-1">
            <span className="text-2xl font-black text-white">#4</span>
            <span className="text-xs text-indigo-400 font-bold">Top 5% League</span>
          </div>
          <div className="flex items-center justify-between text-[11px] text-slate-400 mt-2">
            <span>Score: {user.xp.toLocaleString()} XP</span>
            <span className="text-indigo-400 font-semibold flex items-center gap-0.5">
              <span>Standings</span>
              <ArrowUpRight className="w-3 h-3" />
            </span>
          </div>
        </div>

      </div>

      {/* 3. DAILY QUESTS & WEAK TOPIC RESCUE ROW */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-5">
        
        {/* Daily Quest Section (Left 7 cols) */}
        <div className="lg:col-span-7 rounded-3xl bg-slate-900 border border-slate-800 p-5">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-2">
              <Sparkles className="w-5 h-5 text-amber-400" />
              <h3 className="font-bold text-base text-white font-['Outfit']">Daily Learning Quests</h3>
            </div>
            <span className="text-xs text-slate-400 font-medium">Resets daily at midnight</span>
          </div>

          <div className="space-y-3">
            {quests.map(q => {
              const isReady = q.currentCount >= q.targetCount && !q.isClaimed;
              return (
                <div 
                  key={q.id}
                  className="p-3.5 rounded-2xl bg-slate-950/70 border border-slate-800/80 flex items-center justify-between gap-3"
                >
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-1">
                      <p className="text-xs font-bold text-white truncate">{q.title}</p>
                      <span className="text-[10px] font-mono font-bold text-amber-400 bg-amber-500/10 px-1.5 py-0.2 rounded border border-amber-500/30">
                        +{q.rewardXp} XP
                      </span>
                    </div>
                    <p className="text-[11px] text-slate-400 truncate mb-1.5">{q.description}</p>
                    {/* Progress bar */}
                    <div className="flex items-center gap-2">
                      <div className="flex-1 h-1.5 rounded-full bg-slate-800 overflow-hidden">
                        <div 
                          className="h-full bg-indigo-500 rounded-full"
                          style={{ width: `${Math.min(100, (q.currentCount / q.targetCount) * 100)}%` }}
                        />
                      </div>
                      <span className="text-[10px] font-mono text-slate-400">
                        {q.currentCount}/{q.targetCount}
                      </span>
                    </div>
                  </div>

                  {q.isClaimed ? (
                    <span className="px-3 py-1.5 rounded-xl bg-emerald-500/10 text-emerald-400 text-xs font-bold border border-emerald-500/30 flex items-center gap-1 shrink-0">
                      <CheckCircle2 className="w-3.5 h-3.5" />
                      <span>Claimed</span>
                    </span>
                  ) : isReady ? (
                    <button
                      onClick={() => handleClaimQuest(q.id)}
                      className="px-3.5 py-1.5 rounded-xl bg-gradient-to-r from-amber-500 to-orange-500 hover:from-amber-400 hover:to-orange-400 text-slate-950 text-xs font-black shrink-0 animate-bounce shadow-md shadow-amber-500/20"
                    >
                      Claim Reward
                    </button>
                  ) : (
                    <button
                      onClick={() => onNavigate('play')}
                      className="px-3 py-1.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-semibold shrink-0"
                    >
                      Play
                    </button>
                  )}
                </div>
              );
            })}
          </div>
        </div>

        {/* Weak Topics & Mistake Notebook Card (Right 5 cols) */}
        <div className="lg:col-span-5 rounded-3xl bg-slate-900 border border-slate-800 p-5 flex flex-col justify-between">
          <div>
            <div className="flex items-center justify-between mb-3">
              <div className="flex items-center gap-2">
                <RotateCcw className="w-5 h-5 text-rose-400" />
                <h3 className="font-bold text-base text-white font-['Outfit']">Mistake Notebook</h3>
              </div>
              <span className="text-xs px-2 py-0.5 rounded-full bg-rose-500/10 text-rose-400 border border-rose-500/30 font-bold">
                {mistakes.length} Due for Revision
              </span>
            </div>

            <p className="text-xs text-slate-400 mb-4 leading-relaxed">
              Every missed question is captured with its explanation and scheduled via Spaced Repetition (SM-2) so you never repeat the same error in the final exam.
            </p>

            {mistakes.length > 0 ? (
              <div className="p-3 rounded-2xl bg-rose-950/20 border border-rose-500/30 mb-4">
                <p className="text-xs font-bold text-white mb-1">Active Rescue Queue</p>
                <p className="text-[11px] text-rose-300/80">
                  {mistakes.length} questions require concept reinforcement today.
                </p>
              </div>
            ) : (
              <div className="p-3 rounded-2xl bg-emerald-950/20 border border-emerald-500/30 mb-4">
                <p className="text-xs font-bold text-emerald-300 mb-1">Mistake Notebook Clear!</p>
                <p className="text-[11px] text-slate-400">
                  All past errors have been resolved. Continue practicing to maintain mastery.
                </p>
              </div>
            )}
          </div>

          <div className="flex items-center gap-2 pt-2">
            <button
              onClick={() => onLaunchGame('weak_topic_rescue')}
              className="flex-1 py-2.5 rounded-xl bg-gradient-to-r from-rose-600 to-pink-600 hover:from-rose-500 hover:to-pink-500 text-white font-bold text-xs shadow-md shadow-rose-600/20 flex items-center justify-center gap-1.5 transition-all"
            >
              <RotateCcw className="w-3.5 h-3.5" />
              <span>Revise My Mistakes</span>
            </button>
            <button
              onClick={() => onNavigate('mistakes')}
              className="px-3.5 py-2.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-semibold"
            >
              View All
            </button>
          </div>
        </div>

      </div>

      {/* 4. QUICK PLAY SECTION (Featured Game Modes) */}
      <div className="rounded-3xl bg-slate-900 border border-slate-800 p-5">
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center gap-2">
            <Gamepad2 className="w-5 h-5 text-indigo-400" />
            <h3 className="font-bold text-base text-white font-['Outfit']">Quick Play Game Modes</h3>
          </div>
          <button 
            onClick={() => onNavigate('play')}
            className="text-xs font-bold text-indigo-400 hover:text-indigo-300 flex items-center gap-1"
          >
            <span>All 20 Modes</span>
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3.5">
          {[
            { id: 'quick_quiz', label: 'Quick Quiz', sub: '5 or 10 Qs', icon: Zap, color: 'from-blue-600 to-indigo-600' },
            { id: 'speed_rush', label: 'Speed Rush', sub: 'Timed Sprint', icon: Clock, color: 'from-amber-600 to-orange-600' },
            { id: 'boss_battle', label: 'Boss Battle', sub: 'Chapter Climax', icon: Swords, color: 'from-rose-600 to-red-700' },
            { id: 'pyq_machine', label: 'PYQ Machine', sub: 'Verified 2023', icon: BookOpen, color: 'from-emerald-600 to-teal-700' }
          ].map(game => {
            const Icon = game.icon;
            return (
              <div
                key={game.id}
                onClick={() => onLaunchGame(game.id)}
                className="cursor-pointer group p-3.5 rounded-2xl bg-slate-950/70 border border-slate-800 hover:border-indigo-500/50 transition-all hover:-translate-y-0.5 text-center flex flex-col items-center justify-center"
              >
                <div className={`w-11 h-11 rounded-xl bg-gradient-to-tr ${game.color} flex items-center justify-center text-white mb-2 shadow-md group-hover:scale-110 transition-transform`}>
                  <Icon className="w-5 h-5" />
                </div>
                <p className="text-xs font-bold text-white group-hover:text-indigo-300 transition-colors">{game.label}</p>
                <p className="text-[10px] text-slate-400 mt-0.5">{game.sub}</p>
              </div>
            );
          })}
        </div>
      </div>

      {/* 5. RECENT BADGES & ACHIEVEMENTS */}
      <div className="rounded-3xl bg-slate-900 border border-slate-800 p-5">
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center gap-2">
            <Award className="w-5 h-5 text-amber-400" />
            <h3 className="font-bold text-base text-white font-['Outfit']">Recent Badges & Milestones</h3>
          </div>
          <button 
            onClick={() => onNavigate('achievements')}
            className="text-xs font-bold text-indigo-400 hover:text-indigo-300 flex items-center gap-1"
          >
            <span>View All</span>
            <ChevronRight className="w-4 h-4" />
          </button>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-6 gap-3">
          {badges.map(b => (
            <div 
              key={b.id}
              className={`p-3 rounded-2xl border text-center flex flex-col items-center justify-center ${
                b.unlockedAt 
                  ? 'bg-slate-950/80 border-amber-500/30' 
                  : 'bg-slate-950/40 border-slate-800/80 opacity-60'
              }`}
            >
              <div className={`w-10 h-10 rounded-full flex items-center justify-center mb-2 ${
                b.unlockedAt ? 'bg-amber-500/20 text-amber-400 shadow-md shadow-amber-500/20' : 'bg-slate-800 text-slate-500'
              }`}>
                <Award className="w-5 h-5" />
              </div>
              <p className="text-xs font-bold text-white truncate max-w-[100px]">{b.title}</p>
              <p className="text-[9px] text-slate-400 mt-0.5">
                {b.unlockedAt ? 'Unlocked' : `${b.progressCurrent}/${b.progressTarget}`}
              </p>
            </div>
          ))}
        </div>
      </div>

    </div>
  );
};
