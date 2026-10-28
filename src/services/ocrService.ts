import type { Question, OcrJobItem } from '../types';
import { storage } from './storageService';

export interface ExtractedQuestionDraft {
  id: string;
  questionText: string;
  questionTextArabic?: string;
  questionTextMalayalam?: string;
  options: { id: string; text: string; isCorrect: boolean }[];
  explanation: string;
  difficulty: 'easy' | 'medium' | 'hard';
  topicName: string;
  confidenceScore: number;
  rawTextSnippet: string;
}

export class OcrService {
  public static simulateOcrExtraction(
    fileName: string, 
    examId: string, 
    subjectId: string
  ): Promise<{ job: OcrJobItem; drafts: ExtractedQuestionDraft[] }> {
    return new Promise((resolve) => {
      setTimeout(() => {
        const jobId = 'ocr_' + Date.now();
        const drafts: ExtractedQuestionDraft[] = [
          {
            id: 'draft_1',
            questionText: 'Which of the following research methods is most appropriate to establish a direct cause-and-effect relationship between variables?',
            options: [
              { id: 'd1_opt1', text: 'Descriptive Survey Method', isCorrect: false },
              { id: 'd1_opt2', text: 'Historical Research Method', isCorrect: false },
              { id: 'd1_opt3', text: 'Experimental Research Method', isCorrect: true },
              { id: 'd1_opt4', text: 'Ex-post Facto Method', isCorrect: false }
            ],
            explanation: 'Experimental research manipulates the independent variable under controlled conditions to directly test causal hypotheses.',
            difficulty: 'medium',
            topicName: 'Research Methodology Paradigms',
            confidenceScore: 97.4,
            rawTextSnippet: 'Q.14 (UGC-NET 2023) Which of the following research methods is most appropriate to establish a direct cause-and-effect relationship between variables? (1) Descriptive Survey (2) Historical (3) Experimental [CORRECT] (4) Ex-post Facto'
          },
          {
            id: 'draft_2',
            questionText: 'من هو صاحب كتاب "دلائل الإعجاز" و"أسرار البلاغة" ومؤسس نظرية النظم في البلاغة العربية؟',
            questionTextArabic: 'من هو صاحب كتاب "دلائل الإعجاز" و"أسرار البلاغة" ومؤسس نظرية النظم في البلاغة العربية؟',
            options: [
              { id: 'd2_opt1', text: 'عبد القاهر الجرجاني (Abdul Qahir al-Jurjani)', isCorrect: true },
              { id: 'd2_opt2', text: 'أبو هلال العسكري', isCorrect: false },
              { id: 'd2_opt3', text: 'ابن رشيق القيرواني', isCorrect: false },
              { id: 'd2_opt4', text: 'السكاكي', isCorrect: false }
            ],
            explanation: 'عبد القاهر الجرجاني هو إمام البلاغة ومؤلف دلائل الإعجاز وأسرار البلاغة وصاحب نظرية النظم الشهيرة.',
            difficulty: 'hard',
            topicName: 'Arabic Rhetoric & Balaghah',
            confidenceScore: 95.8,
            rawTextSnippet: 'س.28 من هو مؤلف دلائل الإعجاز وأسرار البلاغة؟ أ- عبد القاهر الجرجاني (صحيح) ب- أبو هلال العسكري ج- ابن رشيق د- السكاكي'
          },
          {
            id: 'draft_3',
            questionText: 'കുമാരനാശാന്റെ "കരുണ" എന്ന ഖണ്ഡകാവ്യത്തിലെ കേന്ദ്ര കഥാപാത്രങ്ങൾ ആരെല്ലാമാണ്?',
            questionTextMalayalam: 'കുമാരനാശാന്റെ "കരുണ" എന്ന ഖണ്ഡകാവ്യത്തിലെ കേന്ദ്ര കഥാപാത്രങ്ങൾ ആരെല്ലാമാണ്?',
            options: [
              { id: 'd3_opt1', text: 'വാസവദത്തയും ഉപഗുപ്തനും (Vasavadatta & Upagupta)', isCorrect: true },
              { id: 'd3_opt2', text: 'നളനും ദമയന്തിയും', isCorrect: false },
              { id: 'd3_opt3', text: 'മാതംഗിയും ആനന്ദനും', isCorrect: false },
              { id: 'd3_opt4', text: 'ചണ്ഡാലികയും ഗൗതമനും', isCorrect: false }
            ],
            explanation: 'വാസവദത്ത എന്ന നർത്തകിയുടെയും ഉപഗുപ്തൻ എന്ന ബുദ്ധശിഷ്യന്റെയും ആത്മീയ പ്രണയമാണ് ആശാന്റെ കരുണയിലെ ഇതിവൃത്തം.',
            difficulty: 'medium',
            topicName: 'Modern Malayalam Poetry',
            confidenceScore: 96.1,
            rawTextSnippet: 'ചോദ്യം: കരുണ എന്ന ഖണ്ഡകാവ്യത്തിലെ കേന്ദ്ര കഥാപാത്രങ്ങൾ ആരെല്ലാം? 1. വാസവദത്തയും ഉപഗുപ്തനും (ശരി) 2. നളനും ദമയന്തിയും'
          }
        ];

        const job: OcrJobItem = {
          id: jobId,
          fileName,
          fileSize: '3.6 MB',
          status: 'ready_for_review',
          extractedQuestionsCount: drafts.length,
          confidenceScore: 96.4,
          uploadedAt: new Date().toISOString(),
          assignedExamId: examId,
          assignedSubjectId: subjectId
        };

        storage.addOcrJob(job);
        storage.addAuditLog('OCR_JOB_PROCESSED', `Extracted ${drafts.length} questions from ${fileName} with 96.4% confidence.`);
        resolve({ job, drafts });
      }, 1200);
    });
  }

  public static publishDraftQuestion(draft: ExtractedQuestionDraft, examId: string, subjectId: string): Question {
    const newQuestion: Question = {
      id: 'q_ocr_' + Date.now() + '_' + Math.random().toString(36).substring(2, 6),
      examId,
      subjectId,
      chapterId: 'chap_ugc_teaching',
      topicId: 'top_levels_teaching',
      type: 'mcq_single',
      difficulty: draft.difficulty,
      questionText: draft.questionText,
      questionTextArabic: draft.questionTextArabic,
      questionTextMalayalam: draft.questionTextMalayalam,
      options: draft.options,
      explanation: draft.explanation,
      isPyq: true,
      pyqYear: 2023,
      pyqPaper: 'Extracted Verified Scan',
      reviewStatus: 'approved',
      creatorId: storage.getUser().id,
      createdAt: new Date().toISOString()
    };

    storage.saveQuestion(newQuestion);
    storage.awardXp(40, 'Published verified OCR question', 'achievement');
    return newQuestion;
  }
}
