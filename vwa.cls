\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vwa}[2019/02/02 Vorwissenschaftliche Arbeit]
%
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
%% BEGIN: Enhancement of kvoptions: Tristate Options
\def\DeclareTristateOption[#1]#2{%
	\expandafter\newif\csname if\KVO@prefix#2@set\endcsname%
	\DeclareBoolOption[#1]{#2}%
	\AddToKeyvalOption{\KVO@family}{#2}{%
		\csname \KVO@prefix #2@settrue\endcsname%
	}%
}%
%
\def\DeclareTristateComplementaryOption#1#2{%
	\DeclareComplementaryOption{#1}{#2}%
	\AddToKeyvalOption{\KVO@family}{#2}{\csname \KVO@prefix #2@settrue\endcsname}%
}%
% Use \SetTristateDefault to change the default of a tristate Option without
% marking it as set.
\def\SetTristateDefault#1#2{%
	\@ifundefined{if\KVO@prefix#1@set}{\ClassWarning{vwa}{Undefined Option
	`#1'}}{%
	\csname if\KVO@prefix #1@set\endcsname%
	\else\csname\KVO@prefix#1#2\endcsname\fi%
	}%
}%
%% END: Enhancement of kvoptions: Tristate Options

%% BEGIN: Enhancement of kvoptions: change string option defaults
\let\vwa@DeclareStringOption\DeclareStringOption%
\def\DeclareTristateStringOption{%
	\@ifnextchar[{\vwa@DeclareStringOption@}{\vwa@DeclareStringOption@[]}%
}%
%
\def\vwa@DeclareStringOption@[#1]#2{%
	\expandafter\newif\csname if\KVO@prefix#2@set\endcsname%
	\vwa@DeclareStringOption[#1]{#2}%
	\AddToKeyvalOption{\KVO@family}{#2}{\csname \KVO@prefix #2@settrue\endcsname}%
}%
%
\def\SetStringOptionDefault#1#2{%
	\@ifundefined{if\KVO@prefix#1@set}{\ClassWarning{vwa}{Undefined Option
	`#1'}}{%
	\csname if\KVO@prefix#1@set\endcsname%
	\else\expandafter\def\csname\KVO@prefix#1\endcsname{#2}%
	\fi%
	}%
}
%% END: Enhancement of kvoptions: change string option defaults

%%%% Optionen

\DeclareVoidOption{DLS}{%
	\SetStringOptionDefault{zitierstil}{harvard}%
	\SetTristateDefault{inreferencehack}{false}%
	\SetTristateDefault{ohneVgl}{true}%
	\SetTristateDefault{ohneS}{true}%
	\SetStringOptionDefault{threshold}{2}%
	\SetTristateDefault{italicblockquotes}{true}%
	\SetTristateDefault{italicquotes}{true}%
	\SetTristateDefault{quotes}{true}%
	\SetTristateDefault{scauthor}{false}%
	\SetTristateDefault{plenk}{false}%
	\SetTristateDefault{rundeauslassung}{true}%
	\SetTristateDefault{doppelpunkt}{true}%
	\SetTristateDefault{postnotedoppelpunkt}{true}%
	\SetTristateDefault{romanheadings}{true}%
	\SetStringOptionDefault{titlepage}{DLS2018}%
}

%% Zitierweise
\DeclareTristateStringOption[klassisch]{zitierstil}
\DeclareTristateOption[false]{doppelpunkt}
\DeclareTristateOption[false]{postnotedoppelpunkt}
\DeclareTristateOption[false]{plenk}
\DeclareTristateOption[false]{klemp}
\DeclareTristateOption[true]{scauthor}
\DeclareTristateComplementaryOption{noscauthor}{scauthor}
\DeclareTristateOption[false]{ohneVgl}
\DeclareTristateOption[false]{ohneS}
\DeclareTristateOption[false]{ohneund}
\DeclareTristateComplementaryOption{mitund}{ohneund}
% Auslassungen in Zitaten in runden Klammern. (\ldots)
\DeclareTristateOption[false]{rundeauslassung} 
\DeclareTristateOption[true]{inreferencehack}
\DeclareTristateComplementaryOption{noinreferencehack}{inreferencehack}
\DeclareTristateOption[false]{vornamevorne}

%% Algemeiner Stil:
\DeclareBoolOption[false]{bookstyle}
\DeclareComplementaryOption{reportstyle}{bookstyle}

%% Layout
\DeclareTristateStringOption[off]{parskip}
\DeclareBoolOption{flattersatz}
\DeclareComplementaryOption{blocksatz}{flattersatz}
\DeclareTristateStringOption[2]{widowlines}
\DeclareTristateOption[false]{romanheadings}
\DeclareTristateComplementaryOption{sfheadings}{romanheadings}
\DeclareBoolOption{grotesk}
\DeclareBoolOption[false]{tallheadings}
\DeclareComplementaryOption{shallowheadings}{tallheadings}
\DeclareTristateOption[false]{italicquotes}
\AddToKeyvalOption{vwa}{italicquotes}{\SetTristateDefault{quotes}{false}}
\DeclareTristateOption[true]{quotes}
\DeclareTristateOption[false]{italicblockquotes}
\DeclareTristateOption[true]{smallblockquotes}
\DeclareTristateOption[true]{singlespacedblockquotes}
\DeclareTristateOption[true]{quotedblockquotes}
\DeclareBoolOption[false]{footpara}
\DeclareTristateOption[false]{superscriptfootnotes}

%% Nummerierung
\DeclareBoolOption[false]{chapterinlabel}

%% Sprache
\DeclareTristateStringOption[naustrian]{language}

\DeclareTristateStringOption[5mm]{BCOR}
\DeclareTristateStringOption[default]{DIV}
\DeclareTristateStringOption[false]{twoside}
\DeclareTristateStringOption[nomultiple]{footnotes}
\DeclareTristateStringOption[big]{headings}
\DeclareTristateStringOption[listof]{toc}
\DeclareTristateStringOption[onehalf]{leading}


\DeclareTristateStringOption[12pt]{fontsize}

\DeclareTristateStringOption[0pt]{capindent}
\DeclareDefaultOption{%
  \expandafter\PassOptionsToClass\expandafter{\CurrentOption}{scrreprt}}

\DeclareTristateStringOption[DLS2018]{titlepage}

\DeclareTristateStringOption[2]{threshold}

\DeclareBoolOption[true]{ibidem}
\DeclareTristateOption[false]{ibidpage}

\ProcessKeyvalOptions*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifvwa@flattersatz
	\SetStringOptionDefault{parskip}{half}%
\fi

\ifvwa@bookstyle
\LoadClass[parskip=\vwa@parskip,%
	BCOR=\vwa@BCOR,%
	DIV=\vwa@DIV,%
	twoside=\vwa@twoside,%
	headings=\vwa@headings,%
	fontsize=\vwa@fontsize,%
	toc=\vwa@toc]{scrbook}[2016/06/14]
\else
\LoadClass[parskip=\vwa@parskip,%
	BCOR=\vwa@BCOR,%
	DIV=\vwa@DIV,%
	twoside=\vwa@twoside,%
	headings=\vwa@headings,%
	fontsize=\vwa@fontsize,%
	toc=\vwa@toc]{scrreprt}[2016/06/14]
\fi
\KOMAoptions{footnotes=\vwa@footnotes}
\def\tempa{multiple}%
\ifx\vwa@footnotes\tempa%
  \PassOptionsToPackage{hyperfootnotes=false}{hyperref}%
\fi

\RequirePackage[verbose]{placeins}
\expandafter\setcapindent\expandafter{\vwa@capindent}
\RequirePackage[T1]{fontenc} 			% Moderne Schriftkodierung
\RequirePackage[\vwa@language]{babel} 	% Sprache: Deutsch
\RequirePackage[utf8]{inputenc}	    	% Zeichenkodierung der Eingabedatei.
\DeclareUnicodeCharacter{2028}{}		% MacOS mischt U+2028 (LS) hinein, wenn C&P verwendet wird.

% Wähle die Schriftfamilie Latin Modern
\RequirePackage{lmodern}
% Aktiviere Mikro-Typographie-Erweiterungen in PDFTeX
\RequirePackage[babel=true]{microtype}

\ifvwa@romanheadings
	\setkomafont{disposition}{\rmfamily\bfseries}
\fi

\ifvwa@grotesk
	\renewcommand*{\familydefault}{\sfdefault}
\fi

% Lege Durchschuss (Zeilenabstand) fest
\expandafter\RequirePackage\expandafter[\vwa@leading spacing]{setspace}
\AfterTOCHead{\singlespacing} % Das Inhaltsverzeichnis mit normalem Durchschuss.
\KOMAoptions{DIV=last}

\ifvwa@flattersatz
	% Flattersatz im Literaturverzeichnis:
	\PassOptionsToPackage{block=space}{biblatex}
\fi

\def\vwa@@klassisch{klassisch}
\def\vwa@@harvard{harvard}
\def\vwa@@modern{modern}
\def\vwa@@gemischt{gemischt}
\def\vwa@@numerisch{numerisch}
\def\vwa@@langkurz{langkurz}

\newcommand*{\mkbibparensbrackets}{\mkbibparens}%

\ifvwa@ibidpage@set%
  \ifvwa@ibidpage%
    \PassOptionsToPackage{ibidpage=true}{biblatex}
  \else%
    \PassOptionsToPackage{ibidpage=false}{biblatex}
  \fi
\fi

% Enable citetracker for \bildquelle
\PassOptionsToPackage{citetracker=context}{biblatex}

\ifx\vwa@zitierstil\vwa@@harvard%
	\RequirePackage[style=authoryear-comp, maxbibnames=10000, maxcitenames=2,
	backend=biber, bibencoding=utf8, datezeros=false, dashed=true,
	mergedate=basic, sortlocale=auto]{biblatex}[2016/12/05]
	\providebibmacro*{cite:postnote}{\usebibmacro{postnote}}%
	\providebibmacro*{cite:short}{\usebibmacro{cite}}%
	\newrobustcmd*{\mkbibautoformat}{\mkbibparens}
\else%
\ifx\vwa@zitierstil\vwa@@gemischt%
	\RequirePackage[style=authoryear\ifvwa@ibidem -icomp\else -comp\fi, maxbibnames=10000, maxcitenames=2,
	backend=biber, bibencoding=utf8, datezeros=false, dashed=true,
	mergedate=basic, sortlocale=auto, autocite=footnote]{biblatex}[2016/12/05]
	\providebibmacro*{cite:postnote}{\usebibmacro{postnote}}%
	\providebibmacro*{cite:short}{\usebibmacro{cite}}%
	\newrobustcmd*{\mkbibautoformat}{\iffootnote\mkbibparens\mkbibfootnote}%
\else%
\ifx\vwa@zitierstil\vwa@@langkurz%
	\RequirePackage[style=authoryear\ifvwa@ibidem -icomp\else -comp\fi, maxbibnames=10000, maxcitenames=2,
	backend=biber, bibencoding=utf8, datezeros=false, dashed=true,
	mergedate=basic, sortlocale=auto, autocite=footnote]{biblatex}[2016/12/05]
	\providebibmacro*{cite:postnote}{\usebibmacro{postnote}}%
	\providebibmacro*{cite:short}{\usebibmacro{cite}}%
	\newrobustcmd*{\mkbibautoformat}{\iffootnote\mkbibparens\mkbibfootnote}%
	\letbibmacro*{cite:short}{cite}
	\renewbibmacro*{cite}{%
		\ifciteseen
   		{\usebibmacro{cite:short}}
   		{\usebibmacro{cite:full}}}
\else%
\ifx\vwa@zitierstil\vwa@@numerisch%
	\RequirePackage[style=numeric-comp, defernumbers=true, maxbibnames=10000,
	maxcitenames=2, backend=biber, bibencoding=utf8,
	datezeros=false]{biblatex}[2016/12/05]%
	\providebibmacro*{cite:postnote}{\usebibmacro{postnote}}%
	\providebibmacro*{cite:short}{\usebibmacro{cite:comp}}%
	\renewcommand*{\mkbibparensbrackets}{\mkbibbrackets}%
	\newrobustcmd*{\mkbibautoformat}{\mkbibbrackets}
\else%
\ifx\vwa@zitierstil\vwa@@modern%
	\RequirePackage[style=authortitle-\ifvwa@ibidem i\fi comp,
	maxbibnames=10000, maxcitenames=2, backend=biber,
	bibencoding=utf8, datezeros=false, sortlocale=auto]{biblatex}[2016/12/05]%
	\providebibmacro*{cite:short}{\usebibmacro{cite}}%
	\newrobustcmd*{\mkbibautoformat}{\iffootnote\mkbibparens\mkbibfootnote}
\else% klassisch
	\RequirePackage[style=verbose\ifvwa@ibidem -ibid\fi, maxbibnames=10000,
	maxcitenames=2,backend=biber, bibencoding=utf8, datezeros=false,
	sortlocale=auto]{biblatex}[2016/12/05]%
	\DisableKeyvalOption[action=warning,class=vwa]{vwa}{inreferencehack}%
	\providebibmacro*{cite:init}{}%
	\newrobustcmd*{\mkbibautoformat}{\iffootnote\mkbibparens\mkbibfootnote}
\ifx\vwa@zitierstil\vwa@@klassisch%
	\relax%
\else%
	\ClassError{vwa}{Unbekannter Zitierstil `\vwa@zitierstil'.}%
\fi\fi\fi\fi\fi\fi

\providebibmacro*{cite:full}{%
	\printtext{\usedriver%
		{\DeclareNameAlias{sortname}{default}}
		{\thefield{entrytype}}}}%

\DeclareBibliographyCategory{nocited}

\let\blx@nocite@do@blx\blx@nocite@do
\def\blx@nocite@do#1{%
  \notbool{skipbib}{\addtocategory{inbib}{#1}}{}%
  \addtocategory{nocited}{#1}%
  \blx@nocite@do@blx{#1}}

% Sekundärzitate
% <audrey>
\NewBibliographyString{quotedfrom}
\NewBibliographyString{quotedon}
\DefineBibliographyStrings{german}{%
  quotedfrom = {zit\adddotspace aus},
  quotedon = {zit\adddotspace auf}}

\DefineBibliographyStrings{english}{%
  quotedfrom = {quoted from},
  quotedon = {quoted on}}

\DeclareBibliographyCategory{quoter}
\DeclareBibliographyCategory{quotee}
\DeclareBibliographyCategory{primary}

\defbibheading{quoter}[Quoters]{\section*{#1}}
\defbibheading{quotee}[Quotees]{\section*{#1}}
\defbibheading{citedasprimary}[Bibliography as desired]{\section*{#1}}

\defbibcheck{citedasprimary}{% Suppress quoter-only entries
  \ifboolexpr{ test {\ifcategory{quoter}}
               and not test {\ifcategory{quotee}}
               and not test {\ifcategory{primary}} }
    {\skipentry}
    {}}

\newtoggle{cbx@isquote}% Current citation quotecite?
\newtoggle{cbx@iflastquote}% Last citation quotecite?
\newtoggle{cbx@fullquote}% Print a full quotecite?
\newtoggle{cbx@iflastibid}% Last quotecite ibid?
\newtoggle{cbx@ifquoteepost}% Ibid quotecite outputs quotee postnote?
\newtoggle{cbx@ifquoterpost}% Ibid quotecite outputs quoter postnote?

\renewbibmacro*{finentry}{% Add quoted-in data to quotee-only entries
  \ifbibliography
    {\ifboolexpr{ test {\ifcategory{quotee}}
                  and not test {\ifcategory{primary}} }
       {\newunit%
        \bibstring{quotedin}%
        \addspace%
        \global\toggletrue{cbx@isquote}%
        %###
        \fullcite{\csuse{cbx@quoter@\thefield{entrykey}}}%
        %###
        \global\togglefalse{cbx@isquote}}
       {}}
    {}%
  \finentry}

\AtEveryCitekey{%
  \iftoggle{cbx@isquote}
    {}
    {\addtocategory{primary}{\thefield{entrykey}}%
     \global\togglefalse{cbx@iflastquote}}}

\newbibmacro*{cite:quotee}{%
  \savefieldcs{postnote}{cbx@post}%
  \ifboolexpr{ test {\ifciteseen} and not test {\iftoggle{cbx@fullquote}} }
    {\iffieldundef{shorthand}
       {\ifboolexpr{ not test {\iffirstonpage}
                     and test {\ifsamepage{\value{instcount}}{\value{instcount}-2}}
                     and test {\iftoggle{cbx@iflastquote}}
                     and test {\iffieldequalcs{entrykey}{cbx@lastquoteekey}} }
          {\printtext[bibhyperlink]{\bibstring[\mkibid]{ibidem}}%
           \iffieldequalcs{postnote}{cbx@lastquoteepost}
             {\clearfield{postnote}}
             {\global\toggletrue{cbx@ifquoteepost}}%
           \global\toggletrue{cbx@iflastibid}}
          {\usebibmacro{cite:short}}}
       {\usebibmacro{cite:shorthand}}}
    {\usebibmacro{cite:full}}%
  \csxdef{cbx@lastquoteepost}{\csuse{cbx@post}}}

\newbibmacro*{cite:quoter}{%
  \savefieldcs{postnote}{cbx@post}%
  \ifboolexpr{ not test {\iftoggle{cbx@fullquote}}
               and test {\iftoggle{cbx@iflastibid}}
               and test {\iffieldequalcs{entrykey}{cbx@lastquoterkey}} }
    {\iffieldequalcs{postnote}{cbx@lastquoterpost}
       {\clearfield{postnote}}
       {\global\toggletrue{cbx@ifquoterpost}}}
    {\iftoggle{cbx@iflastibid}
       {\quotedelim}
       {}%
     \global\togglefalse{cbx@iflastibid}%
     \ifboolexpr{ test {\ifciteseen} and not test {\iftoggle{cbx@fullquote}} }
       {\iffieldundef{shorthand}
          {\usebibmacro{cite:short}}
          {\usebibmacro{cite:shorthand}}}
       {\usebibmacro{cite:full}}}%
  \csxdef{cbx@lastquoterpost}{\csuse{cbx@post}}%
  \global\togglefalse{cbx@ifquoteepost}}

\DeclareCiteCommand{\cbx@quotecite}
  {\usebibmacro{cite:init}\usebibmacro{prenote}}
  {\ifnumless{\value{multicitecount}}{2}% <loopcode>
     {\usebibmacro{citeindex}% Current entry is a quotee
      \addtocategory{quotee}{\thefield{entrykey}}%
      \xdef\cbx@quoteekey{\thefield{entrykey}}%
      \usebibmacro{cite:quotee}%
      \csxdef{cbx@lastquoteekey}{\thefield{entrykey}}}
     {\addtocategory{quoter}{\thefield{entrykey}}% Current entry is a quoter
      \xifinlistcs{\thefield{entrykey}}{cbx@quoterlist@\cbx@quoteekey}
        {}
        {\csxappto{cbx@quoter@\cbx@quoteekey}{\thefield{entrykey},}%
         \listcsxadd{cbx@quoterlist@\cbx@quoteekey}{\thefield{entrykey}}}%
      \usebibmacro{cite:quoter}%
      \csxdef{cbx@lastquoterkey}{\thefield{entrykey}}}}
  {\multicitedelim}
  {\iftoggle{cbx@iflastibid}
     {\iftoggle{cbx@ifquoteepost}
        {\let\postnotedelim=\quoteepostdelim}
        {\iftoggle{cbx@ifquoterpost}
           {\let\postnotedelim=\quoterpostdelim}
           {}}}
     {}%
   \usebibmacro{cite:postnote}%
   \global\toggletrue{cbx@iflastquote}}

% <vwa>
%###
\DeclareMultiCiteCommand{\quotecite}
  [\cbx@qcwrapper\relax\relax]
  {\cbx@quotecite} 
  {\cbx@qcdelim}
\DeclareMultiCiteCommand{\fullquotecite}
  [\cbx@qcwrapper\cbx@mkfullquote\relax]
  {\cbx@quotecite} 
  {\cbx@qcdelim}
\DeclareMultiCiteCommand{\parenquotecite}
  [\cbx@qcwrapper\relax\mkbibparensbrackets]
  {\cbx@quotecite}
  {\cbx@qcdelim}
\DeclareMultiCiteCommand{\footnotequotecite}
  [\cbx@qcwrapper\relax\mkbibfootnote]
  {\cbx@quotecite}
  {\cbx@qcdelim}
\DeclareMultiCiteCommand{\footnotequotecitetext}
  [\cbx@qcwrapper\relax\mkbibfootnotetext]
  {\cbx@quotecite}
  {\cbx@qcdelim}
\DeclareMultiCiteCommand{\smartquotecite}
  [\cbx@qcwrapper\relax{\iffootnote\mkbibparensbrackets\mkbibfootnote}]
  {\cbx@quotecite}
  {\cbx@qcdelim}
%###
% </vwa>
%
%###
% from musuos.cbx
% <musuos>
\DeclareMultiCiteCommand{\autoquotecite}
  [\cbx@qcwrapper\relax\mkbibautoformat] 
  {\cbx@quotecite} 
  {\cbx@qcdelim}
\DeclareMultiCiteCommand{\fullautoquotecite}
  [\cbx@qcwrapper\cbx@mkfullquote\mkbibautoformat]
  {\cbx@quotecite}
  {\cbx@qcdelim}

% \newrobustcmd{\mkbibautoformat}[1]{%
%   \cslet{cbx@autocite}{\autocite}%
%   \ifcsequal{cbx@autocite}{blx@acite@inline}
%     {\ifboolexpr{ test {\ifdefstring{\blx@bbxfile}{numeric}}
%                   or test {\ifdefstring{\blx@bbxfile}{alphabetic}} }
%        {\mkbibbrackets{#1}}
%        {\mkbibparens{#1}}}
%     {\ifcsequal{cbx@autocite}{blx@acite@footnote}
%        {\iffootnote
%           {\ifboolexpr{ test {\ifdefstring{\blx@bbxfile}{numeric}}
%                         or test {\ifdefstring{\blx@bbxfile}{alphabetic}} }
%              {\mkbibbrackets{#1}}
%              {\mkbibparens{#1}}}
%           {\mkbibfootnote{#1}}}
%        {\ifcsequal{cbx@autocite}{blx@acite@superscript}
%           {\mkbibsuperscript{#1}}
%           {#1}}}}
% </musuos>

\DeclareMultiCiteCommand{\parenquotecite}
  [\cbx@qcwrapper\relax\mkbibparens]
  {\cbx@quotecite}
  {\cbx@qcdelim}

\DeclareMultiCiteCommand{\plainquotecite}
  [\cbx@qcwrapper\relax\relax]
  {\cbx@quotecite}
  {\cbx@qcdelim}    
%###
%
% Use first argument to override trackers, second to format
% the citation (e.g. \mkbibfootnote). The third is reserved
% for multicite output.
\newrobustcmd{\cbx@qcwrapper}[3]{%
  \global\toggletrue{cbx@isquote}%
  \global\togglefalse{cbx@fullquote}%
  #1#2{#3}%
  \global\togglefalse{cbx@isquote}%
  \global\togglefalse{cbx@iflastibid}%
  \global\togglefalse{cbx@ifquoteepost}%
  \global\togglefalse{cbx@ifquoterpost}}

\newrobustcmd{\cbx@mkfullquote}{%
  %###
  \AtNextCite{\citetrackerfalse}%
  %###
  \toggletrue{cbx@fullquote}}

\newrobustcmd{\cbx@qcdelim}{%
  \iftoggle{cbx@iflastibid}
    {}
    {\quotedelim}}

\newcommand*{\quoteepostdelim}{%
  \addcomma\space\bibstring{quotedfrom}\space}

\newcommand*{\quoterpostdelim}{%
  \addcomma\space\bibstring{quotedon}\space}

\newcommand*{\quotedelim}{%
  %\setunit{\adddot\space\bibsentence}
  \setunit{\addcomma\space}\bibstring{quotedin}\space}
% </audrey>

% % Needed for audrey's quotecite
% \ifx\vwa@zitierstil\vwa@@klassisch
% 	\providebibmacro*{cite:init}{}%
% 	\else%
% 	\ifx\vwa@zitierstil\vwa@@modern%
% 		\providebibmacro*{cite:init}{}%
% 		\providebibmacro*{cite:short}{\printnames{labelname}%
% 		  \setunit*{\printdelim{nametitledelim}}%
% 		  \printtext[bibhyperlink]{%
% 		    \printfield[citetitle]{labeltitle}}}%
% 	\else%
% 		\providebibmacro*{cite:postnote}{\usebibmacro{postnote}}%
% 		\providebibmacro*{cite:short}{\usebibmacro{cite}}%
% 	\fi%
% 	\providebibmacro*{cite:full}{\usebibmacro{cite:short}}%
% \fi

%% Zitierbefehl für Bildquellen:
\newbool{skipbib}
\newbool{inlof}
\newbool{inlot}

\AtEndPreamble{%
  \addtocontents{lof}{%
    \booltrue{inlof}%
    \booltrue{skipbib}%
    \booltrue{citerequest}%
    \booltrue{citetracker}%
	\boolfalse{pagetracker}%
	%###
	\mancite%
	%###
    \relax}%
  \addtocontents{lot}{%
    \booltrue{inlot}%
    \booltrue{skipbib}
    \booltrue{citerequest}%
    \booltrue{citetracker}%
	\boolfalse{pagetracker}%
	%###
	\mancite%
	%###
    \relax}%
    \RequirePackage[\vwa@language]{cleveref}
}

\AtEndDocument{%
  \addtocontents{lof}{%
    \boolfalse{inlof}%
    \relax}%
  \addtocontents{lot}{%
    \boolfalse{inlot}%
    \relax}%
}

\DeclareBibliographyCategory{inbib}
\AtEveryCitekey{%
  \notbool{skipbib}
    {\addtocategory{inbib}{\thefield{entrykey}}}
    {}}

\NewBibliographyString{foundin}
\NewBibliographyString{source}
\NewBibliographyString{imagesource}
\NewBibliographyString{datasource}
\DefineBibliographyStrings{german}{%
  foundin = {bezogen aus},
  source = {Quelle:\space},
  imagesource = {Bildquelle:\space},
  datasource = {Datenquelle:\space}
}
\DefineBibliographyStrings{english}{%
  foundin = {taken from},
  source = {source:\space},
  imagesource = {image source:\space},
  datasource = {data source:\space}
}

\DeclareCiteCommand{\quelle}
  {\usebibmacro{cite:init}%
	\iffieldundef{prenote}
	  {\bibstring{source}}
	  {\printfield{prenote}}
	\setunit{\prenotedelim}}
  {\ifbool{skipbib}
    {\ifcategory{inbib}
      {\usebibmacro{cite}}
      {\ifciteseen%
        {\usebibmacro{cite}}
        {\usedriver%
          {\DeclareNameAlias{sortname}{default}}
          {\thefield{entrytype}}}}}
    {\usebibmacro{cite}}}%
  {\multicitedelim}
  %###
  {\usebibmacro{postnote}\mancite}
  %###

\DeclareMultiCiteCommand{\quellen}
  {\quelle}
  {\multicitedelim}
  

\newrobustcmd*{\bildquelle}{%
  \VWA@ii@optbracket{%
    \VWA@eatarg{%
      \VWA@applyargs\VWA@bildquelle}}{}}
%###
\def\VWA@bildquelle[#1][#2]#3{%
  \begingroup\ifx\@captype\@undefined\else\boolfalse{citetracker}\fi%
  \blx@blxinit%
  \bibstring{imagesource}\addspace%
  \ifboolexpr{ bool {skipbib}
               and not (
                 test {\ifentrycategory{#3}{inbib}}
                 or test {\ifentryseen{#3}} ) }
    {\fullcite[#1][#2]{#3}}
    {\cite[#1][#2]{#3}}%
  \mancite%
  \endgroup%
}
%###
\newrobustcmd*{\bildquellein}{%
  \VWA@ii@optparenthesis{%
    \VWA@ii@optbracket{%
      \VWA@eatarg{%
        \VWA@ii@optbracket{%
          \VWA@eatarg{%
            \VWA@applyargs\VWA@bildquellein}}}}}%
    {}}
%
%###
\def\VWA@bildquellein(#1)(#2)[#3][#4]#5[#6][#7]#8{%
  \begingroup\ifx\@captype\@undefined\else\boolfalse{citetracker}\fi%
  \blx@blxinit%
  \bibstring{imagesource}\addspace%
  \ifboolexpr{ bool {skipbib}
               and not (
                 test {\ifentrycategory{#5}{inbib}}
                 or test {\ifentryseen{#5}})}
    {\fullcite[#3][#4]{#5}}
    {\cite[#3][#4]{#5}}%
  \setunit{\addcomma\space}\bibstring{foundin}\addspace%
  \ifboolexpr{ bool {skipbib}
               and not (
                 test {\ifentrycategory{#8}{inbib}}
                 or test {\ifentryseen{#8}})}
    {\fullcite[#6][#7]{#8}}
    {\cite[#6][#7]{#8}}%
  \mancite%
  \endgroup
}
%###
%
%
\ifvwa@doppelpunkt%
\let\vwa@tmp@warndelimdeclare\blx@warn@delimdeclare
\def\blx@warn@delimdeclare#1#2{} % override warning
%\renewcommand*{\nametitledelim}{\addcolon\space}%
\DeclareDelimFormat{nametitledelim}{\addcolon\space}%
\DeclareDelimFormat[bib]{nametitledelim}{\addcolon\space}%
\DeclareDelimFormat[biblist]{nametitledelim}{\addcolon\space}%
%\DeclareDelimFormat[textcite]{nametitledelim}{\addcolon\space}%
\let\blx@warn@delimdeclare\vwa@tmp@warndelimdeclare
\fi

\ifvwa@postnotedoppelpunkt%
	\ifvwa@plenk%
		\ifvwa@klemp%
			\renewcommand*{\postnotedelim}{\addnbspace:}%
		\else
			\renewcommand*{\postnotedelim}{\addnbspace:\addabbrvspace}%
		\fi
	\else%
		\ifvwa@klemp%
			\renewcommand*{\postnotedelim}{:}%
		\else
			\renewcommand*{\postnotedelim}{:\addabbrvspace}%
		\fi
	\fi%
\fi%
\ifvwa@ohneS\DeclareFieldFormat{postnote}{\def\pno{}\def\ppno{}\addabbrvspace
#1}\fi%

\ifvwa@inreferencehack%
	%\ClassWarning{vwa}{InReference-Hack aktiv}
	\DeclareLabeldate[inreference]{%
	  \field{title}
	  \field{date}
	  \field{year}
	  \field{eventdate}
	  \field{origdate}
	  \field{urldate}
	  \literal{nodate}
	}
	\AtEveryBibitem{%
	  \iffieldequalstr{labeldatesource}{title}{%
	    \iffieldint{extrayear}%
	      {}%
	      {\clearfield{labelyear}}%
	    }%
	    {}}
	\DeclareFieldFormat{labelyear}{% = the '1995' part in 'Jones 1995a'
	  \iffieldequalstr{labeldatesource}{title}{\mkbibemph{#1}}
	  {\ifbibstring{#1}{\bibstring{#1}}{\mkyearzeros{#1}}}}
	\DeclareFieldFormat{labelendyear}{% = the '1995' part in 'Jones 1995a'
	  \iffieldequalstr{labeldatesource}{title}{\mkbibemph{#1}}
	  {\ifbibstring{#1}{\bibstring{#1}}{\mkyearzeros{#1}}}}
	\renewcommand*{\nameyeardelim}{%
	  \iffieldequalstr{labeldatesource}{title}{\addcomma\space}{\addspace}}
\fi

\ifvwa@scauthor%
	\renewcommand*{\mkbibnamefamily}[1]{%
	  \ifmknamesc{\textsc{#1}}{#1}}
	%
	\renewcommand*{\mkbibnameprefix}[1]{%
	  \ifboolexpr{ test {\ifmknamesc} and test {\ifuseprefix} }
	    {\textsc{#1}}
	    {#1}}
	%
	\def\ifmknamesc{%
	  \ifboolexpr{ test {\ifcurrentname{labelname}}
	               or test {\ifcurrentname{author}}
	               or ( test {\ifnameundef{author}} and test
	               {\ifcurrentname{editor}} and ( test {\ifbibliography} or test
	               {\ifbool{citetracker}} ) ) }}
\fi


% Kopf- und Fußzeile anpassen?
\iffalse
  \RequirePackage[automark]{scrlayer-scrpage}
  % \lohead[Anna Bolika]{}
  % \rohead[Wie man seine VWA in \LaTeX{} schreibt]{}
  % Die folgende Zeile verschiebt die Seitennummern nach rechts. 
  \cfoot*{}\ofoot*{\pagemark}
  %\automark{chapter}
  \pagestyle{scrheadings}
  \renewcommand*{\titlepagestyle}{empty}
  \KOMAoptions{headlines=1.25,headsepline,plainheadsepline}
\fi

% Welche Reihenfolge sollen Vorname und Nachname haben?
\ifvwa@vornamevorne
% Setze Nachname1, Vorname1, Vorname2 Nachname2 und Vorname3 Nachname3
\DeclareNameAlias{sortname}{family-given/given-family}
\DeclareNameAlias{default}{family-given/given-family}
\else
% Setze Nachname1, Vorname1, Nachname2, Vorname2 und Nachname3, Vorname3
\DeclareNameAlias{sortname}{family-given}
\DeclareNameAlias{default}{family-given}
\renewcommand*{\multinamedelim}{\addsemicolon\space}
\fi

\ifvwa@ohneund
  \renewcommand*{\finalnamedelim}{\multinamedelim}
\fi

%###
\DeclareAutoCiteCommand{inline}[l]{\parencite}{\parencites}
%###
\renewrobustcmd{\mkbibparens}[1]{%
  \begingroup
  \blx@blxinit
  \blx@setsfcodes
  \ifcitation{\addspace}{}\bibopenparen#1\bibcloseparen
  \endgroup}

\renewrobustcmd{\mkbibbrackets}[1]{%
  \begingroup
  \blx@blxinit
  \blx@setsfcodes
  \ifcitation{\addspace}{}\bibopenbracket#1\bibclosebracket
  \endgroup}


%%%% csquotes
\RequirePackage[autostyle=true,threshold=\vwa@threshold,maxlevel=3]{csquotes}

\appto\blockquote@prehook{%
\expandafter\def\expandafter\blockquote@savedeverypar\expandafter{\the\everypar}%
\everypar{}%
}
\appto\blockquote@posthook{%
\expandafter\everypar\expandafter{\blockquote@savedeverypar}}
\newrobustcmd*\forceblock{\relax}
\BlockquoteDisable{\def\forceblock{\global\toggletrue{csq@tempsw}}}

\iffalse
\newenvironment{vwaquote}{%
  \ifvmode% neuer Absatz
    \begin{addmargin}{2em}%
    \ifvwa@singlespacedblockquotes\begin{singlespace}\fi%
    \ifvwa@smallblockquotes\small\fi%
    % Da addmargin eine Liste ist und mit einem \item startet, muss \ident
    % nocheinmal eingefügt werden
    \expandafter\everypar\expandafter{\the\everypar\indent}%
  \else% kein neuer Absatz
    % addmargin ist eine Liste und fügt auf jeden Fall \parskip ein. Dem wird
    % durch ein ein \kern entgegengewirkt
    \endgraf\kern-\parskip%
    \begin{addmargin}{2em}%
    \ifvwa@singlespacedblockquotes\begin{singlespace}\fi%
      \ifvwa@smallblockquotes\small\fi%
  \fi%
}{%
  \endgraf\ifvwa@singlespacedblockquotes\end{singlespace}\fi%
  \end{addmargin}%
}
\else
\newenvironment{vwaquote}{%
  \ifvmode% neuer Absatz
    \begin{addmargin}[1cm]{0pt}%
    \ifvwa@singlespacedblockquotes\begin{singlespace}\fi%
    \ifvwa@smallblockquotes\small\fi%
    % Da addmargin eine Liste ist und mit einem \item startet, muss \ident
    % nocheinmal eingefügt werden
    \expandafter\everypar\expandafter{\the\everypar\indent}%
  \else% kein neuer Absatz
    % addmargin ist eine Liste und fügt auf jeden Fall \parskip ein. Dem wird
    % durch ein ein \kern entgegengewirkt
    \endgraf\kern-\parskip%
    \begin{addmargin}[1cm]{0pt}%
    \ifvwa@singlespacedblockquotes\begin{singlespace}\fi%
      \ifvwa@smallblockquotes\small\fi%
  \fi%
}{%
  \endgraf\ifvwa@singlespacedblockquotes\end{singlespace}\fi%
  \end{addmargin}%
}
\fi

\SetBlockEnvironment{vwaquote}
\ifvwa@quotedblockquotes
\ifvwa@italicblockquotes
\renewcommand{\mkblockquote}[4]{\begingroup\itshape\leavevmode\setbox0\hbox{\textooquote}\kern-\wd0\openautoquote#1#2\closeautoquote\ifvmode\noindent\else\/\fi\endgroup#4#3}
\renewcommand{\mkbegdispquote}[2]{\begingroup\itshape\openautoquote}
\renewcommand{\mkenddispquote}[2]{#1\closeautoquote\ifvmode\noindent\else\/\fi\endgroup#2}
\else
\renewcommand{\mkblockquote}[4]{\leavevmode\setbox0\hbox{\textooquote}\kern-\wd0\openautoquote#1#2\closeautoquote#4#3}
\renewcommand{\mkbegdispquote}[2]{\leavevmode\setbox0\hbox{\textooquote}\kern-\wd0\openautoquote}
\renewcommand{\mkenddispquote}[2]{#1\closeautoquote#2}
\fi
\else
\ifvwa@italicblockquotes
\renewcommand{\mkblockquote}[4]{\begingroup\itshape#1#2\ifvmode\noindent\else\/\fi\endgroup#4#3}
\renewcommand{\mkbegdispquote}[2]{\begingroup\itshape}
\renewcommand{\mkenddispquote}[2]{#1\ifvmode\noindent\else\/\fi\endgroup#2}
\fi
\fi

\ifvwa@italicquotes\ifvwa@quotes
\renewcommand{\mktextquote}[6]{\itshape#1#2#4#3\/#6#5}
\else
\renewcommand{\mktextquote}[6]{\advance\csq@qlevel\tw@\itshape#2#4\/\csq@eqgroup#6#5}
\fi\fi
%
%###
\SetCiteCommand{\autocite}
%###
%
% Um Probleme mit zu langen URLs zu vermeiden:
\setcounter{biburlnumpenalty}{100}
\setcounter{biburlucpenalty}{100}
\setcounter{biburllcpenalty}{100}
\biburlsetup

\ifvwa@flattersatz%
	\RequirePackage[document]{ragged2e}
	\renewcommand*{\bibfont}{\RaggedRight}%
	\def\tempa{off}%
	\ifx\vwa@parskip\tempa\ClassWarning{vwa}{Bei Flattersatz empfehle ich
	parskip!}\fi%
\fi%

% Der Abstand zwischen Einträgen im Literaturverzeichnis wird so wie der
% Absatzabstand eingestellt.
\setlength\bibitemsep\parskip

\RequirePackage{graphicx}	% Paket für das Einbinden von Bildern

\ifvwa@chapterinlabel
\RequirePackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{equation}{chapter}
\fi

\RequirePackage[\vwa@language]{varioref}
% \labelformat{chapter}{Kapitel~#1}
% \let\vwa@appendix\appendix
% \renewcommand*\appendix{\vwa@appendix\labelformat{chapter}{Anhang~##1}}
% \labelformat{section}{Abschnitt~#1}
% \labelformat{subsection}{Unterabschnitt~#1}
% \labelformat{table}{\tablename~#1}
% \labelformat{figure}{\figurename~#1}
% \labelformat{equation}{(#1)}

% PDF-spezifische Einstellungen
\RequirePackage[unicode,hidelinks]{hyperref}

% Mit den folgenden Zeilen lassen sich Fußnoten platzsparender gestalten.
\ifvwa@footpara
\PassOptionsToPackage{hyperref}{hyperfootnotes=false}
\RequirePackage[para]{footmisc}
\fi

% bookmark.sty sollte nicht erst nach cleveref geladen werden
\RequirePackage{bookmark}

\ifvwa@superscriptfootnotes\else%
\deffootnote{1em}{1em}{\thefootnotemark\ }%
\fi

% Platzierung von Floats. Verhindere das Floats unter die Fußnoten
% platziert werden.
\renewcommand{\fps@figure}{htp}
\renewcommand{\fps@table}{htp}

\ifvwa@tallheadings
\relax
\else
\RedeclareSectionCommand[
  beforeskip=-1sp,
  afterskip=\baselineskip]{chapter}
\RedeclareSectionCommand[
  beforeskip=-\baselineskip,
  afterskip=.5\baselineskip]{section}
\RedeclareSectionCommand[
  beforeskip=-.75\baselineskip,
  afterskip=.5\baselineskip]{subsection}
\RedeclareSectionCommand[
  beforeskip=-.5\baselineskip,
  afterskip=.25\baselineskip]{subsubsection}
\RedeclareSectionCommand[
  beforeskip=.5\baselineskip,
  afterskip=-1em]{paragraph}
\RedeclareSectionCommand[
  beforeskip=-.5\baselineskip,
  afterskip=-1em]{subparagraph}
\fi  

\RequirePackage[defaultlines=\vwa@widowlines,all]{nowidow}

\def\tempa{plain}
\ifx\vwa@titlepage\tempa
\else
\AtBeginDocument{%
\hypersetup{pdfauthor={\vwa@pdfAuthor},%
	pdftitle={Vorwissenschaftliche Arbeit}}
}%###
\expandafter\input\expandafter{\expandafter v\expandafter
w\expandafter a\vwa@titlepage.def}%###
\fi

% Einige nützliche Abkürzungen
% \zit für Zitate die automatisch als Block eingerückt werden
\renewcommand*{\mkcitation}[1]{#1}
\newrobustcmd*{\zit}{\blockcquote}
\newrobustcmd*{\zitnach}{%
  \VWA@ii@optparenthesis{%
    \VWA@ii@optbracket{%
      \VWA@eatarg{%
        \VWA@ii@optbracket{%
          \VWA@eatarg{%
            \VWA@applyargs\VWA@zitnach}}}}}%
    {}}
\newrobustcmd*{\dzitnach}{%
  \VWA@ii@optparenthesis{%
    \VWA@ii@optbracket{%
      \VWA@eatarg{%
        \VWA@ii@optbracket{%
          \VWA@eatarg{%
            \VWA@i@optbracket{%
              \VWA@eatarg{%
                \VWA@applyargswithend\VWA@dzitnach\VWA@dzitnachend}}}}}}}%
    {}}
\long\def\VWA@applyargs#1#2{#1#2}
\long\def\VWA@applyargswithend#1#2#3{#1#3#2}
\long\def\VWA@eatarg#1#2#3{#1{#2{#3}}}%
\long\def\VWA@eatbracketarg#1#2[#3]{#1{#2[#3]}}%
\long\def\VWA@eatparenthesisarg#1#2(#3){#1{#2(#3)}}%
\long\def\VWA@ii@optparenthesis#1#2{%
  \@ifnextchar(%)
    {\VWA@ii@optparenthesis@i{#1}{#2}}%
    {#1{#2()()}}%
}
\long\def\VWA@ii@optparenthesis@i#1#2(#3){%
  \@ifnextchar(%)
    {\VWA@eatparenthesisarg{#1}{#2(#3)}}%
    {#1{#2()(#3)}}%
}
\long\def\VWA@i@optbracket#1#2{%
  \@ifnextchar[%]
    {\VWA@eatbracketarg{#1}{#2}}%
    {#1{#2[]}}%
}
\long\def\VWA@ii@optbracket#1#2{%
  \@ifnextchar[%]
    {\VWA@ii@optbracket@i{#1}{#2}}%
    {#1{#2[][]}}%
}
\long\def\VWA@ii@optbracket@i#1#2[#3]{%
  \@ifnextchar[%]
    {\VWA@eatbracketarg{#1}{#2[#3]}}%
    {#1{#2[][#3]}}%
}
\def\VWA@i@optarg#1{%
	\@ifnextchar[%]
	  {#1}%
	  {#1[]}}
\def\VWA@ii@optargs#1{%
	\@ifnextchar[%]
	  {\VWA@ii@optargs@i{#1}}%
	  {#1[][]}}
\def\VWA@ii@optargs@i#1[#2]{%
	\@ifnextchar[%]
	  {#1[#2]}%
	  {#1[][#2]}}
\def\VWA@zitnach@i[#1][#2]#3{\VWA@ii@optargs{\VWA@zitnach()()[#1][#2]{#3}}}
%###
\def\VWA@zitnach(#1)(#2)[#3][#4]#5[#6][#7]#8{%
	\blockquote[{\autoquotecite(#1)(#2)[#3][#4]{#5}[#6][#7]{#8}\relax}]}
\def\VWA@dzitnach(#1)(#2)[#3][#4]#5[#6][#7]#8{%
	\begin{displayquote}[{\autoquotecite(#1)(#2)[#3][#4]{#5}[#6][#7]{#8}\relax}]}
\def\VWA@dzitnachend{\end{displayquote}}
%###
%
% \dzit für kurze eingerückte Zitate
\newrobustcmd*{\dzit}{\VWA@dzit}
\def\VWA@dzit{%
	\@ifnextchar[%]
	  {\VWA@@dzit}%
	  {\VWA@@@dzit[][]}}
\def\VWA@@dzit[#1]{%
	\@ifnextchar[%]
	  {\VWA@@@dzit[#1]}%
	  {\VWA@@@dzit[][#1]}}
\def\VWA@@@dzit[#1][#2]#3{%
	\@ifnextchar[%]
	  {\VWA@@@@dzit[#1][#2]{#3}}%
	  {\VWA@@@dzit[#1][#2]{#3}[]}}
\long\def\VWA@@@@dzit[#1][#2]#3[#4]#5{%
	\begin{displaycquote}[#1][#2]{#3}[#4]#5\end{displaycquote}}

\ifvwa@rundeauslassung%
\renewcommand{\mktextelp}{(\textellipsis\unkern)}%
\renewcommand{\mktextelpins}[1]{(\textellipsis\unkern) [#1]}%
\renewcommand{\mktextinselp}[1]{[#1] (\textellipsis\unkern)}%
\fi%

\newcommand*{\elp}{\textelp}
\newcommand*{\ins}{\textins}
\newcommand*{\enq}{\enquote}
\newcommand*{\HdV}{\addcomma{} Hervorh\adddot\addspace durch
d.\addabbrvspace Verf\adddot}
\newcommand*{\iHdV}{\textins{Hervorh.\ durch d.~Verf.}}
\newcommand*{\HiO}{\addcomma{} Hervorh\adddot\addspace im Original}
\newcommand*{\iHiO}{\textins{Hervorh.\ im Original}}
%
%###
%% From: http://tex.stackexchange.com/a/95386/71990
\newrobustcmd*{\Vgl}{\bibsentence\cfcitehook\autocite}
\newrobustcmd*{\Vgls}{\bibsentence\multicfcitehook\autocites}
\def\vgl{\cfcitehook\autocite}
\newrobustcmd*{\vgls}{\multicfcitehook\autocites}
\newrobustcmd*{\cfcitehook}{%
  \AtNextCite{\renewbibmacro*{prenote}{\usebibmacro{prenote:confer}}}}
%###
\newrobustcmd*{\multicfcitehook}{%
  \AtNextCite{\renewbibmacro*{multiprenote}{\usebibmacro{multiprenote:confer}}}}
%
\ifvwa@ohneVgl%
\newbibmacro*{prenote:confer}{%
  \iffieldundef{prenote}
    {}
    {\printfield{prenote}\setunit{\prenotedelim}}%
}
\newbibmacro*{multiprenote:confer}{%
  \iffieldundef{multiprenote}
    {}
    {\printfield{multiprenote}\setunit{\prenotedelim}}%
}
\else
\newbibmacro*{prenote:confer}{%
  \iffieldundef{prenote}
    {\bibstring{confer}}
    {\printfield{prenote}}%
  \setunit{\prenotedelim}}
\newbibmacro*{multiprenote:confer}{%
  \iffieldundef{multiprenote}
    {\bibstring{confer}}
    {\printfield{multiprenote}}%
  \setunit{\prenotedelim}}
\fi


\newrobustcmd*{\withoutclearpage}[1]{\begingroup\let\clearpage\relax#1\endgroup}

\providerobustcmd*{\lf}[1]{\ifblockquote{\\#1}{\addnbspace/ #1}}%

\ifvwa@bookstyle\else
\expandafter\newif\csname if@mainmatter\endcsname\@mainmattertrue
\DeclareRobustCommand*{\frontmatter}{%
  \if@twoside\cleardoubleoddpage\else\clearpage\fi
  \pagestyle{empty}%
  \let\vwa@chapterpagestyle\chapterpagestyle%
  \renewcommand*{\chapterpagestyle}{empty}%
}
\DeclareRobustCommand*{\mainmatter}{%
  \if@twoside\cleardoubleoddpage\else\clearpage\fi
  \@mainmattertrue
  \pagestyle{plain}%
  \let\chapterpagestyle\vwa@chapterpagestyle%
}
\DeclareRobustCommand*{\backmatter}{%
  \if@openright\cleardoubleoddpage\else\clearpage\fi\@mainmatterfalse
  \pagestyle{plain}%
  \let\chapterpagestyle\vwa@chapterpagestyle%
}
\fi
