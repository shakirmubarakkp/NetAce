# NetAce (നെറ്റ്എയ്സ് / نِت آيس)
> **Play to Learn. Practice to Win. Prepare to Ace Your Exam.**

NetAce is a gamified competitive examination preparation platform that transforms serious studying into an engaging game-based learning experience. Built mobile-first as a responsive Progressive Web App (PWA), it equips aspirants for national and state-level competitive exams—prioritizing **UGC NET / JRF** (Paper I, Arabic, Malayalam, English), **KTET**, and **JEE Main**—while providing an extensible curriculum hierarchy for banking, civil services, and university entrance tests.

---

## 🌟 Key Product Features

### 1. 20 Distinct Playable Study Game Modes
NetAce moves far beyond conventional quiz websites with 20 distinct gameplay systems:
1. **Quick Quiz**: 5, 10, or 20 rapid-fire questions with instant academic solution diagnostics.
2. **Speed Rush**: Timed question countdown with speed bonuses and optional relaxed mode.
3. **Daily Quest**: Server-generated daily study objectives with one-click XP claims.
4. **Knowledge Ladder**: Progressive Easy → Medium → Hard ladder requiring 75% accuracy to unlock next rungs.
5. **Chapter Boss Battle**: End-of-chapter climax encounter featuring animated Boss HP, player hearts (3 lives), and chapter mastery badges.
6. **Memory Match**: Card-flipping matching game pairing authors, books, formulas, and terminology against time.
7. **Fill the Gap**: Academic sentence and formula completion with immediate syntax validation.
8. **True or False Challenge**: Fast-paced concept revision under time pressure.
9. **Elimination Challenge**: Deductive reasoning with 50:50 lifelines to eliminate distractor options.
10. **Match the Pairs**: Interactive two-column concept connector with instant pair verification.
11. **Survival Mode**: Endless gauntlet where 3 mistakes trigger game over; tracks maximum wave reached.
12. **Weak Topic Rescue**: Focused revision generated strictly from previous errors and low-accuracy topics.
13. **PYQ Time Machine**: Exam-style practice using verified official previous year questions (2021–2023).
14. **1v1 Quiz Battle**: Synchronous multiplayer battle with matchmaking radar, live score bar, and round comparisons.
15. **Team Battle**: Cooperative group rooms with invite codes and collective team score leaderboards.
16. **Daily Streak Challenge**: Consecutive activity tracking with calendar heatmap and freeze protection.
17. **Formula & Flashcard Arena**: Spaced repetition flashcards with SM-2 interval ratings (Again, Hard, Good, Easy).
18. **Full NTA Mock Exam**: Official exam simulator with Question Palette (Answered, Not Answered, Marked for Review, Not Visited), section navigation, negative marking (+2 / -0.5), and comprehensive scorecard.
19. **Daily Tournament**: Scheduled daily global quiz competition with XP prize pools.
20. **Error Hunter**: Multi-step derivations containing an intentional flaw; students spot the mistake and earn points.

### 2. Spaced Repetition & Mistake Notebook
- Any question answered incorrectly across any game mode is automatically captured in the student's **Mistake Notebook**.
- Implements the **SM-2 spaced repetition algorithm** (ease factor, repetition intervals) to resurface missed items until true conceptual mastery is demonstrated.
- Transparent mastery standard: ≥85% accuracy across distinct question attempts.

### 3. Visual Learning Path (Progress Map)
- Duolingo-style serpentine learning tree with status indicators: *Available, In Progress, Mastered, Needs Revision, Locked*.
- Topic Inspector with concept summary, key formulas, and launch triggers.
- Climax Chapter Boss node at the conclusion of each unit.

### 4. Diagnostic Analytics & Downloadable PDF Reports
- Calculates overall accuracy, speed per question, subject breakdowns, and weekly trends from real attempts.
- Generates official **downloadable PDF Diagnostic Reports** using `jsPDF` for student portfolio review.

### 5. Freemium Monetization & Razorpay Integration
- Free Tier vs. Premium Monthly (₹99) vs. Premium Annual (₹799).
- Seamless **Razorpay Payment Gateway** integration:
  - If live keys are present, launches standard Razorpay checkout.
  - If credentials are absent, runs in a sandbox test mode with simulated order verification and instant role upgrade.

### 6. OCR Question Import Workbench (Admin & Moderator)
- Side-by-side verification workflow: displays original scanned document alongside parsed questions, options, confidence scores (e.g. 96.4%), and editable fields before publication.

---

## 🛠️ Technology Architecture

- **Frontend Framework**: React 19 with TypeScript
- **Build Tooling**: Vite 6
- **Styling**: Tailwind CSS v4 & custom tokens
- **Icons**: Lucide React
- **Audio Synthesizer**: Native HTML5 Web Audio API (zero network latency, 100% offline)
- **PDF Engine**: jsPDF
- **Celebration Effects**: canvas-confetti
- **Database & Migration**: PostgreSQL 15+ / Supabase schema with foreign keys and Row Level Security (RLS) policies in ordered migrations under `supabase/migrations/`
- **Persistence Layer**: Existing game state and configured starter content use browser storage; authentication, account roles, moderator review, and chapter-practice summaries use Supabase.

---

## 🚀 Quick Start & Local Execution

### 1. Prerequisites
- Node.js v18+ or v20+
- npm v9+

### 2. Installation
```bash
npm install
```

### 3. Configure Supabase
NetAce authentication, role authorization, moderator question review, and cross-device chapter-session history require a Supabase project.

1. Copy `.env.example` to `.env.local`.
2. Set `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` from the Supabase project settings. Never put a service-role key in a `VITE_` variable.
3. Run `supabase/migrations/01_netace_schema.sql`, then `supabase/migrations/02_auth_and_chapter_practice.sql` in the Supabase SQL Editor.
4. Enable email/password sign-in and email confirmation in Supabase Auth, and configure local and deployed URLs in the Auth redirect URL allow-list.
5. Register the initial administrator through student signup, then promote that account from the Supabase SQL Editor using its verified email. Role promotion is intentionally unavailable in public signup and the browser client.

If Supabase is not configured, public landing pages remain available, but sign-in and protected routes do not use simulated credentials.
To show Google sign-in, configure the Google provider in Supabase Auth and set `VITE_SUPABASE_GOOGLE_OAUTH_ENABLED=true`; keep OAuth client secrets in Supabase, never in the frontend.

### 4. Run Development Server
```bash
npm run dev
```
Open [http://localhost:5173](http://localhost:5173) in your browser.

### 5. Build for Production
```bash
npm run build
```

---

## 👥 Authentication, roles, and practice

- Students use Supabase Auth for account creation, email confirmation, sign-in, password reset, and sign-out.
- Admin and moderator roles are loaded from the protected `profiles` table. Admin role changes go through the `assign_netace_role` database function; moderators can review only questions in subjects assigned by an administrator.
- First-time students complete an examination and study-goal onboarding flow.
- Chapter practice uses the configured curriculum and approved question data; completed session summaries are stored in Supabase under the authenticated account. Existing quiz/game data outside this feature remains in browser storage.
- Practice sessions do not award XP until question scoring can be validated by a trusted server-side question bank. Do not treat browser-submitted scores as authoritative.

---

## 📦 Database Migration (Supabase)

To deploy the schema to your Supabase or PostgreSQL database:
1. Log in to your Supabase project dashboard.
2. Navigate to the **SQL Editor**.
3. Run [`supabase/migrations/01_netace_schema.sql`](./supabase/migrations/01_netace_schema.sql) followed by [`supabase/migrations/02_auth_and_chapter_practice.sql`](./supabase/migrations/02_auth_and_chapter_practice.sql).
4. Promote the initial administrator only from the Supabase SQL Editor, for example:

   ```sql
   UPDATE public.profiles
   SET role = 'admin', is_premium = TRUE
   WHERE lower(email) = lower('admin@example.com');
   ```

   Replace the example address with the verified administrator account. Never expose a database service-role key to the browser.

---

## 📄 License
NetAce is released under the MIT License.
