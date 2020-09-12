%%%
% @file      eey-resume.cls
% @brief     Resume template.
% @author    Evan Elias Young
% @date      2020-09-09
% @date      2020-09-11
% @copyright Copyright 2020 Evan Elias Young. All rights reserved.
%%%

% #region Metadata
\def\fileversion{0.2.0}
\def\filedate{2020-09-11}
\def\fileauth{Evan Elias Young}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eey-resume}[\filedate\space Version \fileversion\space by \fileauth]
% #endregion

% #region Argument Parsing
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family = eeyrs,
  prefix = eeyrs@,
  setkeys = \kvsetkeys
}

\DeclareStringOption{name}[Wes Sterling Dault]
\DeclareStringOption{web}[YourWebsite.com]
\DeclareStringOption{schooladdr}[1 School Way ; St. Louis, Missouri 63126 ; student@uni.edu]
\DeclareStringOption{homeaddr}[1 Home Way ; St. Louis, Missouri 63126 ; Phone]

\DeclareDefaultOption{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessKeyvalOptions{eeyrs}
\LoadClass[letterpaper,12pt]{article}
% #endregion

% #region Packages and Configuration
\RequirePackage[
    letterpaper,
    headheight = 0pt,
    margin = 0.75in
]{geometry}
\RequirePackage{trimspaces}
\RequirePackage{xstring}
\RequirePackage{enumitem}
\RequirePackage{setspace}

\setlist{nosep}
\setlist[itemize]{noitemsep, leftmargin=*}
\renewcommand{\familydefault}{phv}
% #endregion

% #region Helpers
\newcommand{\eeyrs@temp}{}
\newcommand{\eeyrs@substring}[4]{%
    \ifnum#3 = 1\relax%
        \ifnum#4 = 1\relax%
            \renewcommand{\eeyrs@temp}{#1}%
        \else%
            \StrBefore{#1}{#2}[\eeyrs@temp]%
        \fi%
    \else%
        \ifnum#3 = #4\relax%
            \StrBehind[\numexpr#3 - 1\relax]{#1}{#2}[\eeyrs@temp]%
        \else%
            \StrBetween[\numexpr#3 - 1\relax,#3]{#1}{#2}{#2}[\eeyrs@temp]%
        \fi%
    \fi%
    \expandafter\trim@spaces\expandafter{\eeyrs@temp}%
}
% #endregion

% #region Events
\newcommand{\eeyrs@onAuthor}{%
    \normalsize%
    \hspace{-0.125in}
    \begin{minipage}[t]{2.125in}%
        \underline{School Address}\\
        \eeyrs@substring{\eeyrs@schooladdr}{;}{1}{3}\\
        \eeyrs@substring{\eeyrs@schooladdr}{;}{2}{3}\\
        \eeyrs@substring{\eeyrs@schooladdr}{;}{3}{3}
    \end{minipage}%
    \begin{minipage}[t]{2.75in}~\end{minipage}
    \begin{minipage}[t]{2.125in}
        \underline{Home Address}\\
        \eeyrs@substring{\eeyrs@homeaddr}{;}{1}{3}\\
        \eeyrs@substring{\eeyrs@homeaddr}{;}{2}{3}\\
        \eeyrs@substring{\eeyrs@homeaddr}{;}{3}{3}
    \end{minipage}
    \vspace{\dimexpr -1in / 8 \relax}
}
\newcommand{\eeyrs@onTitle}{%
    \eeyrs@pull\eeyrs@pull%
    \Large\textbf{\eeyrs@name}\\%
    \normalsize\eeyrs@web\eeyrs@pull
}
\newcommand{\eeyrs@onBeginDocument}{%
    \pagenumbering{gobble}%
    \date{}%
    \maketitle%
    \eeyrs@pull\noindent
    \rule{\textwidth}{0.5pt}
    \eeyrs@pull
    \vspace{\dimexpr 1in / 16\relax}
}
\title{\eeyrs@onTitle}
\author{\eeyrs@onAuthor}
\AtBeginDocument{\eeyrs@onBeginDocument}
% #endregion

% #region New Macros
\newcommand{\eeyrs@push}{\vspace{0.75\baselineskip}}
\newcommand{\eeyrs@pull}{\vspace{-0.75\baselineskip}}

\newcommand{\eeyrstwoone}[2]{
    \noindent
    \begin{minipage}[t]{0.66\textwidth}#1\end{minipage}%
    \begin{minipage}[t]{0.34\textwidth}#2\end{minipage}%
    \eeyrs@push
}

\newcommand{\eeyrsthirds}[3]{
    \noindent
    \begin{minipage}[t]{0.33\textwidth}#1\end{minipage}%
    \begin{minipage}[t]{0.33\textwidth}#2\end{minipage}%
    \begin{minipage}[t]{0.33\textwidth}#3\end{minipage}%
    \eeyrs@push
}

\newcommand{\eeyrsposition}[5]{
    \eeyrstwoone%
        {\textbf{#1}\\\textit{#3}}%
        {\textbf{#2}\\\textit{#4}}\relax
    \vspace{-0.5\baselineskip}
    #5
    \eeyrs@push
}
% #endregion

% #region Section Environment
\newenvironment{eeyrssection}[1]%
{%
    \noindent
    \begin{minipage}[t]{1in}%
        #1
    \end{minipage}%
    \begin{minipage}[t]{6in}
}%
{%
    \end{minipage}
}
% #endregion
