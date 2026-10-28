import jsPDF from 'jspdf';
import type { UserProfile, QuestionAttempt } from '../types';

export class PdfService {
  public static generatePerformanceReport(user: UserProfile, attempts: QuestionAttempt[]): void {
    const doc = new jsPDF();
    const pageWidth = doc.internal.pageSize.getWidth();

    // 1. Header Banner
    doc.setFillColor(15, 23, 42); // Deep Navy
    doc.rect(0, 0, pageWidth, 42, 'F');

    // Title
    doc.setTextColor(255, 255, 255);
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(22);
    doc.text('NETACE PERFORMANCE REPORT', 14, 20);

    doc.setFontSize(10);
    doc.setFont('helvetica', 'normal');
    doc.setTextColor(203, 213, 225);
    doc.text('Official Examination Readiness & Diagnostic Analytics', 14, 28);
    doc.text(`Generated on: ${new Date().toLocaleDateString()} | Target Exam: ${user.targetExamId.toUpperCase()}`, 14, 35);

    // 2. Student Info Card
    let y = 52;
    doc.setFillColor(241, 245, 249);
    doc.roundedRect(14, y, pageWidth - 28, 32, 3, 3, 'F');

    doc.setTextColor(30, 41, 59);
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(12);
    doc.text(`Candidate: ${user.name}`, 20, y + 10);

    doc.setFont('helvetica', 'normal');
    doc.setFontSize(10);
    doc.text(`Email: ${user.email}`, 20, y + 18);
    doc.text(`Account Tier: ${user.isPremium ? 'PREMIUM ACCESS' : 'FREE STUDENT'}`, 20, y + 26);

    doc.setFont('helvetica', 'bold');
    doc.text(`Current Level: Level ${user.level} (${user.levelTitle})`, 110, y + 10);
    doc.setFont('helvetica', 'normal');
    doc.text(`Total XP Earned: ${user.xp.toLocaleString()} XP`, 110, y + 18);
    doc.text(`Current Study Streak: ${user.streakDays} Consecutive Days`, 110, y + 26);

    // 3. Analytics Summary
    y += 42;
    const totalAttempts = attempts.length;
    const correctAttempts = attempts.filter(a => a.isCorrect).length;
    const accuracy = totalAttempts > 0 ? Math.round((correctAttempts / totalAttempts) * 100) : 0;
    const avgTime = totalAttempts > 0 ? Math.round(attempts.reduce((sum, a) => sum + a.timeSpentSeconds, 0) / totalAttempts) : 0;

    doc.setFont('helvetica', 'bold');
    doc.setFontSize(14);
    doc.setTextColor(15, 23, 42);
    doc.text('Diagnostic Assessment Overview', 14, y);

    y += 8;
    // 4 KPI Boxes
    const boxW = (pageWidth - 28 - 9) / 4;
    const kpis = [
      { label: 'Total Questions', val: `${totalAttempts}`, sub: 'Across all modes' },
      { label: 'Overall Accuracy', val: `${accuracy}%`, sub: accuracy >= 75 ? 'Exam Ready' : 'Needs Focus' },
      { label: 'Avg Speed', val: `${avgTime}s`, sub: 'Per Question' },
      { label: 'Daily Goal', val: `${user.todayQuestionsAnswered}/${user.dailyGoal}`, sub: 'Today Completion' }
    ];

    kpis.forEach((kpi, idx) => {
      const bx = 14 + idx * (boxW + 3);
      doc.setFillColor(248, 250, 252);
      doc.setDrawColor(226, 232, 240);
      doc.roundedRect(bx, y, boxW, 28, 2, 2, 'FD');

      doc.setFont('helvetica', 'normal');
      doc.setFontSize(8);
      doc.setTextColor(100, 116, 139);
      doc.text(kpi.label, bx + 4, y + 8);

      doc.setFont('helvetica', 'bold');
      doc.setFontSize(14);
      doc.setTextColor(15, 23, 42);
      doc.text(kpi.val, bx + 4, y + 18);

      doc.setFont('helvetica', 'normal');
      doc.setFontSize(7);
      doc.setTextColor(79, 70, 229);
      doc.text(kpi.sub, bx + 4, y + 24);
    });

    // 4. Learning Journey & Readiness Interpretation
    y += 38;
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(12);
    doc.setTextColor(15, 23, 42);
    doc.text('Academic Readiness Evaluation', 14, y);

    y += 6;
    doc.setFont('helvetica', 'normal');
    doc.setFontSize(9);
    doc.setTextColor(71, 85, 105);

    const readinessText = accuracy >= 80 
      ? 'Outstanding examination readiness. The candidate demonstrates consistent conceptual clarity, high retention across previous year question sets, and optimal pacing.'
      : accuracy >= 60
      ? 'Good foundational mastery. Candidate is progressing well but requires focused practice on higher-difficulty topics, assertion-reason items, and timed mock conditions.'
      : 'Early learning stage. The candidate should prioritize foundational concept review in the Learning Path and regular revision of items recorded in the Mistake Notebook.';

    doc.text(readinessText, 14, y, { maxWidth: pageWidth - 28 });

    // 5. Recent Attempt Sample Table
    y += 22;
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(12);
    doc.setTextColor(15, 23, 42);
    doc.text('Recent Question Sessions History', 14, y);

    y += 6;
    // Table Header
    doc.setFillColor(79, 70, 229); // Indigo
    doc.rect(14, y, pageWidth - 28, 8, 'F');
    doc.setTextColor(255, 255, 255);
    doc.setFont('helvetica', 'bold');
    doc.setFontSize(8);
    doc.text('#', 18, y + 5);
    doc.text('Game Mode', 28, y + 5);
    doc.text('Result', 80, y + 5);
    doc.text('Time Spent', 120, y + 5);
    doc.text('XP Awarded', 160, y + 5);

    y += 8;
    const sampleAttempts = attempts.slice(0, 8);
    sampleAttempts.forEach((att, i) => {
      doc.setFillColor(i % 2 === 0 ? 255 : 248, i % 2 === 0 ? 255 : 250, i % 2 === 0 ? 255 : 252);
      doc.rect(14, y, pageWidth - 28, 7, 'F');

      doc.setTextColor(51, 65, 85);
      doc.setFont('helvetica', 'normal');
      doc.setFontSize(8);
      doc.text(`${i + 1}`, 18, y + 5);
      doc.text(att.gameMode.replace('_', ' ').toUpperCase(), 28, y + 5);
      
      if (att.isCorrect) {
        doc.setTextColor(16, 185, 129); // green
        doc.text('CORRECT', 80, y + 5);
      } else {
        doc.setTextColor(239, 68, 68); // red
        doc.text('INCORRECT', 80, y + 5);
      }

      doc.setTextColor(51, 65, 85);
      doc.text(`${att.timeSpentSeconds}s`, 120, y + 5);
      doc.text(`+${att.awardedXp} XP`, 160, y + 5);

      y += 7;
    });

    // Footer
    doc.setDrawColor(203, 213, 225);
    doc.line(14, 280, pageWidth - 14, 280);

    doc.setFontSize(8);
    doc.setTextColor(148, 163, 184);
    doc.text('NetAce Learning Platform — Play to Learn. Practice to Win. Prepare to Ace Your Exam.', 14, 285);
    doc.text('https://netace.edu', pageWidth - 40, 285);

    // Save
    doc.save(`NetAce_Report_${user.name.replace(/\s+/g, '_')}.pdf`);
  }
}
