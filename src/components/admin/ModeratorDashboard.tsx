import React, { useCallback, useEffect, useState } from 'react';
import { CheckCircle2, Loader2, RefreshCw, ShieldCheck, XCircle } from 'lucide-react';
import { supabase } from '../../services/supabaseClient';

interface ReviewQuestion {
  id: string;
  question_text: string;
  explanation: string | null;
  review_status: 'pending_review' | 'needs_edit' | 'approved' | 'rejected';
  difficulty: string;
  subject_id: string | null;
}

interface SubjectName {
  id: string;
  name: string;
}

export const ModeratorDashboard: React.FC = () => {
  const [questions, setQuestions] = useState<ReviewQuestion[]>([]);
  const [subjectNames, setSubjectNames] = useState<Record<string, string>>({});
  const [loading, setLoading] = useState(true);
  const [busyQuestionId, setBusyQuestionId] = useState<string | null>(null);
  const [error, setError] = useState('');
  const [notice, setNotice] = useState('');

  const loadQueue = useCallback(async () => {
    if (!supabase) {
      setError('Supabase is not configured. Moderator queues require a connected Supabase project.');
      setLoading(false);
      return;
    }

    setLoading(true);
    setError('');
    try {
      const { data: queue, error: queueError } = await supabase
        .from('questions')
        .select('id,question_text,explanation,review_status,difficulty,subject_id')
        .in('review_status', ['pending_review', 'needs_edit'])
        .order('created_at', { ascending: false });
      if (queueError) throw queueError;

      const rows = (queue || []) as ReviewQuestion[];
      const subjectIds = [...new Set(rows.flatMap(row => row.subject_id ? [row.subject_id] : []))];
      if (subjectIds.length) {
        const { data: subjects, error: subjectError } = await supabase
          .from('subjects')
          .select('id,name')
          .in('id', subjectIds);
        if (subjectError) throw subjectError;
        const names = (subjects || []) as SubjectName[];
        setSubjectNames(Object.fromEntries(names.map(subject => [subject.id, subject.name])));
      } else {
        setSubjectNames({});
      }
      setQuestions(rows);
    } catch (reason) {
      setError(reason instanceof Error ? reason.message : 'Unable to load the assigned review queue.');
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => { void loadQueue(); }, [loadQueue]);

  const updateStatus = async (question: ReviewQuestion, status: 'approved' | 'rejected' | 'needs_edit') => {
    if (!supabase) return;
    setBusyQuestionId(question.id);
    setError('');
    setNotice('');
    try {
      const { error: updateError } = await supabase
        .from('questions')
        .update({ review_status: status })
        .eq('id', question.id);
      if (updateError) throw updateError;
      setNotice(`Question ${status === 'approved' ? 'approved' : status === 'rejected' ? 'rejected' : 'returned for editing'}.`);
      await loadQueue();
    } catch (reason) {
      setError(reason instanceof Error ? reason.message : 'Unable to update question review status.');
    } finally {
      setBusyQuestionId(null);
    }
  };

  return (
    <section className="space-y-5">
      <header className="rounded-3xl border border-emerald-500/20 bg-gradient-to-br from-emerald-950/40 to-slate-900 p-6">
        <p className="mb-2 flex items-center gap-2 text-xs font-bold uppercase tracking-wider text-emerald-300"><ShieldCheck className="h-4 w-4" /> Assigned content only</p>
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <h1 className="text-2xl font-black text-white">Moderator review queue</h1>
            <p className="mt-1 text-sm text-slate-400">Your assignments and write permissions are validated by Supabase RLS.</p>
          </div>
          <button onClick={() => void loadQueue()} disabled={loading} className="inline-flex items-center gap-2 rounded-xl bg-slate-800 px-3 py-2 text-xs font-bold text-white disabled:opacity-50"><RefreshCw className="h-4 w-4" /> Refresh</button>
        </div>
      </header>

      {error && <p role="alert" className="rounded-xl border border-rose-500/30 bg-rose-500/10 p-3 text-xs leading-5 text-rose-200">{error}</p>}
      {notice && <p role="status" className="rounded-xl border border-emerald-500/30 bg-emerald-500/10 p-3 text-xs text-emerald-200">{notice}</p>}
      {loading ? (
        <p className="flex items-center gap-2 text-sm text-slate-400"><Loader2 className="h-4 w-4 animate-spin" /> Loading assigned questions…</p>
      ) : questions.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-slate-700 p-8 text-center text-sm text-slate-400">There are no pending questions in your assigned subjects.</div>
      ) : questions.map(question => (
        <article key={question.id} className="rounded-2xl border border-slate-800 bg-slate-900 p-5">
          <div className="mb-3 flex flex-wrap items-center gap-2 text-[10px] font-bold uppercase tracking-wider text-slate-400">
            <span className="rounded bg-slate-800 px-2 py-1">{subjectNames[question.subject_id || ''] || 'Assigned subject'}</span>
            <span className="rounded bg-slate-800 px-2 py-1">{question.difficulty}</span>
            <span className="rounded bg-amber-500/10 px-2 py-1 text-amber-200">{question.review_status.replace('_', ' ')}</span>
          </div>
          <h2 className="font-bold leading-6 text-white">{question.question_text}</h2>
          {question.explanation && <p className="mt-3 text-xs leading-5 text-slate-400">{question.explanation}</p>}
          <div className="mt-4 flex flex-wrap gap-2">
            <button disabled={busyQuestionId === question.id} onClick={() => void updateStatus(question, 'approved')} className="inline-flex items-center gap-1.5 rounded-lg bg-emerald-500/15 px-3 py-2 text-xs font-bold text-emerald-200 hover:bg-emerald-500/25 disabled:opacity-50"><CheckCircle2 className="h-4 w-4" /> Approve</button>
            <button disabled={busyQuestionId === question.id} onClick={() => void updateStatus(question, 'needs_edit')} className="rounded-lg bg-amber-500/15 px-3 py-2 text-xs font-bold text-amber-200 hover:bg-amber-500/25 disabled:opacity-50">Request edits</button>
            <button disabled={busyQuestionId === question.id} onClick={() => void updateStatus(question, 'rejected')} className="inline-flex items-center gap-1.5 rounded-lg bg-rose-500/15 px-3 py-2 text-xs font-bold text-rose-200 hover:bg-rose-500/25 disabled:opacity-50"><XCircle className="h-4 w-4" /> Reject</button>
          </div>
        </article>
      ))}
    </section>
  );
};
