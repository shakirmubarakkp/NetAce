import React, { useState } from 'react';
import { 
  Lock, 
  CheckCircle2, 
  Sparkles, 
  Crown, 
  RotateCcw, 
  Play, 
  Award, 
  ChevronRight, 
  Swords,
  BookOpen
} from 'lucide-react';
import type { Chapter, Topic, TopicNodeStatus } from '../../types';
import { storage } from '../../services/storageService';
import { useAuth } from '../../context/AuthContext';
import { soundFX } from '../../services/audioService';

interface ProgressMapProps {
  onStartTopicQuiz: (topicId: string) => void;
  onStartBossBattle: (chapterId: string) => void;
}

export const ProgressMap: React.FC<ProgressMapProps> = ({ onStartTopicQuiz, onStartBossBattle }) => {
  const { user } = useAuth();
  const subjects = storage.getSubjects().filter(s => s.examId === user.targetExamId || s.id === 'sub_ugc_p1');
  const [selectedSubjectId, setSelectedSubjectId] = useState<string>(subjects[0]?.id || 'sub_ugc_p1');
  
  const chapters = storage.getChapters(selectedSubjectId);
  const [selectedChapterId, setSelectedChapterId] = useState<string>(chapters[0]?.id || 'chap_ugc_teaching');

  const topics = storage.getTopics(selectedChapterId);
  const [selectedTopic, setSelectedTopic] = useState<Topic | null>(topics[0] || null);

  const currentChapter = chapters.find(c => c.id === selectedChapterId) || chapters[0];

  const getNodeIcon = (status: TopicNodeStatus) => {
    switch (status) {
      case 'mastered':
        return <Crown className="w-6 h-6 text-amber-400 fill-amber-400" />;
      case 'completed':
        return <CheckCircle2 className="w-6 h-6 text-emerald-400" />;
      case 'needs_revision':
        return <RotateCcw className="w-6 h-6 text-rose-400" />;
      case 'locked':
        return <Lock className="w-5 h-5 text-slate-500" />;
      default:
        return <Play className="w-6 h-6 text-indigo-400 fill-indigo-400 ml-0.5" />;
    }
  };

  const getNodeStyle = (status: TopicNodeStatus) => {
    switch (status) {
      case 'mastered':
        return 'bg-gradient-to-tr from-amber-500 to-yellow-400 border-amber-300 text-slate-950 shadow-lg shadow-amber-500/30';
      case 'completed':
        return 'bg-emerald-600 border-emerald-400 text-white shadow-lg shadow-emerald-600/30';
      case 'needs_revision':
        return 'bg-rose-600 border-rose-400 text-white shadow-lg shadow-rose-600/30 animate-pulse';
      case 'locked':
        return 'bg-slate-800 border-slate-700 text-slate-500 cursor-not-allowed opacity-60';
      default:
        return 'bg-indigo-600 border-indigo-400 text-white shadow-lg shadow-indigo-600/40 ring-4 ring-indigo-500/20';
    }
  };

  return (
    <div className="space-y-6 pb-12 animate-in fade-in">
      
      {/* Subject & Chapter Filter Tabs */}
      <div className="p-4 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl space-y-3">
        {/* Subject Pills */}
        <div className="flex items-center gap-2 overflow-x-auto pb-1 text-xs">
          {subjects.map(s => (
            <button
              key={s.id}
              onClick={() => {
                setSelectedSubjectId(s.id);
                const chaps = storage.getChapters(s.id);
                if (chaps.length > 0) {
                  setSelectedChapterId(chaps[0].id);
                  const tops = storage.getTopics(chaps[0].id);
                  setSelectedTopic(tops[0] || null);
                }
              }}
              className={`px-3.5 py-2 rounded-xl font-bold whitespace-nowrap transition-colors ${
                selectedSubjectId === s.id
                  ? 'bg-indigo-600 text-white shadow-md shadow-indigo-600/30'
                  : 'bg-slate-950 text-slate-400 hover:text-white border border-slate-800'
              }`}
            >
              {s.name}
            </button>
          ))}
        </div>

        {/* Chapter Sub-pills */}
        <div className="flex items-center gap-2 overflow-x-auto text-xs border-t border-slate-800/80 pt-2">
          {chapters.map(c => (
            <button
              key={c.id}
              onClick={() => {
                setSelectedChapterId(c.id);
                const tops = storage.getTopics(c.id);
                setSelectedTopic(tops[0] || null);
              }}
              className={`px-3 py-1.5 rounded-lg text-xs font-semibold whitespace-nowrap transition-colors ${
                selectedChapterId === c.id
                  ? 'bg-indigo-500/20 text-indigo-300 border border-indigo-500/40'
                  : 'text-slate-400 hover:text-slate-200'
              }`}
            >
              Unit {c.unitNumber}: {c.name}
            </button>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
        
        {/* Visual Learning Path Serpentine Path (7 cols) */}
        <div className="lg:col-span-7 p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl relative min-h-[460px] flex flex-col items-center justify-between">
          
          <div className="w-full text-center pb-4 border-b border-slate-800 mb-6">
            <h3 className="text-base font-extrabold text-white font-['Outfit']">
              Unit {currentChapter?.unitNumber}: {currentChapter?.name}
            </h3>
            <p className="text-xs text-slate-400 mt-0.5">
              Follow the node path to unlock the end-of-chapter Boss encounter
            </p>
          </div>

          {/* Serpentine Connected Nodes */}
          <div className="flex flex-col items-center space-y-8 my-auto w-full max-w-sm">
            {topics.map((t, idx) => {
              const isSelected = selectedTopic?.id === t.id;
              // slight serpentine offset: even slightly left, odd slightly right
              const offsetClass = idx % 2 === 0 ? '-translate-x-6' : 'translate-x-6';

              return (
                <div key={t.id} className="relative flex flex-col items-center">
                  
                  {/* Connecting Line to next node */}
                  {idx < topics.length - 1 && (
                    <div className="absolute top-14 w-1 h-8 bg-slate-800 -z-0"></div>
                  )}

                  {/* Topic Node Button */}
                  <button
                    onClick={() => {
                      if (t.status !== 'locked') {
                        setSelectedTopic(t);
                        soundFX.playClick();
                      }
                    }}
                    className={`relative z-10 w-16 h-16 rounded-2xl border-2 flex items-center justify-center transition-all ${offsetClass} ${getNodeStyle(t.status)} ${
                      isSelected ? 'scale-110 ring-4 ring-amber-400/50' : 'hover:scale-105'
                    }`}
                  >
                    {getNodeIcon(t.status)}
                  </button>

                  {/* Label */}
                  <span className={`text-[11px] font-bold mt-1 text-center max-w-[140px] truncate ${offsetClass} ${
                    isSelected ? 'text-amber-300' : 'text-slate-400'
                  }`}>
                    {t.name}
                  </span>
                </div>
              );
            })}

            {/* Final Chapter Boss Node */}
            <div className="relative flex flex-col items-center pt-4">
              <div className="absolute -top-4 w-1 h-8 bg-slate-800 -z-0"></div>
              <button
                onClick={() => onStartBossBattle(selectedChapterId)}
                className="w-20 h-20 rounded-3xl bg-gradient-to-tr from-rose-600 via-red-600 to-amber-600 border-2 border-amber-400 flex items-center justify-center text-3xl shadow-xl shadow-rose-600/30 hover:scale-105 transition-transform"
              >
                <span>{currentChapter?.bossAvatar || '⚔️'}</span>
              </button>
              <span className="text-xs font-black text-rose-400 mt-2 text-center uppercase tracking-wider">
                {currentChapter?.bossName || 'Chapter Boss'}
              </span>
            </div>
          </div>

        </div>

        {/* Selected Topic Inspector Card (5 cols) */}
        <div className="lg:col-span-5 p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl space-y-5">
          {selectedTopic ? (
            <>
              <div>
                <span className="text-[10px] font-bold uppercase tracking-wider px-2.5 py-0.5 rounded-full bg-indigo-500/20 text-indigo-300 border border-indigo-500/30 mb-2 inline-block">
                  Topic Inspector
                </span>
                <h3 className="text-lg font-black text-white font-['Outfit'] mt-1">
                  {selectedTopic.name}
                </h3>
                <p className="text-xs text-slate-400 mt-1 leading-relaxed">
                  {selectedTopic.summaryNote || 'Comprehensive examination practice set covering syllabus key concepts, PYQ patterns, and core principles.'}
                </p>
              </div>

              {/* Mastery Criteria Definition (Prompt Requirement) */}
              <div className="p-3.5 rounded-2xl bg-slate-950 border border-slate-800 text-xs space-y-2">
                <p className="font-bold text-amber-400 flex items-center gap-1.5">
                  <Crown className="w-4 h-4 fill-amber-400" />
                  <span>Mastery Standard: 85%+ Accuracy</span>
                </p>
                <p className="text-[11px] text-slate-400 leading-relaxed">
                  Transparent criteria: Solve at least 10 distinct questions with an average accuracy of ≥85% across multiple attempts to achieve full node mastery.
                </p>
              </div>

              {/* Topic Stats */}
              <div className="grid grid-cols-2 gap-3">
                <div className="p-3 rounded-xl bg-slate-950 border border-slate-800 text-center">
                  <p className="text-[10px] text-slate-500 font-bold uppercase">Node Status</p>
                  <p className="text-xs font-black text-white capitalize mt-0.5">{selectedTopic.status.replace('_', ' ')}</p>
                </div>
                <div className="p-3 rounded-xl bg-slate-950 border border-slate-800 text-center">
                  <p className="text-[10px] text-slate-500 font-bold uppercase">Target Accuracy</p>
                  <p className="text-xs font-black text-emerald-400 mt-0.5">85%</p>
                </div>
              </div>

              {/* Start Practice CTA */}
              <button
                onClick={() => onStartTopicQuiz(selectedTopic.id)}
                className="w-full py-3.5 rounded-2xl bg-gradient-to-r from-indigo-600 to-indigo-500 hover:from-indigo-500 hover:to-indigo-700 text-white font-bold text-xs shadow-lg shadow-indigo-600/30 flex items-center justify-center gap-2 transition-all hover:scale-[1.01]"
              >
                <Play className="w-4 h-4 fill-white" />
                <span>Play Practice Game on this Topic</span>
              </button>
            </>
          ) : (
            <div className="text-center py-12 text-slate-500 text-xs">
              Select any node on the path to view concept summary and start practice.
            </div>
          )}
        </div>

      </div>

    </div>
  );
};
