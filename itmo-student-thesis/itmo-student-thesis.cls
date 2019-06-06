\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{itmo-student-thesis}[2019/06/06 v1.4]
\RequirePackage{xkvltxp}
\LoadClass[14pt,a4paper]{extreport}

%% Обработка опций пакета

\newif\if@shouldusexelatex
\newif\if@shouldmakespecification
\newif\if@shouldmakeannotation
\newif\if@shouldmaketitlepage@ru
\newif\if@shouldmakespecification@ru
\newif\if@shouldmakeannotation@ru

\newcommand{\@babeloptions}{english,russian}

\RequirePackage{xkeyval}

\DeclareOptionX{times}{\@shouldusexelatextrue}
\DeclareOptionX{specification}{\@shouldmakespecificationtrue}
\DeclareOptionX{annotation}{\@shouldmakeannotationtrue}
\DeclareOptionX{specification-extra-ru}{\@shouldmakespecification@rutrue}
\DeclareOptionX{annotation-extra-ru}{\@shouldmakeannotation@rutrue}
\DeclareOptionX{titlepage-extra-ru}{\@shouldmaketitlepage@rutrue}
\DeclareOptionX{languages}{\renewcommand{\@babeloptions}{#1}}

\ProcessOptionsX\relax

\if@shouldusexelatex
    \RequirePackage{fontspec}
    \defaultfontfeatures{Ligatures={TeX},Renderer=Basic}
    \setmainfont[Ligatures={TeX,Historic}]{Times New Roman}
    \setsansfont{Arial}
    \setmonofont{Courier New}
\else
    \RequirePackage{paratype}
\fi

%% Конфигурируем babel

\RequirePackage[\@babeloptions]{babel}
\RequirePackage{csquotes}
\RequirePackage{iflang}

%% Формируем отступы

\RequirePackage[top=2cm, bottom=2cm, left=2.7cm, right=1.5cm]{geometry}

%% Эти пакеты слишком часто используются, чтобы их не включать

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{amsfonts}
\RequirePackage{amsxtra}

%% Поддержка цветов и чего-то еще графического, в том числе в таблицах.

\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{colortbl}

%% Этот пакет используется для некоторых таблиц и других визуальных элементов.

\RequirePackage{tabularx}

%% Расположение номеров страниц - как и в диссертации.

\RequirePackage{fancyhdr}

%% Делаем правильные подписи в правильных местах.

\RequirePackage{caption}
\RequirePackage{floatrow}

%% Тем, кому нужны листинги, должны использовать \begin{algorithm}\end{algorithm}
%% в качестве флоатов.

\RequirePackage{algorithm}
\floatname{algorithm}{\@listingname}

%% Не знаю, надо оно здесь или нет, но пусть будет.

\RequirePackage{algorithmicx}
\RequirePackage{algpseudocode}

%% Перечисления по умолчанию слишком разрежены.

\RequirePackage{enumitem}
\setlist{nosep}

%% Полуторный межстрочный интервал
\RequirePackage{setspace}
\onehalfspace

%% Абзацный отступ по ГОСТу - пять букв. Это примерно столько.

\setlength{\parindent}{1.25cm}

%% Не используем буллеты.

\renewcommand\labelitemi{---}

%% На первом уровне нумерованных списков ставим русские буквы, на втором - цифры.

%%% asbuk работал бы неплохо, но он включает в нумерацию букву "з", которую ГОСТ не разрешает. И, может быть, что-то еще.

\def\asbukx#1{\expandafter\@asbukx\csname c@#1\endcsname}
\def\@asbukx#1{\ifcase#1\or a\or б\or в\or г\or д\or е\or ж\or и\or к\or л\or м\or н\or п\or р\or с\or т\or у\or ф\or х\or ц\or ш\or щ\or э\or ю\or я\fi}

\def\Asbukx#1{\expandafter\@Asbukx\csname c@#1\endcsname}
\def\@Asbukx#1{\ifcase#1\or А\or Б\or В\or Г\or Д\or Е\or Ж\or И\or К\or Л\or М\or Н\or П\or Р\or С\or Т\or У\or Ф\or Х\or Ц\or Ш\or Щ\or Э\or Ю\or Я\fi}

\AddEnumerateCounter{\Asbukx}{\@Asbukx}{М}
\AddEnumerateCounter{\asbukx}{\@asbukx}{м}

\renewcommand\labelenumii{\arabic{enumii})}
\renewcommand\theenumii{\arabic{enumii}}

\newcommand{\@iflfe}[2]{#1}

\newcommand*{\@tablecontinuation}[1]{Table~#1, continued}
\newcommand*{\@chaptername}{CHAPTER}
\newcommand*{\@introductionname}{INTRODUCTION}
\newcommand*{\@conclusionname}{CONCLUSION}
\newcommand*{\@appendixname}{APPENDIX}
\newcommand*{\@appendixcounter}{\Alph{chapter}}
\newcommand*{\@proofname}{Proof}
\newcommand*{\@referencesname}{REFERENCES}
\newcommand*{\@chapterconclusion}{Conclusions on Chapter}
\newcommand*{\@listingname}{Listing}

\newcommand*{\@theorem@theorem}{Theorem}
\newcommand*{\@theorem@proposition}{Proposition}
\newcommand*{\@theorem@corollary}{Corollary}
\newcommand*{\@theorem@lemma}{Lemma}
\newcommand*{\@theorem@question}{Question}
\newcommand*{\@theorem@conjecture}{Conjecture}
\newcommand*{\@theorem@assumption}{Assumption}
\newcommand*{\@theorem@definition}{Definition}
\newcommand*{\@theorem@notation}{Notation}
\newcommand*{\@theorem@condition}{Condition}
\newcommand*{\@theorem@example}{Example}

\addto{\captionsenglish}{%
\renewcommand{\@iflfe}[2]{#1}%
\renewcommand*{\figurename}{Figure}%
\renewcommand*{\contentsname}{Contents}%
\renewcommand*{\labelenumi}{\alph{enumi})}%
\renewcommand*{\theenumi}{\alph{enumi}}%
\renewcommand*{\@tablecontinuation}[1]{Table~#1, continued}%
\renewcommand*{\@chaptername}{CHAPTER}%
\renewcommand*{\@introductionname}{INTRODUCTION}%
\renewcommand*{\@conclusionname}{CONCLUSION}%
\renewcommand*{\@appendixname}{APPENDIX}%
\renewcommand*{\@appendixcounter}{\Alph{chapter}}%
\renewcommand*{\@proofname}{Proof}%
\renewcommand*{\@referencesname}{REFERENCES}%
\renewcommand*{\@chapterconclusion}{Conclusions on Chapter}%
\renewcommand*{\@listingname}{Listing}%
\renewcommand*{\@theorem@theorem}{Theorem}%
\renewcommand*{\@theorem@proposition}{Proposition}%
\renewcommand*{\@theorem@corollary}{Corollary}%
\renewcommand*{\@theorem@lemma}{Lemma}%
\renewcommand*{\@theorem@question}{Question}%
\renewcommand*{\@theorem@conjecture}{Conjecture}%
\renewcommand*{\@theorem@assumption}{Assumption}%
\renewcommand*{\@theorem@definition}{Definition}%
\renewcommand*{\@theorem@notation}{Notation}%
\renewcommand*{\@theorem@condition}{Condition}%
\renewcommand*{\@theorem@example}{Example}%
}

\addto{\captionsrussian}{%
\renewcommand{\@iflfe}[2]{#2}%
\renewcommand*{\figurename}{Рисунок}%
\renewcommand*{\contentsname}{Содержание}%
\renewcommand*{\labelenumi}{\asbukx{enumi})}%
\renewcommand*{\theenumi}{\asbukx{enumi}}%
\renewcommand*{\@tablecontinuation}[1]{Продолжение таблицы~#1}%
\renewcommand*{\@chaptername}{ГЛАВА}%
\renewcommand*{\@introductionname}{ВВЕДЕНИЕ}%
\renewcommand*{\@conclusionname}{ЗАКЛЮЧЕНИЕ}%
\renewcommand*{\@appendixname}{ПРИЛОЖЕНИЕ}%
\renewcommand*{\@appendixcounter}{\Asbukx{chapter}}%
\renewcommand*{\@proofname}{Доказательство}%
\renewcommand*{\@referencesname}{СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ}%
\renewcommand*{\@chapterconclusion}{Выводы по главе}%
\renewcommand*{\@listingname}{Листинг}%
\renewcommand*{\@theorem@theorem}{Теорема}%
\renewcommand*{\@theorem@proposition}{Утверждение}%
\renewcommand*{\@theorem@corollary}{Следствие}%
\renewcommand*{\@theorem@lemma}{Лемма}%
\renewcommand*{\@theorem@question}{Вопрос}%
\renewcommand*{\@theorem@conjecture}{Гипотеза}%
\renewcommand*{\@theorem@assumption}{Предположение}%
\renewcommand*{\@theorem@definition}{Определение}%
\renewcommand*{\@theorem@notation}{Обозначение}%
\renewcommand*{\@theorem@condition}{Условие}%
\renewcommand*{\@theorem@example}{Пример}%
}

%% Многостраничные таблицы в гостовском формате. Аргументы:
%% 1 - имя, по которому ссылаемся
%% 2 - подпись
%% 3 - строка форматирования столбцов (как в tabular)
%% 4 - заголовки столбцов (первая строчка, которая будет везде повторяться)
%% 5 - число столбцов (не осилил вычислить его из значения 3)

\newenvironment{nirtable}[5]{
\begin{longtable}{#3}\caption{#2}\label{#1}
\\\hline #4 \\\hline \endfirsthead
\multicolumn{#5}{r}{\normalsize\@tablecontinuation{\thetable}} \\\hline #4 \endhead
}{\end{longtable}}
                    
%% Библиография по ГОСТу. Используем только бибер.

\RequirePackage[
    backend=biber,
    bibencoding=utf8,
    sorting=nyt,
    sortcites=true,
    bibstyle=gost-numeric,
    citestyle=numeric-comp,
    autolang=other
]{biblatex}

%% Патчи к стилевику библиографии.

% biblatex-3.4 и biblatex-gost
% Эти штуки появились недавно, и кажется, что не во всех дистрибутивах они настроены правильно.
% В любом случае, эта функциональность нам не нужна, ее можно заткнуть таким вот образом.
\providecommand{\datecircaprint}{}
\providecommand{\dateeraprintpre}[1]{}
\providecommand{\mkyearzeros}{}
\providecommand{\dateeraprint}[1]{}
\providecommand{\dateuncertainprint}{}

\renewbibmacro*{//}{\nopunct\printtext{\addspace\mbox{//}\addnbspace}}
\renewcommand*{\newblockpunct}{\textemdash\addnbspace\bibsentence}
\DeclareFieldFormat*{pages}{\mkpageprefix[bookpagination][\mbox]{#1}}
\DeclareFieldFormat*{labelnumberwidth}{#1}
\DefineBibliographyStrings{english}{pages={p\adddot}}
\DefineBibliographyExtras{russian}{\protected\def\bibrangedash{\textendash\penalty\hyphenpenalty}}

% Это ставит сначала русские, потом иностранные источники

\DeclareSourcemap{
    \maps[datatype=bibtex]{
        \map{
            \step[fieldsource=langid, match=russian, final]
            \step[fieldset=presort, fieldvalue={a}]
         }
         \map{
            \step[fieldsource=langid, notmatch=russian, final]
            \step[fieldset=presort, fieldvalue={z}]
         }
    }
}

% Добавляем чей-то драйвер от online, чтобы "электронный ресурс" отражался по ГОСТу.

\DeclareBibliographyDriver{online}{%
\usebibmacro{bibindex}%
\usebibmacro{begentry}%
\usebibmacro{heading}%
\newunit
\usebibmacro{author/editor}%
\setunit*{\labelnamepunct}%
\usebibmacro{title}%
\addspace\foreignlanguage{russian}{[Электронный ресурс]}
\setunit{\addcolondelim}%
\usebibmacro{translation}%
\def\bbx@gost@respdelim{\setunit{\respdelim}}% ----- Resp starts -----
\usebibmacro{byauthor}%
\setunit*{\resppunct}%
\iflistundef{organization}
  {}
  {\setrespdelim%
   \printlist{organization}%
   \setunit*{\resppunct}}%
\usebibmacro{credits}%
\setunit*{\resppunct}%
\usebibmacro{byeditor}%
\setunit*{\resppunct}%
\usebibmacro{bytranslator+others}%
\newunit\newblock
\printfield{version}%
\newunit\newblock
\printlist[semicolondelim]{specdata}%
\newunit\newblock
\usebibmacro{date}%
\newunit\newblock
\printupdate%
\newunit\newblock
\printfield{systemreq}%
\newunit\newblock
\usebibmacro{doi+eprint+url+note}%
\newunit\newblock
\usebibmacro{addendum+pubstate}%
\setunit{\bibpagerefpunct}\newblock
\usebibmacro{pageref}%
\newunit\newblock
\usebibmacro{related:init}%
\usebibmacro{related}%
\usebibmacro{finentry}}

%% Счетчики. Для всего, кроме страниц, используем totcount, для страниц используем pageslts. Если надо.

%\RequirePackage{pageslts} % В текущей версии шаблона нет объема работы. Удивительно, но да.

\RequirePackage{totcount}
\RequirePackage{longtable}
\regtotcounter[auxfile=\jobname.tct]{figure}
\regtotcounter[auxfile=\jobname.tct]{table}
\regtotcounter[auxfile=\jobname.tct]{algorithm}
\newtotcounter[auxfile=\jobname.tct]{citnum}
\newtotcounter[auxfile=\jobname.tct]{appendix}
\AtEveryBibitem{\clearfield{addendum}}

%% Большая пачка определений теорем.

\newtheoremstyle{theoremstyle}{0pt}{0pt}{}{1cm}{\itshape}{.}{.5em}{}
\theoremstyle{theoremstyle}

\newtheorem{theorem}{\@theorem@theorem}
\newtheorem{prop}[theorem]{\@theorem@proposition}
\newtheorem{corollary}[theorem]{\@theorem@corollary}
\newtheorem{lemma}[theorem]{\@theorem@lemma}
\newtheorem{question}[theorem]{\@theorem@question}
\newtheorem{conjecture}[theorem]{\@theorem@conjecture}
\newtheorem{assumption}[theorem]{\@theorem@assumption}
\newtheorem{definition}[theorem]{\@theorem@definition}
\newtheorem{notation}[theorem]{\@theorem@notation}
\newtheorem{condition}[theorem]{\@theorem@condition}
\newtheorem{example}[theorem]{\@theorem@example}

\renewcommand{\proof}[1][]{\textit{\@proofname\ifthenelse{\equal{#1}{}}{}{ (#1)}}.~}

%% Листинги, по умолчанию - Java

\RequirePackage{listings}
\definecolor{darkblue}{rgb}{0,0,0.5}
\definecolor{darkgreen}{rgb}{0,0.5,0}

\lstset{
    language=Java,
    extendedchars=\true,
    tabsize=4,
    keywordstyle=\color{darkblue},
    commentstyle=\color{gray},
    stringstyle=\color{darkgreen},
    breaklines=true,
    showstringspaces=false,
    basicstyle=\small
}

%% Все флоаты нумеруем глобально. Формулы - тоже.

\RequirePackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}
\counterwithout{algorithm}{chapter}
\counterwithout{algorithm}{section}
\counterwithout{algorithm}{subsection}
\counterwithout{equation}{chapter}

\AtBeginDocument{%
  \let\c@lstlisting\c@algorithm
  \let\thelstlisting\thealgorithm
  \let\ftype@lstlisting\ftype@algorithm % give the floats the same precedence
  \counterwithout{lstlisting}{chapter}
  \counterwithout{lstlisting}{section}
  \counterwithout{lstlisting}{subsection}
}
     

%% "Тонкая" настройка теховских штрафов при формировании абзацев.

\sloppy
\binoppenalty=10000
\relpenalty=10000
\clubpenalty=10000
\widowpenalty=10000

%% Подписи к рисункам, таблицам, листингам.

\floatstyle{plaintop}
\restylefloat{algorithm}

\floatsetup[figure]{style=plain, capposition=bottom}
\captionsetup[figure]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=centering,
    position=bottom
}
\floatsetup[table]{style=plain, capposition=top}
\captionsetup[table]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified,
    position=top
}
\floatsetup[algorithm]{style=plain, capposition=top}
\captionsetup[algorithm]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified,
    position=top
}
\floatsetup[lstlisting]{style=plain, capposition=top}
\captionsetup[lstlisting]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified,
    position=top
}

%% Переопределение библиографии. Может, можно и проще, но сделал так.

\defbibheading{trueHeading}{%
\chapter*{\@referencesname}%
\addcontentsline{toc}{chapter}{\@referencesname}}

\newcommand{\printmainbibliography}{
\printbibliography[heading=trueHeading]%
%%% Считаем, какие границы у пяти- и десятилетней давности
\newcounter{@yearminusfive@src}%
\newcounter{@yearminusten@src}%
\setcounter{@yearminusfive@src}{\theyear}%
\addtocounter{@yearminusfive@src}{-5}%
\def\@yearminusfive{\value{@yearminusfive@src}}%
\setcounter{@yearminusten@src}{\theyear}%
\addtocounter{@yearminusten@src}{-10}%
\def\@yearminusten{\value{@yearminusten@src}}%
%%% Компоненты фильтров
\newcommand{\@iffiveyears}{\iffieldint{year}{\ifnumless{\thefield{year}}{\@yearminusfive}{\skipentry}{}}{\skipentry}}%
\newcommand{\@iftenyears}{\iffieldint{year}{\ifnumless{\thefield{year}}{\@yearminusfive}{\ifnumless{\thefield{year}}{\@yearminusten}{\skipentry}{}}{\skipentry}}{\skipentry}}%
\newcommand{\@ifveryold}{\iffieldint{year}{\ifnumless{\thefield{year}}{\@yearminusten}{}{\skipentry}}{}}%
\newcommand{\@ifrussian}{\iffieldundef{langid}{}{\iffieldequalstr{langid}{russian}{}{\skipentry}}}%
\newcommand{\@ifforeign}{\iffieldundef{langid}{\skipentry}{\iffieldequalstr{langid}{russian}{\skipentry}{}}}%
%%% Сами фильтры
\defbibcheck{bibch@russiansourcesfiveyears}{\@iffiveyears\@ifrussian}%
\defbibcheck{bibch@russiansourcestenyears}{\@iftenyears\@ifrussian}%
\defbibcheck{bibch@russiansourcesveryold}{\@ifveryold\@ifrussian}%
\defbibcheck{bibch@foreignsourcesfiveyears}{\@iffiveyears\@ifforeign}%
\defbibcheck{bibch@foreignsourcestenyears}{\@iftenyears\@ifforeign}%
\defbibcheck{bibch@foreignsourcesveryold}{\@ifveryold\@ifforeign}%
\@countsourceswhere{}{citnum}%
\@countsourceswhere{check=bibch@russiansourcesfiveyears}{c@russiansourcesfiveyears}%
\@countsourceswhere{check=bibch@russiansourcestenyears}{c@russiansourcestenyears}%
\@countsourceswhere{check=bibch@russiansourcesveryold}{c@russiansourcesveryold}%
\@countsourceswhere{check=bibch@foreignsourcesfiveyears}{c@foreignsourcesfiveyears}%
\@countsourceswhere{check=bibch@foreignsourcestenyears}{c@foreignsourcestenyears}%
\@countsourceswhere{check=bibch@foreignsourcesveryold}{c@foreignsourcesveryold}%
\@countsourceswhere{type=online}{c@internetsources}}

\newcommand{\printannobibliography}{\renewcommand*{\bibfont}{\small}\printbibliography[heading=none]}

%% Подсчет источников различных категорий. Это следующие команды:
%%   \relatedworksourcecount   - число источников, использованных в обзоре
%%   \russiansourcesfiveyears  - число отечественных источников за последние 5 лет
%%   \russiansourcestenyears   - число отечественных источников от 5 (не включительно) до 10 лет
%%   \russiansourcesveryold    - число отечественных источников старше 10 лет
%%   \foreignsourcesfiveyears  - число иностранных источников за последние 5 лет
%%   \foreignsourcestenyears   - число иностранных источников от 5 (не включительно) до 10 лет
%%   \foreignsourcesveryold    - число иностранных источников старше 10 лет
%%   \internetsources          - число интернет-источников

%%% Сначала учимся считать источники вместо того, чтобы их печатать
\newcounter{@bibliocounter}
\defbibenvironment{@fillbibliocounter}
    {\renewcommand{\blx@driver}[1]{}}
    {}
    {\stepcounter{@bibliocounter}}

%%% Заводим счетчики под это все
\newtotcounter[auxfile=\jobname.tct]{c@relatedworksourcecount}
\newtotcounter[auxfile=\jobname.tct]{c@russiansourcesfiveyears}
\newtotcounter[auxfile=\jobname.tct]{c@russiansourcestenyears}
\newtotcounter[auxfile=\jobname.tct]{c@russiansourcesveryold}
\newtotcounter[auxfile=\jobname.tct]{c@foreignsourcesfiveyears}
\newtotcounter[auxfile=\jobname.tct]{c@foreignsourcestenyears}
\newtotcounter[auxfile=\jobname.tct]{c@foreignsourcesveryold}
\newtotcounter[auxfile=\jobname.tct]{c@internetsources}

\defbibheading{reallynone}{}

%%% Считаем в счетчик #2 число ссылок, удовлетворяющих фильтру #1
\newcommand{\@countsourceswhere}[2]{%
\setcounter{@bibliocounter}{0}%
\printbibliography[env=@fillbibliocounter,heading=reallynone,#1]%
\setcounter{#2}{\arabic{@bibliocounter}}}

%%% Определяем команды через значения счетчиков
\newcommand{\relatedworksourcecount}{\total{c@relatedworksourcecount}}
\newcommand{\russiansourcesfiveyears}{\total{c@russiansourcesfiveyears}}
\newcommand{\russiansourcestenyears}{\total{c@russiansourcestenyears}}
\newcommand{\russiansourcesveryold}{\total{c@russiansourcesveryold}}
\newcommand{\foreignsourcesfiveyears}{\total{c@foreignsourcesfiveyears}}
\newcommand{\foreignsourcestenyears}{\total{c@foreignsourcestenyears}}
\newcommand{\foreignsourcesveryold}{\total{c@foreignsourcesveryold}}
\newcommand{\internetsources}{\@iflfe{\ifthenelse{\equal{\totvalue{c@internetsources}}{0}}{none}{yes, \total{c@internetsources} resource(s)}}
                                     {\ifthenelse{\equal{\totvalue{c@internetsources}}{0}}{нет}{да, число ресурсов: \total{c@internetsources}}}}

%%% Команды для начала и конца секции с обзором
\newcommand{\startrelatedwork}{\newrefsegment}
\newcommand{\finishrelatedwork}{\@countsourceswhere{segment=\arabic{refsegment}}{c@relatedworksourcecount}\endrefsegment}

%% Делаем русские варианты знаков неравенств.

\let\le\leqslant
\let\leq\leqslant
\let\ge\geqslant
\let\geq\geqslant

%% Позволяем многострочным формулам перелезать на следующие страницы.

\allowdisplaybreaks

%% Шрифты, размеры, расположения заголовков разделов.

\RequirePackage{titlesec}
\RequirePackage{titletoc}

\setcounter{secnumdepth}{3}
\titleformat{\chapter}[block]{\normalsize\bfseries\center}{\@chaptername~\thechapter.~}%
{0pt}{\begin{MakeUppercase}}[\end{MakeUppercase}\thispagestyle{\TheOnlyTruePageStyle}]
\titlespacing{\chapter}{0pt}{-30pt}{0pt}
\titleformat{\section}[block]{\normalsize\bfseries\center}{\thesection.~}{0pt}{}
\titlespacing{\section}{0pt}{0pt}{0pt}
\titleformat{\subsection}[block]{\normalsize\bfseries\center}{\thesubsection.~}{0pt}{}
\titlespacing{\subsection}{0pt}{0pt}{0pt}
\titleformat{\subsubsection}[block]{\normalsize\bfseries\center}{\thesubsubsection.~}{0pt}{}
\titlespacing{\subsubsection}{0pt}{0pt}{0pt}

%% \appendix начинает приложения, которые должны правильно именоваться.

\let\oldappendix\appendix
\renewcommand{\appendix}{
\oldappendix
%% Нумерация в приложениях идет по приложениям
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\counterwithin{algorithm}{chapter}
\counterwithin{lstlisting}{chapter}
%%
\renewcommand{\thechapter}{\@appendixcounter}
\titleformat{\chapter}[block]{\normalsize\bfseries\center\stepcounter{appendix}}%
    {\@appendixname~\thechapter.~}{0pt}{\begin{MakeUppercase}}[\end{MakeUppercase}\thispagestyle{\TheOnlyTruePageStyle}]
\titlecontents{chapter}
    [\appendixPrefix]
    {}
    {\contentslabel[\@appendixname~\thecontentslabel.]{\the\appendixPrefix}}
    {\hspace*{-\the\appendixPrefix}}
    {\titlerule*[0.5pc]{.}\contentspage}
}

%% Приемлемый внешний вид содержания

\contentsmargin{1.8em}
\newcommand{\chapterW}{1.2em}
\newcommand{\sectionW}{2.2em}
\newcommand{\subsectionW}{2.6em}

\newcommand{\banhyphens}{\hyphenpenalty=10000\exhyphenpenalty=10000{}}

\AtBeginDocument{
    %% Длина "приложения" нормально определяется только теперь
    \newlength{\appendixPrefix}
    \settowidth{\appendixPrefix}{\@appendixname~M.~}
}

\newlength{\chapterPrefix}
\addtolength{\chapterPrefix}{\chapterW}

\newlength{\sectionPrefix}
\addtolength{\sectionPrefix}{\chapterPrefix}
\addtolength{\sectionPrefix}{\sectionW}

\newlength{\subsectionPrefix}
\addtolength{\subsectionPrefix}{\sectionPrefix}
\addtolength{\subsectionPrefix}{\subsectionW}

\titlecontents{chapter}
    [\chapterPrefix]
    {}
    {\contentslabel[\thecontentslabel.]{\chapterW}}
    {\hspace*{-\chapterW}}
    {\titlerule*[0.5pc]{.}\contentspage}
\titlecontents{section}
    [\sectionPrefix]
    {}
    {\contentslabel[\thecontentslabel.]{\sectionW}}
    {\hspace*{-\sectionW}}
    {\titlerule*[0.5pc]{.}\contentspage}
\titlecontents{subsection}
    [\subsectionPrefix]
    {}
    {\contentslabel[\thecontentslabel.]{\subsectionW}~}
    {\hspace*{-\subsectionW}}
    {\titlerule*[0.5pc]{.}\contentspage}

%% Выводы по главе - удобная команда

\newcommand{\chapterconclusion}{\section*{\@chapterconclusion~\thechapter}\addcontentsline{toc}{section}{\@chapterconclusion~\thechapter}}

%% Обратная совместимость со старым стилем

\newcommand{\startthechapters}{}
\newcommand{\startappendices}{\appendix}
\newcommand{\initializefrontsections}{}

%% ...отдельным пунктом - введение и заключение

\newcommand{\startprefacepage}{%
\chapter*{\@introductionname}\label{chapter:introduction}%
\addcontentsline{toc}{chapter}{\@introductionname}}
\newcommand{\startconclusionpage}{%
\chapter*{\@conclusionname}\label{chapter:conclusion}%
\addcontentsline{toc}{chapter}{\@conclusionname}}

%% Титульная страница

\newcommand{\hfilll}{\hspace{0pt plus 1filll}}

\RequirePackage[normalem]{ulem}

\newcommand{\uhspace}[1]{\uline{\hspace{#1}}}
\newcommand{\signatureplace}{\uhspace{7em}}
\newcommand{\datequoteplace}{\@iflfe{``\uhspace{5ex}''}{<<\uhspace{5ex}>>}}
\newcommand{\infiniteuhspace}{\uhspace{0 cm plus 1fill}}
\newcommand{\unknowndate}{\datequoteplace~\uhspace{13ex}~20\uhspace{3ex}\@iflfe{~}{~г.}}

%% Контентные команды со значениями по умолчанию

%%% \university

\newcommand{\theuniversity@ru}{{\small\bfseries Министерство науки и высшего образования Российской Федерации\par
\MakeUppercase{\scriptsize федеральное государственное автономное образовательное учреждение высшего образования}\par
\begin{singlespace}\MakeUppercase{<<Санкт-Петербургский национальный исследовательский университет информационных технологий,}\par\MakeUppercase{механики и оптики>>}\end{singlespace}}}

\newcommand{\theuniversity@en}{{\small\bfseries Ministry of Science and Higher Education\par
\MakeUppercase{\scriptsize federal state autonomous educational institution of higher education}\par
\begin{singlespace}\MakeUppercase{``Saint Petersburg National Research University of Information Technologies,}\par\MakeUppercase{Mechanics and Optics''}\end{singlespace}}}

\newcommand{\theuniversity}{\@iflfe{\theuniversity@en}{\theuniversity@ru}}
\newcommand{\university}[1]{\@iflfe{\renewcommand{\theuniversity@en}{#1}}{\renewcommand{\theuniversity@ru}{#1}}}

%%% \degreehost

\newcommand{\thedegreehost@ru}{Университет ИТМО}
\newcommand{\thedegreehost@en}{ITMO University}
\newcommand{\thedegreehost}{\@iflfe{\thedegreehost@en}{\thedegreehost@ru}}
\newcommand{\degreehost}[1]{\@iflfe{\renewcommand{\thedegreehost@en}{#1}}{\renewcommand{\thedegreehost@ru}{#1}}}

%%% \faculty

\newcommand{\thefaculty@ru}{ИТиП}
\newcommand{\thefaculty@en}{IT\&P}
\newcommand{\thefaculty}{\@iflfe{\thefaculty@en}{\thefaculty@ru}}
\newcommand{\faculty}[1]{\@iflfe{\renewcommand{\thefaculty@en}{#1}}{\renewcommand{\thefaculty@ru}{#1}}}

%%% \specialty

\newcommand{\specialty}[1]{\@iflfe{\newcommand{\thespecialty@en}{#1}}{\newcommand{\thespecialty@ru}{#1}}}
\newcommand{\thespecialty}{\@iflfe{\thespecialty@en}{\thespecialty@ru}}

%%% \specialization

\newcommand{\specialization}[1]{\@iflfe{\newcommand{\thespecialization@en}{#1}}{\newcommand{\thespecialization@ru}{#1}}}
\newcommand{\thespecialization}{\@iflfe{\thespecialization@en}{\thespecialization@ru}}

%%% \programhead

\newcommand{\theprogramhead@ru}{Парфенов В.Г.}
\newcommand{\theprogramhead@en}{Parfenov V.G.}
\newcommand{\theprogramhead}{\@iflfe{\theprogramhead@en}{\theprogramhead@ru}}

\newcommand{\theprogramheaddegree@ru}{проф., д.т.н.}
\newcommand{\theprogramheaddegree@en}{prof., doct.}
\newcommand{\theprogramheaddegree}{\@iflfe{\theprogramheaddegree@en}{\theprogramheaddegree@ru}}

\newcommand{\programhead}[2]{\@iflfe{\renewcommand{\theprogramhead@en}{#1}\renewcommand{\theprogramheaddegree@en}{#2}}
                                    {\renewcommand{\theprogramhead@ru}{#1}\renewcommand{\theprogramheaddegree@ru}{#2}}}

%%% \city

\newcommand{\thecity@ru}{Санкт-Петербург}
\newcommand{\thecity@en}{Saint Petersburg}
\newcommand{\thecity}{\@iflfe{\thecity@en}{\thecity@ru}}
\newcommand{\city}[1]{\@iflfe{\renewcommand{\thecity@en}{#1}}{\renewcommand{\thecity@ru}{#1}}}

%%% Перечень графического материала

\newcommand{\theplannedgraphics@ru}{Графические материалы и чертежи работой не предусмотрены}
\newcommand{\theplannedgraphics@en}{Supplementary materials and blueprints not required}
\newcommand{\theplannedgraphics}{\@iflfe{\theplannedgraphics@en}{\theplannedgraphics@ru}}
\newcommand{\plannedgraphics}[1]{\@iflfe{\renewcommand{\theplannedgraphics@en}{#1}}{\renewcommand{\theplannedgraphics@ru}{#1}}}

%%% Даты
\newcommand{\@localizeddate@ru}[3]{<<#1>>~#2~#3~г.}
\newcommand{\@localizeddate@en}[3]{``#1''~#2~#3}
\newcommand{\@localizeddate}[3]{\@iflfe{\@localizeddate@en{#1}{#2}{#3}}{\@localizeddate@ru{#1}{#2}{#3}}}

\newcommand{\thestartdate}{\unknowndate}
\newcommand{\startdate}[3]{\renewcommand{\thestartdate}{\@localizeddate{#1}{#2}{#3}}}
\newcommand{\thefinishdate}{\unknowndate}
\newcommand{\finishdate}[3]{\renewcommand{\thefinishdate}{\@localizeddate{#1}{#2}{#3}}}
\newcommand{\thedefencedate}{\unknowndate}
\newcommand{\defencedate}[3]{\renewcommand{\thedefencedate}{\@localizeddate{#1}{#2}{#3}}}

%% Контентные команды без значений по умолчанию

\newcommand{\studygroup}[1]{\newcommand{\thestudygroup}{#1}}

%%% \title

\newcommand{\thetitle}{\@iflfe{\thetitle@en}{\thetitle@ru}}
\renewcommand{\title}[1]{\@iflfe{\newcommand{\thetitle@en}{#1}}{\newcommand{\thetitle@ru}{#1}}}

%%% \author

\providecommand{\theauthor}{~} % some distributions have it, some not
\renewcommand{\theauthor}{\@iflfe{\theauthor@en}{\theauthor@ru}}
\newcommand{\theauthorshort}{\@iflfe{\theauthorshort@en}{\theauthorshort@ru}}

\renewcommand{\author}[2]{\@iflfe{\newcommand{\theauthor@en}{#1}\newcommand{\theauthorshort@en}{#2}}
                                 {\newcommand{\theauthor@ru}{#1}\newcommand{\theauthorshort@ru}{#2}}}

%%% \supervisor

\newcommand{\thesupervisor}{\@iflfe{\thesupervisor@en}{\thesupervisor@ru}}
\newcommand{\thesupervisorshort}{\@iflfe{\thesupervisorshort@en}{\thesupervisorshort@ru}}
\newcommand{\thesupervisordegree}{\@iflfe{\thesupervisordegree@en}{\thesupervisordegree@ru}}
\newcommand{\thesupervisorwork}{\@iflfe{\thesupervisorwork@en}{\thesupervisorwork@ru}}

\newcommand{\supervisor}[4]{\@iflfe{\newcommand{\thesupervisor@en}{#1}\newcommand{\thesupervisorshort@en}{#2}\newcommand{\thesupervisordegree@en}{#3}\newcommand{\thesupervisorwork@en}{#4}}
                                   {\newcommand{\thesupervisor@ru}{#1}\newcommand{\thesupervisorshort@ru}{#2}\newcommand{\thesupervisordegree@ru}{#3}\newcommand{\thesupervisorwork@ru}{#4}}}

%%% \secretary

\newcommand{\thesecretary}{\@iflfe{\thesecretary@en}{\thesecretary@ru}}
\newcommand{\secretary}[1]{\@iflfe{\newcommand{\thesecretary@en}{#1}}{\newcommand{\thesecretary@ru}{#1}}}

%%% \publishyear

\newcommand{\publishyear}[1]{\newcommand{\theyear}{#1}}

%%% Техническое задание и исходные данные к работе

\newcommand{\thetechnicalspec}{\@iflfe{\thetechnicalspec@en}{\thetechnicalspec@ru}}
\newcommand{\technicalspec}[1]{\@iflfe{\newcommand{\thetechnicalspec@en}{#1}}{\newcommand{\thetechnicalspec@ru}{#1}}}

%%% Содержание работы

\newcommand{\theplannedcontents}{\@iflfe{\theplannedcontents@en}{\theplannedcontents@ru}}
\newcommand{\plannedcontents}[1]{\@iflfe{\newcommand{\theplannedcontents@en}{#1}}{\newcommand{\theplannedcontents@ru}{#1}}}

%%% Исходные материалы и пособия

\newcommand{\theplannedsources}{\@iflfe{\theplannedsources@en}{\theplannedsources@ru}}
\newcommand{\plannedsources}[1]{\@iflfe{\newcommand{\theplannedsources@en}{#1}}{\newcommand{\theplannedsources@ru}{#1}}}

%%% Цель исследования

\newcommand{\theresearchaim}{\@iflfe{\theresearchaim@en}{\theresearchaim@ru}}
\newcommand{\researchaim}[1]{\@iflfe{\newcommand{\theresearchaim@en}{#1}}{\newcommand{\theresearchaim@ru}{#1}}}

%%% Задачи, решаемые в ВКР

\newcommand{\theresearchtargets}{\@iflfe{\theresearchtargets@en}{\theresearchtargets@ru}}
\newcommand{\researchtargets}[1]{\@iflfe{\newcommand{\theresearchtargets@en}{#1}}{\newcommand{\theresearchtargets@ru}{#1}}}

%%% Краткая характеристика полученных результатов

\newcommand{\theresearchsummary}{\@iflfe{\theresearchsummary@en}{\theresearchsummary@ru}}
\newcommand{\researchsummary}[1]{\@iflfe{\newcommand{\theresearchsummary@en}{#1}}{\newcommand{\theresearchsummary@ru}{#1}}}

%%% Гранты, полученные при выполнении работы

\newcommand{\theresearchfunding}{\@iflfe{\theresearchfunding@en}{\theresearchfunding@ru}}
\newcommand{\researchfunding}[1]{\@iflfe{\newcommand{\theresearchfunding@en}{#1}}{\newcommand{\theresearchfunding@ru}{#1}}}

%%% Наличие публикаций и выступлений на конференциях

\newcommand{\theresearchpublications}{\@iflfe{\theresearchpublications@en}{\theresearchpublications@ru}}
\newcommand{\researchpublications}[1]{\@iflfe{\newcommand{\theresearchpublications@en}{#1}}{\newcommand{\theresearchpublications@ru}{#1}}}

%% Контентные команды пополнения списков

%%% Добавить консультанта: (Фамилия И.О.) (звание, степень)
\newbool{hasconsultants@en}
\newbool{hasconsultants@ru}
\newcommand{\thelistofconsultants@en}{}
\newcommand{\thelistofconsultants@ru}{}
\newcommand{\addconsultant}[2]{\@iflfe{\booltrue{hasconsultants@en}\appto{\thelistofconsultants@en}{\item #1, #2 \hfill\signatureplace\par\bigskip}}
                                      {\booltrue{hasconsultants@ru}\appto{\thelistofconsultants@ru}{\item #1, #2 \hfill\signatureplace\par\bigskip}}}
\newcommand{\displayconsultants}{\@iflfe{\ifbool{hasconsultants@en}{\noindent Consultant(s): \begin{enumerate}\thelistofconsultants@en\end{enumerate}\par}{}}
                                        {\ifbool{hasconsultants@ru}{\noindent Консультанты:  \begin{enumerate}\thelistofconsultants@ru\end{enumerate}\par}{}}}

%%% Добавить пакет программ: (Название) (Ссылки на разделы)
\newbool{hasadvancedsoftware@en}
\newbool{hasadvancedsoftware@ru}
\newcommand{\thelistofadvancedsoftware@en}{}
\newcommand{\thelistofadvancedsoftware@ru}{}
\newcommand{\addadvancedsoftware}[2]{\@iflfe{\booltrue{hasadvancedsoftware@en}\appto{\thelistofadvancedsoftware@en}{#1 & #2 \\\hline}}
                                            {\booltrue{hasadvancedsoftware@ru}\appto{\thelistofadvancedsoftware@ru}{#1 & #2 \\\hline}}}

\newcommand{\displayadvancedsoftware@ru}{\ifbool{hasadvancedsoftware@ru}
{\par\vspace{3pt}\noindent\begin{tabularx}{\textwidth}{|X|p{0.25\textwidth}|}\hline
 \multicolumn{1}{|c|}{\textbf{Пакеты компьютерных программ и технологий}} & \multicolumn{1}{c|}{\textbf{Раздел работы}} \\\hline
 \thelistofadvancedsoftware@ru
\end{tabularx}\par\vspace{6pt}}{нет\par}}

\newcommand{\displayadvancedsoftware@en}{\ifbool{hasadvancedsoftware@en}
{\par\vspace{3pt}\noindent\begin{tabularx}{\textwidth}{|X|p{0.25\textwidth}|}\hline
 \multicolumn{1}{|c|}{\textbf{Software suites and technologies}} & \multicolumn{1}{c|}{\textbf{Thesis section}} \\\hline
 \thelistofadvancedsoftware@en
\end{tabularx}\par\vspace{6pt}}{none\par}}

\newcommand{\displayadvancedsoftware}{\@iflfe{\displayadvancedsoftware@en}{\displayadvancedsoftware@ru}}

\newcommand{\displaysourcepartition@ru}{\begin{tabularx}{\textwidth}{|*{6}{>{\centering\arraybackslash}X|}}\hline
  \multicolumn{3}{|c|}{\textbf{Отечественных}} & \multicolumn{3}{c|}{\textbf{Иностранных}} \\\hline
  Последние & От 5      & Более  & Последние & От 5 & Более \\
  5 лет     & до 10 лет & 10 лет & 5 лет     & до 10 лет & 10 лет \\\hline
  \russiansourcesfiveyears & \russiansourcestenyears & \russiansourcesveryold &
  \foreignsourcesfiveyears & \foreignsourcestenyears & \foreignsourcesveryold \\\hline
\end{tabularx}}

\newcommand{\displaysourcepartition@en}{\begin{tabularx}{\textwidth}{|*{6}{>{\centering\arraybackslash}X|}}\hline
  \multicolumn{3}{|c|}{\textbf{Russian}} & \multicolumn{3}{c|}{\textbf{Foreign}} \\\hline
  In the last & 5 to 10 & More than  & In the last & 5 to 10 & More than \\
  5 years     & years   & 10 years   & 5 years     & years   & 10 years  \\\hline
  \russiansourcesfiveyears & \russiansourcestenyears & \russiansourcesveryold &
  \foreignsourcesfiveyears & \foreignsourcestenyears & \foreignsourcesveryold \\\hline
\end{tabularx}}

\newcommand{\displaysourcepartition}{\@iflfe{\displaysourcepartition@en}{\displaysourcepartition@ru}}

%% Создание титульной страницы, задания и аннотации

\newcommand{\@strings@ThesisName@en}{Graduation Thesis}
\newcommand{\@strings@ThesisName@ru}{Выпускная квалификационная работа}
\newcommand{\@strings@ThesisName}{\@iflfe{\@strings@ThesisName@en}{\@strings@ThesisName@ru}}

\newcommand{\@strings@ThesisTitle@en}{Title of thesis}
\newcommand{\@strings@ThesisTitle@ru}{Наименование темы}
\newcommand{\@strings@ThesisTitle}{\@iflfe{\@strings@ThesisTitle@en}{\@strings@ThesisTitle@ru}}

\newcommand{\@strings@ThesisTitleLong@en}{Title of the thesis}
\newcommand{\@strings@ThesisTitleLong@ru}{Наименование темы ВКР}
\newcommand{\@strings@ThesisTitleLong}{\@iflfe{\@strings@ThesisTitleLong@en}{\@strings@ThesisTitleLong@ru}}

\newcommand{\@strings@Author@en}{Author}
\newcommand{\@strings@Author@ru}{Автор}
\newcommand{\@strings@Author}{\@iflfe{\@strings@Author@en}{\@strings@Author@ru}}

\newcommand{\@strings@SubjectArea@en}{Subject area}
\newcommand{\@strings@SubjectArea@ru}{Направление подготовки}
\newcommand{\@strings@SubjectArea}{\@iflfe{\@strings@SubjectArea@en}{\@strings@SubjectArea@ru}}

\newcommand{\@strings@SubjectAreaBig@en}{Subject area}
\newcommand{\@strings@SubjectAreaBig@ru}{Направление подготовки (специальность)}
\newcommand{\@strings@SubjectAreaBig}{\@iflfe{\@strings@SubjectAreaBig@en}{\@strings@SubjectAreaBig@ru}}

\newcommand{\@strings@ProgramMajor@en}{Program/Major}
\newcommand{\@strings@ProgramMajor@ru}{Направленность (профиль)}
\newcommand{\@strings@ProgramMajor}{\@iflfe{\@strings@ProgramMajor@en}{\@strings@ProgramMajor@ru}}

\newcommand{\@strings@DegreeLevel@en}{Degree level}
\newcommand{\@strings@DegreeLevel@ru}{Квалификация}
\newcommand{\@strings@DegreeLevel}{\@iflfe{\@strings@DegreeLevel@en}{\@strings@DegreeLevel@ru}}

\newcommand{\@strings@DegreeName}{\@iflfe{\@strings@DegreeName@en}{\@strings@DegreeName@ru}}

\newcommand{\@strings@ThesisSupervisor@en}{Thesis supervisor}
\newcommand{\@strings@ThesisSupervisor@ru}{Руководитель}
\newcommand{\@strings@ThesisSupervisor}{\@iflfe{\@strings@ThesisSupervisor@en}{\@strings@ThesisSupervisor@ru}}

\newcommand{\@strings@ThesisSupervisorLong@en}{Thesis supervisor}
\newcommand{\@strings@ThesisSupervisorLong@ru}{Руководитель ВКР}
\newcommand{\@strings@ThesisSupervisorLong}{\@iflfe{\@strings@ThesisSupervisorLong@en}{\@strings@ThesisSupervisorLong@ru}}

\newcommand{\@strings@APPROVED@en}{APPROVED}
\newcommand{\@strings@APPROVED@ru}{УТВЕРЖДАЮ}
\newcommand{\@strings@APPROVED}{\@iflfe{\@strings@APPROVED@en}{\@strings@APPROVED@ru}}

\newcommand{\@strings@ApprovedForDefense@en}{Approved for defense}
\newcommand{\@strings@ApprovedForDefense@ru}{К защите допустить}
\newcommand{\@strings@ApprovedForDefense}{\@iflfe{\@strings@ApprovedForDefense@en}{\@strings@ApprovedForDefense@ru}}

\newcommand{\@strings@HeadOfProgram@en}{Head of educational program}
\newcommand{\@strings@HeadOfProgram@ru}{Руководитель ОП}
\newcommand{\@strings@HeadOfProgram}{\@iflfe{\@strings@HeadOfProgram@en}{\@strings@HeadOfProgram@ru}}

\newcommand{\@strings@yearend@en}{}
\newcommand{\@strings@yearend@ru}{~г.}
\newcommand{\@strings@yearend}{\@iflfe{\@strings@yearend@en}{\@strings@yearend@ru}}

\newcommand{\@strings@Student@en}{Student}
\newcommand{\@strings@Student@ru}{Студент}
\newcommand{\@strings@Student}{\@iflfe{\@strings@Student@en}{\@strings@Student@ru}}

\newcommand{\@strings@Group@en}{Group}
\newcommand{\@strings@Group@ru}{Группа}
\newcommand{\@strings@Group}{\@iflfe{\@strings@Group@en}{\@strings@Group@ru}}

\newcommand{\@strings@FacultyOf@en}{Faculty of}
\newcommand{\@strings@FacultyOf@ru}{Факультет}
\newcommand{\@strings@FacultyOf}{\@iflfe{\@strings@FacultyOf@en}{\@strings@FacultyOf@ru}}

\newcommand{\@strings@SubjectAreaProgramMajor@en}{Subject area, program/major}
\newcommand{\@strings@SubjectAreaProgramMajor@ru}{Направленность (профиль), специализация}
\newcommand{\@strings@SubjectAreaProgramMajor}{\@iflfe{\@strings@SubjectAreaProgramMajor@en}{\@strings@SubjectAreaProgramMajor@ru}}

\newcommand{\@strings@ThesisReceived@en}{Thesis received}
\newcommand{\@strings@ThesisReceived@ru}{ВКР принята}
\newcommand{\@strings@ThesisReceived}{\@iflfe{\@strings@ThesisReceived@en}{\@strings@ThesisReceived@ru}}

\newcommand{\@strings@OriginalityOfThesis@en}{Originality of thesis}
\newcommand{\@strings@OriginalityOfThesis@ru}{Оригинальность ВКР}
\newcommand{\@strings@OriginalityOfThesis}{\@iflfe{\@strings@OriginalityOfThesis@en}{\@strings@OriginalityOfThesis@ru}}

\newcommand{\@strings@ThesisCompletedWithGrade@en}{Thesis completed with grade}
\newcommand{\@strings@ThesisCompletedWithGrade@ru}{ВКР выполнена с оценкой}
\newcommand{\@strings@ThesisCompletedWithGrade}{\@iflfe{\@strings@ThesisCompletedWithGrade@en}{\@strings@ThesisCompletedWithGrade@ru}}

\newcommand{\@strings@DateOfDefense@en}{Date of defense}
\newcommand{\@strings@DateOfDefense@ru}{Дата защиты}
\newcommand{\@strings@DateOfDefense}{\@iflfe{\@strings@DateOfDefense@en}{\@strings@DateOfDefense@ru}}

\newcommand{\@strings@SecretaryOfCommission@en}{Secretary of State Exam Commission}
\newcommand{\@strings@SecretaryOfCommission@ru}{Секретарь ГЭК}
\newcommand{\@strings@SecretaryOfCommission}{\@iflfe{\@strings@SecretaryOfCommission@en}{\@strings@SecretaryOfCommission@ru}}

\newcommand{\@strings@NumberOfPages@en}{Number of pages}
\newcommand{\@strings@NumberOfPages@ru}{Листов хранения}
\newcommand{\@strings@NumberOfPages}{\@iflfe{\@strings@NumberOfPages@en}{\@strings@NumberOfPages@ru}}

\newcommand{\@strings@NumberOfSupplementary@en}{Number of supplementary materials/Blueprints}
\newcommand{\@strings@NumberOfSupplementary@ru}{Демонстрационных материалов/Чертежей хранения}
\newcommand{\@strings@NumberOfSupplementary}{\@iflfe{\@strings@NumberOfSupplementary@en}{\@strings@NumberOfSupplementary@ru}}

\newcommand{\@strings@OBJECTIVES@first@en}{OBJECTIVES}
\newcommand{\@strings@OBJECTIVES@first@ru}{ЗАДАНИЕ}
\newcommand{\@strings@OBJECTIVES@first}{\@iflfe{\@strings@OBJECTIVES@first@en}{\@strings@OBJECTIVES@first@ru}}

\newcommand{\@strings@OBJECTIVES@second@en}{FOR A GRADUATION THESIS}
\newcommand{\@strings@OBJECTIVES@second@ru}{НА ВЫПУСКНУЮ КВАЛИФИКАЦИОННУЮ РАБОТУ}
\newcommand{\@strings@OBJECTIVES@second}{\@iflfe{\@strings@OBJECTIVES@second@en}{\@strings@OBJECTIVES@second@ru}}

\newcommand{\@strings@DeadlineForSubmission@en}{Deadline for submission of complete thesis}
\newcommand{\@strings@DeadlineForSubmission@ru}{Срок сдачи студентом законченной работы}
\newcommand{\@strings@DeadlineForSubmission}{\@iflfe{\@strings@DeadlineForSubmission@en}{\@strings@DeadlineForSubmission@ru}}

\newcommand{\@strings@RequirementsAndPremise@en}{Requirements and premise for the thesis}
\newcommand{\@strings@RequirementsAndPremise@ru}{Техническое задание и исходные данные к работе}
\newcommand{\@strings@RequirementsAndPremise}{\@iflfe{\@strings@RequirementsAndPremise@en}{\@strings@RequirementsAndPremise@ru}}

\newcommand{\@strings@ContentOfTheThesis@en}{Content of the thesis (list of key issues)}
\newcommand{\@strings@ContentOfTheThesis@ru}{Содержание выпускной работы (перечень подлежащих разработке вопросов)}
\newcommand{\@strings@ContentOfTheThesis}{\@iflfe{\@strings@ContentOfTheThesis@en}{\@strings@ContentOfTheThesis@ru}}

\newcommand{\@strings@ListOfGraphic@en}{List of graphic materials (with a list of required materials)}
\newcommand{\@strings@ListOfGraphic@ru}{Перечень графического материала (с указанием обязательного материала)}
\newcommand{\@strings@ListOfGraphic}{\@iflfe{\@strings@ListOfGraphic@en}{\@strings@ListOfGraphic@ru}}

\newcommand{\@strings@SourceMaterials@en}{Source materials and publications}
\newcommand{\@strings@SourceMaterials@ru}{Исходные материалы и пособия}
\newcommand{\@strings@SourceMaterials}{\@iflfe{\@strings@SourceMaterials@en}{\@strings@SourceMaterials@ru}}

\newcommand{\@strings@ObjectivesIssuedOn@en}{Objectives issued on}
\newcommand{\@strings@ObjectivesIssuedOn@ru}{Дата выдачи задания}
\newcommand{\@strings@ObjectivesIssuedOn}{\@iflfe{\@strings@ObjectivesIssuedOn@en}{\@strings@ObjectivesIssuedOn@ru}}

\newcommand{\@strings@ObjectivesAssumed@en}{Objectives assumed by}
\newcommand{\@strings@ObjectivesAssumed@ru}{Задание принял к исполнению}
\newcommand{\@strings@ObjectivesAssumed}{\@iflfe{\@strings@ObjectivesAssumed@en}{\@strings@ObjectivesAssumed@ru}}

\newcommand{\@strings@ANNOTATION@first@en}{SUMMARY}
\newcommand{\@strings@ANNOTATION@first@ru}{АННОТАЦИЯ}
\newcommand{\@strings@ANNOTATION@first}{\@iflfe{\@strings@ANNOTATION@first@en}{\@strings@ANNOTATION@first@ru}}

\newcommand{\@strings@ANNOTATION@second@en}{OF A GRADUATION THESIS}
\newcommand{\@strings@ANNOTATION@second@ru}{ВЫПУСКНОЙ КВАЛИФИКАЦИОННОЙ РАБОТЫ}
\newcommand{\@strings@ANNOTATION@second}{\@iflfe{\@strings@ANNOTATION@second@en}{\@strings@ANNOTATION@second@ru}}

\newcommand{\@strings@NameOfOrganization@en}{Name of organization}
\newcommand{\@strings@NameOfOrganization@ru}{Наименование организации, в которой выполнена ВКР}
\newcommand{\@strings@NameOfOrganization}{\@iflfe{\@strings@NameOfOrganization@en}{\@strings@NameOfOrganization@ru}}

\newcommand{\@strings@DescriptionOfThesis@en}{DESCRIPTION OF THE GRADUATION THESIS}
\newcommand{\@strings@DescriptionOfThesis@ru}{ХАРАКТЕРИСТИКА ВЫПУСКНОЙ КВАЛИФИКАЦИОННОЙ РАБОТЫ}
\newcommand{\@strings@DescriptionOfThesis}{\@iflfe{\@strings@DescriptionOfThesis@en}{\@strings@DescriptionOfThesis@ru}}

\newcommand{\@strings@ResearchObjective@en}{Research objective}
\newcommand{\@strings@ResearchObjective@ru}{Цель исследования}
\newcommand{\@strings@ResearchObjective}{\@iflfe{\@strings@ResearchObjective@en}{\@strings@ResearchObjective@ru}}

\newcommand{\@strings@ResearchTasks@en}{Research tasks}
\newcommand{\@strings@ResearchTasks@ru}{Задачи, решаемые в ВКР}
\newcommand{\@strings@ResearchTasks}{\@iflfe{\@strings@ResearchTasks@en}{\@strings@ResearchTasks@ru}}

\newcommand{\@strings@SourcesReview@en}{Number of sources listed in the review section}
\newcommand{\@strings@SourcesReview@ru}{Число источников, использованных при составлении обзора}
\newcommand{\@strings@SourcesReview}{\@iflfe{\@strings@SourcesReview@en}{\@strings@SourcesReview@ru}}

\newcommand{\@strings@SourcesTotal@en}{Total number of sources used in the thesis}
\newcommand{\@strings@SourcesTotal@ru}{Полное число источников, использованных в работе}
\newcommand{\@strings@SourcesTotal}{\@iflfe{\@strings@SourcesTotal@en}{\@strings@SourcesTotal@ru}}

\newcommand{\@strings@SourcesByYear@ru}{В том числе источников по годам}
\newcommand{\@strings@SourcesByYear@en}{Sources by years}
\newcommand{\@strings@SourcesByYear}{\@iflfe{\@strings@SourcesByYear@en}{\@strings@SourcesByYear@ru}}

\newcommand{\@strings@OnlineResources@en}{Use of online (internet) resources}
\newcommand{\@strings@OnlineResources@ru}{Использование информационных ресурсов Internet}
\newcommand{\@strings@OnlineResources}{\@iflfe{\@strings@OnlineResources@en}{\@strings@OnlineResources@ru}}

\newcommand{\@strings@UseOfSoftware@en}{Use of modern computer software suites and technologies}
\newcommand{\@strings@UseOfSoftware@ru}{Использование современных пакетов компьютерных программ и технологий}
\newcommand{\@strings@UseOfSoftware}{\@iflfe{\@strings@UseOfSoftware@en}{\@strings@UseOfSoftware@ru}}

\newcommand{\@strings@ShortSummary@en}{Short summary of results/conclusions}
\newcommand{\@strings@ShortSummary@ru}{Краткая характеристика полученных результатов}
\newcommand{\@strings@ShortSummary}{\@iflfe{\@strings@ShortSummary@en}{\@strings@ShortSummary@ru}}

\newcommand{\@strings@GrantsReceived@en}{Grants received while working on the thesis}
\newcommand{\@strings@GrantsReceived@ru}{Гранты, полученные при выполнении работы}
\newcommand{\@strings@GrantsReceived}{\@iflfe{\@strings@GrantsReceived@en}{\@strings@GrantsReceived@ru}}

\newcommand{\@strings@ThesisPublications@en}{Have you produced any publications or conference reports on the topic of the thesis?}
\newcommand{\@strings@ThesisPublications@ru}{Наличие публикаций и выступлений на конференциях по теме работы}
\newcommand{\@strings@ThesisPublications}{\@iflfe{\@strings@ThesisPublications@en}{\@strings@ThesisPublications@ru}}

%%% Локализуемый шаблон титульной страницы
\newcommand{\typeoutTitlePage}{\begin{titlepage}
    \banhyphens
    \begin{center}\theuniversity\end{center}
    \vspace{0cm plus 0.66fill minus 0cm}
    {\centering\bfseries\MakeUppercase{\@strings@ThesisName}\par}
    \vspace{0cm plus 0.66fill minus 0cm}
    {\centering\MakeUppercase{\thetitle}\par}
    \vspace{0cm plus 1fill minus 0cm}
    {\setlength{\tabcolsep}{3pt}\renewcommand{\arraystretch}{1.5}
    \noindent\begin{tabularx}{\textwidth}{Xl}
    & \@strings@Author: \theauthor \hfilll \signatureplace \\
    & \@strings@SubjectArea:\;
       \begin{minipage}[t]{0.4\textwidth}\begin{flushleft}\thespecialty\end{flushleft}\end{minipage} \\
    & \@strings@DegreeLevel: \@strings@DegreeName \\
    & \@strings@ThesisSupervisor: \thesupervisorshort, \thesupervisordegree~ \hfilll \signatureplace \\
    & \textbf{\@strings@ApprovedForDefense} \\
    & \@strings@HeadOfProgram\ \theprogramhead, \theprogramheaddegree~ \hfilll \signatureplace \\
    \end{tabularx}\par}
    \begin{flushright}\unknowndate\end{flushright}
    \vspace{0cm plus 1fill minus 0cm}
    \begin{center}\thecity, \theyear\@strings@yearend\end{center}
\end{titlepage}\begin{titlepage}
    \banhyphens
    \noindent\@strings@Student~\theauthorshort\;\hfilll \@strings@Group~\thestudygroup\; \@strings@FacultyOf~\thefaculty\par\bigskip\par
    \noindent\@strings@SubjectAreaProgramMajor\par
    \noindent\thespecialization \par\bigskip\par
    \displayconsultants\bigskip\par\bigskip\par
    \noindent\@strings@ThesisReceived~\unknowndate\par\bigskip\par
    \noindent\@strings@OriginalityOfThesis~\uhspace{5ex}\%\par\bigskip\par
    \noindent\@strings@ThesisCompletedWithGrade~\infiniteuhspace\par\bigskip\par
    \noindent\@strings@DateOfDefense~\unknowndate\par\bigskip\par
    \noindent\@strings@SecretaryOfCommission~\thesecretary\hfill\signatureplace\par\bigskip\par
    \noindent\@strings@NumberOfPages~\infiniteuhspace\par\bigskip\par
    \noindent\@strings@NumberOfSupplementary~\infiniteuhspace\par\bigskip\par
\end{titlepage}}

%%% Локализуемый шаблон задания
\newcommand{\typeoutSpecification}{\begin{titlepage}
\begin{center}\theuniversity\end{center}
\begin{small}
    \noindent\begin{tabularx}{\textwidth}{Xl}
        & \hfilll \textbf{\@strings@APPROVED} \hfilll\ \\
        & \@strings@HeadOfProgram\\
        & \theprogramheaddegree\ \theprogramhead\ \signatureplace \\
        & \unknowndate \\
    \end{tabularx}
    \bigskip
    \begin{center}\bfseries{\normalsize\@strings@OBJECTIVES@first}\\\@strings@OBJECTIVES@second\end{center}
    \bigskip
    \begingroup\banhyphens
    \noindent \textbf{\@strings@Student}~\theauthorshort\;\hfilll \textbf{\@strings@Group}~\thestudygroup\; \textbf{\@strings@FacultyOf}~\thefaculty\;\par
    \noindent \textbf{\@strings@ThesisSupervisor}~\thesupervisorshort, \thesupervisordegree, \thesupervisorwork\par
    \noindent \textbf{1~\@strings@ThesisTitle:} \thetitle\par
    \noindent \textbf{\@strings@SubjectAreaBig:} \thespecialty\par
    \noindent \textbf{\@strings@ProgramMajor:} \thespecialization\par
    \noindent \textbf{\@strings@DegreeLevel:} \@strings@DegreeName\par
    \endgroup
    \noindent \textbf{2~\@strings@DeadlineForSubmission:}     \thefinishdate     \par
    \noindent \textbf{3~\@strings@RequirementsAndPremise}\par \thetechnicalspec  \par\pagebreak[3]
    \noindent \textbf{4~\@strings@ContentOfTheThesis}    \par \theplannedcontents\par\pagebreak[3]
    \noindent \textbf{5~\@strings@ListOfGraphic}         \par \theplannedgraphics\par\pagebreak[3]
    \noindent \textbf{6~\@strings@SourceMaterials}       \par \theplannedsources \par\pagebreak[3]
    \noindent \textbf{7~\@strings@ObjectivesIssuedOn}         \thestartdate      \par\bigskip\par
    \noindent\begingroup\renewcommand{\arraystretch}{1.5}\begin{tabular}{ll}
        \@strings@ThesisSupervisorLong & \signatureplace \\
        \@strings@ObjectivesAssumed    & \signatureplace \\
        & \thestartdate
    \end{tabular}\endgroup
\end{small}
\end{titlepage}}

%%% Локализуемый шаблон аннотации
\newcommand{\typeoutAnnotation}{\begin{titlepage}
    \begin{center}\theuniversity\end{center}
    {\centering\bfseries\@strings@ANNOTATION@first\par}
    \begin{small}
    {\centering\bfseries\@strings@ANNOTATION@second\par}
    \bigskip
    \noindent\textbf{\@strings@Student:} \theauthor\par
    \noindent\textbf{\@strings@ThesisTitleLong:} \thetitle\par
    \noindent\textbf{\@strings@NameOfOrganization:} \thedegreehost\par
    \bigskip
    {\centering\bfseries\@strings@DescriptionOfThesis\par}
    \bigskip
    \noindent1~\@strings@ResearchObjective: \theresearchaim\par\pagebreak[3]
    \noindent2~\@strings@ResearchTasks: \theresearchtargets\par\pagebreak[3]
    \noindent3~\@strings@SourcesReview: \relatedworksourcecount\par
    \noindent4~\@strings@SourcesTotal: \total{citnum}\par
    \noindent5~\@strings@SourcesByYear: \par\vspace{3pt}
    \noindent\displaysourcepartition\par\vspace{6pt}
    \noindent6~\@strings@OnlineResources: \internetsources\par\pagebreak[3]
    \noindent7~\@strings@UseOfSoftware: \displayadvancedsoftware\pagebreak[3]
    \noindent8~\@strings@ShortSummary\par\theresearchsummary\par\pagebreak[3]\vspace{1ex minus 1ex}
    \noindent9~\@strings@GrantsReceived\par\theresearchfunding\par\pagebreak[3]\vspace{1ex minus 1ex}
    \noindent10~\@strings@ThesisPublications\par\theresearchpublications\par\bigskip
    \noindent\begingroup\renewcommand{\arraystretch}{1.5}\begin{tabular}{lll}
        \@strings@Student & \theauthorshort & \signatureplace \\
        \@strings@ThesisSupervisor & \thesupervisorshort &  \signatureplace \\
        \multicolumn{3}{l}{\unknowndate}
    \end{tabular}\endgroup
    \end{small}
\end{titlepage}}

%%% Параметр: Бакалавр/Магистр
\renewcommand{\maketitle}[1]{
    \ifstrequal{#1}{Магистр}{
        \providecommand{\thespecialization@ru}{Технологии разработки программного обеспечения}
        \providecommand{\thespecialty@ru}{01.04.02~Прикладная математика и информатика}
        \providecommand{\thespecialization@en}{Technologies of software engineering}
        \providecommand{\thespecialty@en}{01.04.02~Applied mathematics and informatics}
        \providecommand{\@strings@DegreeName@ru}{Магистр}
        \providecommand{\@strings@DegreeName@en}{Master}
    }{
        \ifstrequal{#1}{Бакалавр}{
            \providecommand{\thespecialization@ru}{Математические модели и алгоритмы в разработке программного обеспечения}
            \providecommand{\thespecialty@ru}{01.03.02~Прикладная математика и информатика}
            \providecommand{\thespecialization@en}{Mathematical models and algorithms in software engineering}
            \providecommand{\thespecialty@en}{01.03.02~Applied mathematics and informatics}
            \providecommand{\@strings@DegreeName@ru}{Бакалавр}
            \providecommand{\@strings@DegreeName@en}{Bachelor}
        }{
            \ClassError{Unknown maketitle argument: #1, expected Магистр or Бакалавр}
        }
    }

	\pagenumbering{gobble}
	\typeoutTitlePage
    \if@shouldmaketitlepage@ru\begin{otherlanguage}{russian}\typeoutTitlePage\end{otherlanguage}\fi
    \if@shouldmakespecification\typeoutSpecification\fi
    \if@shouldmakespecification@ru\begin{otherlanguage}{russian}\typeoutSpecification\end{otherlanguage}\fi
    \if@shouldmakeannotation\typeoutAnnotation\fi
    \if@shouldmakeannotation@ru\begin{otherlanguage}{russian}\typeoutAnnotation\end{otherlanguage}\fi
    \pagenumbering{arabic}

    %% Ставим номер страницы сверху по центру
    \newcommand{\TheOnlyTruePageStyle}{fancy}
    \pagestyle{\TheOnlyTruePageStyle}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
    \lhead{}
    \chead{\thepage}
    \rhead{}
    \lfoot{}
    \cfoot{}
    \rfoot{}
    \addtolength{\voffset}{3mm}
    \addtolength{\headsep}{-3mm}

    \setcounter{page}{4}
    % Выключаем переносы в оглавлении
    \pretocmd{\tableofcontents}{\begingroup\banhyphens}{}{}
    \apptocmd{\tableofcontents}{\endgroup}{}{}
}

%% Веселый способ работать с метапостом

\RequirePackage{ifpdf}
\ifpdf
\DeclareGraphicsRule{.1}{mps}{*}{}
\DeclareGraphicsRule{.2}{mps}{*}{}
\DeclareGraphicsRule{.3}{mps}{*}{}
\DeclareGraphicsRule{.4}{mps}{*}{}
\DeclareGraphicsRule{.5}{mps}{*}{}
\DeclareGraphicsRule{.6}{mps}{*}{}
\DeclareGraphicsRule{.7}{mps}{*}{}
\DeclareGraphicsRule{.8}{mps}{*}{}
\DeclareGraphicsRule{.9}{mps}{*}{}
\DeclareGraphicsRule{.10}{mps}{*}{}
\DeclareGraphicsRule{.11}{mps}{*}{}
\DeclareGraphicsRule{.12}{mps}{*}{}
\DeclareGraphicsRule{.13}{mps}{*}{}
\DeclareGraphicsRule{.14}{mps}{*}{}
\DeclareGraphicsRule{.15}{mps}{*}{}
\DeclareGraphicsRule{.16}{mps}{*}{}
\DeclareGraphicsRule{.17}{mps}{*}{}
\DeclareGraphicsRule{.18}{mps}{*}{}
\DeclareGraphicsRule{.19}{mps}{*}{}
\DeclareGraphicsRule{.20}{mps}{*}{}
\fi
