\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{itmo-student-thesis}[2017/06/06 v1.1.2.b3]

\LoadClass[14pt,a4paper]{extreport}

%% Russian language in UTF-8

\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[english,german,russian]{babel}
\RequirePackage{csquotes}

%% Теперь можно писать по-русски.
%% Формируем отступы

\RequirePackage[top=2cm, bottom=2cm, left=2.7cm, right=1.2cm]{geometry}

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

%% Титульная страница делается гораздо легче, если так

\RequirePackage{tabu}

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

\addto{\captionsrussian}{\renewcommand*{\figurename}{Рисунок}}

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
    sorting=none,
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


%% Счетчики. Для всего, кроме страниц, используем totcount,
%% для страниц lastpage, так как он нормально работает с кучей флоатов.

\RequirePackage{lastpage}
\RequirePackage{totcount}
\RequirePackage{longtable}
\regtotcounter[auxfile=\jobname.tct]{figure}
\regtotcounter[auxfile=\jobname.tct]{table}
\regtotcounter[auxfile=\jobname.tct]{algorithm}
\newtotcounter[auxfile=\jobname.tct]{citnum}
\newtotcounter[auxfile=\jobname.tct]{appendix}
\AtEveryBibitem{\stepcounter{citnum}}
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
\renewcommand{\proof}[1][]{\textit{Доказательство%
\ifthenelse{\equal{#1}{}}{}{ (#1)}%
}.~}

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

\newcommand{\printmainbibliography}{\printbibliography[heading=trueHeading]}
\newcommand{\printannobibliography}{\renewcommand*{\bibfont}{\small}\printbibliography[heading=none]}

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

%% Обратная совместимость со стилем, который у всех есть.

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
\newcommand{\signatureplace}{\uhspace{8em}}
\newcommand{\datequoteplace}{<<\uhspace{3ex}>>}
\newcommand{\infiniteuhspace}{\uhspace{0 cm plus 1fill}}
\newcommand{\unknowndate}{\datequoteplace~\uhspace{10ex}~20\uhspace{3ex}~г.}

%% Контентные команды со значениями по умолчанию

\newcommand{\theuniversity}{{\bfseries Министерство образования и науки Российской Федерации\par
{\scriptsize\MakeUppercase{федеральное государственное автономное образовательное учреждение высшего образования}\par}
\MakeUppercase{<<Санкт-Петербургский национальный исследовательский университет информационных технологий, механики и оптики>>}}}
\newcommand{\university}[1]{\renewcommand{\theuniversity}{#1}}

\newcommand{\thedegreehost}{Университет ИТМО}
\newcommand{\degreehost}[1]{\renewcommand{\thedegreehost}{#1}}

\newcommand{\thefaculty}{информационных технологий и программирования}
\newcommand{\faculty}[1]{\renewcommand{\thefaculty}{#1}}

\newcommand{\specialty}[1]{\newcommand{\thespecialty}{#1}}

\newcommand{\specialization}[1]{\newcommand{\thespecialization}{#1}}

\newcommand{\thechair}{компьютерных технологий}
\newcommand{\chair}[1]{\renewcommand{\thechair}{#1}}

\newcommand{\thechairhead}{Васильев В.Н.}
\newcommand{\thechairheaddegree}{докт. техн. наук, проф.}
\newcommand{\chairhead}[2]{\renewcommand{\thechairhead}{#1}
                           \renewcommand{\thechairheaddegree}{#2}}

\newcommand{\thedegreetail}{прикладной математики и информатики}
\newcommand{\degreetail}[1]{\renewcommand{\thedegreetail}{#1}}

\newcommand{\thecity}{Санкт-Петербург}
\newcommand{\city}[1]{\renewcommand{\thecity}{#1}}

%%% Перечень графического материала
\newcommand{\theplannedgraphics}{Не предусмотрено}
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
\newcommand{\secretary}[1]{\newcommand{\thesecretary}{\textit{#1}}}

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
%%% Использование современных пакетов
\newcommand{\advancedtechnologyusage}[1]{\newcommand{\theadvancedtechnologyusage}{#1}}
%%% Краткая характеристика полученных результатов
\newcommand{\researchsummary}[1]{\newcommand{\theresearchsummary}{#1}}
%%% Гранты, полученные при выполнении работы
\newcommand{\researchfunding}[1]{\newcommand{\theresearchfunding}{#1}}
%%% Наличие публикаций и выступлений на конференциях
\newcommand{\researchpublications}[1]{\newcommand{\theresearchpublications}{#1}}

%% Контентные команды пополнения списков

\newbool{hasconsultants}
\newcommand{\thelistofconsultants}{}
\newcommand{\thelistofstages}{}
\newcounter{numofstages}

%%% Добавить консультанта: (Фамилия И.О.) (степень, звание)
\newcommand{\addconsultant}[2]{
\booltrue{hasconsultants}
\appto{\thelistofconsultants}{\item #1, #2 \hfill\signatureplace\par\bigskip}
}

%%% Добавить этап в календарный план: (Название этапа) (Срок выполнения)
\newcommand{\addstage}[2]{\appto{\thelistofstages}{\stepcounter{numofstages}\arabic{numofstages} & #1\strut & #2 & \\\hline\par}}

%% Создание титульной страницы, задания и аннотации

%%% Параметр: бакалавр/магистр/инженер/...
\renewcommand{\maketitle}[1]{
    \ifstrequal{#1}{Магистр}{
        \newcommand{\worktypeGenitive}{магистерской диссертации}
        \newcommand{\worktypeDative}{магистерской диссертации}
        \newcommand{\worktypeAccusative}{магистерскую диссертацию}
        \newcommand{\worktypeTitle}{\MakeUppercase{Пояснительная записка}\parК {\worktypeDative}}
        \providecommand{\thespecialization}{Технологии проектирования и разработки программного обеспечения}
        \providecommand{\thespecialty}{01.04.02~Прикладная математика и информатика}
    }{
        \ifstrequal{#1}{Бакалавр}{
            \newcommand{\worktypeGenitive}{выпускной квалификационной работы}
            \newcommand{\worktypeDative}{выпускной квалификационной работе}
            \newcommand{\worktypeAccusative}{выпускную квалификационную работу}
            \newcommand{\worktypeTitle}{\MakeUppercase{Пояснительная записка}\parК {\worktypeDative}}
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
        {\centering\bfseries\worktypeTitle\par}
        \vspace{0cm plus 1fill minus 0cm}
        {\centering\bfseries <<\thetitle>>\par}
        \vspace{0cm plus 1fill minus 0cm}
        {\setlength{\tabcolsep}{0.1em}
         \noindent\small\begin{tabu}to\textwidth{X[p]l}
            & Автор: \theauthor \hfilll \signatureplace \\
            & Направление подготовки (специальность):\; 
                \begin{minipage}[t]{0.4\textwidth}\thespecialty\end{minipage} \\
            & Квалификация: #1 \\
            & Руководитель: \thesupervisorshort, \thesupervisordegree \hfilll \signatureplace \\
            & \\
            & \\
            & \textbf{К защите допустить} \\
            & Зав. кафедрой \thechairhead, \thechairheaddegree \hfilll \signatureplace \\
        \end{tabu}\par}
        \begin{flushright}\small\unknowndate\end{flushright}
        \vspace{0cm plus 1fill minus 0cm}
        \begin{center}\thecity, \theyear~г.\end{center}
    \end{titlepage}
    \begin{titlepage}
        \banhyphens
        \noindent\small \textbf{Студент}~\theauthorshort\; \textbf{Группа}~\thestudygroup\; \textbf{Кафедра}~\thechair\; \textbf{Факультет}~\thefaculty\par\bigskip\par
        \noindent\small \textbf{Направленность (профиль), специализация} \thespecialization \par\bigskip\par
        \ifbool{hasconsultants}{
            \noindent\small \textbf{Консультанты}:
            \begin{enumerate}\thelistofconsultants\end{enumerate}\par
        }{}\bigskip\par\bigskip\par
        \noindent\small Квалификационная работа выполнена с оценкой \infiniteuhspace\par\bigskip\par
        \noindent\small Дата защиты \hspace{0cm plus 1fill}\thedefencedate\par\bigskip\par
        \noindent\small Секретарь ГЭК~\thesecretary \hspace{0cm plus 1fill} Принято: \unknowndate\par\bigskip\par
        \noindent\small Листов хранения \infiniteuhspace\par\bigskip\par
        \noindent\small Демонстрационных материалов/Чертежей хранения \infiniteuhspace\par\bigskip\par
    \end{titlepage}
    \if@shouldmakespecification
    \begin{titlepage}
    \begin{center}\theuniversity\end{center}
    \begin{small}
        \noindent\begin{tabu}to\textwidth{X[p]r}
            & \hfilll \textbf{УТВЕРЖДАЮ} \hfilll\ \\
            & Зав.~каф. \thechair \\
            & \thechairheaddegree \\
            & \signatureplace\ \thechairhead \\
            & \unknowndate \\
        \end{tabu}
        \begin{center}\bfseries {\normalsize ЗАДАНИЕ} \\ НА \MakeUppercase{\worktypeAccusative}\end{center}
        \bigskip
        \begingroup\banhyphens
        \noindent \textbf{Студент}~\theauthorshort\; \textbf{Группа}~\thestudygroup\; \textbf{Кафедра}~\thechair\; \textbf{Факультет}~\thefaculty\;
        \textbf{Руководитель}~\thesupervisor, \thesupervisordegree, \thesupervisorwork\par
        \noindent \textbf{1 Наименование темы:} \thetitle\par
        \noindent \textbf{Направление подготовки (специальность):} \thespecialty\par
        \noindent \textbf{Направленность (профиль):} \thespecialization\par
        \noindent \textbf{Квалификация:} #1\par\bigskip\par
        \endgroup
        \noindent \textbf{2 Срок сдачи студентом законченной работы:} \thefinishdate \par
        \noindent \textbf{3 Техническое задание и исходные данные к работе.}\par \thetechnicalspec\par
        \pagebreak[3]
        \noindent \textbf{4 Содержание \worktypeGenitive\ (перечень подлежащих разработке вопросов)}\par \theplannedcontents\par
        \pagebreak[3]
        \noindent \textbf{5 Перечень графического материала (с указанием обязательного материала)}\par \theplannedgraphics\par
        \pagebreak[3]
        \noindent \textbf{6 Исходные материалы и пособия}\par \theplannedsources\par
        \pagebreak[3]
        \begin{center}
            \textbf{7 Календарный план}
            \begin{tabu}to\textwidth{|l|X[3.5p]|X[p]|X[p]|}\hline
            №№ пп. & Наименование этапов \worktypeGenitive & Срок выполнения этапов работы & Отметка о выполнении, 
            подпись руков.\strut \\\hline
            \thelistofstages
            \end{tabu}
        \end{center}
        \noindent \textbf{8 Дата выдачи задания:} \thestartdate\par\bigskip\par
        \noindent Руководитель \signatureplace\par\bigskip\par
        \noindent Задание принял к исполнению \signatureplace\ \thestartdate\par
    \end{small}
    \end{titlepage}
    \fi
    \if@shouldmakeannotation
    \begin{titlepage}
    \begin{center}\theuniversity\end{center}
    {\centering\bfseries АННОТАЦИЯ \par}
    \begin{small}
        {\centering\bfseries \MakeUppercase{\worktypeGenitive} \par}
        \bigskip
        \noindent \textbf{Студент:} \theauthor\par
        \noindent \textbf{Наименование темы работы:} \thetitle\par
        \noindent \textbf{Наименование организации, где выполнена работа:} \thedegreehost\par
        \bigskip
        {\centering\bfseries ХАРАКТЕРИСТИКА \MakeUppercase{\worktypeGenitive} \par}
        \bigskip
        \noindent \textbf{1 Цель исследования:} \theresearchaim \par
        \pagebreak[3]
        \noindent \textbf{2 Задачи, решаемые в работе:} \theresearchtargets \par
        \pagebreak[3]
        \noindent \textbf{3 Число источников, использованных при составлении обзора:} \uhspace{4em} \par
        \noindent \textbf{4 Полное число источников, использованных в работе:} \total{citnum} \par
        \noindent \textbf{5 В том числе источников по годам} \par
        \begin{tabular}{|c|c|c|c|c|c|}\hline
            \multicolumn{3}{|c|}{Отечественных} & \multicolumn{3}{c|}{Иностранных} \\\hline
            Последние & От 5      & Более  & Последние & От 5 & Более \\
            5 лет     & до 10 лет & 10 лет & 5 лет     & до 10 лет & 10 лет \\\hline
            ~ & ~ & ~ & ~ & ~ & ~ \\\hline
        \end{tabular}\par
        \noindent \textbf{6 Использование информационных ресурсов Internet:} \uhspace{4em} \par
        \pagebreak[3]
        \noindent \textbf{7 Использование современных пакетов компьютерных программ и технологий:}
            \theadvancedtechnologyusage\par
        \pagebreak[3]
        \noindent \textbf{8 Краткая характеристика полученных результатов:}
            \theresearchsummary\par        
        \pagebreak[3]
        \noindent \textbf{9 Гранты, полученные при выполнении работы:}
            \theresearchfunding\par
        \pagebreak[3]
        \noindent \textbf{10 Наличие публикаций и выступлений на конференциях по теме работы:}
            \theresearchpublications\par
        \bigskip
        \noindent Выпусник: \theauthorshort\ \signatureplace\par\bigskip\par
        \noindent Руководитель: \thesupervisorshort\ \signatureplace\par\bigskip\par
        \noindent \unknowndate\par
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
    \setcounter{citnum}{0} %to get rid of my own publications counted twice
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

\newif\if@shouldusetimes
\newif\if@shouldmakespecification
\newif\if@shouldmakeannotation

\DeclareOption{times}{\@shouldusetimestrue}
\DeclareOption{specification}{\@shouldmakespecificationtrue}
\DeclareOption{annotation}{\@shouldmakeannotationtrue}

\ProcessOptions

%% Включаем times, если надо

\if@shouldusetimes
	\RequirePackage{pscyr}
	\def\rmdefault{ftm}
\else
    \RequirePackage{paratype}
\fi	

