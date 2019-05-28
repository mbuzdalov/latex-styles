\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{itmo-student-thesis}[2019/05/28 v1.3.b4]

\LoadClass[14pt,a4paper]{extreport}

\RequirePackage[russian,english]{babel}
\RequirePackage{csquotes}

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
\floatname{algorithm}{Листинг}

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

\renewcommand\labelenumi{\asbukx{enumi})}
\renewcommand\theenumi{\asbukx{enumi}}
\renewcommand\labelenumii{\arabic{enumii})}
\renewcommand\theenumii{\arabic{enumii}}

%% Рис. => Рисунок
%% Оглавление => Содержание

\addto{\captionsrussian}{%
\renewcommand*{\figurename}{Рисунок}%
\renewcommand*{\contentsname}{Содержание}%
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
\multicolumn{#5}{r}{\normalsizeПродолжение таблицы \thetable{}} \\\hline #4 \endhead
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
\newtheorem{theorem}{Теорема}
\newtheorem{prop}[theorem]{Утверждение}
\newtheorem{corollary}[theorem]{Следствие}
\newtheorem{lemma}[theorem]{Лемма}
\newtheorem{question}[theorem]{Вопрос}
\newtheorem{conjecture}[theorem]{Гипотеза}
\newtheorem{assumption}[theorem]{Предположение}
\newtheorem{definition}[theorem]{Определение}
\newtheorem{notation}[theorem]{Обозначение}
\newtheorem{condition}[theorem]{Условие}
\newtheorem{example}[theorem]{Пример}

\renewcommand{\proof}[1][]{\textit{Доказательство\ifthenelse{\equal{#1}{}}{}{ (#1)}}.~}

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
\chapter*{СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ}%
\addcontentsline{toc}{chapter}{СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ}}

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
\newcommand{\internetsources}{\ifthenelse{\equal{\totvalue{c@internetsources}}{0}}{нет}{да, число ресурсов: \total{c@internetsources}}}

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
\titleformat{\chapter}[block]{\normalsize\bfseries\center}{ГЛАВА~\thechapter.~}%
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
\renewcommand{\thechapter}{\Asbukx{chapter}}
\titleformat{\chapter}[block]{\normalsize\bfseries\center\stepcounter{appendix}}%
    {ПРИЛОЖЕНИЕ~\thechapter.~}{0pt}{\begin{MakeUppercase}}[\end{MakeUppercase}\thispagestyle{\TheOnlyTruePageStyle}]
\titlecontents{chapter}
    [\appendixPrefix]
    {}
    {\contentslabel[ПРИЛОЖЕНИЕ \thecontentslabel.]{\the\appendixPrefix}}
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
    \settowidth{\appendixPrefix}{ПРИЛОЖЕНИЕ Ж.}
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

\newcommand{\chapterconclusion}{\section*{Выводы по главе~\thechapter}\addcontentsline{toc}{section}{Выводы по главе~\thechapter}}

%% Обратная совместимость со старым стилем

\newcommand{\startthechapters}{}
\newcommand{\startappendices}{\appendix}
\newcommand{\initializefrontsections}{}

%% ...отдельным пунктом - введение и заключение

\newcommand{\startprefacepage}{%
\chapter*{ВВЕДЕНИЕ}\label{chapter:introduction}%
\addcontentsline{toc}{chapter}{ВВЕДЕНИЕ}}
\newcommand{\startconclusionpage}{%
\chapter*{ЗАКЛЮЧЕНИЕ}\label{chapter:conclusion}%
\addcontentsline{toc}{chapter}{ЗАКЛЮЧЕНИЕ}}

%% Титульная страница

\newcommand{\hfilll}{\hspace{0pt plus 1filll}}

\RequirePackage[normalem]{ulem}

\newcommand{\uhspace}[1]{\uline{\hspace{#1}}}
\newcommand{\signatureplace}{\uhspace{7em}}
\newcommand{\datequoteplace}{<<\uhspace{5ex}>>}
\newcommand{\infiniteuhspace}{\uhspace{0 cm plus 1fill}}
\newcommand{\unknowndate}{\datequoteplace~\uhspace{13ex}~20\uhspace{3ex}~г.}

%% Контентные команды со значениями по умолчанию

\newcommand{\theuniversity}{{\small\bfseries Министерство науки и высшего образования Российской Федерации\par
\MakeUppercase{\scriptsize федеральное государственное автономное образовательное учреждение высшего образования}\par
\begin{singlespace}\MakeUppercase{<<Санкт-Петербургский национальный исследовательский университет информационных технологий,}\par\MakeUppercase{механики и оптики>>}\end{singlespace}}}
\newcommand{\university}[1]{\renewcommand{\theuniversity}{#1}}

\newcommand{\thedegreehost}{Университет ИТМО}
\newcommand{\degreehost}[1]{\renewcommand{\thedegreehost}{#1}}

\newcommand{\thefaculty}{ИТиП}
\newcommand{\faculty}[1]{\renewcommand{\thefaculty}{#1}}

\newcommand{\specialty}[1]{\newcommand{\thespecialty}{#1}}

\newcommand{\specialization}[1]{\newcommand{\thespecialization}{#1}}

\newcommand{\theprogramhead}{Парфенов В.Г.}
\newcommand{\theprogramheaddegree}{проф., д.т.н.}
\newcommand{\programhead}[2]{\renewcommand{\theprogramhead}{#1}
                             \renewcommand{\theprogramheaddegree}{#2}}

\newcommand{\thecity}{Санкт-Петербург}
\newcommand{\city}[1]{\renewcommand{\thecity}{#1}}

%%% Перечень графического материала
\newcommand{\theplannedgraphics}{Графические материалы и чертежи работой не предусмотрены}
\newcommand{\plannedgraphics}[1]{\renewcommand{\theplannedgraphics}{#1}}

%%% Даты
\newcommand{\thestartdate}{\unknowndate}
\newcommand{\startdate}[3]{\renewcommand{\thestartdate}{<<#1>>~#2~#3~г.}}
\newcommand{\thefinishdate}{\unknowndate}
\newcommand{\finishdate}[3]{\renewcommand{\thefinishdate}{<<#1>>~#2~#3~г.}}
\newcommand{\thedefencedate}{\unknowndate}
\newcommand{\defencedate}[3]{\renewcommand{\thedefencedate}{<<#1>>~#2~#3~г.}}

%% Контентные команды без значений по умолчанию

\newcommand{\studygroup}[1]{\newcommand{\thestudygroup}{#1}}
\renewcommand{\title}[1]{\newcommand{\thetitle}{#1}}
\renewcommand{\author}[2]{\providecommand{\theauthor}{~}  % some distributions have it, some not
                          \renewcommand{\theauthor}{#1}
                          \newcommand{\theauthorshort}{#2}}
\newcommand{\supervisor}[4]{\newcommand{\thesupervisor}{#1}
                            \newcommand{\thesupervisorshort}{#2}
                            \newcommand{\thesupervisordegree}{#3}
                            \newcommand{\thesupervisorwork}{#4}}
\newcommand{\publishyear}[1]{\newcommand{\theyear}{#1}}
\newcommand{\secretary}[1]{\newcommand{\thesecretary}{#1}}

%%% Техническое задание и исходные данные к работе
\newcommand{\technicalspec}[1]{\newcommand{\thetechnicalspec}{#1}}
%%% Содержание работы
\newcommand{\plannedcontents}[1]{\newcommand{\theplannedcontents}{#1}}
%%% Исходные материалы и пособия
\newcommand{\plannedsources}[1]{\newcommand{\theplannedsources}{#1}}
%%% Цель исследования
\newcommand{\researchaim}[1]{\newcommand{\theresearchaim}{#1}}
%%% Задачи, решаемые в ВКР
\newcommand{\researchtargets}[1]{\newcommand{\theresearchtargets}{#1}}
%%% Краткая характеристика полученных результатов
\newcommand{\researchsummary}[1]{\newcommand{\theresearchsummary}{#1}}
%%% Гранты, полученные при выполнении работы
\newcommand{\researchfunding}[1]{\newcommand{\theresearchfunding}{#1}}
%%% Наличие публикаций и выступлений на конференциях
\newcommand{\researchpublications}[1]{\newcommand{\theresearchpublications}{#1}}

%% Контентные команды пополнения списков

%%% Добавить консультанта: (Фамилия И.О.) (звание, степень)
\newbool{hasconsultants}
\newcommand{\thelistofconsultants}{}
\newcommand{\addconsultant}[2]{\booltrue{hasconsultants}\appto{\thelistofconsultants}{\item #1, #2 \hfill\signatureplace\par\bigskip}}

%%% Добавить пакет программ: (Название) (Ссылки на разделы)
\newbool{hasadvancedsoftware}
\newcommand{\thelistofadvancedsoftware}{}
\newcommand{\addadvancedsoftware}[2]{\booltrue{hasadvancedsoftware}\appto{\thelistofadvancedsoftware}{#1 & #2 \\\hline}}

%% Создание титульной страницы, задания и аннотации

%%% Параметр: Бакалавр/Магистр
\renewcommand{\maketitle}[1]{
    \ifstrequal{#1}{Магистр}{
        \providecommand{\thespecialization}{Технологии разработки программного обеспечения}
        \providecommand{\thespecialty}{01.04.02~Прикладная математика и информатика}
    }{
        \ifstrequal{#1}{Бакалавр}{
            \providecommand{\thespecialization}{Математические модели и алгоритмы в разработке программного обеспечения}
            \providecommand{\thespecialty}{01.03.02~Прикладная математика и информатика}
        }{
            \ClassError{Unknown maketitle argument: #1, expected Магистр or Бакалавр}
        }
    }

	\pagenumbering{gobble}
    \begin{titlepage}
        \banhyphens
        \begin{center}\theuniversity\end{center}
        \vspace{0cm plus 0.66fill minus 0cm}
        {\centering\bfseries\MakeUppercase{Выпускная квалификационная работа}\par}
        \vspace{0cm plus 0.66fill minus 0cm}
        {\centering\MakeUppercase{\thetitle}\par}
        \vspace{0cm plus 1fill minus 0cm}
        {\setlength{\tabcolsep}{3pt}\renewcommand{\arraystretch}{1.5}
         \noindent\begin{tabularx}{\textwidth}{Xl}
            & Автор: \theauthor \hfilll \signatureplace \\
            & Направление подготовки:\;
                \begin{minipage}[t]{0.4\textwidth}\begin{flushleft}\thespecialty\end{flushleft}\end{minipage} \\
            & Квалификация: #1 \\
            & Руководитель: \thesupervisorshort, \thesupervisordegree~ \hfilll \signatureplace \\
            & \textbf{К защите допустить} \\
            & Руководитель ОП \theprogramhead, \theprogramheaddegree~ \hfilll \signatureplace \\
        \end{tabularx}\par}
        \begin{flushright}\unknowndate\end{flushright}
        \vspace{0cm plus 1fill minus 0cm}
        \begin{center}\thecity, \theyear~г.\end{center}
    \end{titlepage}
    \begin{titlepage}
        \banhyphens
        \noindent Студент~\theauthorshort\;\hfilll Группа~\thestudygroup\; Факультет~\thefaculty\par\bigskip\par
        \noindent Направленность (профиль), специализация\par
        \noindent \thespecialization \par\bigskip\par
        \ifbool{hasconsultants}{
            \noindent Консультанты:
            \begin{enumerate}\thelistofconsultants\end{enumerate}\par
        }{}\bigskip\par\bigskip\par
        \noindent ВКР принята \unknowndate\par\bigskip\par
        \noindent Оригинальность ВКР \uhspace{5ex}\%\par\bigskip\par
        \noindent ВКР выполнена с оценкой \infiniteuhspace\par\bigskip\par
        \noindent Дата защиты \unknowndate\par\bigskip\par
        \noindent Секретарь ГЭК~\thesecretary\hfill\signatureplace\par\bigskip\par
        \noindent Листов хранения \infiniteuhspace\par\bigskip\par
        \noindent Демонстрационных материалов/Чертежей хранения \infiniteuhspace\par\bigskip\par
    \end{titlepage}
    \if@shouldmakespecification
    \begin{titlepage}
    \begin{center}\theuniversity\end{center}
    \begin{small}
        \noindent\begin{tabularx}{\textwidth}{Xl}
            & \hfilll \textbf{УТВЕРЖДАЮ} \hfilll\ \\
            & Руководитель ОП \\
            & \theprogramheaddegree\ \theprogramhead\ \signatureplace \\
            & \unknowndate \\
        \end{tabularx}
        \bigskip
        \begin{center}\bfseries {\normalsize ЗАДАНИЕ} \\ НА ВЫПУСКНУЮ КВАЛИФИКАЦИОННУЮ РАБОТУ\end{center}
        \bigskip
        \begingroup\banhyphens
        \noindent \textbf{Студент}~\theauthorshort\;\hfilll \textbf{Группа}~\thestudygroup\; \textbf{Факультет}~\thefaculty\;\par
        \noindent \textbf{Руководитель}~\thesupervisorshort, \thesupervisordegree, \thesupervisorwork\par
        \noindent \textbf{1 Наименование темы:} \thetitle\par
        \noindent \textbf{Направление подготовки (специальность):} \thespecialty\par
        \noindent \textbf{Направленность (профиль):} \thespecialization\par
        \noindent \textbf{Квалификация:} #1\par
        \endgroup
        \noindent \textbf{2 Срок сдачи студентом законченной работы:} \thefinishdate \par
        \noindent \textbf{3 Техническое задание и исходные данные к работе}\par \thetechnicalspec\par
        \pagebreak[3]
        \noindent \textbf{4 Содержание выпускной работы (перечень подлежащих разработке вопросов)}\par \theplannedcontents\par
        \pagebreak[3]
        \noindent \textbf{5 Перечень графического материала (с указанием обязательного материала)}\par \theplannedgraphics\par
        \pagebreak[3]
        \noindent \textbf{6 Исходные материалы и пособия}\par \theplannedsources\par
        \pagebreak[3]
        \noindent \textbf{7 Дата выдачи задания} \thestartdate\par\bigskip\par
        \noindent\begingroup\renewcommand{\arraystretch}{1.5}\begin{tabular}{ll}
            Руководитель ВКР & \signatureplace \\
            Задание принял к исполнению & \signatureplace \\
            & \thestartdate
        \end{tabular}\endgroup
    \end{small}
    \end{titlepage}
    \fi
    \if@shouldmakeannotation
    \begin{titlepage}
    \begin{center}\theuniversity\end{center}
    {\centering\bfseries АННОТАЦИЯ \par}
    \begin{small}
        {\centering\bfseries ВЫПУСКНОЙ КВАЛИФИКАЦИОННОЙ РАБОТЫ \par}
        \bigskip
        \noindent \textbf{Студент:} \theauthor\par
        \noindent \textbf{Наименование темы ВКР:} \thetitle\par
        \noindent \textbf{Наименование организации, где выполнена ВКР:} \thedegreehost\par
        \bigskip
        {\centering\bfseries ХАРАКТЕРИСТИКА ВЫПУСКНОЙ КВАЛИФИКАЦИОННОЙ РАБОТЫ \par}
        \bigskip
        \noindent 1 Цель исследования: \theresearchaim \par
        \pagebreak[3]
        \noindent 2 Задачи, решаемые в ВКР: \theresearchtargets \par
        \pagebreak[3]
        \noindent 3 Число источников, использованных при составлении обзора: \relatedworksourcecount \par
        \noindent 4 Полное число источников, использованных в работе: \total{citnum} \par
        \noindent 5 В том числе источников по годам: \par\vspace{3pt}
        \noindent\begin{tabularx}{\textwidth}{|*{6}{>{\centering\arraybackslash}X|}}\hline
            \multicolumn{3}{|c|}{\textbf{Отечественных}} & \multicolumn{3}{c|}{\textbf{Иностранных}} \\\hline
            Последние & От 5      & Более  & Последние & От 5 & Более \\
            5 лет     & до 10 лет & 10 лет & 5 лет     & до 10 лет & 10 лет \\\hline
            \russiansourcesfiveyears & \russiansourcestenyears & \russiansourcesveryold &
            \foreignsourcesfiveyears & \foreignsourcestenyears & \foreignsourcesveryold \\\hline
        \end{tabularx}\par\vspace{6pt}
        \noindent 6 Использование информационных ресурсов Internet: \internetsources \par
        \pagebreak[3]
        \noindent 7 Использование современных пакетов компьютерных программ и технологий:
        \ifbool{hasadvancedsoftware}{
            \par\vspace{3pt}
            \noindent\begin{tabularx}{\textwidth}{|X|p{0.25\textwidth}|}\hline
                \multicolumn{1}{|c|}{\textbf{Пакеты компьютерных программ и технологий}} & \multicolumn{1}{c|}{\textbf{Раздел работы}} \\\hline
                \thelistofadvancedsoftware
            \end{tabularx}\par\vspace{6pt}
        }{нет\par}
        \pagebreak[3]
        \noindent 8 Краткая характеристика полученных результатов\par\theresearchsummary\par
        \pagebreak[3]\vspace{1ex minus 1ex}
        \noindent 9 Гранты, полученные при выполнении работы\par\theresearchfunding\par
        \pagebreak[3]\vspace{1ex minus 1ex}
        \noindent 10 Наличие публикаций и выступлений на конференциях по теме работы\par\theresearchpublications\par
        \bigskip
        \noindent\begingroup\renewcommand{\arraystretch}{1.5}\begin{tabular}{lll}
        Студент & \theauthorshort & \signatureplace \\
        Руководитель & \thesupervisorshort &  \signatureplace \\
        \multicolumn{3}{l}{\unknowndate}
        \end{tabular}\endgroup
    \end{small}
    \end{titlepage}
    \fi
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

%% Обработка опций пакета

\newif\if@shouldusexelatex
\newif\if@shouldmakespecification
\newif\if@shouldmakeannotation
\newif\if@shouldsourcesbyhand

\DeclareOption{times}{\@shouldusexelatextrue}
\DeclareOption{specification}{\@shouldmakespecificationtrue}
\DeclareOption{annotation}{\@shouldmakeannotationtrue}

\ProcessOptions

\if@shouldusexelatex
    \RequirePackage{fontspec}
    \defaultfontfeatures{Ligatures={TeX},Renderer=Basic}
    \setmainfont[Ligatures={TeX,Historic}]{Times New Roman}
    \setsansfont{Arial}
    \setmonofont{Courier New}
\else
    \RequirePackage{paratype}
\fi	
