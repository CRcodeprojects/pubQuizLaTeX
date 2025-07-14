%%
%% This is file `pubQuiz.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pubQuiz.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from pubQuiz.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file pubQuiz.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
\NeedsTeXFormat{LaTeX2e}[2023-11-01]
\ProvidesClass{pubQuiz}









\RequirePackage{ifthen}
\RequirePackage{environ}
\newif\ifpubQuiz@Host
\pubQuiz@Hostfalse
\DeclareOption{host}{\pubQuiz@Hosttrue}
\DeclareOption{nohost}{\pubQuiz@Hostfalse}
\newif\ifpubQuiz@Answers
\pubQuiz@Answerstrue
\DeclareOption{answers}{\pubQuiz@Answerstrue}
\DeclareOption{noanswers}{\pubQuiz@Answersfalse}
\newif\ifpubQuiz@Bonus
\pubQuiz@Bonustrue
\DeclareOption{printbonus}{\pubQuiz@Bonustrue}
\DeclareOption{noprintbonus}{\pubQuiz@Bonusfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage[margin=0.5in]{geometry}
\RequirePackage{titlesec}
\RequirePackage[inline]{enumitem}
\RequirePackage{tikz}
\RequirePackage{multicol}
\RequirePackage{mdframed}
\RequirePackage{nicefrac}
\RequirePackage{graphicx}
\RequirePackage{calc}
\RequirePackage[export]{adjustbox}
\titleformat{\section}{\huge\filcenter}{\thesection}{}{}
\titleformat{\subsection}{\Large\filcenter}{\thesubsection}{}{}
\titleformat{\subsubsection}{\large}{\thesubsubsection}{}{}
\titlespacing*{\section}{0cm}{1ex plus 1mm minus 1mm}{1ex plus 1mm minus 1mm}
\titlespacing*{\subsection}{0cm}{2ex plus 1mm minus 1mm}{2ex plus 1mm minus 1mm}
\setlength{\abovedisplayskip}{1em}
\setlist{itemsep=0.5ex}
\ifpubQuiz@Host \else \pagestyle{empty} \fi
\NewEnviron{pubQuiz@Hide}{}
\newif\ifpubQuiz@Columns
\pubQuiz@Columnsfalse
\setlength{\multicolsep}{0pt plus 3pt minus 3pt}
\setlength{\columnsep}{5pt}
\newlength{\pubQuiz@Pixwidth}
\newlength{\pubQuiz@Pixheight}
\setlength{\pubQuiz@Pixheight}{0.1\textheight}
\setlength{\pubQuiz@Pixwidth}{0.125\textwidth}
\makeatletter
\NewDocumentEnvironment{PubRules}{}{ 
\subsection*{\textsc{The Rules:} \hfill}
\begin{enumerate}
}{ \end{enumerate}\par }
\ifpubQuiz@Host \else
  \let\PubRules\pubQuiz@Hide
   \let\endPubRules\endpubQuiz@Hide
\fi
\NewDocumentEnvironment{PubInstructions}{}{ 

\vspace{3mm}
\subsection*{\textsc{Instructions:} \hfill}
\begin{itemize}
}{ \end{itemize}\par }
\ifpubQuiz@Host \else
  \let\PubInstructions\pubQuiz@Hide
   \let\endPubInstructions\endpubQuiz@Hide
\fi
\NewDocumentCommand\pubQuiz@ScoreBox{m o}{
\begin{mdframed}
#1 Score:%
\begin{center}
{\huge $\IfNoValueTF{#2}{
\phantom{\nicefrac{}{}}
}{
\nicefrac{}{#2}}$
}
\end{center}%
\end{mdframed}%
}
\NewDocumentCommand\pubQuiz@PageHeader{m o}{
\ifpubQuiz@Host \else \clearpage%
\noindent\begin{minipage}{0.75\columnwidth}
Team name:\enspace\hrulefill
\end{minipage}%
\hfill \begin{minipage}{0.25\columnwidth}
\pubQuiz@ScoreBox{#1}[#2]
\end{minipage}%
\fi%
}
\NewDocumentCommand\PubRound{mo}{
\pubQuiz@PageHeader{#1}[#2]
\ifpubQuiz@Host \else \vspace{-3em} \fi
\section*{\textbf{\underline{#1}}}
}
 %
\NewDocumentCommand\pubQuiz@CategoryTopMatter{m d<> +o}{
\subsection*{\textbf{#1} \ifpubQuiz@Host \hfill
\IfNoValueTF{#2}{}{#2}\fi}
\ifpubQuiz@Host \IfNoValueF{#3}{#3} \fi%
}
\NewDocumentCommand\pubQuiz@SubcategoryTopMatter{m d<> +o}{
\subsubsection*{\textbf{#1} \ifpubQuiz@Host \hfill
\IfNoValueTF{#2}{}{#2}\fi}
\ifpubQuiz@Host \IfNoValueF{#3}{#3} \fi%
}
\NewDocumentCommand\pubQuiz@CategoryPrint{+m}{
\IfBlankF{#1}{
\begin{enumerate}[topsep=0px,partopsep=0px]
#1 
\end{enumerate}}
}
\NewDocumentEnvironment{PubCategory}{s d|| m d<> +o +b}{
\IfBooleanTF{#1}{
\ifpubQuiz@Bonus \pubQuiz@CategoryTopMatter{#3}<#4>[#5] 
\else \ifpubQuiz@Host \pubQuiz@CategoryTopMatter{#3}<#4>[#5] \fi
\fi
}{ \pubQuiz@CategoryTopMatter{#3}<#4>[#5] }
}{
\IfBooleanTF{#1}
{\ifpubQuiz@Host \pubQuiz@CategoryPrint{#6} \fi}
{ \IfNoValueF{#2}{
\ifpubQuiz@Host \else
\begin{multicols}{#2}
\pubQuiz@Columnstrue
\fi
}\pubQuiz@CategoryPrint{#6} 
\IfNoValueF{#2}{
\ifpubQuiz@Host \else
\end{multicols}
\pubQuiz@Columnsfalse
\fi
}
}\par
}
\NewDocumentCommand\PubCat{s d|| m O{5}}{
\IfBooleanTF{#1}
{ \begin{PubCategory}*|#2|{#3} 
\end{PubCategory}}
{ \begin{PubCategory}|#2|{#3} 
\pubQuiz@PrintAnswerLines{#4} 
\end{PubCategory}
}
}
\NewDocumentEnvironment{PubSubcategory}{s d|| m d<> +o +b}{
\item[] \vspace{-1em}
\IfBooleanTF{#1}{
\ifpubQuiz@Bonus \pubQuiz@SubcategoryTopMatter{#3}<#4>[#5] 
\else \ifpubQuiz@Host \pubQuiz@SubcategoryTopMatter{#3}<#4>[#5] \fi
\fi
}{ \pubQuiz@SubcategoryTopMatter{#3}<#4>[#5] }
}{
\IfBooleanTF{#1}
{\ifpubQuiz@Host \pubQuiz@CategoryPrint{#6} \fi}
{ \IfNoValueF{#2}{
\ifpubQuiz@Host \else
\begin{multicols}{#2}
\pubQuiz@Columnstrue
\fi
}\pubQuiz@CategoryPrint{#6} 
\IfNoValueF{#2}{
\ifpubQuiz@Host \else
\end{multicols}
\pubQuiz@Columnsfalse
\fi
}
}\par
}
\NewDocumentCommand\PubQ{s O{No question given} t. o}{ 
\ifpubQuiz@Host
\item \IfNoValueF{#2}{#2}
\ifpubQuiz@Answers  
\IfNoValueF{#4}
{\IfBooleanTF{#3}{\dotfill}{\\}
\textbf{#4}}
\fi
\else
\IfBooleanF{#1}{ 
\item \hrulefill \par
}
\fi
}
\NewDocumentCommand\pubQuiz@PrintAnswerLines{m}{
\foreach \i in {1,...,#1}{
\PubQ
}
}
\NewDocumentCommand\PubQPic{m o}{
\item \ifpubQuiz@Host
\ifpubQuiz@Answers
 #2
\fi
\else  \hfill%
\begin{minipage}[c][\pubQuiz@Pixheight][c]{\pubQuiz@Pixwidth}
\centering
\includegraphics[
keepaspectratio=true,
width=\pubQuiz@Pixwidth,
height=\pubQuiz@Pixheight,
valign=t]{#1}
\end{minipage}
\hspace*{\fill}

\vspace{6mm}
\hrulefill \par
\fi
}
\makeatother

\endinput
%%
%% End of file `pubQuiz.cls'.
