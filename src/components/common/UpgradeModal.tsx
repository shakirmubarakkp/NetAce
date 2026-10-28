import React, { useState } from 'react';
import { Crown, Check, X, ShieldCheck, Zap } from 'lucide-react';
import { useGame } from '../../context/GameContext';
import { useAuth } from '../../context/AuthContext';
import { RazorpayService } from '../../services/razorpayService';

export const UpgradeModal: React.FC = () => {
  const { isUpgradeModalOpen, closeUpgradeModal, upgradeFeatureName, fireConfetti } = useGame();
  const { user, refreshUser } = useAuth();
  const [selectedPlan, setSelectedPlan] = useState<'monthly' | 'annual'>('annual');
  const [isProcessing, setIsProcessing] = useState(false);
  const [successMsg, setSuccessMsg] = useState('');
  const [errorMsg, setErrorMsg] = useState('');

  if (!isUpgradeModalOpen) return null;

  const handleCheckout = () => {
    setIsProcessing(true);
    setErrorMsg('');
    setSuccessMsg('');

    const amount = selectedPlan === 'annual' ? 799 : 99;

    RazorpayService.openCheckout({
      planId: selectedPlan,
      amountInr: amount,
      userName: user.name,
      userEmail: user.email,
      onSuccess: (paymentId) => {
        setIsProcessing(false);
        setSuccessMsg(`Payment verified! ID: ${paymentId}`);
        refreshUser();
        fireConfetti();
        setTimeout(() => {
          closeUpgradeModal();
          setSuccessMsg('');
        }, 1600);
      },
      onFailure: (err) => {
        setIsProcessing(false);
        setErrorMsg(err);
      }
    });
  };

  const perks = [
    'Access to all 20 study game modes & boss battles',
    'Complete official previous year questions (PYQs) archive',
    'Real-time 1v1 quiz battles & team competitions',
    'Full-length NTA timed mock tests with question palette',
    'Unlimited mistake notebook revision & spaced repetition',
    'Downloadable PDF diagnostic performance reports',
    'Global & subject-specific ranked leaderboards'
  ];

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/85 backdrop-blur-md animate-in fade-in">
      <div className="relative w-full max-w-lg rounded-3xl bg-slate-900 border border-slate-700/80 p-6 shadow-2xl shadow-indigo-950/50 overflow-hidden max-h-[90vh] overflow-y-auto">
        
        {/* Close Button */}
        <button
          onClick={closeUpgradeModal}
          className="absolute top-4 right-4 p-2 rounded-xl bg-slate-800 text-slate-400 hover:text-white transition-colors"
        >
          <X className="w-4 h-4" />
        </button>

        {/* Header */}
        <div className="text-center mb-6">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-amber-500/10 border border-amber-500/30 text-amber-400 text-xs font-bold mb-3">
            <Crown className="w-3.5 h-3.5 fill-amber-400" />
            <span>NETACE PREMIUM ACCESS</span>
          </div>

          <h3 className="text-2xl font-black text-white font-['Outfit']">
            Level Up to NetAce Pro
          </h3>
          <p className="text-xs text-slate-400 mt-1 max-w-sm mx-auto">
            You clicked on <span className="text-amber-300 font-semibold">{upgradeFeatureName}</span>. Unlock full examination mastery without restrictions.
          </p>
        </div>

        {/* Pricing Plan Selector */}
        <div className="grid grid-cols-2 gap-3 mb-6">
          {/* Monthly Plan */}
          <div
            onClick={() => setSelectedPlan('monthly')}
            className={`cursor-pointer relative p-4 rounded-2xl border-2 transition-all ${
              selectedPlan === 'monthly'
                ? 'border-indigo-500 bg-indigo-500/10'
                : 'border-slate-800 bg-slate-950/60 hover:border-slate-700'
            }`}
          >
            <div className="flex items-center justify-between mb-2">
              <span className="text-xs font-bold text-slate-300">Monthly</span>
              <div className={`w-4 h-4 rounded-full border flex items-center justify-center ${
                selectedPlan === 'monthly' ? 'border-indigo-400 bg-indigo-500' : 'border-slate-600'
              }`}>
                {selectedPlan === 'monthly' && <div className="w-1.5 h-1.5 rounded-full bg-white"></div>}
              </div>
            </div>
            <div className="flex items-baseline gap-1">
              <span className="text-2xl font-black text-white">₹99</span>
              <span className="text-[11px] text-slate-400">/month</span>
            </div>
            <p className="text-[10px] text-slate-500 mt-1">Billed monthly, cancel anytime</p>
          </div>

          {/* Annual Plan (Best Value) */}
          <div
            onClick={() => setSelectedPlan('annual')}
            className={`cursor-pointer relative p-4 rounded-2xl border-2 transition-all ${
              selectedPlan === 'annual'
                ? 'border-amber-500 bg-amber-500/10'
                : 'border-slate-800 bg-slate-950/60 hover:border-slate-700'
            }`}
          >
            <span className="absolute -top-2.5 right-3 px-2 py-0.5 rounded-full bg-gradient-to-r from-amber-500 to-orange-500 text-[9px] font-black uppercase text-slate-950 tracking-wider">
              Save 33%
            </span>
            <div className="flex items-center justify-between mb-2">
              <span className="text-xs font-bold text-slate-300">Annual Pass</span>
              <div className={`w-4 h-4 rounded-full border flex items-center justify-center ${
                selectedPlan === 'annual' ? 'border-amber-400 bg-amber-500' : 'border-slate-600'
              }`}>
                {selectedPlan === 'annual' && <div className="w-1.5 h-1.5 rounded-full bg-slate-950"></div>}
              </div>
            </div>
            <div className="flex items-baseline gap-1">
              <span className="text-2xl font-black text-white">₹799</span>
              <span className="text-[11px] text-slate-400">/year</span>
            </div>
            <p className="text-[10px] text-amber-300/80 mt-1">₹66/month equivalent</p>
          </div>
        </div>

        {/* Feature List */}
        <div className="bg-slate-950/60 rounded-2xl p-4 border border-slate-800 mb-6 space-y-2">
          <p className="text-xs font-bold text-slate-300 mb-2">Everything included in Pro:</p>
          {perks.map((perk, i) => (
            <div key={i} className="flex items-start gap-2.5 text-xs text-slate-300">
              <div className="w-4 h-4 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center shrink-0 mt-0.5">
                <Check className="w-2.5 h-2.5 stroke-[3]" />
              </div>
              <span>{perk}</span>
            </div>
          ))}
        </div>

        {/* Feedback messages */}
        {successMsg && (
          <div className="mb-4 p-3 rounded-xl bg-emerald-500/20 border border-emerald-500/40 text-emerald-300 text-xs font-bold text-center">
            {successMsg}
          </div>
        )}
        {errorMsg && (
          <div className="mb-4 p-3 rounded-xl bg-rose-500/20 border border-rose-500/40 text-rose-300 text-xs font-bold text-center">
            {errorMsg}
          </div>
        )}

        {/* Checkout CTA */}
        <button
          onClick={handleCheckout}
          disabled={isProcessing}
          className="w-full py-3.5 rounded-2xl bg-gradient-to-r from-amber-500 via-orange-500 to-amber-600 hover:from-amber-400 hover:to-orange-500 text-slate-950 font-black text-sm shadow-xl shadow-amber-500/20 flex items-center justify-center gap-2 transition-all hover:scale-[1.01] disabled:opacity-50"
        >
          <Zap className="w-4 h-4 fill-slate-950" />
          <span>
            {isProcessing ? 'Verifying with Razorpay...' : `Unlock Full Access for ₹${selectedPlan === 'annual' ? 799 : 99}`}
          </span>
        </button>

        <div className="mt-3 flex items-center justify-center gap-4 text-[11px] text-slate-500">
          <div className="flex items-center gap-1">
            <ShieldCheck className="w-3.5 h-3.5 text-emerald-400" />
            <span>256-Bit SSL Razorpay Gateway</span>
          </div>
          <span>•</span>
          <span>Sandbox / Test Mode Active</span>
        </div>

      </div>
    </div>
  );
};
