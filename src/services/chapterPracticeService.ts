import { supabase } from './supabaseClient';

export interface SavedChapterPracticeSession {
  id: string;
  user_id: string;
  exam_id: string;
  paper_id: string | null;
  subject_id: string;
  chapter_id: string;
  mode: string;
  source: string;
  total_questions: number;
  answered_count: number;
  correct_count: number;
  accuracy_percentage: number;
  time_spent_seconds: number;
  question_results: Array<{
    question_id: string;
    selected_option_ids: string[];
    given_answer_text: string;
    is_correct: boolean | null;
    marked_for_review: boolean;
  }>;
  created_at: string;
}

export const getChapterPracticeSessions = async (userId: string): Promise<SavedChapterPracticeSession[]> => {
  if (!supabase) return [];
  const { data, error } = await supabase
    .from('chapter_practice_sessions')
    .select('*')
    .eq('user_id', userId)
    .order('created_at', { ascending: false });
  if (error) throw error;
  return (data || []) as SavedChapterPracticeSession[];
};

export const saveChapterPracticeSession = async (
  session: Omit<SavedChapterPracticeSession, 'created_at'>
): Promise<void> => {
  if (!supabase) throw new Error('Supabase is not configured; practice results cannot be saved.');
  const { error } = await supabase.from('chapter_practice_sessions').insert(session);
  if (error) throw error;
};
