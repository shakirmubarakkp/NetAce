import React, { useState } from 'react';
import { 
  User, 
  Crown, 
  Award, 
  Flame, 
  Target, 
  Volume2, 
  VolumeX, 
  ShieldCheck, 
  RotateCcw,
  Sparkles,
  Calendar,
  Check
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useGame } from '../../context/GameContext';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';

export const UserProfileView: React.FC = () => {
  const { user, updateUserProfile, refreshUser } = useAuth();
  const { isMuted, toggleSound, openUpgradeModal } = useGame();

  const [dailyGoal, setDailyGoal] = useState(user.dailyGoal);
  const [avatarChoice, setAvatarChoice] = useState(user.avatar);
  const [name, setName] = useState(user.name);
  const [leaderboardPublic, setLeaderboardPublic] = useState(true);
  const [savedSuccess, setSavedSuccess] = useState(false);
  const [saveError, setSaveError] = useState('');

  const avatars = ['🚀', '👩‍🏫', '👨‍🎓', '⚡', '🦉', '🎯', '🦁', '💎', '👑'];

  const handleSaveProfile = async (e: React.FormEvent) => {
    e.preventDefault();
    setSaveError('');
    try {
      await updateUserProfile({ name, avatar: avatarChoice, dailyGoal });
      soundFX.playCorrect();
      setSavedSuccess(true);
      setTimeout(() => setSavedSuccess(false), 2000);
    } catch (reason) {
      setSaveError(reason instanceof Error ? reason.message : 'Unable to save profile settings.');
    }
  };

  const handleResetData = async () => {
    if (window.confirm('Reset all demo progress and reload original seed data?')) {
      storage.resetToDefault();
      try {
        await refreshUser();
        window.location.reload();
      } catch (reason) {
        setSaveError(reason instanceof Error ? reason.message : 'Unable to reload your account profile.');
      }
    }
  };

  return (
    <div className="max-w-3xl mx-auto space-y-6 pb-12 animate-in fade-in">
      
      {/* Header */}
      <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl flex items-center justify-between">
        <div className="flex items-center gap-4">
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-indigo-500 to-amber-500 p-0.5 shadow-lg">
            <div className="w-full h-full rounded-[14px] bg-slate-950 flex items-center justify-center text-3xl">
              {avatarChoice}
            </div>
          </div>
          <div>
            <div className="flex items-center gap-2">
              <h2 className="text-xl font-black text-white font-['Outfit']">{user.name}</h2>
              {user.isPremium && (
                <span className="px-2 py-0.5 rounded-full bg-amber-500/20 text-amber-400 border border-amber-500/40 text-[10px] font-bold">
                  PRO
                </span>
              )}
            </div>
            <p className="text-xs text-slate-400">{user.email}</p>
            <p className="text-[11px] text-indigo-400 font-semibold capitalize mt-0.5">
              Role: {user.role.replace('_', ' ')} • Level {user.level} ({user.levelTitle})
            </p>
          </div>
        </div>

        {!user.isPremium && (
          <button
            onClick={() => openUpgradeModal('Profile Page')}
            className="px-4 py-2 rounded-xl bg-gradient-to-r from-amber-500 to-orange-500 text-slate-950 font-black text-xs shadow-md"
          >
            Upgrade to Pro
          </button>
        )}
      </div>

      {savedSuccess && (
        <div className="p-3.5 rounded-2xl bg-emerald-500/20 border border-emerald-500/40 text-emerald-300 text-xs font-bold text-center animate-in fade-in">
          ✓ Profile settings saved successfully!
        </div>
      )}
      {saveError && <p role="alert" className="rounded-2xl border border-rose-500/30 bg-rose-500/10 p-3.5 text-center text-xs text-rose-200">{saveError}</p>}

      {/* Profile Form */}
      <form onSubmit={handleSaveProfile} className="p-6 rounded-3xl bg-slate-900 border border-slate-800 space-y-5">
        <h3 className="font-bold text-white text-base">Candidate Profile Settings</h3>

        {/* Avatar Picker */}
        <div>
          <label className="text-xs font-bold text-slate-400 block mb-2">Choose Avatar:</label>
          <div className="flex items-center gap-2 overflow-x-auto pb-1">
            {avatars.map(av => (
              <button
                key={av}
                type="button"
                onClick={() => setAvatarChoice(av)}
                className={`w-11 h-11 rounded-xl text-xl flex items-center justify-center transition-all ${
                  avatarChoice === av
                    ? 'bg-indigo-600 scale-110 shadow-lg ring-2 ring-white'
                    : 'bg-slate-950 border border-slate-800 hover:border-slate-700'
                }`}
              >
                {av}
              </button>
            ))}
          </div>
        </div>

        {/* Display Name */}
        <div>
          <label className="text-xs font-bold text-slate-400 block mb-1">Display Name:</label>
          <input 
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            className="w-full p-3 rounded-xl bg-slate-950 border border-slate-700 text-xs text-white"
          />
        </div>

        {/* Daily Study Goal */}
        <div>
          <div className="flex items-center justify-between text-xs font-bold mb-1">
            <span className="text-slate-400">Daily Practice Target (Questions):</span>
            <span className="text-indigo-400">{dailyGoal} questions / day</span>
          </div>
          <input 
            type="range"
            min={5}
            max={50}
            step={5}
            value={dailyGoal}
            onChange={(e) => setDailyGoal(Number(e.target.value))}
            className="w-full accent-indigo-500"
          />
          <div className="flex justify-between text-[10px] text-slate-500 mt-1">
            <span>5 Qs (Casual)</span>
            <span>20 Qs (Recommended)</span>
            <span>50 Qs (Intensive)</span>
          </div>
        </div>

        {/* Audio Toggle */}
        <div className="flex items-center justify-between py-2 border-t border-slate-800/80">
          <div>
            <p className="text-xs font-bold text-white">Audio & Sound FX Synthesizer</p>
            <p className="text-[11px] text-slate-400">Interactive sound effects for answers, boss hits, and level ups</p>
          </div>
          <button
            type="button"
            onClick={toggleSound}
            className={`px-3 py-1.5 rounded-xl text-xs font-bold flex items-center gap-1.5 ${
              !isMuted ? 'bg-emerald-500/20 text-emerald-400' : 'bg-slate-800 text-slate-500'
            }`}
          >
            {!isMuted ? <Volume2 className="w-4 h-4" /> : <VolumeX className="w-4 h-4" />}
            <span>{!isMuted ? 'Enabled' : 'Muted'}</span>
          </button>
        </div>

        {/* Leaderboard Privacy Toggle */}
        <div className="flex items-center justify-between py-2 border-t border-slate-800/80">
          <div>
            <p className="text-xs font-bold text-white">Public Leaderboard Participation</p>
            <p className="text-[11px] text-slate-400">Display your avatar and rank on the division leaderboard</p>
          </div>
          <input 
            type="checkbox"
            checked={leaderboardPublic}
            onChange={(e) => setLeaderboardPublic(e.target.checked)}
            className="w-4 h-4 accent-indigo-500 rounded"
          />
        </div>

        <button
          type="submit"
          className="w-full py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shadow-md transition-all"
        >
          Save Profile & Preferences
        </button>
      </form>

      {/* Danger Zone / Reset */}
      <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 flex items-center justify-between">
        <div>
          <p className="text-xs font-bold text-rose-400">Reset Local Progress</p>
          <p className="text-[11px] text-slate-500">Restore factory demo state and reload verified seed questions</p>
        </div>
        <button
          onClick={handleResetData}
          className="px-4 py-2 rounded-xl bg-rose-950/40 border border-rose-500/30 text-rose-400 hover:bg-rose-900/60 text-xs font-bold"
        >
          Reset Demo Data
        </button>
      </div>

    </div>
  );
};
