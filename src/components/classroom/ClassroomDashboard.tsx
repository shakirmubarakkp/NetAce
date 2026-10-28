import React, { useState } from 'react';
import { Users, Plus, Key, Calendar, CheckCircle2, Trophy, Clock, ArrowRight } from 'lucide-react';
import type { Classroom, ClassroomAssignment } from '../../types';
import { soundFX } from '../../services/audioService';
import { useAuth } from '../../context/AuthContext';

export const ClassroomDashboard: React.FC = () => {
  const { user } = useAuth();
  const [inviteInput, setInviteInput] = useState('');
  const [joinedSuccess, setJoinedSuccess] = useState(false);

  const [classrooms, setClassrooms] = useState<Classroom[]>([
    {
      id: 'cr_1',
      name: 'UGC NET Arabic JRF Batch 2024',
      instituteName: 'Darul Ilm Academy',
      teacherName: 'Prof. Zainab Al-Hadi',
      inviteCode: 'NET-ARB-99',
      examId: 'ugc_net',
      studentCount: 38,
      activeAssignmentsCount: 2
    },
    {
      id: 'cr_2',
      name: 'KTET Category 1 Mission 100',
      instituteName: 'Kerala Teachers Forum',
      teacherName: 'Dr. Suresh Kumar',
      inviteCode: 'KTET-2024',
      examId: 'ktet',
      studentCount: 64,
      activeAssignmentsCount: 1
    }
  ]);

  const [assignments, setAssignments] = useState<ClassroomAssignment[]>([
    {
      id: 'as_1',
      classroomId: 'cr_1',
      title: 'Pre-Islamic Mu’allaqat Comprehensive Quiz',
      subjectName: 'Arabic Language & Literature',
      chapterName: 'Classical Arabic Poetry',
      questionsCount: 15,
      deadline: 'Tomorrow, 8:00 PM',
      isCompletedByStudent: false
    },
    {
      id: 'as_2',
      classroomId: 'cr_1',
      title: 'Teaching Aptitude Evaluation Level 2',
      subjectName: 'Paper 1 General',
      chapterName: 'Teaching Aptitude',
      questionsCount: 20,
      deadline: 'Friday, 11:59 PM',
      isCompletedByStudent: true,
      studentScore: 92
    }
  ]);

  const handleJoinClassroom = (e: React.FormEvent) => {
    e.preventDefault();
    if (!inviteInput) return;
    soundFX.playCorrect();
    setJoinedSuccess(true);
    setTimeout(() => {
      setJoinedSuccess(false);
      setInviteInput('');
    }, 2000);
  };

  return (
    <div className="space-y-6 pb-12 animate-in fade-in max-w-5xl mx-auto">
      
      {/* Header */}
      <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-indigo-500/10 border border-indigo-500/30 text-indigo-300 text-xs font-bold mb-2">
            <Users className="w-3.5 h-3.5" />
            <span>COACHING INSTITUTES & CLASSROOMS</span>
          </div>
          <h2 className="text-2xl sm:text-3xl font-black text-white font-['Outfit']">
            Classrooms & Assignments
          </h2>
          <p className="text-xs sm:text-sm text-slate-400 mt-1">
            Join your coaching institute batch using an invite code to receive homework sets, mock exam deadlines, and cohort leaderboards.
          </p>
        </div>

        {/* Join Classroom Input Form */}
        <form onSubmit={handleJoinClassroom} className="flex items-center gap-2 w-full md:w-auto">
          <input 
            type="text"
            placeholder="Enter 6-digit Invite Code..."
            value={inviteInput}
            onChange={(e) => setInviteInput(e.target.value)}
            className="px-3.5 py-2.5 rounded-xl bg-slate-950 border border-slate-700 text-xs text-white uppercase tracking-wider font-mono focus:outline-none focus:border-indigo-500"
          />
          <button
            type="submit"
            className="px-4 py-2.5 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs shrink-0 shadow-md"
          >
            Join Class
          </button>
        </form>
      </div>

      {joinedSuccess && (
        <div className="p-3.5 rounded-2xl bg-emerald-500/20 border border-emerald-500/40 text-emerald-300 text-xs font-bold text-center animate-in fade-in">
          ✓ Successfully joined coaching classroom! Your assignments are now synced.
        </div>
      )}

      {/* Active Enrolled Classrooms */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {classrooms.map(cr => (
          <div key={cr.id} className="p-5 rounded-3xl bg-slate-900 border border-slate-800 space-y-3">
            <div className="flex items-start justify-between">
              <div>
                <span className="text-[10px] font-bold text-indigo-400 uppercase tracking-wider block">
                  {cr.instituteName}
                </span>
                <h3 className="text-base font-bold text-white mt-0.5">{cr.name}</h3>
                <p className="text-xs text-slate-400">Instructor: {cr.teacherName}</p>
              </div>
              <span className="text-[10px] font-mono font-bold bg-slate-800 text-slate-300 px-2 py-1 rounded-lg">
                Code: {cr.inviteCode}
              </span>
            </div>

            <div className="flex items-center justify-between text-xs text-slate-400 pt-3 border-t border-slate-800/80">
              <span className="flex items-center gap-1.5">
                <Users className="w-4 h-4 text-slate-500" />
                <span>{cr.studentCount} Peers Enrolled</span>
              </span>
              <span className="text-amber-400 font-bold">
                {cr.activeAssignmentsCount} Active Tasks
              </span>
            </div>
          </div>
        ))}
      </div>

      {/* Assigned Tasks & Homework */}
      <div className="p-6 rounded-3xl bg-slate-900 border border-slate-800 shadow-xl space-y-4">
        <h3 className="font-bold text-base text-white font-['Outfit']">
          Institute Assignments & Due Dates
        </h3>

        <div className="space-y-3">
          {assignments.map(as => (
            <div 
              key={as.id}
              className="p-4 rounded-2xl bg-slate-950/70 border border-slate-800/80 flex flex-col sm:flex-row sm:items-center justify-between gap-3"
            >
              <div>
                <div className="flex items-center gap-2 mb-1">
                  <span className="text-[10px] font-bold text-indigo-400 uppercase">
                    {as.subjectName} • {as.chapterName}
                  </span>
                  {as.isCompletedByStudent && (
                    <span className="text-[10px] font-bold bg-emerald-500/20 text-emerald-400 px-2 py-0.2 rounded-full">
                      Completed ({as.studentScore}%)
                    </span>
                  )}
                </div>
                <h4 className="text-xs font-bold text-white">{as.title}</h4>
                <div className="flex items-center gap-3 text-[11px] text-slate-400 mt-1">
                  <span>{as.questionsCount} Questions</span>
                  <span>•</span>
                  <span className="flex items-center gap-1 text-amber-400">
                    <Clock className="w-3.5 h-3.5" />
                    <span>Due: {as.deadline}</span>
                  </span>
                </div>
              </div>

              <div>
                {as.isCompletedByStudent ? (
                  <button className="px-4 py-2 rounded-xl bg-slate-800 text-slate-400 text-xs font-semibold">
                    Review Answers
                  </button>
                ) : (
                  <button className="px-4 py-2 rounded-xl bg-indigo-600 hover:bg-indigo-500 text-white font-bold text-xs flex items-center gap-1.5">
                    <span>Start Assignment</span>
                    <ArrowRight className="w-3.5 h-3.5" />
                  </button>
                )}
              </div>
            </div>
          ))}
        </div>
      </div>

    </div>
  );
};
