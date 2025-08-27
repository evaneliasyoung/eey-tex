%%%
% @file      eey-homework.cls
% @brief     Homework assignment template.
% @author    Evan Elias Young
% @date      2020-09-02
% @date      2025-08-27
% @copyright Copyright 2020-2025 Evan Elias Young. All rights reserved.
%%%

% #region Metadata
\def\fileversion{0.2.1}
\def\filedate{2025-08-27}
\def\fileauth{Evan Elias Young}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eey-homework}[\filedate\space Version \fileversion\space by \fileauth]
% #endregion

% #region Argument Parsing
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family = eeyhw,
  prefix = eeyhw@,
  setkeys = \kvsetkeys
}

\DeclareStringOption[missouri university of science and technology]{university}
\DeclareStringOption[Chem]{subject}
\DeclareStringOption[1310]{course}
\DeclareStringOption[101]{section}
\DeclareStringOption[Assignment 1]{assignment}
\DeclareStringOption[Evan Elias Young]{name}
\DeclareStringOption[umrsid@mst.edu]{email}

\DeclareDefaultOption{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessKeyvalOptions{eeyhw}
\LoadClass[letterpaper,11pt]{article}
% #endregion

% #region Packages and Configuration
\RequirePackage[
    letterpaper,
    headheight = 20pt,
    margin = 1in,
    tmargin = \dimexpr 1in - 10pt \relax
]{geometry}
\addtolength{\footskip}{20pt}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{mathpazo}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage[tworuled, linesnumbered, noend, noline]{algorithm2e}
\RequirePackage{xcolor}
\RequirePackage{trimspaces}
\RequirePackage{xstring}
\RequirePackage{hyperref}
\RequirePackage[en-US]{datetime2}

\definecolor{medium-blue}{rgb}{0.1294,0.5882,0.9529}

\hypersetup{colorlinks, urlcolor={medium-blue}}
\renewcommand{\thefootnote}{[\roman{footnote}]}
% #endregion

\newcommand*{\eeyhw@semester}{%
    \ifnum\the\month < 6%
        SS\the\year%
    \else%
        \ifnum\the\month < 8%
            XS\the\year%
        \else%
            FS\the\year%
        \fi%
    \fi%
}

\newcommand{\eeyhw@temp}{}
\newcommand{\eeyhw@sub}[4]{%
    \ifnum#3 = 1\relax%
        \ifnum#4 = 1\relax%
            \renewcommand{\eeyhw@temp}{#1}%
        \else%
            \StrBefore{#1}{#2}[\eeyhw@temp]%
        \fi%
    \else%
        \ifnum#3 = #4\relax%
            \StrBehind[\numexpr#3 - 1\relax]{#1}{#2}[\eeyhw@temp]%
        \else%
            \StrBetween[\numexpr#3 - 1\relax,#3]{#1}{#2}{#2}[\eeyhw@temp]%
        \fi%
    \fi%
    \expandafter\trim@spaces\expandafter{\eeyhw@temp}%
    }
\newcommand{\eeyhw@getAuthorByIndex}[1]{%
    \eeyhw@sub{\eeyhw@name}{;}{#1}{\arabic{eeyhw@numAuthors}}~\\%
    \texttt{\eeyhw@sub{\eeyhw@email}{;}{#1}{\arabic{eeyhw@numAuthors}}}%
    \ifnum#1 < \arabic{eeyhw@numAuthors}\relax\and\eeyhw@getAuthorByIndex{\numexpr#1 + 1\relax}\fi
}

% #region Events
\newcommand{\eeyhw@onAuthor}{%
  \StrCount{\eeyhw@name}{;}[\eeyhw@numAuthors]%
  \newcounter{eeyhw@numAuthors}%
  \setcounter{eeyhw@numAuthors}{\eeyhw@numAuthors}%
  \stepcounter{eeyhw@numAuthors}%
  \eeyhw@getAuthorByIndex{1}%
}
\newcommand{\eeyhw@onTitle}{%
    \vspace{-2\baselineskip}%
    \eeyhw@assignment%
}
\newcommand{\eeyhw@onBeginDocument}{%
    \maketitle%
    \vspace{-1.5\baselineskip}%
}
% #endregion

\graphicspath{{figures/}}

\setlength{\headheight}{14pt}
\newcommand{\eeyhw@setupHF}{%
  \fancyhf{}%
  \fancyhead[L]{\sffamily \eeyhw@university}%
  \fancyhead[R]{\sffamily \eeyhw@subject~\eeyhw@course-\eeyhw@section~\eeyhw@semester}%
  \fancyfoot[R]{\sffamily\bfseries\thepage}%
  \renewcommand{\headrulewidth}{0.5pt}%
  \renewcommand{\footrulewidth}{0.5pt}%
}
\fancypagestyle{plain}{\eeyhw@setupHF}
\eeyhw@setupHF{}
\pagestyle{fancy}

\title{\eeyhw@onTitle}
\author{\eeyhw@onAuthor}
\AtBeginDocument{\eeyhw@onBeginDocument}

% \let\oldnl\nl
% \newcommand{\nonl}{\renewcommand{\nl}{\let\nl\oldnl}}
% \newcommand{\eeyhw@capsty}[1]{\!}
% \SetAlCapSty{eeyhw@capsty}
% \SetAlCapNameFnt{\scshape\hspace{.69em}}
% \DontPrintSemicolon
% \newcommand\eeyhw@commentsty[1]{\footnotesize\ttfamily\textcolor{gray}{#1}}
% \SetCommentSty{eeyhw@commentsty}

% #region New Style Macros
\newcommand{\eeyhwhint}[1]{\footnotesize{\textbf{\textcolor{red}{[Hint: #1]}}}}
\newcommand{\eeyhwnote}[1]{\textbf{Note}: #1}
% #endregion

% #region Useful Macros
\newcommand*{\R}{\mathbb R}
\newcommand*{\N}{\mathbb N}
\newcommand*{\Z}{\mathbb Z}
\newcommand*{\Q}{\mathbb Q}
\newcommand{\eeyhwfigure}[1]{
    \begin{figure}[!htb]
        #1
    \end{figure}
}
\newcommand{\printdate}[1]{%
    \DTMsavedate{newdate}{#1}%
    \DTMusedate{newdate}%
}
\newcommand{\printtime}[1]{%
    \DTMsavetime{newtime}{#1}%
    \DTMusetime{newtime}%
}
% #endregion
