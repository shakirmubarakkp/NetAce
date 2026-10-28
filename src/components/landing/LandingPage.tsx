import React, { useState } from 'react';
import { 
  Zap, 
  Crown, 
  Gamepad2, 
  Compass, 
  Trophy, 
  ArrowRight, 
  CheckCircle2, 
  Flame, 
  Sparkles, 
  ChevronDown, 
  ChevronUp, 
  Check, 
  Layers, 
  HelpCircle,
  GraduationCap,
  Swords,
  Clock,
  RotateCcw
} from 'lucide-react';
import { INITIAL_EXAMINATIONS } from '../../data/initialData';
import { useGame } from '../../context/GameContext';
import { soundFX } from '../../services/audioService';

interface LandingPageProps {
  onStartLearning: () => void;
  onExploreGames: () => void;
}

export const LandingPage: React.FC<LandingPageProps> = ({ onStartLearning, onExploreGames }) => {
  const { openUpgradeModal, fireConfetti } = useGame();

  // Interactive Live Quiz Preview State on Landing Page
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [isAnswerSubmitted, setIsAnswerSubmitted] = useState<boolean>(false);
  const [openFaqIndex, setOpenFaqIndex] = useState<number | null>(null);

  const previewQuestion = {
    exam: 'UGC NET Paper I — Teaching Aptitude',
    text: 'Which cognitive level of teaching is primarily focused on problem formulation, creative hypothesis generation, and critical self-evaluation?',
    options: [
      { id: 1, text: 'Memory Level of Teaching (Herbart)', isCorrect: false },
      { id: 2, text: 'Understanding Level of Teaching (Morrison)', isCorrect: false },
      { id: 3, text: 'Reflective Level of Teaching (Hunt)', isCorrect: true },
      { id: 4, text: 'Conditioning & Association Level', isCorrect: false }
    ],
    explanation: 'Propounded by Maurice P. Hunt, the Reflective Level is the highest tier of cognitive engagement. Learners tackle authentic problems, form inductive hypotheses, and evaluate outcomes.'
  };

  const handlePreviewSubmit = (idx: number) => {
    setSelectedOption(idx);
    setIsAnswerSubmitted(true);
    if (previewQuestion.options[idx].isCorrect) {
      soundFX.playCorrect();
      fireConfetti();
    } else {
      soundFX.playIncorrect();
    }
  };

  const gameModeHighlights = [
    { title: 'Quick Quiz', desc: '5, 10, or 20 rapid-fire questions with instant answer diagnostics.', icon: Zap, color: 'from-blue-500 to-indigo-600' },
    { title: 'Speed Rush', desc: 'Beat the clock! Fast answers earn bonus multipliers and adrenaline boosts.', icon: Clock, color: 'from-amber-500 to-orange-600' },
    { title: 'Chapter Boss Battle', desc: 'Tackle the chapter titan with 3 lives and mixed difficulty questions.', icon: Swords, color: 'from-rose-500 to-red-700' },
    { title: 'PYQ Time Machine', desc: 'Simulate verified previous year exams from 2023, 2022, and 2021.', icon: GraduationCap, color: 'from-emerald-500 to-teal-700' },
    { title: 'Memory Match', desc: 'Flip and pair authors, books, formulas, and terminology against time.', icon: Layers, color: 'from-purple-500 to-indigo-700' },
    { title: 'Weak Topic Rescue', desc: 'Targeted revision on topics where your accuracy dipped below 60%.', icon: RotateCcw, color: 'from-cyan-500 to-blue-700' }
  ];

  const faqs = [
    {
      q: 'Which examinations does NetAce currently prioritize?',
      a: 'NetAce prioritizes UGC NET / JRF (including General Paper 1, Arabic, Malayalam, and English), KTET Category 1 & 2, and JEE Main. Additional exams such as Banking PO, PSC, and University entrances are architected into the system and expanding regularly.'
    },
    {
      q: 'How does NetAce differ from regular quiz websites?',
      a: 'NetAce is a true gamified learning engine with 20 distinct gameplay modes, a Mistake Notebook powered by the SM-2 spaced repetition algorithm, chapter boss encounters, visual skill-tree paths, live 1v1 battle matchmaking, and downloadable PDF performance diagnostics.'
    },
    {
      q: 'Can I use NetAce for free?',
      a: 'Yes! NetAce offers a robust Free tier providing access to designated free chapters, daily study quests, streak rewards, basic game modes, and learning path progress. Upgrading to NetAce Pro (₹99/month or ₹799/year) unlocks the complete PYQ archive, live battles, full-length timed mock exams, and PDF diagnostics.'
    },
    {
      q: 'Are the questions authentic and verified?',
      a: 'Yes. All PYQs cite the official examination, paper, year, and question number. Questions are reviewed by subject moderators, with full step-by-step academic explanations.'
    },
    {
      q: 'Is NetAce accessible on mobile without installing an app?',
      a: 'Absolutely. NetAce is built mobile-first as an installable Progressive Web App (PWA). You can save it directly to your phone’s home screen on Android or iOS.'
    }
  ];

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100 flex flex-col font-['Plus_Jakarta_Sans'] selection:bg-indigo-500 selection:text-white">
      
      {/* 1. HERO SECTION */}
      <section className="relative pt-12 pb-20 px-4 overflow-hidden border-b border-slate-800/80">
        {/* Glow effects */}
        <div className="absolute top-1/4 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[350px] bg-gradient-to-tr from-indigo-600/20 via-violet-600/15 to-amber-500/10 rounded-full blur-[100px] pointer-events-none"></div>

        <div className="max-w-6xl mx-auto grid grid-cols-1 lg:grid-cols-12 gap-12 items-center relative z-10">
          
          {/* Left Hero Text */}
          <div className="lg:col-span-7 text-center lg:text-left">
            
            {/* Pill */}
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-indigo-500/10 border border-indigo-500/30 text-indigo-300 text-xs font-semibold mb-6 shadow-sm">
              <Sparkles className="w-4 h-4 text-amber-400" />
              <span>Next-Gen Gamified Exam Preparation</span>
            </div>

            {/* Headline per Prompt */}
            <h1 className="text-4xl sm:text-5xl lg:text-6xl font-black text-white tracking-tight leading-[1.1] font-['Outfit'] mb-4">
              Make Every Study Session <br className="hidden sm:block" />
              <span className="bg-gradient-to-r from-indigo-400 via-amber-300 to-orange-400 bg-clip-text text-transparent">
                a Game.
              </span>
            </h1>

            {/* Supporting Text per Prompt */}
            <p className="text-base sm:text-lg text-slate-300 max-w-xl mx-auto lg:mx-0 mb-8 leading-relaxed font-normal">
              Practice smarter. Level up. Get exam-ready. Master UGC NET, KTET, and JEE Main with 20 addictive educational study games, verified PYQs, and spaced repetition.
            </p>

            {/* CTAs per Prompt */}
            <div className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-4">
              <button
                onClick={onStartLearning}
                className="w-full sm:w-auto px-8 py-4 rounded-2xl bg-gradient-to-r from-indigo-600 via-indigo-500 to-indigo-600 hover:from-indigo-500 hover:to-indigo-700 text-white font-black text-base shadow-xl shadow-indigo-600/30 flex items-center justify-center gap-3 transition-all hover:scale-[1.02]"
              >
                <span>Start Learning Free</span>
                <ArrowRight className="w-5 h-5" />
              </button>

              <button
                onClick={onExploreGames}
                className="w-full sm:w-auto px-7 py-4 rounded-2xl bg-slate-900 border border-slate-700 hover:border-slate-500 text-slate-200 font-bold text-base flex items-center justify-center gap-2 transition-all hover:bg-slate-800"
              >
                <Gamepad2 className="w-5 h-5 text-indigo-400" />
                <span>Explore Study Games</span>
              </button>
            </div>

            {/* Value Highlights */}
            <div className="mt-8 flex flex-wrap items-center justify-center lg:justify-start gap-5 text-xs text-slate-400">
              <div className="flex items-center gap-1.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-400" />
                <span>No Credit Card Required</span>
              </div>
              <div className="flex items-center gap-1.5">
                <Flame className="w-4 h-4 text-amber-400" />
                <span>7-Day Daily Streaks</span>
              </div>
              <div className="flex items-center gap-1.5">
                <Trophy className="w-4 h-4 text-indigo-400" />
                <span>20 Game Modes</span>
              </div>
            </div>

          </div>

          {/* Right Hero: Interactive Quiz Challenge Preview (Prompt Requirement) */}
          <div className="lg:col-span-5">
            <div className="relative rounded-3xl bg-slate-900/90 border-2 border-indigo-500/40 p-6 shadow-2xl shadow-indigo-950/60 backdrop-blur-xl">
              
              {/* Badge */}
              <div className="flex items-center justify-between mb-4">
                <span className="text-[10px] font-bold uppercase tracking-wider px-2.5 py-1 rounded-full bg-indigo-500/20 text-indigo-300 border border-indigo-500/30">
                  {previewQuestion.exam}
                </span>
                <div className="flex items-center gap-1 text-xs font-mono font-bold text-amber-400">
                  <Zap className="w-3.5 h-3.5 fill-amber-400" />
                  <span>+15 XP</span>
                </div>
              </div>

              {/* Question Text */}
              <p className="text-sm font-bold text-white mb-4 leading-snug">
                {previewQuestion.text}
              </p>

              {/* Options */}
              <div className="space-y-2 mb-4">
                {previewQuestion.options.map((opt, idx) => {
                  let btnStyle = 'border-slate-800 bg-slate-950/70 text-slate-300 hover:border-indigo-500/60';
                  if (isAnswerSubmitted) {
                    if (opt.isCorrect) {
                      btnStyle = 'border-emerald-500 bg-emerald-500/20 text-emerald-300 font-bold';
                    } else if (selectedOption === idx) {
                      btnStyle = 'border-rose-500 bg-rose-500/20 text-rose-300 font-bold';
                    } else {
                      btnStyle = 'border-slate-800 bg-slate-950/40 text-slate-500';
                    }
                  }

                  return (
                    <button
                      key={opt.id}
                      disabled={isAnswerSubmitted}
                      onClick={() => handlePreviewSubmit(idx)}
                      className={`w-full text-left p-3 rounded-xl border text-xs transition-all flex items-center justify-between ${btnStyle}`}
                    >
                      <span>{opt.text}</span>
                      {isAnswerSubmitted && opt.isCorrect && (
                        <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
                      )}
                    </button>
                  );
                })}
              </div>

              {/* Post-submit feedback */}
              {isAnswerSubmitted && (
                <div className="p-3 rounded-xl bg-slate-950 border border-slate-800 text-xs animate-in fade-in">
                  <div className="flex items-center gap-1.5 font-bold mb-1 text-emerald-400">
                    <Sparkles className="w-3.5 h-3.5" />
                    <span>Instant Academic Diagnostic</span>
                  </div>
                  <p className="text-[11px] text-slate-300 leading-relaxed mb-3">
                    {previewQuestion.explanation}
                  </p>
                  <button
                    onClick={onStartLearning}
                    className="w-full py-2 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs transition-colors flex items-center justify-center gap-1.5"
                  >
                    <span>Play More Free Questions</span>
                    <ArrowRight className="w-3.5 h-3.5" />
                  </button>
                </div>
              )}

              {!isAnswerSubmitted && (
                <p className="text-[11px] text-center text-slate-400">
                  👆 Tap an option to test your knowledge right now!
                </p>
              )}

            </div>
          </div>

        </div>
      </section>

      {/* 2. SUPPORTED EXAMINATIONS CARDS */}
      <section className="py-16 px-4 bg-slate-900/50 border-b border-slate-800/80">
        <div className="max-w-6xl mx-auto">
          <div className="text-center max-w-2xl mx-auto mb-12">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white font-['Outfit'] mb-2">
              Supported Competitive Examinations
            </h2>
            <p className="text-xs sm:text-sm text-slate-400">
              Architected to support diverse syllabi, languages, and marking schemes without rebuilding.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
            {INITIAL_EXAMINATIONS.map(exam => (
              <div 
                key={exam.id}
                onClick={onStartLearning}
                className="cursor-pointer group p-5 rounded-2xl bg-slate-900 border border-slate-800 hover:border-indigo-500/60 transition-all hover:-translate-y-1 shadow-lg shadow-black/20"
              >
                <div className="flex items-start justify-between mb-4">
                  <div className={`p-3 rounded-xl bg-gradient-to-tr ${exam.badgeColor} text-white shadow-md`}>
                    <GraduationCap className="w-6 h-6" />
                  </div>
                  {exam.isPopular && (
                    <span className="text-[10px] font-black uppercase tracking-wider px-2 py-0.5 rounded-full bg-amber-500/20 text-amber-400 border border-amber-500/30">
                      Popular
                    </span>
                  )}
                </div>
                <h3 className="text-lg font-bold text-white group-hover:text-indigo-300 transition-colors mb-1">
                  {exam.name}
                </h3>
                <p className="text-xs text-slate-400 leading-relaxed mb-4">
                  {exam.description}
                </p>
                <div className="flex items-center justify-between text-xs text-slate-400 pt-3 border-t border-slate-800/60">
                  <span className="font-semibold text-indigo-400">{exam.category}</span>
                  <span className="flex items-center gap-1 group-hover:translate-x-1 transition-transform">
                    <span>View Path</span>
                    <ArrowRight className="w-3.5 h-3.5" />
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* 3. 20 STUDY GAME MODES PREVIEW */}
      <section className="py-16 px-4 border-b border-slate-800/80">
        <div className="max-w-6xl mx-auto">
          <div className="text-center max-w-2xl mx-auto mb-12">
            <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-amber-500/10 text-amber-400 text-xs font-bold mb-3">
              <Flame className="w-3.5 h-3.5" />
              <span>20 PLAYABLE STUDY GAME MODES</span>
            </div>
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white font-['Outfit'] mb-2">
              Transform Boring Study into High-Stakes Gameplay
            </h2>
            <p className="text-xs sm:text-sm text-slate-400">
              Each mode taps into a different cognitive channel: speed, retention, error recognition, and competitive strategy.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
            {gameModeHighlights.map((mode, i) => {
              const Icon = mode.icon;
              return (
                <div 
                  key={i}
                  onClick={onExploreGames}
                  className="cursor-pointer group p-5 rounded-2xl bg-slate-900/60 border border-slate-800 hover:border-slate-700 transition-all hover:bg-slate-900"
                >
                  <div className={`w-12 h-12 rounded-xl bg-gradient-to-tr ${mode.color} flex items-center justify-center text-white mb-4 shadow-lg`}>
                    <Icon className="w-6 h-6" />
                  </div>
                  <h3 className="text-base font-bold text-white mb-1.5 group-hover:text-amber-300 transition-colors">
                    {mode.title}
                  </h3>
                  <p className="text-xs text-slate-400 leading-relaxed">
                    {mode.desc}
                  </p>
                </div>
              );
            })}
          </div>

          <div className="mt-10 text-center">
            <button
              onClick={onExploreGames}
              className="inline-flex items-center gap-2 px-6 py-3 rounded-xl bg-indigo-600/20 hover:bg-indigo-600/30 border border-indigo-500/40 text-indigo-300 text-xs font-bold transition-all"
            >
              <span>Explore all 20 modes (Boss Battles, 1v1 Battle, Error Hunter, and more)</span>
              <ArrowRight className="w-4 h-4" />
            </button>
          </div>
        </div>
      </section>

      {/* 4. HOW NETACE WORKS (Core Learning Loop) */}
      <section className="py-16 px-4 bg-slate-900/40 border-b border-slate-800/80">
        <div className="max-w-6xl mx-auto">
          <div className="text-center max-w-2xl mx-auto mb-12">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white font-['Outfit'] mb-2">
              The NetAce Core Learning Loop
            </h2>
            <p className="text-xs sm:text-sm text-slate-400">
              Engineered to encourage genuine cognitive mastery rather than clicking or guessing.
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {[
              { step: '01', title: 'Choose & Target', desc: 'Select your examination (e.g. UGC NET Arabic or KTET) and current chapter.', icon: GraduationCap },
              { step: '02', title: 'Play to Learn', desc: 'Engage in Quick Quiz, Speed Rush, or Memory Match with verified questions.', icon: Gamepad2 },
              { step: '03', title: 'Instant Feedback', desc: 'Digest step-by-step reasoning. Incorrect answers automatically queue into your Mistake Notebook.', icon: Sparkles },
              { step: '04', title: 'Level Up & Ace', desc: 'Earn XP, unlock Chapter Bosses, defeat weak topics, and track exam readiness.', icon: Trophy }
            ].map((step, idx) => (
              <div key={idx} className="relative p-6 rounded-2xl bg-slate-900 border border-slate-800">
                <span className="text-3xl font-black text-indigo-500/30 font-['Outfit'] block mb-2">{step.step}</span>
                <h3 className="text-base font-bold text-white mb-2">{step.title}</h3>
                <p className="text-xs text-slate-400 leading-relaxed">{step.desc}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* 5. FREE VS PREMIUM COMPARISON (Prompt Requirement) */}
      <section className="py-16 px-4 border-b border-slate-800/80">
        <div className="max-w-4xl mx-auto">
          <div className="text-center max-w-2xl mx-auto mb-12">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white font-['Outfit'] mb-2">
              Transparent, Flexible Plans
            </h2>
            <p className="text-xs sm:text-sm text-slate-400">
              Start completely free. Upgrade anytime for full question archives, live battles, and PDF diagnostics.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            
            {/* Free Tier */}
            <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 flex flex-col justify-between">
              <div>
                <div className="inline-block px-3 py-1 rounded-full bg-slate-800 text-slate-300 text-xs font-bold mb-4">
                  Free Student Plan
                </div>
                <div className="flex items-baseline gap-1 mb-4">
                  <span className="text-3xl font-black text-white">₹0</span>
                  <span className="text-xs text-slate-400">/forever</span>
                </div>
                <p className="text-xs text-slate-400 mb-6">
                  Perfect for foundational practice and exploring sample chapters.
                </p>
                <div className="space-y-3 mb-8">
                  {[
                    'Designated free chapters per subject',
                    'Basic study games (Quick Quiz, Flashcards)',
                    'Earn XP, build streaks, unlock basic badges',
                    'Mistake notebook for free sets',
                    'Read-only leaderboard viewing'
                  ].map((feat, i) => (
                    <div key={i} className="flex items-center gap-2.5 text-xs text-slate-300">
                      <Check className="w-4 h-4 text-emerald-400 shrink-0" />
                      <span>{feat}</span>
                    </div>
                  ))}
                </div>
              </div>
              <button
                onClick={onStartLearning}
                className="w-full py-3 rounded-xl bg-slate-800 hover:bg-slate-700 text-white font-bold text-xs transition-colors"
              >
                Start Free Learning
              </button>
            </div>

            {/* Premium Tier */}
            <div className="relative p-6 rounded-3xl bg-gradient-to-b from-indigo-950/60 via-slate-900 to-slate-900 border-2 border-amber-500/60 flex flex-col justify-between shadow-xl shadow-amber-500/10">
              <span className="absolute -top-3 right-6 px-3 py-0.5 rounded-full bg-gradient-to-r from-amber-500 to-orange-500 text-slate-950 text-[10px] font-black uppercase tracking-wider">
                Recommended
              </span>
              <div>
                <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-amber-500/10 border border-amber-500/30 text-amber-400 text-xs font-bold mb-4">
                  <Crown className="w-3.5 h-3.5 fill-amber-400" />
                  <span>NetAce Pro Access</span>
                </div>
                <div className="flex items-baseline gap-1 mb-4">
                  <span className="text-3xl font-black text-white">₹99</span>
                  <span className="text-xs text-slate-400">/month or ₹799/year</span>
                </div>
                <p className="text-xs text-slate-400 mb-6">
                  Everything unlocked for serious competitive exam candidates.
                </p>
                <div className="space-y-3 mb-8">
                  {[
                    'All 20 study game modes & chapter boss battles',
                    'Complete official PYQ bank (2021-2023)',
                    'Live synchronous 1v1 battle matchmaking',
                    'Full-length NTA timed mock exams with palette',
                    'Unlimited spaced repetition & mistake revisions',
                    'Downloadable PDF diagnostic performance reports',
                    'Weekly & all-time ranked leaderboards'
                  ].map((feat, i) => (
                    <div key={i} className="flex items-center gap-2.5 text-xs text-slate-200 font-medium">
                      <Check className="w-4 h-4 text-amber-400 shrink-0" />
                      <span>{feat}</span>
                    </div>
                  ))}
                </div>
              </div>
              <button
                onClick={() => openUpgradeModal('Landing Page Pro CTA')}
                className="w-full py-3 rounded-xl bg-gradient-to-r from-amber-500 to-orange-500 hover:from-amber-400 hover:to-orange-400 text-slate-950 font-black text-xs shadow-lg shadow-amber-500/20 transition-all"
              >
                Upgrade to Pro (Razorpay Test Mode)
              </button>
            </div>

          </div>
        </div>
      </section>

      {/* 6. FAQS (Prompt Requirement) */}
      <section className="py-16 px-4 bg-slate-900/30 border-b border-slate-800/80">
        <div className="max-w-3xl mx-auto">
          <div className="text-center mb-10">
            <h2 className="text-2xl sm:text-3xl font-extrabold text-white font-['Outfit'] mb-2">
              Frequently Asked Questions
            </h2>
            <p className="text-xs sm:text-sm text-slate-400">
              Clear answers about exams, pricing, and game systems.
            </p>
          </div>

          <div className="space-y-3">
            {faqs.map((faq, i) => {
              const isOpen = openFaqIndex === i;
              return (
                <div 
                  key={i}
                  className="rounded-2xl bg-slate-900 border border-slate-800 overflow-hidden"
                >
                  <button
                    onClick={() => setOpenFaqIndex(isOpen ? null : i)}
                    className="w-full flex items-center justify-between p-4 text-left text-xs sm:text-sm font-bold text-white hover:text-indigo-300 transition-colors"
                  >
                    <span>{faq.q}</span>
                    {isOpen ? <ChevronUp className="w-4 h-4 text-slate-400" /> : <ChevronDown className="w-4 h-4 text-slate-400" />}
                  </button>
                  {isOpen && (
                    <div className="px-4 pb-4 pt-1 text-xs text-slate-300 leading-relaxed border-t border-slate-800/60 animate-in fade-in">
                      {faq.a}
                    </div>
                  )}
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* 7. FOOTER per Prompt */}
      <footer className="pt-12 pb-24 md:pb-12 px-4 bg-slate-950 border-t border-slate-800/80 text-xs text-slate-400">
        <div className="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-4 gap-8 mb-10">
          <div>
            <div className="flex items-center gap-2 mb-3">
              <div className="w-7 h-7 rounded-lg bg-indigo-600 flex items-center justify-center">
                <Zap className="w-4 h-4 text-amber-400 fill-amber-400" />
              </div>
              <span className="font-extrabold text-lg text-white font-['Outfit']">NetAce</span>
            </div>
            <p className="text-slate-400 leading-relaxed mb-4 text-[11px]">
              Play to Learn. Practice to Win. Prepare to Ace Your Exam.
            </p>
            <p className="text-[10px] text-slate-500">
              © 2026 NetAce Education Systems. All rights reserved.
            </p>
          </div>

          <div>
            <h4 className="font-bold text-white mb-3 text-xs uppercase tracking-wider">Examinations</h4>
            <ul className="space-y-2 text-[11px]">
              <li><button onClick={onStartLearning} className="hover:text-white">UGC NET Arabic</button></li>
              <li><button onClick={onStartLearning} className="hover:text-white">UGC NET Malayalam</button></li>
              <li><button onClick={onStartLearning} className="hover:text-white">UGC NET English</button></li>
              <li><button onClick={onStartLearning} className="hover:text-white">KTET Pedagogy</button></li>
              <li><button onClick={onStartLearning} className="hover:text-white">JEE Main Physics</button></li>
            </ul>
          </div>

          <div>
            <h4 className="font-bold text-white mb-3 text-xs uppercase tracking-wider">Game Modes</h4>
            <ul className="space-y-2 text-[11px]">
              <li><button onClick={onExploreGames} className="hover:text-white">Quick Quiz & Speed Rush</button></li>
              <li><button onClick={onExploreGames} className="hover:text-white">Chapter Boss Battles</button></li>
              <li><button onClick={onExploreGames} className="hover:text-white">1v1 Synchronous Battle</button></li>
              <li><button onClick={onExploreGames} className="hover:text-white">PYQ Time Machine</button></li>
              <li><button onClick={onExploreGames} className="hover:text-white">NTA Timed Mock Exams</button></li>
            </ul>
          </div>

          <div>
            <h4 className="font-bold text-white mb-3 text-xs uppercase tracking-wider">Legal & Support</h4>
            <ul className="space-y-2 text-[11px]">
              <li><span className="hover:text-white cursor-pointer">About NetAce</span></li>
              <li><span className="hover:text-white cursor-pointer">Privacy Policy</span></li>
              <li><span className="hover:text-white cursor-pointer">Terms of Service</span></li>
              <li><span className="hover:text-white cursor-pointer">Razorpay Payment Security</span></li>
              <li><span className="hover:text-white cursor-pointer">Contact Support (support@netace.edu)</span></li>
            </ul>
          </div>
        </div>

        <div className="max-w-6xl mx-auto pt-6 border-t border-slate-900 text-center text-[10px] text-slate-400">
          Realistic demonstration data is utilized for pre-configured sample modules. No fabricated real rankings or student testimonials are published.
        </div>
      </footer>

    </div>
  );
};
