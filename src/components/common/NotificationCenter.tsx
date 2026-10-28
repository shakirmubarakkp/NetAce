import React, { useState } from 'react';
import { Bell, Flame, Award, Clock, X, Check, ShieldCheck } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';

interface NotificationCenterProps {
  isOpen: boolean;
  onClose: () => void;
}

export const NotificationCenter: React.FC<NotificationCenterProps> = ({ isOpen, onClose }) => {
  const { user } = useAuth();
  const [reminderEnabled, setReminderEnabled] = useState(true);
  const [reminderTime, setReminderTime] = useState('20:00'); // 8:00 PM default per prompt requirement

  if (!isOpen) return null;

  const notifications = [
    {
      id: 'notif_1',
      title: '7-Day Streak Alive!',
      body: `You are on fire! Complete 1 practice question today to extend your streak to 8 days.`,
      icon: Flame,
      color: 'text-amber-400 bg-amber-500/10 border-amber-500/20',
      time: '1 hour ago'
    },
    {
      id: 'notif_2',
      title: 'New Chapter Challenge Available',
      body: `Chapter Boss: "Al-Mutanabbi: The Undefeated Poet" is ready in Arabic Literature.`,
      icon: Award,
      color: 'text-indigo-400 bg-indigo-500/10 border-indigo-500/20',
      time: '3 hours ago'
    },
    {
      id: 'notif_3',
      title: 'Weekly Leaderboard Reset',
      body: `You are currently Rank #4 in the UGC NET Division. Top 3 earn 500 bonus XP.`,
      icon: Clock,
      color: 'text-emerald-400 bg-emerald-500/10 border-emerald-500/20',
      time: 'Yesterday'
    }
  ];

  return (
    <div className="fixed inset-0 z-50 flex justify-end bg-slate-950/60 backdrop-blur-sm animate-in fade-in">
      <div className="w-full max-w-sm bg-slate-900 border-l border-slate-800 h-full p-5 flex flex-col shadow-2xl animate-in slide-in-from-right duration-200">
        
        {/* Header */}
        <div className="flex items-center justify-between pb-4 border-b border-slate-800">
          <div className="flex items-center gap-2">
            <Bell className="w-5 h-5 text-indigo-400" />
            <h3 className="font-bold text-base text-white">Notifications</h3>
          </div>
          <button 
            onClick={onClose}
            className="p-1.5 rounded-lg bg-slate-800 text-slate-400 hover:text-white"
          >
            <X className="w-4 h-4" />
          </button>
        </div>

        {/* 8 PM Daily Reminder Toggle (Prompt Requirement) */}
        <div className="my-4 p-3.5 rounded-2xl bg-indigo-950/40 border border-indigo-500/30">
          <div className="flex items-center justify-between mb-2">
            <div className="flex items-center gap-2">
              <Clock className="w-4 h-4 text-indigo-400" />
              <span className="text-xs font-bold text-white">Daily Study Reminder</span>
            </div>
            <button
              onClick={() => setReminderEnabled(!reminderEnabled)}
              className={`w-9 h-5 rounded-full transition-colors relative ${
                reminderEnabled ? 'bg-indigo-600' : 'bg-slate-700'
              }`}
            >
              <div className={`w-4 h-4 rounded-full bg-white transition-transform ${
                reminderEnabled ? 'translate-x-4' : 'translate-x-0.5'
              }`} />
            </button>
          </div>
          <p className="text-[11px] text-slate-400 mb-2">
            Automated prompt sent daily to maintain study discipline and protect your streak.
          </p>
          <div className="flex items-center justify-between text-xs">
            <span className="text-slate-400">Scheduled Time:</span>
            <input 
              type="time" 
              value={reminderTime}
              onChange={(e) => setReminderTime(e.target.value)}
              className="bg-slate-900 border border-slate-700 text-indigo-300 font-mono text-xs rounded-lg px-2 py-1"
            />
          </div>
        </div>

        {/* Notification List */}
        <div className="flex-1 overflow-y-auto space-y-3 pr-1">
          {notifications.map(n => {
            const Icon = n.icon;
            return (
              <div 
                key={n.id}
                className="p-3 rounded-2xl bg-slate-950/70 border border-slate-800/80 hover:border-slate-700 transition-colors"
              >
                <div className="flex items-start gap-3">
                  <div className={`p-2 rounded-xl border ${n.color} shrink-0`}>
                    <Icon className="w-4 h-4" />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between gap-1 mb-1">
                      <p className="text-xs font-bold text-white truncate">{n.title}</p>
                      <span className="text-[10px] text-slate-500 shrink-0">{n.time}</span>
                    </div>
                    <p className="text-[11px] text-slate-400 leading-relaxed">{n.body}</p>
                  </div>
                </div>
              </div>
            );
          })}
        </div>

        {/* Footer */}
        <div className="pt-3 border-t border-slate-800 text-center">
          <p className="text-[11px] text-slate-500 flex items-center justify-center gap-1.5">
            <ShieldCheck className="w-3.5 h-3.5 text-emerald-400" />
            <span>Target Exam: {user.targetExamId.toUpperCase()}</span>
          </p>
        </div>

      </div>
    </div>
  );
};
