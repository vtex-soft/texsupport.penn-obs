%% This is file `obs.cls'.
%%
%% LaTeX 2e class file for articles in the journal:
%%   Observational Studies (OBS)
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{obs}[2026/05/20 v1.2, OBS journal class]

%% Numbering switches:
\newif\if@seceqn \@seceqnfalse
\DeclareOption{seceqn}{\@seceqntrue}

\newif\if@pdfua \@pdfuatrue
\DeclareOption{pdfua}{\@pdfuatrue}
\DeclareOption{nopdfua}{\@pdfuafalse}
\DeclareOption{notags}{%
    \def\NOPDFUA{}%
%    \AtEndOfClass{\csname penn@check@notags@status\endcsname}%
    }

\PassOptionsToClass{11pt,twoside}{article}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions*
\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             REQUIRED PACKAGES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[T1]{fontenc}
\RequirePackage{etoolbox}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
%\RequirePackage{epsfig} % senas paketas, istrinti
%\RequirePackage{natbib}
\IfFileExists{vtexnatbib.sty}%
  {\RequirePackage{vtexnatbib}%
   \setNATbibitem
   \let\setVTEXbibitem\relax}%
  {\RequirePackage{natbib}%
   \setcitestyle{round}}

%\csuse{penn@ltxext}

\RequirePackage{xcolor}
%\definecolor{linkblue}{rgb}{0 0.4235 0.6392}

\RequirePackage{graphicx}
\RequirePackage{url}

\AtEndPreamble{%
  \RequirePackage{hyperref}
  \hypersetup{%
    unicode=true,
    colorlinks=true,
    linkcolor=blue,
    citecolor=blue,
    urlcolor=blue,
    breaklinks=true
    }
  }

\InputIfFileExists{obs.cfg}{}{}

\def\@journal{Observational Studies}
%\def\@journalabbrev{}
%\def\@journalurl{}
\def\@jid{obs}
\def\@JID{OBS}
%\gdef\@issn{}
%\gdef\@eissn{2767-3324}

%\RequirePackage{lmodern}
%\DeclareFontFamily{OMX}{lmex}{}
%\DeclareFontShape{OMX}{lmex}{m}{n}{<-> lmex10}{}

%\bibliographystyle{plainnat}
%\bibpunct{(}{)}{;}{a}{,}{,}

\if@seceqn
    \@addtoreset{equation}{section}
    \def\theequation{\@arabic\c@section.\@arabic\c@equation}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\volume#1{\gdef\@volume{#1}}
\def\@volume{00}
\def\issue#1{\gdef\@issue{#1}}
\def\@issue{0}
\def\pubyear#1{\gdef\@pubyear{#1}}
\def\@pubyear{0000}
\def\firstpage#1{\gdef\@firstpage{#1}\setcounter{page}{#1}}
\def\@firstpage{0}
\def\lastpage#1{\gdef\@lastpage{#1}}
\def\@lastpage{0}
\def\aid#1{\gdef\@aid{#1}}
\def\@vtexed{??}
\def\vtexed#1{\def\@vtexed{#1}}

% startlocaldefs, endlocaldefs
\def\startlocaldefs{\makeatletter}
\def\endlocaldefs{\makeatother}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             P A G E   S I Z E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change the overall width of the page.  If these parameters are
%       changed, they will require corresponding changes in the
%       maketitle section.
%
\renewcommand{\topfraction}{0.95}   % let figure take up nearly whole page
\renewcommand{\textfraction}{0.05}  % let figure take up nearly whole page

% Specify the dimensions of each page

\oddsidemargin .25in    %   Note \oddsidemargin = \evensidemargin
\evensidemargin .25in
\marginparwidth 0.07 true in
%\marginparwidth 0.75 true in
%\topmargin 0 true pt           % Nominal distance from top of page to top of
%\topmargin 0.125in
\topmargin -0.5in
\addtolength{\headsep}{0.25in}
\textheight 8.5 true in       % Height of text (including footnotes & figures)
\textwidth 6.0 true in        % Width of text line.
\widowpenalty=10000
\clubpenalty=10000
\@twosidetrue \@mparswitchtrue \def\ds@draft{\overfullrule 5pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           H I S T O R Y   D A T E S
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% history month - abbreviation name
\xdef\getitemvalue#1#2{\noexpand\csname #1@item@#2\endcsname}
\def\setvaluelist#1#2{%
  \@tempcnta=0\relax
  \@for\@curr@val:=#2\do{%
    \advance\@tempcnta by1\relax
    \expandafter\protected@xdef\csname #1@item@\the\@tempcnta\endcsname{\@curr@val}%
    }%
  \expandafter\protected@xdef\csname #1@item@0\endcsname{\the\@tempcnta}%
  }
\def\sday#1{#1}
\def\syear#1{#1}
\def\smonth#1{%
  \@ifundefined{month@item@#1}%
    {\vtxClassError{\fmt@name}{There is no month with number '#1'!}{}}%
    {\getitemvalue{month}{#1}}%
  }
\setvaluelist{month}{Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec}
\expandafter\def\csname month@item@0\endcsname{????}

\def\accepted#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@empty
  \else
    \gdef\@accepted{#1}%
  \fi
  }
\def\@accepted{\@nil}
\def\published#1{%
  \def\@tempa{#1}%
  \ifx\@tempa\@empty
  \else
    \gdef\@published{#1}%
  \fi
  }
\def\@published{\@nil}

\def\accepted@prefix{Accepted~}
\def\published@prefix{Published~}
\def\upd@hist@prefices{%
  \def\accepted@prefix{; Accepted~}%
  \def\published@prefix{; Published~}%
  }
\def\empty@data{\@nil}

\def\history@fmt{%
  \bgroup
    \ifx\@accepted\empty@data
    \else
      \accepted@prefix\@accepted
      \upd@hist@prefices
    \fi
    \ifx\@published\empty@data
    \else
      \published@prefix\@published
    \fi
  \egroup
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               S E C T I O N S
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definitions for nicer (?) sections, etc., ideas from Pat Langley.
% Numbering for sections, etc. is taken care of automatically.

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \def\@svsecsep{}%
  \ifnum#2=1\relax \def\@svsecsep{.}\fi
  \ifnum#2=4\relax \def\@svsecsep{.}\fi
  \ifnum#2=5\relax \def\@svsecsep{.}\fi
   \ifnum #2>\c@secnumdepth
     \def\@svsec{}\else
     \refstepcounter{#1}%
     \edef\@svsec{\csname the#1\endcsname}\fi
     \@tempskipa #5\relax
     \ifdim \@tempskipa>\z@
       \begingroup #6\relax
         \csuse{tagpdf@section@start}%
         \@hangfrom{\hskip #3\relax\@svsec\@svsecsep\hskip0.5em}{\interlinepenalty \@M #8\par}
       \endgroup
       \csname #1mark\endcsname{#7}%
       \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth \else
                      \protect\numberline{\csname the#1\endcsname}\fi
                      #7}
     \else
       \def\@svsechd{#6\hskip #3%
                      \csuse{tagpdf@inlinesection@start}%
                      \@svsec #8%
                      \csuse{tagpdf@inlinesection@stop}%
                      \csname #1mark\endcsname
                      {#7}\addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth \else
                             \protect\numberline{\csname the#1\endcsname}\fi
                       #7}}\fi
     \@xsect{#5}}


\def\thesection{\arabic{section}}
\def\thesubsection{\thesection.\arabic{subsection}}
\def\section{%
  \@startsection{section}{1}{\z@}{-0.24in}{0.10in}{\large\bf\raggedright}%
  }
\def\subsection{%
  \@startsection{subsection}{2}{\z@}{-0.20in}{0.08in}{\normalsize\bf\raggedright}%
  }
\def\subsubsection{%
  \@startsection{subsubsection}{3}{\z@}{-0.18in}{0.08in}{\normalsize\sc\raggedright}%
  }
\def\paragraph{%
  \@startsection{paragraph}{4}{\z@}{1.5ex plus 0.5ex minus .2ex}{-1em}{\normalsize\bf}%
  }
\def\subparagraph{%
  \@startsection{subparagraph}{5}{\z@}{1.5ex plus 0.5ex minus .2ex}{-1em}{\normalsize\bf}%
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              F O O T N O T E S
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change the size of the footnote rule
%
% \renewcommand{\footnoterule}{\vspace{10pt}\hrule width 0mm}

\long\def\@makefntext#1{%
  \@setpar{\@@par\@tempdima \hsize
           \advance\@tempdima-15pt\parshape \@ne 15pt \@tempdima}\par
           \parindent 2em\noindent 
           \hbox to \z@{\hss\csuse{tagpdf@footnotemark@start}{\@thefnmark}.\csuse{tagpdf@footnotemark@stop} \hfil}#1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               F R O N T M A T T E R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newbox\fm@box
\newdimen\fm@size
\def\open@fm{%
  \global\setbox\fm@box=\vbox\bgroup
    \hsize=\textwidth
%        \frontmatter@style
    }
\def\close@fm{%
        \par
    \egroup
    \fm@size=\dp\fm@box
    \advance\fm@size by \ht\fm@box
%    \@whiledim\fm@size>\t@xtheight\do{%
%        \global\setbox\@tempboxa=\vsplit\fm@box to \t@xtheight
%        \unvbox\@tempboxa
%        \fm@size=\dp\fm@box
%        \advance\fm@size by \ht\fm@box
%        }%
        \unvbox\fm@box
    }

\def\frontmatter{%
%  \def\pdftitle##1{\write@pdfinfo{\user@hy@title}{##1}}%
%  \def\pdfauthor##1{\write@pdfinfo{\user@hy@author}{##1}}%
%  \def\pdfsubject##1{\write@pdfinfo{\user@hy@subject}{##1}}%
%  \def\pdfkeywords##1{\write@pdfinfo{\user@hy@keywords}{##1}}%
  \thispagestyle{copyright}%
%  \open@fm
  \begingroup
%        \ignorespaces
  }
\def\endfrontmatter{%
  \@maketitle
%        \put@fmt@data
%    \close@fm
  \endgroup
  \csname make@page@headers\endcsname
  \@thanks
%    \global\let\@thanks\@empty
  }

\newenvironment{aug}{%
%    \setbox\@tempboxa=\hbox\bgroup
  }{%
    \let\prefix\@firstofone
    \let\fnms\@firstofone
    \let\inits\@firstofone
    \let\snm\@firstofone
%    \egroup
%    \the\aug@toks
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         P A G E S T Y L E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Defines the pagestyle for the title page.
\def\copyright@line{%
  \copyright\@pubyear\ \copyright@authors. 
  This is an open access article distributed under the terms of a Creative Commons license (CC BY-NC-ND 4.0).}
\def\ps@copyright{%
  \def\@oddhead{%
    \parbox{\textwidth}{\normalsize\@journal\ \@volume\ (\@pubyear): \@firstpage--\@lastpage\hfill\history@fmt}%
    }%
  \let\@evenhead\@oddhead
  \def\@oddfoot{%
    \parindent\z@
    \parbox{\textwidth}{\scriptsize\copyright@line}%
    }
  \let\@evenfoot\@oddfoot
  }
%% Defines the pagestyle for the rest of the pages
\def\ps@headings{%
  \def\@oddhead{\csuse{tagpdf@artifact@start}\hfill\small\textsc{\@runtitle}\hfill\csuse{tagpdf@artifact@stop}}%
  \def\@evenhead{\csuse{tagpdf@artifact@start}\hfill\small\textsc{\@runauthor}\hfill\csuse{tagpdf@artifact@stop}}%
  \def\@oddfoot{\csuse{tagpdf@artifact@start}\hfill\small\thepage\hfill\csuse{tagpdf@artifact@stop}}%
  \let\@evenfoot\@oddfoot
  }

\def\copyright@authors{}
\newtoks\copyright@authors@list
\def\copyright@author@info#1#2{%
  \bgroup
    \@tempcnta=#1\relax
    \def\fnms##1{\g@addto@macro#2{##1 }}%
    \def\snm##1{\g@addto@macro#2{##1}}%
    \def\author[##1]##2{##2%
      \ifnum\@tempcnta>2\relax
        \g@addto@macro#2{, }%
        \advance\@tempcnta by\m@ne
      \else
        \ifnum\@tempcnta=2\relax
          \ifnum#1>2\relax
            \g@addto@macro#2{,\ and\ }%
          \else
            \g@addto@macro#2{\ and\ }%
          \fi
          \advance\@tempcnta by\m@ne
        \else
          \def\author[####1]####2{}%
        \fi
      \fi
      }%
  \setbox\@tempboxa\hbox{\the\copyright@authors@list}%
  \egroup
  }
\newtoks\authors@list
\def\print@author@info#1#2{%
  \bgroup
    \@tempcnta=#1\relax
    \def\snm##1{\g@addto@macro#2{##1}}%
    \def\author[##1]##2{##2%
      \advance\@tempcnta by\m@ne
      \ifnum\@tempcnta>\z@
        \g@addto@macro#2{\ and\ }%
      \else
        \def\author[####1]####2{}%
      \fi
      }%
    \setbox\@tempboxa\hbox{\the\authors@list}%
  \egroup
  }
\def\make@page@headers{%
  \copyright@author@info{\c@author}\copyright@authors
  \ifx\@runauthor\@empty
    \ifcase\c@author
    \or
      \print@author@info{1}\@runauthor
    \or
      \print@author@info{2}\@runauthor
    \else
      \print@author@info{1}\@runauthor
      \g@addto@macro\@runauthor{~\betal}%
    \fi
  \fi
  \ifx\@runtitle\@empty
    \gdef\@runtitle{\@title}%
  \fi
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        FIRST PAGE, TITLE, AUTHOR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\title#1{\gdef\@title{#1}}
\def\@title{}
\def\runtitle#1{\gdef\@runtitle{#1}}
\def\@runtitle{}
\def\runauthor#1{\gdef\@runauthor{#1}}
\def\@runauthor{}
\def\betal{et al.}

\newlength\aftertitskip     
\newlength\beforetitskip
\newlength\interauthorskip  
\newlength\aftermaketitskip

%% Changeable parameters.
\setlength\aftertitskip{0.1in plus 0.2in minus 0.2in}
\setlength\beforetitskip{0.05in plus 0.08in minus 0.08in}
\setlength\interauthorskip{0.08in plus 0.1in minus 0.1in}
\setlength\aftermaketitskip{0.3in plus 0.1in minus 0.1in}

\DeclareRobustCommand{\ead}[1]{\hfill{\small\href{#1}{#1}}}

%\def\AND{\hss \vskip\interauthorskip}
\def\@maketitle{%
  \@tempcnta=0%
%  \vbox{%
    \hsize=\textwidth
    \linewidth=\hsize
    \vskip\beforetitskip
    \begin{center}%
      \csuse{tagpdf@title@start}%
      \Large\bfseries\@title
      \csuse{tagpdf@title@stop}%
    \end{center}% 
    \vskip\aftertitskip
    \bgroup
      \@whilenum{\@tempcnta<\c@address}\do{%
        \advance\@tempcnta\@ne
        {\bfseries\upshape\csname author\the\@tempcnta\endcsname}\\
        {\small\itshape\csname address\the\@tempcnta\endcsname}%
        \vskip\interauthorskip\noindent
        }%
    \egroup
    \ifdefined\@dedicated
      \textbf{\@dedicated}
    \fi
    \vskip\aftermaketitskip
    \vskip\aftermaketitskip
    \ifvoid\absbox
    \else
      \unvbox\absbox
      \par
    \fi
    \ifvoid\keybox
    \else
      \vskip8pt
      \unvbox\keybox
      \par
    \fi
%    }%
  }

%%% !!! pasikartuoja, istrinti kazkuri
%\def\proc@elem#1#2{%
%  \csgdef{@#1}{#2}%
%  }
\def\@xnamedef#1{\expandafter\xdef\csname #1\endcsname}
\def\proc@elem#1#2{%
  \begingroup
%    \no@harm
    \def\thanks##1##{\@gobble}%
    \def\thanksref##1##{\@gobble}%
    \@xnamedef{@#1}{#2}%
  \endgroup
%  \upd@elem{#1}%
%  \expandafter\elem@nothanksref#2\thanksref\relax
%  \expandafter\elem@nothanks#2\thanks\relax
  }
\newcommand\init@fm@element[3][]{%
  \proc@elem{#2}{#3}%
  }
\long\def\g@addto@hook#1#2{\global#1\expandafter{\the#1#2}}

\def\inits#1{}
\def\fnms#1{#1}
\def\snm#1{#1}

\newcounter{author}
\newcounter{address}
\newtoks\temptoks
\def\author{%
  \@ifnextchar[%
    {\author@fmt}%
    {\author@fmt[]}%
  }
\def\author@fmt[#1]#2{%
%%  \global\ead@labels={}%
  \stepcounter{author}%
%%  \beg@elem
%%  \@for\@tempa:=#1\do{%
%%    \expandafter\add@addressref\expandafter{\@tempa}%
%%    }%
%%  \proc@elem{author}{#2}%
%%  \author@fmt{\the\c@author}{\the\t@loc@notes}{\@author}%
%  \init@fm@element{author}{#2}%      \@author = #2
%  \temptoks=\expandafter{\@author}%  
%  \csxdef{author\the\c@author}{\expandonce{\the\temptoks}}%
  \csgdef{author\the\c@author}{#2}%
  \g@addto@hook\authors@list{\author[#1]{#2}}%
  \g@addto@hook\copyright@authors@list{\author[#1]{#2}}%
  }

\def\address{%
  \@ifnextchar[%
    {\address@fmt}%
    {\address@fmt[]}%
  }
\def\address@fmt[#1]#2{%
  \stepcounter{address}%
%  \beg@elem
%  \proc@elem{address}{#2}%
%  \address@fmt{\the\c@address}{\the\t@loc@notes}{\@address}\label{#1}%
%  \ignorespaces
  \csgdef{address\the\c@address}{#2}%
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                          D E D I C A T E D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\dedicated#1{\gdef\@dedicated{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                 T H A N K S R E F, T H A N K S T E X T
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  thanksref, thanksmark, thankslabel, thankstext
%%  To be safe with hyperref we will use original LaTeX definitions
\def\saferef#1{%
    \expandafter\safe@setref\csname r@#1\endcsname\@firstoftwo{#1}%
    }
\let\safe@setref\@setref

\let\thanksnewlabel\newlabel
\def\safelabel#1{%
    \@bsphack
        \protected@write\@auxout{}%
            {\string\thanksnewlabel{#1}{{\@currentlabel}{\thepage}}}%
    \@esphack
    }

\long\def\safe@footnotetext#1{%
    \insert\footins{%
        \reset@font\footnotesize
        \interlinepenalty\interfootnotelinepenalty
        \splittopskip\footnotesep
        \splitmaxdepth \dp\strutbox
        \floatingpenalty \@MM
        \hsize\columnwidth
        \@parboxrestore
        \color@begingroup
            \def\@thefnmark{}%
            \@makefntext{%
                \rule\z@
                \footnotesep\ignorespaces#1%
                \@finalstrut\strutbox
                }%
        \color@endgroup
        }%
    }

\long\def\orig@footnotetext#1{%#1 -> aaa bbb
    \insert\footins{%
        \reset@font\footnotesize
        \interlinepenalty\interfootnotelinepenalty
        \splittopskip\footnotesep
        \splitmaxdepth \dp\strutbox
        \floatingpenalty \@MM
        \hsize\columnwidth
        \@parboxrestore
        \protected@edef\@currentlabel{%
            \csname p@footnote\endcsname\@thefnmark
            }%
        \color@begingroup
            \@makefntext{%
                \rule\z@
                \footnotesep\ignorespaces#1%
                \@finalstrut\strutbox
                }%
        \color@endgroup
        }%
    }

%%  We want to use various counters
\def\usethankscounter#1{%
    \@ifundefined{current@thankscounter}%
        {\gdef\previous@thankscounter{#1}}%
        {\xdef\previous@thankscounter{\current@thankscounter}}%
    \def\current@thankscounter{#1}%
    }
\def\restorethankscounter{%
    \xdef\current@thankscounter{\previous@thankscounter}%
    }

\newcounter{thanks}
\def\thethanks{\@fnsymbol\c@thanks}
\usethankscounter{thanks}

%%  Address ref
\newcounter{addressref}
\def\theaddressref{\arabic{addressref}}

\def\thanksmark@fmt#1{\csuse{tagpdf@superscript@start}\@textsuperscript{\normalfont#1}\csuse{tagpdf@superscript@stop}}
\def\thanksref@sep{,}

%% Hooks for the hyperref:
\def\thankref@hyperlink#1{\saferef{#1thanks}}
\def\thanks@hypertarget#1{}

%%  Isvedame zymes
\DeclareRobustCommand{\thanksref}{%
    \@ifnextchar[{\@tempswatrue\@thanksref}{\@tempswafalse\@thanksref[]}%
    }
\def\@thanksref[#1]#2{%
    \if@tempswa %  []
        \thanksmark@fmt{#1}%
    \else
        \let\@tempa\@empty
        \thanksmark@fmt{%
            \@for\@tempb:=#2\do{%
                \csname thanksref@hook\endcsname
                \@tempa\let\@tempa\thanksref@sep
                \edef\@tempb{\expandafter\@firstofone\@tempb\@empty}%
                \thankref@hyperlink{\@tempb}%
                }%
            }%
    \fi
    }

%%  Suformuojame ir isvedame zyme
\def\thanksmark{%
    \@ifnextchar[{\@tempswatrue\@thanksmark}{\@tempswafalse\@thanksmark[]}%
    }
\def\@thanksmark[#1]#2{%
    \@thankslabel[#1]{#2}%
    \thanksmark@fmt{%
        \expandafter\saferef{#2thanks}\thanks@hypertarget{#2}%
        }%
    }

%%  Suformuojame tik zyme
\def\thankslabel{%
    \@ifnextchar[{\@tempswatrue\@thankslabel}{\@tempswafalse\@thankslabel[]}%
    }
\def\@thankslabel[#1]#2{%
    \if@tempswa %  []
        \protected@edef\@currentlabel{#1}%
    \else
        \refstepcounter{\current@thankscounter}%
    \fi
    \@ifundefined{temp@label@#2thanks}%
        {\global\@namedef{temp@label@#2thanks}{}\safelabel{#2thanks}}{}%
    }

%%  Suformuojame zyme ir idedame teksta i \@thanks:
\def\thankstext{%
    \@ifnextchar[{\@tempswatrue\@thankstext}{\@tempswafalse\@thankstext[]}%
    }
\def\@thankstext[#1]#2#3{%
    \@thankslabel[#1]{#2}%
    \protected@xdef\@thanks{%
        \@thanks\protect\thanks@thefnmark{#2thanks}%
        \protect\orig@footnotetext{\thanks@hypertarget{#2}#3}%
        }%
    }
\def\thanks@thefnmark#1{%
    \begingroup
        \unrestored@protected@xdef\@thefnmark{\saferef{#1}}%
    \endgroup
    }%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               A B S T R A C T
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% use \begin{abstract} .. \end{abstract} for abstracts.
\def\abstractname{\large\textbf{Abstract}}
\def\abstract@font{\small\noindent}
\def\abstractname@postskip{\vskip0.7ex}
\newbox\absbox
\renewenvironment{abstract}
  {%
    \global\setbox\absbox=\vbox\bgroup%
      \leftskip 20pt\relax
      \rightskip 20pt\relax
      \csuse{tagpdf@abstract@start}%
      {\centerline\abstractname}%
      \abstractname@postskip%
      \abstract@font%
  }{%
      \csuse{tagpdf@abstract@stop}%
      \par
    \egroup
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               KEYWORDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% use \begin{keyword} .. \end{keyword} for keywordss.
\newbox\keybox
\newif\if@firstkwd
\def\keywordsname{\textbf{Keywords:}\ }
\newenvironment{keyword}
  {%
    \global\setbox\keybox=\vbox\bgroup
      \@firstkwdtrue
      \leftskip 20pt\relax
      \rightskip 20pt\relax
      \small
      \csuse{tagpdf@keywords@start}%
      \noindent\keywordsname
  }%
  {%
      \csuse{tagpdf@keywords@stop}%
      \par
    \egroup
  }
\def\kwd@sep{,\ }
\newcommand\kwd[1]{%
  \bgroup
    \if@firstkwd
      \global\@firstkwdfalse
      \let\kwd@sep\@empty
    \fi
    \kwd@sep
    #1%
  \egroup
  \ignorespaces
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               MISCELLANY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\svtable\table
\let\endsvtable\endtable
\renewenvironment{table}[1][]%
  {\svtable[#1]\centering}
  {\endsvtable}

\let\svfigure\figure
\let\endsvfigure\endfigure
\renewenvironment{figure}[1][]%
  {\svfigure[#1]\centering}
  {\endsvfigure}

% Define macros for figure captions and table titles
%\def\figurecaption#1#2{\noindent\hangindent 40pt
%                       \hbox to 36pt {\small\sl #1 \hfil}
%                       \ignorespaces {\small #2}}
%\def\figurecenter#1#2{\centerline{{\sl #1} #2}}
%\def\figurecenter#1#2{\centerline{{\small\sl #1} {\small #2}}}

%
%  Allow ``hanging indents'' in long captions
%
\long\def\@makecaption#1#2{%
  \vskip10pt
  \setbox\@tempboxa\hbox{#1: #2}
  \ifdim\wd\@tempboxa>\hsize               % IF longer than one line:
    \settowidth{\@tempdima}{#1: }%
    {\hangindent\@tempdima\hangafter1
    \noindent\hbox to\@tempdima{#1:\hfil}#2\par}%
  \else                                    %   ELSE  center.
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip8pt
  }


% Define strut macros for skipping spaces above and below text in a
% tabular environment.
\def\abovestrut#1{\rule[0in]{0in}{#1}\ignorespaces}
\def\belowstrut#1{\rule[-#1]{0in}{#1}\ignorespaces}

% Acknowledgments
\def\acknowledgementsname{Acknowledgments}
\def\acks{%
  \section*{\acknowledgementsname}%
  }

% Research Note
\long\def\researchnote#1{\noindent\LARGE\textit{Research Note} #1}

% Appendix
\def\appendix{%
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \def\thesection{\Alph{section}}%
  \def\section{%
    \@ifnextchar*{\@startsection{section}{1}{\z@}{-0.24in}{0.10in}{\large\raggedright\bfseries}}%
                 {\@startsection{section}{1}{\z@}{-0.24in}{0.10in}{\large\raggedright\bfseries Appendix\ }}
    }
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               PROOF, THEOREM, and FRIENDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\BlackBox}{\rule{1.5ex}{1.5ex}}  % end of proof
\newenvironment{proof}{\par\noindent\textbf{Proof}\ }{\hfill\BlackBox\\[2mm]}
\newtheorem{example}{Example}
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{remark}[theorem]{Remark}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{conjecture}[theorem]{Conjecture}
\newtheorem{axiom}[theorem]{Axiom}

%%%%%%

\pagestyle{headings}

\endinput
%%
%% End of file `obs.cls'.
