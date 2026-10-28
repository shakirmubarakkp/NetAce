import React, { useCallback, useState } from 'react';
import { AuthProvider, useAuth } from './context/AuthContext';
import { GameProvider } from './context/GameContext';
import { Navbar } from './components/common/Navbar';
import { Sidebar } from './components/common/Sidebar';
import { MobileNav } from './components/common/MobileNav';
import { LevelUpModal } from './components/common/LevelUpModal';
import { UpgradeModal } from './components/common/UpgradeModal';
import { NotificationCenter } from './components/common/NotificationCenter';

// Views
import { LandingPage } from './components/landing/LandingPage';
import { StudentDashboard } from './components/dashboard/StudentDashboard';
import { ProgressMap } from './components/learn/ProgressMap';
import { GameHub } from './components/games/GameHub';
import { QuizRunner } from './components/games/QuizRunner';
import { BossBattleGame } from './components/games/BossBattleGame';
import { MemoryMatchGame } from './components/games/MemoryMatchGame';
import { Battle1v1Game } from './components/games/Battle1v1Game';
import { MockExamGame } from './components/games/MockExamGame';
import { FlashcardArenaGame } from './components/games/FlashcardArenaGame';
import { ErrorHunterGame } from './components/games/ErrorHunterGame';
import { MatchPairsGame } from './components/games/MatchPairsGame';
import { MistakeNotebookView } from './components/revision/MistakeNotebookView';
import { AnalyticsDashboard } from './components/analytics/AnalyticsDashboard';
import { LeaderboardView } from './components/social/LeaderboardView';
import { ClassroomDashboard } from './components/classroom/ClassroomDashboard';
import { AdminDashboard } from './components/admin/AdminDashboard';
import { UserProfileView } from './components/profile/UserProfileView';
import { AuthPages } from './components/auth/AuthPages';
import { ChapterPractice } from './components/learn/ChapterPractice';
import { ModeratorDashboard } from './components/admin/ModeratorDashboard';

const MainApp: React.FC = () => {
  const { role, isLoggedIn, isLoading, user, authError, clearAuthError } = useAuth();
  const routeFromPath = () => {
    const path = window.location.pathname.replace(/^\/+|\/+$/g, '');
    return path || 'landing';
  };
  const [currentRoute, setCurrentRoute] = useState<string>(routeFromPath);
  const [activeGameMode, setActiveGameMode] = useState<string | null>(null);
  const [activeTopicId, setActiveTopicId] = useState<string | undefined>(undefined);
  const [isNotificationOpen, setIsNotificationOpen] = useState(false);

  const handleNavigate = useCallback((route: string) => {
    setActiveGameMode(null);
    setCurrentRoute(route);
    const path = route === 'landing' ? '/' : `/${route}`;
    if (window.location.pathname !== path) window.history.pushState({}, '', path);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }, []);

  React.useEffect(() => {
    const handlePopState = () => setCurrentRoute(routeFromPath());
    window.addEventListener('popstate', handlePopState);
    return () => window.removeEventListener('popstate', handlePopState);
  }, []);

  React.useEffect(() => {
    if (isLoading) return;
    const publicRoutes = new Set(['landing', 'login', 'signup', 'forgot-password', 'reset-password', 'verify-email']);
    if (!isLoggedIn) {
      if (!publicRoutes.has(currentRoute)) {
        sessionStorage.setItem('netace:returnTo', currentRoute);
        handleNavigate('login');
      }
      return;
    }

    if (currentRoute === 'login' || currentRoute === 'landing' || currentRoute === 'signup') {
      if (role === 'admin') handleNavigate('admin');
      else if (role === 'moderator') handleNavigate('moderator');
      else if (!user.onboardingComplete) handleNavigate('onboarding');
      else handleNavigate('dashboard');
      return;
    }

    if (role === 'admin' && !['admin', 'admin/import', 'profile', 'settings', 'onboarding'].includes(currentRoute)) {
      handleNavigate('admin');
      return;
    }
    if (role === 'moderator' && !['moderator', 'moderator/import', 'profile'].includes(currentRoute)) {
      handleNavigate('moderator');
      return;
    }
    if (role !== 'admin' && role !== 'moderator' && ['admin', 'admin/import', 'moderator', 'moderator/import'].includes(currentRoute)) {
      handleNavigate('unauthorized');
      return;
    }
    if (role !== 'admin' && role !== 'moderator' && !user.onboardingComplete && !['onboarding', 'verify-email'].includes(currentRoute)) {
      handleNavigate('onboarding');
      return;
    }
    if (currentRoute === 'onboarding' && user.onboardingComplete) handleNavigate('dashboard');
  }, [currentRoute, handleNavigate, isLoading, isLoggedIn, role, user.onboardingComplete]);

  // If user role changes to guest, route can be landing
  const handleLaunchGame = (gameMode: string, topicId?: string) => {
    setActiveGameMode(gameMode);
    setActiveTopicId(topicId);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const handleExitGame = () => {
    setActiveGameMode(null);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  // Render Active Game if selected
  const renderGame = () => {
    if (!activeGameMode) return null;

    switch (activeGameMode) {
      case 'boss_battle':
        return <BossBattleGame onExit={handleExitGame} />;
      case 'memory_match':
        return <MemoryMatchGame onExit={handleExitGame} />;
      case 'battle_1v1':
        return <Battle1v1Game onExit={handleExitGame} />;
      case 'mock_exam':
        return <MockExamGame onExit={handleExitGame} />;
      case 'flashcard_arena':
        return <FlashcardArenaGame onExit={handleExitGame} />;
      case 'error_hunter':
        return <ErrorHunterGame onExit={handleExitGame} />;
      case 'match_pairs':
        return <MatchPairsGame onExit={handleExitGame} />;
      default:
        // Quick quiz, speed rush, knowledge ladder, survival, weak topic rescue, pyq machine, true false, elimination
        return (
          <QuizRunner 
            gameMode={activeGameMode} 
            onExit={handleExitGame} 
            topicId={activeTopicId} 
          />
        );
    }
  };

  // Render Page by Route
  const renderContent = () => {
    if (activeGameMode) {
      return renderGame();
    }

    if (['login', 'signup', 'forgot-password', 'reset-password', 'verify-email', 'onboarding'].includes(currentRoute)) {
      return <AuthPages route={currentRoute} onNavigate={handleNavigate} />;
    }

    if (currentRoute === 'landing') {
      return (
        <LandingPage 
          onStartLearning={() => handleNavigate('dashboard')} 
          onExploreGames={() => handleNavigate('play')} 
        />
      );
    }

    switch (currentRoute) {
      case 'dashboard':
        return (
          <StudentDashboard 
            onNavigate={handleNavigate} 
            onLaunchGame={handleLaunchGame} 
          />
        );
      case 'chapter-practice':
        return <ChapterPractice onNavigate={handleNavigate} />;
      case 'unauthorized':
        return (
          <div className="mx-auto max-w-xl rounded-3xl border border-rose-500/25 bg-slate-900 p-8 text-center">
            <h1 className="text-2xl font-black text-white">Access not authorized</h1>
            <p className="mt-2 text-sm leading-6 text-slate-400">Your account does not have permission to open this area.</p>
            <button onClick={() => handleNavigate(role === 'admin' ? 'admin' : role === 'moderator' ? 'moderator' : 'dashboard')} className="mt-5 rounded-xl bg-indigo-600 px-5 py-2.5 text-xs font-bold text-white">Return to your workspace</button>
          </div>
        );
      case 'moderator':
      case 'moderator/import':
        return <ModeratorDashboard />;
      case 'learn':
        return (
          <ProgressMap 
            onStartTopicQuiz={(topicId) => handleLaunchGame('quick_quiz', topicId)}
            onStartBossBattle={(chapId) => handleLaunchGame('boss_battle', chapId)}
          />
        );
      case 'play':
        return <GameHub onSelectGame={handleLaunchGame} />;
      case 'mistakes':
        return <MistakeNotebookView onStartRevisionGame={() => handleLaunchGame('weak_topic_rescue')} />;
      case 'bookmarks':
        return <MistakeNotebookView onStartRevisionGame={() => handleLaunchGame('quick_quiz')} />;
      case 'mock-exam':
        return <MockExamGame onExit={() => handleNavigate('dashboard')} />;
      case 'progress':
      case 'achievements':
        return <AnalyticsDashboard />;
      case 'leaderboard':
        return <LeaderboardView />;
      case 'classroom':
        return <ClassroomDashboard />;
      case 'admin':
      case 'admin/import':
        return <AdminDashboard />;
      case 'profile':
      case 'settings':
      case 'subscription':
        return <UserProfileView />;
      default:
        return (
          <StudentDashboard 
            onNavigate={handleNavigate} 
            onLaunchGame={handleLaunchGame} 
          />
        );
    }
  };

  const isLandingView = currentRoute === 'landing' && !activeGameMode;
  const isAuthView = ['login', 'signup', 'forgot-password', 'reset-password', 'verify-email', 'onboarding'].includes(currentRoute);

  if (isLoading) {
    return <div className="flex min-h-screen items-center justify-center bg-slate-950 text-sm font-semibold text-slate-300">Loading your secure session…</div>;
  }

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100 flex flex-col font-['Plus_Jakarta_Sans']">
      
      {/* Top Navbar */}
      {!isAuthView && <Navbar 
        onNavigate={handleNavigate} 
        currentRoute={currentRoute}
        onOpenNotifications={() => setIsNotificationOpen(true)}
      />}
      {authError && !isAuthView && (
        <div role="alert" className="mx-auto mt-3 flex w-full max-w-7xl items-center justify-between gap-3 px-4 text-xs text-rose-200">
          <span>{authError}</span>
          <button onClick={clearAuthError} aria-label="Dismiss error" className="rounded bg-rose-500/10 px-2 py-1">Dismiss</button>
        </div>
      )}

      {/* Main Body */}
      {isAuthView ? (
        <main className="flex-1">{renderContent()}</main>
      ) : isLandingView ? (
        <main className="flex-1">
          {renderContent()}
        </main>
      ) : (
        <div className="flex-1 flex max-w-7xl w-full mx-auto">
          {/* Desktop Sidebar */}
          <Sidebar currentRoute={currentRoute} onNavigate={handleNavigate} />

          {/* Main Content Area */}
          <main className="flex-1 p-4 sm:p-6 lg:p-8 max-w-5xl w-full pb-20 md:pb-8">
            {renderContent()}
          </main>
        </div>
      )}

      {/* Mobile Bottom Navigation Bar (Hidden on Desktop) */}
      {!isAuthView && !activeGameMode && role !== 'admin' && role !== 'moderator' && (
        <MobileNav currentRoute={currentRoute} onNavigate={handleNavigate} />
      )}

      {/* Global Modals */}
      <LevelUpModal />
      <UpgradeModal />
      <NotificationCenter 
        isOpen={isNotificationOpen} 
        onClose={() => setIsNotificationOpen(false)} 
      />

    </div>
  );
};

export default function App() {
  return (
    <AuthProvider>
      <GameProvider>
        <MainApp />
      </GameProvider>
    </AuthProvider>
  );
}
