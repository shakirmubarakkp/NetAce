import React, { createContext, useContext, useState } from 'react';
import confetti from 'canvas-confetti';
import { soundFX } from '../services/audioService';

interface LevelUpInfo {
  oldLevel: number;
  newLevel: number;
  title: string;
}

interface GameContextType {
  isMuted: boolean;
  toggleSound: () => void;
  fireConfetti: () => void;
  levelUpData: LevelUpInfo | null;
  triggerLevelUp: (info: LevelUpInfo) => void;
  closeLevelUp: () => void;
  isUpgradeModalOpen: boolean;
  openUpgradeModal: (featureName?: string) => void;
  closeUpgradeModal: () => void;
  upgradeFeatureName: string;
}

const GameContext = createContext<GameContextType | undefined>(undefined);

export const GameProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [isMuted, setIsMuted] = useState(false);
  const [levelUpData, setLevelUpData] = useState<LevelUpInfo | null>(null);
  const [isUpgradeModalOpen, setIsUpgradeModalOpen] = useState(false);
  const [upgradeFeatureName, setUpgradeFeatureName] = useState('Premium Feature');

  const toggleSound = () => {
    const next = !isMuted;
    setIsMuted(next);
    soundFX.setMuted(next);
  };

  const fireConfetti = () => {
    try {
      confetti({
        particleCount: 80,
        spread: 70,
        origin: { y: 0.6 }
      });
    } catch {
      // fallback
    }
  };

  const triggerLevelUp = (info: LevelUpInfo) => {
    setLevelUpData(info);
    soundFX.playLevelUp();
    fireConfetti();
  };

  const closeLevelUp = () => {
    setLevelUpData(null);
  };

  const openUpgradeModal = (featureName: string = 'Premium Feature') => {
    setUpgradeFeatureName(featureName);
    setIsUpgradeModalOpen(true);
  };

  const closeUpgradeModal = () => {
    setIsUpgradeModalOpen(false);
  };

  return (
    <GameContext.Provider
      value={{
        isMuted,
        toggleSound,
        fireConfetti,
        levelUpData,
        triggerLevelUp,
        closeLevelUp,
        isUpgradeModalOpen,
        openUpgradeModal,
        closeUpgradeModal,
        upgradeFeatureName
      }}
    >
      {children}
    </GameContext.Provider>
  );
};

export const useGame = () => {
  const context = useContext(GameContext);
  if (!context) throw new Error('useGame must be used within a GameProvider');
  return context;
};
