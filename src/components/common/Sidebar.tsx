import React from 'react';
import { 
  LayoutDashboard, 
  Gamepad2, 
  BookOpen,
  Compass, 
  BookMarked, 
  RotateCcw, 
  Clock, 
  BarChart3, 
  Trophy, 
  Users, 
  ShieldAlert, 
  Crown,
  FileText
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useGame } from '../../context/GameContext';

interface SidebarProps {
  currentRoute: string;
  onNavigate: (route: string) => void;
}

export const Sidebar: React.FC<SidebarProps> = ({ currentRoute, onNavigate }) => {
  const { role, isPremium } = useAuth();
  const { openUpgradeModal } = useGame();

  const mainNav = [
    { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard },
    { id: 'chapter-practice', label: 'Chapter Practice', icon: BookOpen },
    { id: 'play', label: 'Study Games (20)', icon: Gamepad2, badge: 'Popular' },
    { id: 'learn', label: 'Learning Path', icon: Compass },
    { id: 'mistakes', label: 'Mistake Notebook', icon: RotateCcw, count: 'Spaced' },
    { id: 'bookmarks', label: 'Saved Bookmarks', icon: BookMarked },
    { id: 'mock-exam', label: 'NTA Mock Exams', icon: Clock },
    { id: 'progress', label: 'Analytics & PDF', icon: BarChart3 },
    { id: 'leaderboard', label: 'Leaderboard', icon: Trophy },
    { id: 'classroom', label: 'Classrooms', icon: Users },
  ];

  const adminNav = [
    { id: 'admin', label: 'Admin Console', icon: ShieldAlert, badge: 'Staff' },
    { id: 'admin/import', label: 'OCR Import Bench', icon: FileText }
  ];
  const staffNav = role === 'admin'
    ? adminNav
    : role === 'moderator'
      ? [
          { id: 'moderator', label: 'Moderator Workspace', icon: ShieldAlert, badge: 'Staff' },
          { id: 'moderator/import', label: 'Question Review', icon: FileText }
        ]
      : [];
  const visibleMainNav = role === 'admin'
    ? [{ id: 'admin', label: 'Admin Console', icon: ShieldAlert }]
    : role === 'moderator'
      ? [{ id: 'moderator', label: 'Moderator Workspace', icon: ShieldAlert }]
      : mainNav;

  return (
    <aside className="hidden md:flex flex-col w-64 bg-slate-950/80 border-r border-slate-800/80 min-h-[calc(100vh-61px)] p-4 select-none">
      
      {/* Navigation Group */}
      <div className="space-y-1">
        <p className="px-3 text-[11px] font-bold text-slate-500 uppercase tracking-wider mb-2">Main Menu</p>
        {visibleMainNav.map(item => {
          const Icon = item.icon;
          const isActive = currentRoute === item.id || 
            (item.id === 'play' && currentRoute.startsWith('play/')) ||
            (item.id === 'learn' && currentRoute.startsWith('learn'));

          return (
            <button
              key={item.id}
              onClick={() => onNavigate(item.id)}
              className={`w-full flex items-center justify-between px-3 py-2.5 rounded-xl text-xs font-semibold transition-all group ${
                isActive
                  ? 'bg-indigo-600 text-white shadow-lg shadow-indigo-600/30'
                  : 'text-slate-400 hover:text-slate-100 hover:bg-slate-900/80'
              }`}
            >
              <div className="flex items-center gap-3">
                <Icon className={`w-4 h-4 transition-transform group-hover:scale-110 ${isActive ? 'text-white' : 'text-slate-400 group-hover:text-indigo-400'}`} />
                <span>{item.label}</span>
              </div>
              {item.badge && (
                <span className={`text-[10px] px-1.5 py-0.5 rounded-full font-bold ${
                  isActive ? 'bg-white/20 text-white' : 'bg-indigo-500/20 text-indigo-400'
                }`}>
                  {item.badge}
                </span>
              )}
              {item.count && (
                <span className="text-[10px] text-amber-400/90 bg-amber-500/10 px-1.5 py-0.5 rounded font-mono font-bold">
                  {item.count}
                </span>
              )}
            </button>
          );
        })}
      </div>

      {/* Staff / Admin Section */}
      {(role === 'admin' || role === 'moderator') && (
        <div className="mt-6 pt-4 border-t border-slate-800/60 space-y-1">
          <p className="px-3 text-[11px] font-bold text-emerald-400 uppercase tracking-wider mb-2">Management</p>
          {staffNav.map(item => {
            const Icon = item.icon;
            const isActive = currentRoute === item.id;
            return (
              <button
                key={item.id}
                onClick={() => onNavigate(item.id)}
                className={`w-full flex items-center justify-between px-3 py-2 rounded-xl text-xs font-semibold transition-colors ${
                  isActive
                    ? 'bg-emerald-600 text-white'
                    : 'text-slate-400 hover:text-white hover:bg-slate-900'
                }`}
              >
                <div className="flex items-center gap-3">
                  <Icon className="w-4 h-4 text-emerald-400" />
                  <span>{item.label}</span>
                </div>
                <span className="text-[10px] bg-emerald-500/20 text-emerald-300 px-1.5 py-0.5 rounded">
                  {item.badge}
                </span>
              </button>
            );
          })}
        </div>
      )}

      {/* Pro Upgrade / Status Card in sidebar */}
      <div className="mt-auto pt-6">
        {isPremium ? (
          <div className="p-3.5 rounded-2xl bg-gradient-to-br from-amber-500/10 to-orange-500/5 border border-amber-500/30">
            <div className="flex items-center gap-2 mb-1">
              <Crown className="w-4 h-4 text-amber-400 fill-amber-400" />
              <span className="text-xs font-bold text-amber-300">PRO Membership Active</span>
            </div>
            <p className="text-[11px] text-slate-400">All 20 Game Modes, Full Question Bank & Mock Exams Unlocked.</p>
          </div>
        ) : (
          <div className="p-3.5 rounded-2xl bg-gradient-to-br from-indigo-900/40 via-slate-900 to-indigo-950/40 border border-indigo-500/30">
            <div className="flex items-center gap-2 mb-1.5">
              <Crown className="w-4 h-4 text-amber-400 fill-amber-400" />
              <span className="text-xs font-bold text-white">Unlock NetAce Pro</span>
            </div>
            <p className="text-[11px] text-slate-400 mb-3">
              Get unlimited battles, full PYQs, and timed mock tests. Starting at ₹99/mo.
            </p>
            <button
              onClick={() => openUpgradeModal('Sidebar Promo')}
              className="w-full py-2 rounded-xl bg-gradient-to-r from-amber-500 to-orange-500 hover:from-amber-400 hover:to-orange-400 text-slate-950 font-extrabold text-xs shadow-md transition-all text-center"
            >
              Upgrade Now
            </button>
          </div>
        )}
      </div>

    </aside>
  );
};
