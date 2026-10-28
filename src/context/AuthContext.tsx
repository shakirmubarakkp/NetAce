import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import type { UserProfile, UserRole } from '../types';
import { storage } from '../services/storageService';
import { googleOAuthEnabled, supabase, supabaseConfigError } from '../services/supabaseClient';
import type { User } from '@supabase/supabase-js';
import { DEFAULT_USER_PROFILE } from '../data/initialData';

interface AuthContextType {
  user: UserProfile;
  role: UserRole;
  isLoggedIn: boolean;
  isPremium: boolean;
  isLoading: boolean;
  authError: string | null;
  configurationError: string | null;
  clearAuthError: () => void;
  updateTargetExam: (examId: string) => Promise<void>;
  updateUserProfile: (profile: { name: string; avatar: string; dailyGoal: number }) => Promise<void>;
  toggleSubjectPreference: (subjectId: string) => void;
  refreshUser: () => Promise<void>;
  signIn: (email: string, password: string) => Promise<void>;
  signInWithGoogle: () => Promise<void>;
  signUp: (name: string, email: string, password: string) => Promise<void>;
  sendPasswordReset: (email: string) => Promise<void>;
  updatePassword: (password: string) => Promise<void>;
  resendVerification: (email: string) => Promise<void>;
  completeOnboarding: (preferences: {
    targetExamId: string;
    preferredSubjectIds: string[];
    dailyGoal: number;
    targetExamDate?: string;
    preferredStudyModes: string[];
  }) => Promise<void>;
  logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

const guestProfile: UserProfile = {
  ...DEFAULT_USER_PROFILE,
  id: 'guest',
  name: 'Guest Learner',
  email: '',
  avatar: '👤',
  role: 'guest',
  xp: 0,
  level: 1,
  levelTitle: 'Beginner',
  streakDays: 0,
  todayQuestionsAnswered: 0,
  coins: 0,
  isPremium: false
};

interface ProfileRow {
  id: string;
  auth_user_id: string;
  email: string;
  name: string;
  avatar: string | null;
  role: UserRole;
  target_exam_id: string | null;
  preferred_subject_ids: string[] | null;
  daily_goal: number | null;
  xp: number | null;
  level: number | null;
  level_title: string | null;
  streak_days: number | null;
  last_active_date: string | null;
  streak_frozen: boolean | null;
  coins: number | null;
  is_premium: boolean | null;
  premium_expires_at: string | null;
  plan_id: 'free' | 'monthly' | 'annual' | null;
  onboarding_complete: boolean | null;
  target_exam_date: string | null;
  preferred_study_modes: string[] | null;
  created_at: string;
}

const isUserRole = (role: string): role is UserRole =>
  ['guest', 'free_student', 'premium_student', 'moderator', 'admin'].includes(role);

const toUserProfile = (row: ProfileRow): UserProfile => ({
  ...guestProfile,
  id: row.auth_user_id,
  email: row.email,
  name: row.name,
  avatar: row.avatar || '🚀',
  role: isUserRole(row.role) ? row.role : 'free_student',
  targetExamId: row.target_exam_id || 'ugc_net',
  preferredSubjectIds: row.preferred_subject_ids || [],
  dailyGoal: row.daily_goal || 15,
  xp: row.xp || 0,
  level: row.level || 1,
  levelTitle: row.level_title || 'Beginner',
  streakDays: row.streak_days || 0,
  lastActiveDate: row.last_active_date || new Date().toISOString().slice(0, 10),
  streakFrozen: row.streak_frozen || false,
  coins: row.coins || 0,
  isPremium: row.is_premium || row.role === 'admin' || row.role === 'premium_student',
  premiumExpiresAt: row.premium_expires_at || undefined,
  planId: row.plan_id || 'free',
  onboardingComplete: row.onboarding_complete || false,
  targetExamDate: row.target_exam_date || undefined,
  preferredStudyModes: row.preferred_study_modes || [],
  createdAt: row.created_at
});

const preserveLocalGameStats = (profile: UserProfile): UserProfile => {
  const localProfile = storage.getUser();
  return localProfile.id === profile.id
    ? {
        ...profile,
        xp: localProfile.xp,
        level: localProfile.level,
        levelTitle: localProfile.levelTitle,
        streakDays: localProfile.streakDays,
        todayQuestionsAnswered: localProfile.todayQuestionsAnswered,
        coins: localProfile.coins
      }
    : profile;
};

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<UserProfile>(guestProfile);
  const [isLoading, setIsLoading] = useState(Boolean(supabase));
  const [authError, setAuthError] = useState<string | null>(null);

  const loadProfile = useCallback(async (authUser: User): Promise<UserProfile> => {
    if (!supabase) throw new Error(supabaseConfigError || 'Supabase is not configured.');

    const { data, error } = await supabase
      .from('profiles')
      .select('*')
      .eq('auth_user_id', authUser.id)
      .maybeSingle();
    if (error) throw error;
    if (!data) throw new Error('Your account profile was not created. Apply the latest Supabase migration and try again.');
    const hydratedProfile = preserveLocalGameStats(toUserProfile(data as ProfileRow));
    storage.saveUser(hydratedProfile);
    return hydratedProfile;
  }, []);

  const refreshUser = useCallback(async () => {
    if (!supabase) return;
    const { data, error } = await supabase.auth.getUser();
    if (error) throw error;
    if (!data.user) {
      setUser(guestProfile);
      return;
    }
    setUser(await loadProfile(data.user));
  }, [loadProfile]);

  useEffect(() => {
    if (!supabase) {
      setIsLoading(false);
      return;
    }

    let active = true;
    const initialize = async () => {
      try {
        const { data, error } = await supabase.auth.getSession();
        if (error) throw error;
        if (data.session?.user) {
          const profile = await loadProfile(data.session.user);
          if (active) setUser(profile);
        }
      } catch (error) {
        if (active) setAuthError(error instanceof Error ? error.message : 'Unable to load your account.');
      } finally {
        if (active) setIsLoading(false);
      }
    };

    void initialize();
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session?.user) {
        setUser(guestProfile);
        setIsLoading(false);
        return;
      }
      setIsLoading(true);
      void loadProfile(session.user)
        .then(profile => { if (active) setUser(profile); })
        .catch(error => {
          if (active) setAuthError(error instanceof Error ? error.message : 'Unable to load your account.');
        })
        .finally(() => { if (active) setIsLoading(false); });
    });

    return () => {
      active = false;
      subscription.unsubscribe();
    };
  }, [loadProfile]);

  const requireSupabase = () => {
    if (!supabase) throw new Error(supabaseConfigError || 'Supabase is not configured.');
    setAuthError(null);
    return supabase;
  };

  const signIn = async (email: string, password: string) => {
    const client = requireSupabase();
    const { error } = await client.auth.signInWithPassword({ email, password });
    if (error) throw error;
    await refreshUser();
  };

  const signInWithGoogle = async () => {
    const client = requireSupabase();
    if (!googleOAuthEnabled) throw new Error('Google sign-in is not enabled for this application.');
    const { error } = await client.auth.signInWithOAuth({
      provider: 'google',
      options: { redirectTo: `${window.location.origin}/dashboard` }
    });
    if (error) throw error;
  };

  const signUp = async (name: string, email: string, password: string) => {
    const client = requireSupabase();
    const { error } = await client.auth.signUp({
      email,
      password,
      options: {
        data: { full_name: name, terms_accepted: true },
        emailRedirectTo: `${window.location.origin}/verify-email`
      }
    });
    if (error) throw error;
  };

  const sendPasswordReset = async (email: string) => {
    const client = requireSupabase();
    const { error } = await client.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/reset-password`
    });
    if (error) throw error;
  };

  const updatePassword = async (password: string) => {
    const client = requireSupabase();
    const { error } = await client.auth.updateUser({ password });
    if (error) throw error;
  };

  const resendVerification = async (email: string) => {
    const client = requireSupabase();
    const { error } = await client.auth.resend({ type: 'signup', email });
    if (error) throw error;
  };

  const updateProfile = async (updates: Record<string, unknown>) => {
    const client = requireSupabase();
    const { data: { user: authUser }, error: authErrorResponse } = await client.auth.getUser();
    if (authErrorResponse) throw authErrorResponse;
    if (!authUser) throw new Error('Sign in before updating your profile.');

    const { data, error } = await client
      .from('profiles')
      .update(updates)
      .eq('auth_user_id', authUser.id)
      .select('*')
      .single();
    if (error) throw error;
    const profile = preserveLocalGameStats(toUserProfile(data as ProfileRow));
    storage.saveUser(profile);
    setUser(profile);
  };

  const updateTargetExam = async (examId: string) => {
    try {
      await updateProfile({ target_exam_id: examId });
    } catch (error) {
      setAuthError(error instanceof Error ? error.message : 'Unable to save your target examination.');
    }
  };

  const updateUserProfile = async (profile: { name: string; avatar: string; dailyGoal: number }) => {
    await updateProfile({ name: profile.name.trim(), avatar: profile.avatar, daily_goal: profile.dailyGoal });
  };

  const toggleSubjectPreference = (subjectId: string) => {
    const preferences = user.preferredSubjectIds.includes(subjectId)
      ? user.preferredSubjectIds.filter(id => id !== subjectId)
      : [...user.preferredSubjectIds, subjectId];
    void updateProfile({ preferred_subject_ids: preferences }).catch(error => {
      setAuthError(error instanceof Error ? error.message : 'Unable to save subject preferences.');
    });
  };

  const completeOnboarding = async (preferences: {
    targetExamId: string;
    preferredSubjectIds: string[];
    dailyGoal: number;
    targetExamDate?: string;
    preferredStudyModes: string[];
  }) => {
    await updateProfile({
      target_exam_id: preferences.targetExamId,
      preferred_subject_ids: preferences.preferredSubjectIds,
      daily_goal: preferences.dailyGoal,
      target_exam_date: preferences.targetExamDate || null,
      preferred_study_modes: preferences.preferredStudyModes,
      onboarding_complete: true
    });
  };

  const logout = async () => {
    try {
      const client = requireSupabase();
      const { error } = await client.auth.signOut();
      if (error) throw error;
      setUser(guestProfile);
    } catch (error) {
      setAuthError(error instanceof Error ? error.message : 'Unable to sign out.');
    }
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        role: user.role,
        isLoggedIn: user.role !== 'guest',
        isPremium: user.isPremium,
        isLoading,
        authError,
        configurationError: supabaseConfigError,
        clearAuthError: () => setAuthError(null),
        updateTargetExam,
        updateUserProfile,
        toggleSubjectPreference,
        refreshUser,
        signIn,
        signInWithGoogle,
        signUp,
        sendPasswordReset,
        updatePassword,
        resendVerification,
        completeOnboarding,
        logout
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error('useAuth must be used within an AuthProvider');
  return context;
};
