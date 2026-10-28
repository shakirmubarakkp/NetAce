import React from 'react';
import { Home, Gamepad2, BookOpen, Trophy, User } from 'lucide-react';

interface MobileNavProps {
  currentRoute: string;
  onNavigate: (route: string) => void;
}

export const MobileNav: React.FC<MobileNavProps> = ({ currentRoute, onNavigate }) => {
  const tabs = [
    { id: 'dashboard', label: 'Home', icon: Home },
    { id: 'play', label: 'Play', icon: Gamepad2, highlight: true },
    { id: 'chapter-practice', label: 'Practice', icon: BookOpen },
    { id: 'leaderboard', label: 'Leaderboard', icon: Trophy },
    { id: 'profile', label: 'Profile', icon: User }
  ];

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-40 md:hidden bg-slate-950/95 backdrop-blur-lg border-t border-slate-800/80 px-2 py-1 safe-area-pb">
      <div className="flex items-center justify-around max-w-md mx-auto">
        {tabs.map(tab => {
          const Icon = tab.icon;
          const isActive = currentRoute === tab.id || 
            (tab.id === 'play' && currentRoute.startsWith('play/')) ||
            (tab.id === 'learn' && (currentRoute.startsWith('learn') || currentRoute.startsWith('chapters/')));

          return (
            <button
              key={tab.id}
              onClick={() => onNavigate(tab.id)}
              className={`flex flex-col items-center justify-center py-1.5 px-3 rounded-xl transition-all relative ${
                isActive ? 'text-indigo-400 font-bold' : 'text-slate-400 hover:text-slate-200'
              }`}
            >
              {tab.highlight && !isActive && (
                <span className="absolute top-1 right-2 w-1.5 h-1.5 rounded-full bg-amber-400 animate-ping"></span>
              )}

              <div className={`p-1 rounded-lg transition-transform ${isActive ? 'scale-110 bg-indigo-500/15' : ''}`}>
                <Icon className={`w-5 h-5 ${isActive ? 'stroke-[2.5px]' : 'stroke-[1.8px]'}`} />
              </div>

              <span className="text-[11px] tracking-tight mt-0.5">{tab.label}</span>

              {isActive && (
                <span className="w-1 h-1 rounded-full bg-indigo-400 mt-0.5"></span>
              )}
            </button>
          );
        })}
      </div>
    </nav>
  );
};
