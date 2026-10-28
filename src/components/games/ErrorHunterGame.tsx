import React, { useState } from 'react';
import { Sparkles, CheckCircle2, XCircle, RotateCcw, Award, ChevronRight } from 'lucide-react';
import { storage } from '../../services/storageService';
import { soundFX } from '../../services/audioService';
import { useGame } from '../../context/GameContext';

interface ErrorHunterGameProps {
  onExit: () => void;
}

export const ErrorHunterGame: React.FC<ErrorHunterGameProps> = ({ onExit }) => {
  const { fireConfetti } = useGame();

  const [selectedStep, setSelectedStep] = useState<number | null>(null);
  const [isAnswerSubmitted, setIsAnswerSubmitted] = useState(false);
  const [isSuccess, setIsSuccess] = useState(false);

  // Worked physics / logic derivation containing an intentional physical or grammatical flaw
  const derivationItem = {
    title: 'Error Hunter Challenge: Road Banking Dynamics',
    context: 'A student was asked to derive the maximum safe turning velocity v on a banked friction-free curve of radius R at angle θ. Examine their 4-step derivation below and tap the step containing the flaw:',
    steps: [
      {
        stepNo: 1,
        title: 'Step 1: Component Breakdown of Normal Reaction',
        formula: 'Vertical component: N cos θ upward; Horizontal component: N sin θ towards center of curvature.',
        hasFlaw: false
      },
      {
        stepNo: 2,
        title: 'Step 2: Vertical Force Equilibrium',
        formula: 'Equating vertical forces: N cos θ = m * g  ==>  N = (m * g) / cos θ.',
        hasFlaw: false
      },
      {
        stepNo: 3,
        title: 'Step 3: Centripetal Force Equation',
        formula: 'N sin θ = m * v² * R   [The student multiplied by R instead of dividing by R]',
        hasFlaw: true,
        flawExplanation: 'Centripetal force is strictly F_c = (m * v²) / R. Multiplying by R yields units of kg·m³/s² instead of force (Newtons / kg·m/s²). Dimensional consistency was violated!'
      },
      {
        stepNo: 4,
        title: 'Step 4: Division & Simplification',
        formula: 'Dividing Step 3 by Step 2 yields: tan θ = v² * R / g.',
        hasFlaw: false
      }
    ]
  };

  const handleStepClick = (stepNo: number) => {
    if (isAnswerSubmitted) return;
    setSelectedStep(stepNo);
    setIsAnswerSubmitted(true);

    const step = derivationItem.steps.find(s => s.stepNo === stepNo);
    if (step?.hasFlaw) {
      soundFX.playCorrect();
      setIsSuccess(true);
      fireConfetti();
      storage.awardXp(50, 'Spotted flaw in Error Hunter', 'achievement');
    } else {
      soundFX.playIncorrect();
      setIsSuccess(false);
    }
  };

  return (
    <div className="max-w-2xl mx-auto space-y-4 animate-in fade-in">
      
      {/* Top Bar */}
      <div className="flex items-center justify-between text-xs px-1">
        <button onClick={onExit} className="text-slate-400 hover:text-white">✕ Exit</button>
        <span className="text-pink-400 font-bold uppercase tracking-wider flex items-center gap-1">
          <Sparkles className="w-3.5 h-3.5" />
          <span>Error Hunter Game #20</span>
        </span>
        <span className="text-amber-400 font-mono font-bold">+50 XP</span>
      </div>

      <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl space-y-4">
        <div>
          <span className="text-[10px] font-bold uppercase tracking-wider px-2.5 py-0.5 rounded-full bg-pink-500/10 text-pink-300 border border-pink-500/30">
            Critical Reasoning Drill
          </span>
          <h3 className="text-lg font-black text-white font-['Outfit'] mt-2">
            {derivationItem.title}
          </h3>
          <p className="text-xs text-slate-300 mt-1 leading-relaxed">
            {derivationItem.context}
          </p>
        </div>

        {/* Steps to Inspect */}
        <div className="space-y-3 pt-2">
          {derivationItem.steps.map(step => {
            let borderStyle = 'border-slate-800 bg-slate-950/70 hover:border-pink-500/50';

            if (isAnswerSubmitted) {
              if (step.hasFlaw) {
                borderStyle = 'border-emerald-500 bg-emerald-500/20 text-white font-bold ring-2 ring-emerald-400/40';
              } else if (selectedStep === step.stepNo) {
                borderStyle = 'border-rose-500 bg-rose-500/20 text-rose-300';
              } else {
                borderStyle = 'border-slate-800/40 opacity-40';
              }
            }

            return (
              <div
                key={step.stepNo}
                onClick={() => handleStepClick(step.stepNo)}
                className={`cursor-pointer p-4 rounded-2xl border transition-all ${borderStyle}`}
              >
                <div className="flex items-center justify-between mb-1 text-xs">
                  <span className="font-bold text-slate-300">{step.title}</span>
                  {isAnswerSubmitted && step.hasFlaw && (
                    <span className="text-emerald-400 font-bold text-xs flex items-center gap-1">
                      <CheckCircle2 className="w-4 h-4" />
                      <span>Flaw Located Here!</span>
                    </span>
                  )}
                </div>
                <p className="font-mono text-xs text-slate-200 mt-1">
                  {step.formula}
                </p>
              </div>
            );
          })}
        </div>

        {/* Post-selection Diagnostic */}
        {isAnswerSubmitted && (
          <div className="p-4 rounded-2xl bg-slate-950 border border-slate-800 text-xs animate-in fade-in space-y-3">
            <div className="flex items-center gap-1.5 font-bold">
              {isSuccess ? (
                <span className="text-emerald-400 flex items-center gap-1">
                  <CheckCircle2 className="w-4 h-4" />
                  <span>Spot-on! You spotted the intentional mistake in Step 3!</span>
                </span>
              ) : (
                <span className="text-rose-400 flex items-center gap-1">
                  <XCircle className="w-4 h-4" />
                  <span>Not quite! The error is in Step 3.</span>
                </span>
              )}
            </div>

            <p className="text-slate-300 leading-relaxed">
              {derivationItem.steps.find(s => s.hasFlaw)?.flawExplanation}
            </p>

            <button
              onClick={onExit}
              className="w-full py-3 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs"
            >
              Continue Playing Other Modes
            </button>
          </div>
        )}

      </div>

    </div>
  );
};
