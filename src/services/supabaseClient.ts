import { createClient } from '@supabase/supabase-js';

const sanitizeSupabaseUrl = (url: string | undefined): string | undefined => {
  if (!url) return undefined;
  return url.trim().replace(/^["';\s]+/, '').replace(/["';\s/]+$/, '');
};

const sanitizeSupabaseKey = (key: string | undefined): string | undefined => {
  if (!key) return undefined;
  let cleaned = key.trim().replace(/^["';\s]+/, '').replace(/["';\s]+$/, '');
  // Auto-heal if the key was pasted without the JWT header prefix (starting directly with the payload {"iss":...})
  if (cleaned.startsWith('eyJpc3Mi')) {
    cleaned = `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.${cleaned}`;
  }
  return cleaned;
};

const supabaseUrl = sanitizeSupabaseUrl(import.meta.env.VITE_SUPABASE_URL);
const supabaseAnonKey = sanitizeSupabaseKey(import.meta.env.VITE_SUPABASE_ANON_KEY);
export const googleOAuthEnabled = import.meta.env.VITE_SUPABASE_GOOGLE_OAUTH_ENABLED === 'true';

export const supabaseConfigError =
  !supabaseUrl || !supabaseAnonKey
    ? 'Supabase is not configured. Add VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY to your local environment.'
    : null;

export const supabase =
  supabaseUrl && supabaseAnonKey
    ? createClient(supabaseUrl, supabaseAnonKey, {
        auth: {
          autoRefreshToken: true,
          persistSession: true,
          detectSessionInUrl: true
        }
      })
    : null;
