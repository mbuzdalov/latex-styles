\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{itmo-student-thesis}[2015/06/04]

\LoadClass[14pt,a4paper]{extreport}

%% Russian language in UTF-8

\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[english,german,russian]{babel}
\RequirePackage{csquotes}

%% Теперь можно писать по-русски.
%% Формируем отступы

\RequirePackage[top=2cm, bottom=2cm, left=3cm, right=1.3cm]{geometry}

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

%% Делаем правильные подписи.

\RequirePackage{caption}

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

\renewcommand{\baselinestretch}{1.5}

%% Абзацный отступ по ГОСТу - пять букв. Это примерно столько.

\setlength{\parindent}{1.25cm}

%% Не используем буллеты.

\renewcommand\labelitemi{---}

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

\renewbibmacro*{//}{\nopunct\printtext{\addspace\mbox{//}\addnbspace}}
\renewcommand*{\newblockpunct}{\textemdash\addnbspace\bibsentence}
\DeclareFieldFormat*{pages}{\mkpageprefix[bookpagination][\mbox]{#1}}
\DeclareFieldFormat*{labelnumberwidth}{#1}
\DefineBibliographyStrings{english}{pages={p\adddot}}

%% Счетчики. Для всего, кроме страниц, используем totcount,
%% для страниц lastpage, так как он нормально работает с кучей флоатов.

\RequirePackage{lastpage}
\RequirePackage{totcount}
\RequirePackage{longtable}
\regtotcounter[auxfile=totals.aux]{figure}
\regtotcounter[auxfile=totals.aux]{table}
\regtotcounter[auxfile=totals.aux]{algorithm}
\newtotcounter[auxfile=totals.aux]{citnum}
\newtotcounter[auxfile=totals.aux]{appendix}
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
\renewcommand{\proof}{\textit{Доказательство}.~}

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
\captionsetup[figure]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=centering
}
\captionsetup[table]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified
}
\captionsetup[algorithm]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified
}
\captionsetup[lstlisting]{
    labelsep=endash,
    singlelinecheck=false,
    labelfont={normalsize,md},
    justification=justified
}

%% Переопределение библиографии. Может, можно и проще, но сделал так.

\defbibheading{trueHeading}{%
\chapter*{СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ}%
\addcontentsline{toc}{chapter}{СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ}}

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
{0pt}{\begin{MakeUppercase}}[\end{MakeUppercase}%
%\thispagestyle{\TheOnlyTruePageStyle}
]
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
\renewcommand{\thechapter}{\Asbuk{chapter}}
\titleformat{\chapter}[hang]{\normalsize}{
\hspace{1cm}\stepcounter{appendix}ПРИЛОЖЕНИЕ~\thechapter~}{0pt}{}
\titlecontents{chapter}
    [8.5em]
    {}
    {\contentslabel[ПРИЛОЖЕНИЕ \thecontentslabel]{8.5em}}
    {\hspace*{-8.5em}}
    {\titlerule*[0.5pc]{.}\contentspage}
}

%% Приемлемый внешний вид содержания

\contentsmargin{1.8em}
\newcommand{\chapterW}{1.2em}
\newcommand{\sectionW}{2.2em}
\newcommand{\subsectionW}{2.6em}

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

\RequirePackage[normalem]{ulem}

\newcommand{\titletabutwo}[2]{{\setlength{\tabcolsep}{0.1em}%
    \noindent\begin{tabu}to\textwidth{lX[r]}#1&#2\\\end{tabu}}}
\newcommand{\titletabufour}[4]{{\setlength{\tabcolsep}{0.1em}%
    \noindent\begin{tabu}to\textwidth{lX[6,c]lX[1,r]}#1&%
    \uline{\hfill#2\hfill~}&#3&\uline{\hfill#4\hfill~}\\\end{tabu}}}
\newcommand{\uhspace}[1]{\uline{\hspace{#1}}}
\newcommand{\signatureplace}{\uhspace{5em}}
\newcommand{\datequoteplace}{<<\uhspace{2em}>>}
\newcommand{\infiniteuhspace}{\uhspace{0 cm plus 1fill}}

%%%% БАКАЛАВРЫ

%% Вспомогательная команда для следующей

\newcommand{\makebachelortitlebottom}[9]{
        \titletabufour{Кафедра}{#1}{Группа}{#4}\\
        \vspace{0cm plus 1fill minus 0cm}
        \begin{center}
            \textbf{\MakeUppercase{\LARGE Пояснительная записка}}\\
            \textbf{\large к выпускной квалификационной работе}\\{\large #5}\\
        \end{center}
        \vspace{0cm plus 1fill minus 0cm}
        \noindent\begin{tabular}{p{8.5cm}p{4.5cm}r}
            Автор квалификационной работы & #6 & \signatureplace \\
            Научный руководитель & #7 & \signatureplace \\
            \textbf{Консультанты}: & &\\
            а) По экономике и организации производства & & \signatureplace \\
            б) По безопасности жизнедеятельности и экологии & & \signatureplace \\
            в) & & \signatureplace \\
            \vspace{0cm plus 1fill minus 0cm}
            \textbf{К защите допустить} & &\\
            Заведующий кафедрой & #2 & \signatureplace \\
            & \multicolumn{2}{l}{\datequoteplace~\signatureplace{} #8~г.}
        \end{tabular}\\
        \vspace{0cm plus 1fill}
        \begin{center}#3, #8~г.\end{center}
    \end{titlepage}
    \begin{titlepage}
        \noindent Квалификационная работа выполнена с оценкой \infiniteuhspace\\
        Дата защиты \hspace{0cm plus 1fill}\datequoteplace~\uhspace{10em} #8~г.\\
        Секретарь ГАК \infiniteuhspace\\
        Листов хранения \infiniteuhspace\\
        Чертежей хранения \infiniteuhspace\\
    \end{titlepage}
    \setcounter{page}{3}
}

%% Команда для общей генерации бакалаврской титульной страницы 
%% 1 - университет
%% 2 - факультет
%% 3 - специальность
%% 4 - квалификация (степень)
%% 5 - кафедра
%% 6 - заведующий кафедрой
%% 7 - город
%% 8 - группа
%% 9 - тема
%% 10 - автор
%% 11 - руководитель
%% 12 - год

\newcommand{\makebachelortitle}[4]{%
    \begin{titlepage}
        \begin{center}#1\end{center}
        \vspace{0cm plus 1fill minus 0cm}
        \titletabutwo{Факультет}{\uline{\hfill#2\hfill~}}\\
        \titletabutwo{Направление (специальность)}{\uline{\hfill#3\hfill~}}\\
        \titletabutwo{Квалификация (степень)}{\uline{\hfill#4\hfill~}}\\
    \makebachelortitlebottom
}

%% Короткая команда для состояния на 2015 год
%% 1 - группа
%% 2 - тема
%% 3 - автор (Фамилия И.О.)
%% 4 - руководитель (Фамилия И.О.)
%% 5 - год
\newcommand{\makebachelortitleitmo}{\makebachelortitle%
{федеральное государственное автономное образовательное учреждение
 высшего профессионального образования\\<<Санкт-Петербургский национальный
 исследовательский университет информационных технологий, механики и оптики>>}
{информационных технологий и программирования}
{Прикладная математика и информатика}
{бакалавр прикладной математики и информатики}
{компьютерных технологий}
{Васильев В.Н.}
{Санкт-Петербург}}

%%%% МАГИСТРЫ

%% Вспомогательная команда для следующей

\newcommand{\makemastertitlebottom}[9]{
        \titletabufour{Кафедра}{#1}{Группа}{#5}\\
        \vspace{0cm plus 1fill minus 0cm}
        \begin{center}
            \textbf{\MakeUppercase{\LARGE Магистерская диссертация}}\\
            \textbf{\large на тему}\\{\large #6}\\
        \end{center}
        \vspace{1cm plus 1fill minus 1cm}
        \noindent\begin{tabular}{p{9cm}p{4cm}r}
            Автор магистерской диссертации & #7 & \signatureplace \\
            Научный руководитель & #8 & \signatureplace \\
            Руководитель магистерской программы & #2 & \signatureplace \\
            \vspace{1cm plus 1fill minus 1cm}
            \textbf{К защите допустить} & &\\
            Заведующий кафедрой & #3 & \signatureplace \\
            & \multicolumn{2}{l}{\datequoteplace~\signatureplace{} #9~г.}
        \end{tabular}\\
        \vspace{2cm plus 1fill minus 2cm}
        \begin{center}#4, #9~г.\end{center}
    \end{titlepage}
    \begin{titlepage}
        \noindent Магистерская диссертация выполнена с оценкой \infiniteuhspace\\
        Дата защиты \hspace{0cm plus 1fill}\datequoteplace~\uhspace{10em} #9~г.\\
        Секретарь ГАК \infiniteuhspace\\
        Листов хранения \infiniteuhspace\\
        Чертежей хранения \infiniteuhspace\\
    \end{titlepage}
    \setcounter{page}{3}
}

%% Команда для общей генерации магистерской страницы 
%% 1 - университет
%% 2 - факультет
%% 3 - специальность
%% 4 - квалификация (степень)
%% 5 - кафедра
%% 6 - руководитель магистерской программы
%% 7 - заведующий кафедрой
%% 8 - город
%% 9 - группа
%% 10 - тема
%% 11 - автор
%% 12 - руководитель
%% 13 - год

\newcommand{\makemastertitle}[4]{%
    \begin{titlepage}
        \begin{center}#1\end{center}
        \vspace{0cm plus 1fill minus 0cm}
        \titletabutwo{Факультет}{\uline{\hfill#2\hfill~}}\\
        \titletabutwo{Направление (специальность)}{\uline{\hfill#3\hfill~}}\\
        \titletabutwo{Квалификация (степень)}{\uline{\hfill#4\hfill~}}\\
    \makemastertitlebottom
}

%% Короткая команда для состояния на 2015 год
%% 1 - группа
%% 2 - тема
%% 3 - автор (Фамилия И.О.)
%% 4 - руководитель (Фамилия И.О.)
%% 5 - год
\newcommand{\makemastertitleitmo}{\makemastertitle%
{федеральное государственное автономное образовательное учреждение
 высшего профессионального образования\\<<Санкт-Петербургский национальный
 исследовательский университет информационных технологий, механики и оптики>>}
{информационных технологий и программирования}
{Прикладная математика и информатика}
{магистр прикладной математики и информатики}
{компьютерных технологий}
{Васильев В.Н.}
{Васильев В.Н.}
{Санкт-Петербург}}

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

\DeclareOption{times}{\@shouldusetimestrue}

\ProcessOptions

%% Включаем times, если надо

\if@shouldusetimes
	\RequirePackage{pscyr}
	\def\rmdefault{ftm}
\fi	
