import React, { useMemo, useState } from 'react';
import { ArrowLeft, CheckCircle2, Eye, EyeOff, Loader2, LockKeyhole, Mail } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { INITIAL_EXAMINATIONS, INITIAL_PAPERS, INITIAL_SUBJECTS } from '../../data/initialData';
import { googleOAuthEnabled } from '../../services/supabaseClient';

interface AuthPagesProps {
  route: string;
  onNavigate: (route: string) => void;
}

const cardClass = 'w-full max-w-md rounded-3xl border border-slate-800 bg-slate-900 p-6 shadow-2xl sm:p-8';
const inputClass = 'w-full rounded-xl border border-slate-700 bg-slate-950 px-4 py-3 text-sm text-white outline-none transition focus:border-indigo-500 focus:ring-2 focus:ring-indigo-500/20';

const AuthFrame: React.FC<{
  title: string;
  subtitle: string;
  children: React.ReactNode;
  onBack: () => void;
}> = ({ title, subtitle, children, onBack }) => (
  <main className="flex min-h-screen items-center justify-center bg-slate-950 px-4 py-10 text-slate-100">
    <section className={cardClass}>
      <button onClick={onBack} className="mb-6 inline-flex items-center gap-2 text-xs font-semibold text-slate-400 hover:text-white">
        <ArrowLeft className="h-4 w-4" /> Back to NetAce
      </button>
      <div className="mb-6">
        <div className="mb-4 flex h-11 w-11 items-center justify-center rounded-xl bg-indigo-600 text-lg font-black text-white">N</div>
        <h1 className="text-2xl font-black text-white">{title}</h1>
        <p className="mt-1 text-sm leading-6 text-slate-400">{subtitle}</p>
      </div>
      {children}
    </section>
  </main>
);

export const AuthPages: React.FC<AuthPagesProps> = ({ route, onNavigate }) => {
  const {
    user,
    role,
    isLoggedIn,
    configurationError,
    authError,
    signIn,
    signInWithGoogle,
    signUp,
    sendPasswordReset,
    updatePassword,
    resendVerification,
    completeOnboarding
  } = useAuth();
  const [email, setEmail] = useState('');
  const [name, setName] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [consent, setConsent] = useState(false);
  const [targetExamId, setTargetExamId] = useState(user.targetExamId);
  const [subjectIds, setSubjectIds] = useState<string[]>(user.preferredSubjectIds);
  const [dailyGoal, setDailyGoal] = useState(20);
  const [targetDate, setTargetDate] = useState('');
  const [studyModes, setStudyModes] = useState<string[]>(['learn', 'revision']);
  const [showPassword, setShowPassword] = useState(false);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');

  const exams = INITIAL_EXAMINATIONS;
  const papers = INITIAL_PAPERS.filter(paper => paper.examId === targetExamId);
  const paperIds = useMemo(() => new Set(papers.map(paper => paper.id)), [papers]);
  const subjects = INITIAL_SUBJECTS.filter(subject => paperIds.has(subject.paperId));
  const authUnavailable = configurationError !== null;

  const handleError = (reason: unknown) => {
    setError(reason instanceof Error ? reason.message : 'Something went wrong. Please try again.');
  };

  const run = async (action: () => Promise<void>, successMessage?: string) => {
    setBusy(true);
    setError('');
    setNotice('');
    try {
      await action();
      if (successMessage) setNotice(successMessage);
    } catch (reason) {
      handleError(reason);
    } finally {
      setBusy(false);
    }
  };

  const startDashboard = () => {
    const requestedRoute = sessionStorage.getItem('netace:returnTo');
    sessionStorage.removeItem('netace:returnTo');
    const routesByRole: Record<string, string[]> = {
      admin: ['admin', 'admin/import'],
      moderator: ['moderator', 'moderator/import', 'profile'],
      student: ['dashboard', 'chapter-practice', 'learn', 'play', 'mistakes', 'bookmarks', 'mock-exam', 'progress', 'leaderboard', 'classroom', 'profile']
    };
    if (role === 'admin') onNavigate(requestedRoute && routesByRole.admin.includes(requestedRoute) ? requestedRoute : 'admin');
    else if (role === 'moderator') onNavigate(requestedRoute && routesByRole.moderator.includes(requestedRoute) ? requestedRoute : 'moderator');
    else if (!user.onboardingComplete) onNavigate('onboarding');
    else onNavigate(requestedRoute && routesByRole.student.includes(requestedRoute) ? requestedRoute : 'dashboard');
  };

  React.useEffect(() => {
    if (route === 'verify-email' && isLoggedIn) startDashboard();
  }, [isLoggedIn, route, role, user.onboardingComplete]);

  if (route === 'onboarding') {
    if (!isLoggedIn) {
      onNavigate('login');
      return null;
    }
    return (
      <AuthFrame title="Build your study plan" subtitle="Choose your target exam and preferences. You can update these later in your profile." onBack={() => onNavigate('dashboard')}>
        <form className="space-y-4" onSubmit={event => {
          event.preventDefault();
          void run(async () => {
            if (subjects.length && subjectIds.length === 0) throw new Error('Choose at least one subject or paper.');
            await completeOnboarding({
              targetExamId,
              preferredSubjectIds: subjectIds,
              dailyGoal,
              targetExamDate: targetDate || undefined,
              preferredStudyModes: studyModes
            });
            onNavigate('dashboard');
          });
        }}>
          <label className="block space-y-1.5 text-xs font-semibold text-slate-300">
            Target examination
            <select className={inputClass} value={targetExamId} onChange={event => {
              setTargetExamId(event.target.value);
              setSubjectIds([]);
            }}>
              {exams.map(exam => <option key={exam.id} value={exam.id}>{exam.name}</option>)}
            </select>
          </label>
          {subjects.length > 0 && (
            <fieldset className="space-y-2">
              <legend className="text-xs font-semibold text-slate-300">Subjects or papers</legend>
              <div className="grid gap-2 sm:grid-cols-2">
                {subjects.map(subject => (
                  <label key={subject.id} className="flex cursor-pointer items-center gap-2 rounded-xl border border-slate-800 bg-slate-950 p-3 text-xs text-slate-200">
                    <input type="checkbox" checked={subjectIds.includes(subject.id)} onChange={() => setSubjectIds(current =>
                      current.includes(subject.id) ? current.filter(id => id !== subject.id) : [...current, subject.id]
                    )} />
                    {subject.name}
                  </label>
                ))}
              </div>
            </fieldset>
          )}
          <label className="block space-y-1.5 text-xs font-semibold text-slate-300">
            Target exam date (optional)
            <input className={inputClass} type="date" value={targetDate} onChange={event => setTargetDate(event.target.value)} />
          </label>
          <label className="block space-y-1.5 text-xs font-semibold text-slate-300">
            Daily question goal
            <select className={inputClass} value={dailyGoal} onChange={event => setDailyGoal(Number(event.target.value))}>
              {[10, 20, 30].map(goal => <option key={goal} value={goal}>{goal} questions</option>)}
            </select>
          </label>
          <fieldset className="space-y-2">
            <legend className="text-xs font-semibold text-slate-300">Preferred study modes</legend>
            <div className="flex flex-wrap gap-2">
              {['learn', 'timed', 'exam', 'revision'].map(mode => (
                <label key={mode} className="flex items-center gap-2 rounded-lg bg-slate-950 px-3 py-2 text-xs capitalize text-slate-300">
                  <input type="checkbox" checked={studyModes.includes(mode)} onChange={() => setStudyModes(current =>
                    current.includes(mode) ? current.filter(value => value !== mode) : [...current, mode]
                  )} />
                  {mode === 'exam' ? 'Exam simulation' : `${mode} mode`}
                </label>
              ))}
            </div>
          </fieldset>
          <FormFeedback error={error} notice={notice} />
          <button disabled={busy} className="flex w-full items-center justify-center gap-2 rounded-xl bg-indigo-600 py-3 text-sm font-bold text-white hover:bg-indigo-500 disabled:opacity-60">
            {busy && <Loader2 className="h-4 w-4 animate-spin" />} Save study plan
          </button>
        </form>
      </AuthFrame>
    );
  }

  if (route === 'verify-email') {
    return (
      <AuthFrame title="Verify your email" subtitle="Follow the verification link we sent to your inbox. If you have not received it, you can request a new message." onBack={() => onNavigate('login')}>
        {isLoggedIn && <p className="mb-4 text-sm text-emerald-300">Signed in as {user.email}.</p>}
        <form className="space-y-4" onSubmit={event => {
          event.preventDefault();
          void run(() => resendVerification(email || user.email), 'If the address can receive verification, a new link has been sent.');
        }}>
          <label className="block space-y-1.5 text-xs font-semibold text-slate-300">
            Email address
            <input className={inputClass} required type="email" autoComplete="email" value={email || user.email} onChange={event => setEmail(event.target.value)} />
          </label>
          <FormFeedback error={error} notice={notice} />
          <button disabled={busy} className="w-full rounded-xl bg-indigo-600 py-3 text-sm font-bold text-white hover:bg-indigo-500 disabled:opacity-60">
            {busy ? 'Sending…' : 'Resend verification email'}
          </button>
        </form>
      </AuthFrame>
    );
  }

  if (route === 'forgot-password') {
    return (
      <AuthFrame title="Reset your password" subtitle="Enter your account email and we will send a secure password-reset link if the account is eligible." onBack={() => onNavigate('login')}>
        <form className="space-y-4" onSubmit={event => {
          event.preventDefault();
          void run(() => sendPasswordReset(email), 'If an account exists for that address, a reset link has been sent.');
        }}>
          <EmailField email={email} setEmail={setEmail} />
          <FormFeedback error={error} notice={notice} />
          <SubmitButton busy={busy} label="Send reset link" />
        </form>
      </AuthFrame>
    );
  }

  if (route === 'reset-password') {
    return (
      <AuthFrame title="Choose a new password" subtitle="Use at least eight characters with a mix of letters and numbers." onBack={() => onNavigate('login')}>
        <form className="space-y-4" onSubmit={event => {
          event.preventDefault();
          void run(async () => {
            if (!isStrongPassword(password)) throw new Error('Use at least 8 characters, including letters and numbers.');
            if (password !== confirmPassword) throw new Error('The passwords do not match.');
            await updatePassword(password);
            setNotice('Password updated. You can now sign in with the new password.');
          });
        }}>
          <PasswordField password={password} setPassword={setPassword} visible={showPassword} setVisible={setShowPassword} label="New password" />
          <PasswordField password={confirmPassword} setPassword={setConfirmPassword} visible={showPassword} setVisible={setShowPassword} label="Confirm new password" />
          <FormFeedback error={error} notice={notice} />
          <SubmitButton busy={busy} label="Update password" />
        </form>
      </AuthFrame>
    );
  }

  if (route === 'signup') {
    return (
      <AuthFrame title="Create your student account" subtitle="Start a personal, secure NetAce learning profile." onBack={() => onNavigate('landing')}>
        <form className="space-y-4" onSubmit={event => {
          event.preventDefault();
          void run(async () => {
            if (!isStrongPassword(password)) throw new Error('Use at least 8 characters, including letters and numbers.');
            if (password !== confirmPassword) throw new Error('The passwords do not match.');
            if (!consent) throw new Error('Please accept the Terms and Privacy Policy to continue.');
            await signUp(name.trim(), email, password);
          }, 'Account request received. Check your email to verify your address before signing in.');
        }}>
          <label className="block space-y-1.5 text-xs font-semibold text-slate-300">
            Full name
            <input className={inputClass} required minLength={2} autoComplete="name" value={name} onChange={event => setName(event.target.value)} />
          </label>
          <EmailField email={email} setEmail={setEmail} />
          <PasswordField password={password} setPassword={setPassword} visible={showPassword} setVisible={setShowPassword} label="Password" />
          <PasswordField password={confirmPassword} setPassword={setConfirmPassword} visible={showPassword} setVisible={setShowPassword} label="Confirm password" />
          <label className="flex items-start gap-2 text-xs leading-5 text-slate-400">
            <input className="mt-1" type="checkbox" checked={consent} onChange={event => setConsent(event.target.checked)} />
            I agree to the Terms of Service and Privacy Policy.
          </label>
          <FormFeedback error={error} notice={notice} />
          <SubmitButton busy={busy} label="Create account" />
          <p className="text-center text-xs text-slate-400">Already have an account? <button type="button" className="font-bold text-indigo-300" onClick={() => onNavigate('login')}>Sign in</button></p>
        </form>
      </AuthFrame>
    );
  }

  return (
    <AuthFrame title="Welcome back" subtitle="Sign in to continue your personalized study plan." onBack={() => onNavigate('landing')}>
      <form className="space-y-4" onSubmit={event => {
        event.preventDefault();
        void run(async () => {
          await signIn(email, password);
          startDashboard();
        });
      }}>
        <EmailField email={email} setEmail={setEmail} />
        <PasswordField password={password} setPassword={setPassword} visible={showPassword} setVisible={setShowPassword} label="Password" />
        <div className="flex items-center justify-between text-xs">
          <span className="text-slate-500">Secure persistent session</span>
          <button type="button" className="font-semibold text-indigo-300 hover:text-indigo-200" onClick={() => onNavigate('forgot-password')}>Forgot password?</button>
        </div>
        <FormFeedback error={error} notice={notice} />
        {error.toLowerCase().includes('confirm') && (
          <button type="button" className="w-full text-xs font-bold text-indigo-300 hover:text-indigo-200" onClick={() => onNavigate('verify-email')}>
            Need a verification link? Resend email
          </button>
        )}
        {(authUnavailable || authError) && <p role="alert" className="rounded-xl border border-amber-500/30 bg-amber-500/10 p-3 text-xs leading-5 text-amber-200">{configurationError || authError}</p>}
        <SubmitButton busy={busy} label="Sign in" disabled={authUnavailable} />
        {googleOAuthEnabled && !authUnavailable && (
          <button type="button" disabled={busy} onClick={() => void run(signInWithGoogle)} className="w-full rounded-xl border border-slate-700 py-3 text-sm font-bold text-slate-200 hover:bg-slate-800 disabled:opacity-50">
            Continue with Google
          </button>
        )}
        <p className="text-center text-xs text-slate-400">New to NetAce? <button type="button" className="font-bold text-indigo-300" onClick={() => onNavigate('signup')}>Create an account</button></p>
      </form>
    </AuthFrame>
  );
};

const EmailField: React.FC<{ email: string; setEmail: (value: string) => void }> = ({ email, setEmail }) => (
  <label className="block space-y-1.5 text-xs font-semibold text-slate-300">
    Email address
    <span className="relative block">
      <Mail className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-500" />
      <input className={`${inputClass} pl-10`} required type="email" autoComplete="email" value={email} onChange={event => setEmail(event.target.value)} />
    </span>
  </label>
);

const PasswordField: React.FC<{
  password: string;
  setPassword: (value: string) => void;
  visible: boolean;
  setVisible: (value: boolean) => void;
  label: string;
}> = ({ password, setPassword, visible, setVisible, label }) => (
  <label className="block space-y-1.5 text-xs font-semibold text-slate-300">
    {label}
    <span className="relative block">
      <LockKeyhole className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-500" />
      <input className={`${inputClass} px-10`} required type={visible ? 'text' : 'password'} autoComplete="current-password" value={password} onChange={event => setPassword(event.target.value)} />
      <button type="button" aria-label={visible ? 'Hide password' : 'Show password'} onClick={() => setVisible(!visible)} className="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-white">
        {visible ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
      </button>
    </span>
  </label>
);

const FormFeedback: React.FC<{ error: string; notice: string }> = ({ error, notice }) => (
  <>
    {error && <p role="alert" className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-3 text-xs leading-5 text-rose-200">{error}</p>}
    {notice && <p role="status" className="flex items-start gap-2 rounded-xl border border-emerald-500/30 bg-emerald-500/10 p-3 text-xs leading-5 text-emerald-200"><CheckCircle2 className="mt-0.5 h-4 w-4 shrink-0" />{notice}</p>}
  </>
);

const SubmitButton: React.FC<{ busy: boolean; label: string; disabled?: boolean }> = ({ busy, label, disabled = false }) => (
  <button type="submit" disabled={busy || disabled} className="flex w-full items-center justify-center gap-2 rounded-xl bg-indigo-600 py-3 text-sm font-bold text-white transition hover:bg-indigo-500 disabled:cursor-not-allowed disabled:opacity-60">
    {busy && <Loader2 className="h-4 w-4 animate-spin" />} {label}
  </button>
);

const isStrongPassword = (value: string) =>
  value.length >= 8 && /[A-Za-z]/.test(value) && /\d/.test(value);
