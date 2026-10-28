import React, { useState } from 'react';
import { 
  Flame, 
  Volume2, 
  VolumeX, 
  Crown, 
  ShieldCheck, 
  Bell, 
  ChevronDown, 
  Zap,
  LogOut
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useGame } from '../../context/GameContext';
import { INITIAL_EXAMINATIONS } from '../../data/initialData';

interface NavbarProps {
  onNavigate: (route: string) => void;
  currentRoute: string;
  onOpenNotifications: () => void;
}

export const Navbar: React.FC<NavbarProps> = ({ onNavigate, onOpenNotifications }) => {
  const { user, role, updateTargetExam, isPremium, logout } = useAuth();
  const { isMuted, toggleSound, openUpgradeModal } = useGame();
  const [showRoleMenu, setShowRoleMenu] = useState(false);
  const [showExamMenu, setShowExamMenu] = useState(false);

  const currentExam = INITIAL_EXAMINATIONS.find(e => e.id === user.targetExamId) || INITIAL_EXAMINATIONS[0];

  return (
    <header className="sticky top-0 z-40 bg-slate-900/90 backdrop-blur-md border-b border-slate-800/80 px-4 py-2.5 transition-all">
      <div className="max-w-7xl mx-auto flex items-center justify-between gap-3">
        
        {/* Brand / Logo */}
        <div className="flex items-center gap-3">
          <button 
            onClick={() => onNavigate(role === 'guest' ? 'landing' : 'dashboard')}
            className="flex items-center gap-2 group text-left focus:outline-none"
          >
            <div className="w-10 h-10 rounded-xl bg-gradient-to-tr from-indigo-600 via-indigo-500 to-amber-500 p-0.5 shadow-lg shadow-indigo-500/20 group-hover:scale-105 transition-transform">
              <div className="w-full h-full bg-slate-950 rounded-[10px] flex items-center justify-center">
                <Zap className="w-5 h-5 text-amber-400 fill-amber-400" />
              </div>
            </div>
            <div>
              <div className="flex items-center gap-1.5">
                <span className="font-extrabold text-xl tracking-tight bg-gradient-to-r from-white via-slate-100 to-indigo-200 bg-clip-text text-transparent font-['Outfit']">
                  NetAce
                </span>
                <span className="text-[10px] uppercase font-bold tracking-widest px-1.5 py-0.5 rounded bg-indigo-500/20 text-indigo-400 border border-indigo-500/30">
                  Prep
                </span>
              </div>
              <p className="text-[11px] text-slate-400 hidden sm:block">Gamified Exam Engine</p>
            </div>
          </button>

          {/* Exam Selector Dropdown */}
          {role !== 'guest' && <div className="relative">
            <button
              onClick={() => { setShowExamMenu(!showExamMenu); setShowRoleMenu(false); }}
              className="hidden md:flex items-center gap-2 px-3 py-1.5 rounded-lg bg-slate-800/80 border border-slate-700/60 hover:border-indigo-500/50 text-xs font-semibold text-slate-200 transition-colors"
            >
              <span className="w-2 h-2 rounded-full bg-indigo-400 animate-pulse"></span>
              <span>{currentExam.shortCode}</span>
              <ChevronDown className="w-3.5 h-3.5 text-slate-400" />
            </button>

            {showExamMenu && (
              <div className="absolute left-0 mt-2 w-64 rounded-xl bg-slate-900 border border-slate-700/80 shadow-2xl py-2 z-50 animate-in fade-in slide-in-from-top-2">
                <div className="px-3 py-1 text-[11px] font-semibold text-slate-400 uppercase tracking-wider">
                  Select Target Exam
                </div>
                {INITIAL_EXAMINATIONS.map(exam => (
                  <button
                    key={exam.id}
                    onClick={() => {
                      void updateTargetExam(exam.id);
                      setShowExamMenu(false);
                    }}
                    className={`w-full flex items-center justify-between px-3 py-2 text-left text-xs transition-colors hover:bg-indigo-600/10 ${
                      user.targetExamId === exam.id ? 'text-indigo-400 font-bold bg-indigo-500/10' : 'text-slate-300'
                    }`}
                  >
                    <span>{exam.name}</span>
                    {user.targetExamId === exam.id && <span className="text-indigo-400 text-xs">✓</span>}
                  </button>
                ))}
              </div>
            )}
          </div>}
        </div>

        {/* User Stats & Controls */}
        <div className="flex items-center gap-2 sm:gap-3">
          
          {/* Daily Streak */}
          {role !== 'guest' && (
            <div 
              title={`${user.streakDays} Day Study Streak`}
              className="flex items-center gap-1.5 px-2.5 py-1.5 rounded-lg bg-amber-500/10 border border-amber-500/30 text-amber-400 text-xs font-bold"
            >
              <Flame className="w-4 h-4 fill-amber-400 text-amber-500 animate-bounce" />
              <span>{user.streakDays}</span>
              <span className="hidden sm:inline text-[11px] text-amber-300/80 font-normal">days</span>
            </div>
          )}

          {/* Level & XP */}
          {role !== 'guest' && (
            <div 
              onClick={() => onNavigate('progress')}
              className="cursor-pointer hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-lg bg-slate-800/80 border border-slate-700/60 hover:border-slate-600 text-xs text-slate-200"
            >
              <div className="w-5 h-5 rounded-full bg-indigo-500/20 text-indigo-400 flex items-center justify-center font-black text-[10px]">
                {user.level}
              </div>
              <span className="font-semibold text-indigo-300">{user.levelTitle}</span>
              <span className="text-slate-400">|</span>
              <span className="font-mono text-amber-300 font-bold">{user.xp.toLocaleString()} XP</span>
            </div>
          )}

          {/* Sound Toggle */}
          <button
            onClick={toggleSound}
            aria-label="Toggle Sound Effects"
            className="p-2 rounded-lg bg-slate-800/80 border border-slate-700/60 text-slate-300 hover:text-white transition-colors"
          >
            {isMuted ? <VolumeX className="w-4 h-4 text-slate-500" /> : <Volume2 className="w-4 h-4 text-emerald-400" />}
          </button>

          {/* Notifications */}
          {role !== 'guest' && (
            <button
              onClick={onOpenNotifications}
              aria-label="Open notifications"
              className="relative p-2 rounded-lg bg-slate-800/80 border border-slate-700/60 text-slate-300 hover:text-white transition-colors"
            >
              <Bell className="w-4 h-4" />
              <span className="absolute top-1 right-1 w-2 h-2 rounded-full bg-amber-400 animate-ping"></span>
              <span className="absolute top-1 right-1 w-2 h-2 rounded-full bg-amber-500"></span>
            </button>
          )}

          {/* Premium Upgrade Button */}
          {!isPremium && role !== 'admin' && (
            <button
              onClick={() => openUpgradeModal('Full Access')}
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-gradient-to-r from-amber-500 to-orange-500 hover:from-amber-400 hover:to-orange-400 text-slate-950 font-bold text-xs shadow-md shadow-amber-500/20 transition-all hover:scale-105"
            >
              <Crown className="w-3.5 h-3.5 fill-slate-950" />
              <span className="hidden sm:inline">Get Pro</span>
              <span className="sm:hidden">Pro</span>
            </button>
          )}

          {role === 'guest' ? (
            <div className="flex items-center gap-2">
              <button onClick={() => onNavigate('login')} className="rounded-lg border border-slate-700 px-3 py-2 text-xs font-bold text-slate-200 hover:border-indigo-500">Sign in</button>
              <button onClick={() => onNavigate('signup')} className="rounded-lg bg-indigo-600 px-3 py-2 text-xs font-bold text-white hover:bg-indigo-500">Create account</button>
            </div>
          ) : (
            <div className="relative">
              <button
                onClick={() => { setShowRoleMenu(!showRoleMenu); setShowExamMenu(false); }}
                className="flex items-center gap-1.5 rounded-lg border border-slate-700/80 bg-slate-800/90 px-2.5 py-1.5 text-xs font-medium text-slate-200 hover:border-slate-600"
                aria-expanded={showRoleMenu}
              >
                <span className="text-sm">{user.avatar}</span>
                <span className="hidden max-w-28 truncate font-semibold lg:inline">{user.name}</span>
                <ChevronDown className="h-3 w-3 text-slate-400" />
              </button>
              {showRoleMenu && (
                <div className="absolute right-0 z-50 mt-2 w-52 rounded-xl border border-slate-700/80 bg-slate-900 py-2 shadow-2xl">
                  <p className="px-3 py-1 text-[11px] font-semibold capitalize text-slate-400">{user.role.replace('_', ' ')}</p>
                  <button onClick={() => { onNavigate('profile'); setShowRoleMenu(false); }} className="flex w-full items-center gap-2 px-3 py-2 text-left text-xs text-slate-300 hover:bg-slate-800">
                    <ShieldCheck className="h-3.5 w-3.5" /> Profile & Settings
                  </button>
                  <button onClick={() => { void logout(); setShowRoleMenu(false); }} className="flex w-full items-center gap-2 px-3 py-2 text-left text-xs text-rose-300 hover:bg-slate-800">
                    <LogOut className="h-3.5 w-3.5" /> Sign out
                  </button>
                </div>
              )}
            </div>
          )}

        </div>

      </div>
    </header>
  );
};
