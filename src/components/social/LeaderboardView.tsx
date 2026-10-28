import React, { useState } from 'react';
import { Trophy, Flame, Award, Crown, Medal, Sparkles } from 'lucide-react';
import { storage } from '../../services/storageService';
import { useAuth } from '../../context/AuthContext';

export const LeaderboardView: React.FC = () => {
  const { user } = useAuth();
  const [activeTab, setActiveTab] = useState<'weekly' | 'monthly' | 'alltime'>('weekly');
  const [filterExam, setFilterExam] = useState<string>('all');

  const leaderboard = storage.getLeaderboard();

  return (
    <div className="space-y-6 pb-12 animate-in fade-in max-w-4xl mx-auto">
      
      {/* Header */}
      <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl text-center space-y-2">
        <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-amber-500 to-orange-500 flex items-center justify-center mx-auto text-white shadow-xl shadow-amber-500/20 mb-2">
          <Trophy className="w-8 h-8" />
        </div>
        <h2 className="text-2xl sm:text-3xl font-black text-white font-['Outfit']">
          Competitive Division Leaderboard
        </h2>
        <p className="text-xs text-slate-400 max-w-md mx-auto">
          Rankings are calculated server-side from verified study game XP. No fabricated accounts or unearned points.
        </p>

        {/* Division Tab Switcher */}
        <div className="inline-flex p-1 rounded-2xl bg-slate-950 border border-slate-800 mt-4">
          {[
            { id: 'weekly', label: 'Weekly League' },
            { id: 'monthly', label: 'Monthly Championship' },
            { id: 'alltime', label: 'All-Time Legends' }
          ].map(tab => (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id as 'weekly' | 'monthly' | 'alltime')}
              className={`px-4 py-2 rounded-xl text-xs font-bold transition-all ${
                activeTab === tab.id
                  ? 'bg-indigo-600 text-white shadow-md'
                  : 'text-slate-400 hover:text-white'
              }`}
            >
              {tab.label}
            </button>
          ))}
        </div>
      </div>

      {/* Top 3 Podium (Visual Excellence) */}
      <div className="grid grid-cols-3 gap-3 items-end pt-4 max-w-lg mx-auto">
        {/* Rank 2 */}
        {leaderboard[1] && (
          <div className="p-4 rounded-3xl bg-slate-900 border border-slate-800 text-center flex flex-col items-center">
            <span className="text-2xl mb-1">{leaderboard[1].avatar}</span>
            <span className="w-6 h-6 rounded-full bg-slate-700 text-slate-200 font-bold text-xs flex items-center justify-center mb-1">
              2
            </span>
            <p className="text-xs font-bold text-white truncate max-w-[90px]">{leaderboard[1].name}</p>
            <p className="text-[10px] text-amber-400 font-mono font-bold">{leaderboard[1].score} XP</p>
          </div>
        )}

        {/* Rank 1 (Center, Elevated) */}
        {leaderboard[0] && (
          <div className="p-5 rounded-3xl bg-gradient-to-b from-amber-500/20 via-slate-900 to-slate-950 border-2 border-amber-500 text-center flex flex-col items-center -translate-y-4 shadow-xl shadow-amber-500/10">
            <Crown className="w-6 h-6 text-amber-400 mb-1" />
            <span className="text-3xl mb-1">{leaderboard[0].avatar}</span>
            <span className="w-7 h-7 rounded-full bg-amber-500 text-slate-950 font-black text-xs flex items-center justify-center mb-1">
              1
            </span>
            <p className="text-xs font-black text-white truncate max-w-[100px]">{leaderboard[0].name}</p>
            <p className="text-[11px] text-amber-300 font-mono font-black">{leaderboard[0].score} XP</p>
          </div>
        )}

        {/* Rank 3 */}
        {leaderboard[2] && (
          <div className="p-4 rounded-3xl bg-slate-900 border border-slate-800 text-center flex flex-col items-center">
            <span className="text-2xl mb-1">{leaderboard[2].avatar}</span>
            <span className="w-6 h-6 rounded-full bg-amber-800/80 text-amber-200 font-bold text-xs flex items-center justify-center mb-1">
              3
            </span>
            <p className="text-xs font-bold text-white truncate max-w-[90px]">{leaderboard[2].name}</p>
            <p className="text-[10px] text-amber-400 font-mono font-bold">{leaderboard[2].score} XP</p>
          </div>
        )}
      </div>

      {/* Leaderboard Table */}
      <div className="p-4 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl space-y-2">
        {leaderboard.map((u, idx) => {
          const isMe = u.userId === user.id || u.isCurrentUser;

          return (
            <div
              key={u.userId}
              className={`p-3.5 rounded-2xl flex items-center justify-between transition-all ${
                isMe
                  ? 'bg-indigo-600/20 border-2 border-indigo-500 shadow-lg'
                  : 'bg-slate-950/70 border border-slate-800/80 hover:border-slate-700'
              }`}
            >
              <div className="flex items-center gap-3">
                <span className={`w-7 h-7 rounded-xl flex items-center justify-center font-black text-xs ${
                  idx === 0 ? 'bg-amber-500 text-slate-950' : idx === 1 ? 'bg-slate-600 text-white' : idx === 2 ? 'bg-amber-800 text-white' : 'text-slate-500'
                }`}>
                  {idx + 1}
                </span>

                <div className="w-9 h-9 rounded-xl bg-slate-900 border border-slate-800 flex items-center justify-center text-lg">
                  {u.avatar}
                </div>

                <div>
                  <div className="flex items-center gap-2">
                    <p className={`text-xs font-bold ${isMe ? 'text-indigo-300' : 'text-white'}`}>
                      {u.name} {isMe && '(You)'}
                    </p>
                    {u.targetExam && (
                      <span className="text-[9px] px-1.5 py-0.2 rounded bg-slate-800 text-slate-400">
                        {u.targetExam}
                      </span>
                    )}
                  </div>
                  <p className="text-[10px] text-slate-400">
                    Level {u.level} • {u.levelTitle}
                  </p>
                </div>
              </div>

              <div className="flex items-center gap-4 text-right">
                <div className="flex items-center gap-1 text-xs text-amber-400 font-bold">
                  <Flame className="w-3.5 h-3.5 fill-amber-400" />
                  <span>{u.streak}d</span>
                </div>
                <div>
                  <p className="text-sm font-black font-mono text-white">{u.score.toLocaleString()} XP</p>
                </div>
              </div>
            </div>
          );
        })}
      </div>

    </div>
  );
};
