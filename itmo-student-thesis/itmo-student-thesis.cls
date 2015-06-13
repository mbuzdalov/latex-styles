\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{itmo-student-thesis}[2015/06/13 v1.0.4]

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
\RequirePackage{setspace}
\onehalfspace

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
{0pt}{\begin{MakeUppercase}}[\end{MakeUppercase}]
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
\titleformat{\chapter}[block]{\normalsize\bfseries\center\stepcounter{appendix}}%
{ПРИЛОЖЕНИЕ~\thechapter.~}{0pt}{\begin{MakeUppercase}}[\end{MakeUppercase}]
\titlecontents{chapter}
    [8.5em]
    {}
    {\contentslabel[ПРИЛОЖЕНИЕ \thecontentslabel.]{8.5em}}
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

\RequirePackage[normalem]{ulem}

\newcommand{\titletabutwo}[2]{{\setlength{\tabcolsep}{0.1em}%
    \noindent\begin{tabu}to\textwidth{lX[p]}#1&#2\\\end{tabu}}}
\newcommand{\titletabutwow}[2]{{\setlength{\tabcolsep}{0.1em}%
    \noindent\begin{tabu}to\textwidth{lcX[p]}#1&~&#2\\\end{tabu}}}
\newcommand{\titletabufour}[4]{{\setlength{\tabcolsep}{0.1em}%
    \noindent\begin{tabu}to\textwidth{lX[6,c]lX[1,r]}#1&%
    \uline{\hfill#2\hfill~}&#3&\uline{\hfill#4\hfill~}\\\end{tabu}}}
\newcommand{\uhspace}[1]{\uline{\hspace{#1}}}
\newcommand{\signatureplace}{\uhspace{5em}}
\newcommand{\datequoteplace}{<<\uhspace{2em}>>}
\newcommand{\infiniteuhspace}{\uhspace{0 cm plus 1fill}}

%% Команды со значениями по умолчанию

\newcommand{\theuniversity}{федеральное государственное автономное образовательное учреждение высшего образования <<Санкт-Петербургский национальный исследовательский университет информационных технологий, механики и оптики>>}
\newcommand{\university}[1]{\renewcommand{\theuniversity}{#1}}

\newcommand{\thefaculty}{информационных технологий и программирования}
\newcommand{\faculty}[1]{\renewcommand{\thefaculty}{#1}}

\newcommand{\thespecialty}{Прикладная математика и информатика}
\newcommand{\specialty}[1]{\renewcommand{\thespecialty}{#1}}

\newcommand{\thechair}{компьютерных технологий}
\newcommand{\chair}[1]{\renewcommand{\thechair}{#1}}

\newcommand{\thechairhead}{Васильев В.Н.}
\newcommand{\chairhead}[1]{\renewcommand{\thechairhead}{#1}}

\newcommand{\themasterhead}{Васильев В.Н.}
\newcommand{\masterhead}[1]{\renewcommand{\themasterhead}{#1}}

\newcommand{\thedegreetail}{прикладной математики и информатики}
\newcommand{\degreetail}[1]{\renewcommand{\thedegreetail}{#1}}

\newcommand{\thecity}{Санкт-Петербург}
\newcommand{\city}[1]{\renewcommand{\thecity}{#1}}

\newcommand{\theconsultantwithdegree}{}
\newcommand{\consultantwithdegree}[1]{\renewcommand{\theconsultantwithdegree}{#1}}

%% Команды без значений по умолчанию

\newcommand{\studygroup}[1]{\newcommand{\thestudygroup}{#1}}
\renewcommand{\title}[1]{\newcommand{\thetitle}{#1}}
\renewcommand{\author}[1]{\renewcommand{\theauthor}{#1}}
\newcommand{\supervisor}[1]{\newcommand{\thesupervisor}{#1}}
\newcommand{\supervisordegree}[1]{\newcommand{\thesupervisordegree}{#1}}
\newcommand{\publishyear}[1]{\newcommand{\theyear}{#1}}

%% Команды для аннотации

\newcommand{\researchdirections}[1]{\newcommand{\theresearchdirections}{#1}}
\newcommand{\researchpart}[1]{\newcommand{\theresearchpart}{#1}}
\newcommand{\economicpart}[1]{\newcommand{\theeconomicpart}{#1}}
\newcommand{\ecologypart}[1]{\newcommand{\theecologypart}{#1}}
\newcommand{\novelty}[1]{\newcommand{\thenovelty}{#1}}
\newcommand{\cwpublications}[1]{\newcommand{\thecwpublications}{#1}}
\newcommand{\practicalimplications}[1]{\newcommand{\thepracticalimplications}{#1}}

%% Создание титульной страницы и аннотации для бакалавров

\newcommand{\makebachelortitle}{
	\pagenumbering{gobble}
    \begin{titlepage}
        \begin{center}\theuniversity\end{center}
        \vspace{0cm plus 1fill minus 0cm}
        \titletabutwo{Факультет}{\uline{\hfill\thefaculty\hfill~}}\\
        \titletabutwo{Направление (специальность)}{\uline{\hfill\thespecialty\hfill~}}\\
        \titletabutwo{Квалификация (степень)}{\uline{\hfillБакалавр \thedegreetail\hfill~}}\\
        \titletabufour{Кафедра}{\thechair}{Группа}{\thestudygroup}\\
        \vspace{0cm plus 1fill minus 0cm}
        \begin{center}
            \textbf{\MakeUppercase{\LARGE Пояснительная записка}}\\
            \textbf{\large к выпускной квалификационной работе}\\{\large \thetitle}\\
        \end{center}
        \vspace{0cm plus 1fill minus 0cm}
        \noindent\begin{tabular}{p{8.5cm}p{4.5cm}r}
            Автор квалификационной работы & \theauthor & \signatureplace \\
            Научный руководитель & \thesupervisor & \signatureplace \\
            \textbf{Консультанты}: & &\\
            а) По экономике и организации производства & & \signatureplace \\
            б) По безопасности жизнедеятельности и экологии & & \signatureplace \\
            в) & & \signatureplace \\
            \vspace{0cm plus 1fill minus 0cm}
            \textbf{К защите допустить} & &\\
            Заведующий кафедрой & \thechairhead & \signatureplace \\
            & \multicolumn{2}{l}{\datequoteplace~\signatureplace{} \theyear~г.}
        \end{tabular}\\
        \vspace{0cm plus 1fill}
        \begin{center}\thecity, \theyear~г.\end{center}
    \end{titlepage}
    \begin{titlepage}
        \noindent Квалификационная работа выполнена с оценкой \infiniteuhspace\\
        Дата защиты \hspace{0cm plus 1fill}\datequoteplace~\uhspace{10em} \theyear~г.\\
        Секретарь ГАК \infiniteuhspace\\
        Листов хранения \infiniteuhspace\\
        Чертежей хранения \infiniteuhspace\\
    \end{titlepage}
    \if@shouldmakeannotation
    \begin{titlepage}\begin{small}
        \begin{center}\theuniversity\end{center}
        \begin{center}\textbf{АННОТАЦИЯ}\\\textbf{ПО ВЫПУСКНОЙ КВАЛИФИКАЦИОННОЙ РАБОТЕ}\end{center}
        \titletabutwo{Студент}{\uline{\hfill\theauthor\hfill~}}\\
        \titletabutwo{Факультет}{\uline{\hfill\thefaculty\hfill~}}\\
        \titletabufour{Кафедра}{\thechair}{Группа}{\thestudygroup}\\
        \titletabutwo{Направление (специальность)}{\uline{\hfill\thespecialty\hfill~}}\\
        \titletabutwo{Квалификация (степень)}{\uline{\hfillБакалавр \thedegreetail\hfill~}}\\
		\titletabutwow{Наименование темы}{\thetitle}\\
		\titletabutwo{Руководитель}{\uline{\hfill\thesupervisor, \thesupervisordegree\hfill~}}\\
		\titletabutwo{Консультант}{\uline{\hfill\theconsultantwithdegree\hfill~}}\\
		\begin{center}
			\MakeUppercase{\textbf{Краткое содержание выпускной квалификационной работы и основные выводы}}
		\end{center}
		\noindent\textbf{объем} \uline{\hfill\pageref{LastPage}\hfill~} стр.,
			\textbf{графический материал} \uline{\hfill--\hfill~} стр.,
			\textbf{библиография} \uline{\hfill\total{citnum}\hfill~} наим.

		\noindent\textbf{Направление и задача исследований}
		
		\theresearchdirections
		
		\noindent\textbf{Проектная или исследовательская часть (с указанием основных методов исследований, 
		расчетов и результатов)}
		
		\theresearchpart
		
		\noindent\textbf{Экономическая часть (какие использованы методики, экономическая эффективность 
		результатов)}
		
		\theeconomicpart
		
		\noindent\textbf{Характеристика вопросов экологии, техники безопасности и др.}
		
		\theecologypart

		\@ifundefined{thenovelty}{}{%
			\noindent\textbf{Новизна полученных результатов}
		
			\thenovelty}
		
		\noindent\textbf{Является ли работа продолжением курсовых проектов (работ), есть ли публикации}
		
		\thecwpublications
		
		\noindent\textbf{Практическая ценность работы. Рекомендации по внедрению}
		
		\thepracticalimplications
		
		~
				
		{\setlength{\tabcolsep}{0pt}
		\begin{tabular}{p{5cm}r}
		Выпускник & \signatureplace\\
		Научный руководитель & \signatureplace\\
		\end{tabular}}
		
		~
		
		\datequoteplace~\uhspace{10em} \theyear~г.
    \end{small}\end{titlepage}
    \fi
    \pagenumbering{arabic}
    \setcounter{page}{\firstcontentspage}
}

%% Создание титульной страницы и аннотации для магистров

\newcommand{\makemastertitle}{
	\pagenumbering{gobble}
    \begin{titlepage}
        \begin{center}\theuniversity\end{center}
        \vspace{0cm plus 1fill minus 0cm}
        \titletabutwo{Факультет}{\uline{\hfill\thefaculty\hfill~}}\\
        \titletabutwo{Направление (специальность)}{\uline{\hfill\thespecialty\hfill~}}\\
        \titletabutwo{Квалификация (степень)}{\uline{\hfillМагистр \thedegreetail\hfill~}}\\
        \titletabufour{Кафедра}{\thechair}{Группа}{\thestudygroup}\\
        \vspace{0cm plus 1fill minus 0cm}
        \begin{center}
            \textbf{\MakeUppercase{\LARGE Магистерская диссертация}}\\
            \textbf{\large на тему}\\{\large \thetitle}\\
        \end{center}
        \vspace{1cm plus 1fill minus 1cm}
        \noindent\begin{tabular}{p{9cm}p{4cm}r}
            Автор магистерской диссертации & \theauthor & \signatureplace \\
            Научный руководитель & \thesupervisor & \signatureplace \\
            Руководитель магистерской программы & \themasterhead & \signatureplace \\
            \vspace{1cm plus 1fill minus 1cm}
            \textbf{К защите допустить} & &\\
            Заведующий кафедрой & \thechairhead & \signatureplace \\
            & \multicolumn{2}{l}{\datequoteplace~\signatureplace{} \theyear~г.}
        \end{tabular}\\
        \vspace{2cm plus 1fill minus 2cm}
        \begin{center}\thecity, \theyear~г.\end{center}
    \end{titlepage}
    \begin{titlepage}
        \noindent Магистерская диссертация выполнена с оценкой \infiniteuhspace\\
        Дата защиты \hspace{0cm plus 1fill}\datequoteplace~\uhspace{10em} \theyear~г.\\
        Секретарь ГАК \infiniteuhspace\\
        Листов хранения \infiniteuhspace\\
        Чертежей хранения \infiniteuhspace\\
    \end{titlepage}
    \if@shouldmakeannotation
    \begin{titlepage}\begin{small}
        \begin{center}\theuniversity\end{center}
        \begin{center}\textbf{АННОТАЦИЯ}\\\textbf{ПО МАГИСТЕРСКОЙ ДИССЕРТАЦИИ}\end{center}
        \titletabutwo{Студент}{\uline{\hfill\theauthor\hfill~}}\\
        \titletabutwo{Факультет}{\uline{\hfill\thefaculty\hfill~}}\\
        \titletabufour{Кафедра}{\thechair}{Группа}{\thestudygroup}\\
        \titletabutwo{Направление подготовки}{\uline{\hfill\thespecialty\hfill~}}\\
        \titletabutwo{Квалификация (степень)}{\uline{\hfillМагистр \thedegreetail\hfill~}}\\
		\titletabutwo{Специальное звание}{\uline{~\hfill~}}\\
		\titletabutwow{Наименование темы}{\thetitle}\\
		\titletabutwo{Научный руководитель}{\uline{\hfill\thesupervisor, \thesupervisordegree\hfill~}}\\
		\titletabutwo{Консультант}{\uline{\hfill\theconsultantwithdegree\hfill~}}\\
		\begin{center}
			\MakeUppercase{\textbf{Краткое содержание магистерской диссертации и основные выводы}}
		\end{center}
		\noindent\textbf{объем} \uline{\hfill\pageref{LastPage}\hfill~} стр.,
			\textbf{графический материал} \uline{\hfill--\hfill~} стр.,
			\textbf{библиография} \uline{\hfill\total{citnum}\hfill~} наим.

		\noindent\textbf{Направление и задача исследований}
		
		\theresearchdirections
		
		\noindent\textbf{Проектная или исследовательская часть (с указанием основных методов исследований, 
		расчетов и результатов)}
		
		\theresearchpart
		
		\noindent\textbf{Экономическая часть (какие использованы методики, экономическая эффективность 
		результатов)}
		
		\theeconomicpart
		
		\noindent\textbf{Новизна полученных результатов}
		
		\thenovelty
		
		\noindent\textbf{Является ли работа продолжением курсовых проектов (работ), есть ли публикации}
		
		\thecwpublications
		
		\noindent\textbf{Практическая ценность работы. Рекомендации по внедрению}
		
		\thepracticalimplications
		
		~
				
		{\setlength{\tabcolsep}{0pt}
		\begin{tabular}{p{5cm}r}
		Выпускник & \signatureplace\\
		Научный руководитель & \signatureplace\\
		\end{tabular}}
		
		~
		
		\datequoteplace~\uhspace{10em} \theyear~г.
    \end{small}\end{titlepage}
	\fi
    \pagenumbering{arabic}
    \setcounter{page}{\firstcontentspage}
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
\newif\if@shouldmakeannotation
\newif\if@contentspagefour

\DeclareOption{times}{\@shouldusetimestrue}
\DeclareOption{annotation}{\@shouldmakeannotationtrue}
\DeclareOption{page4}{\@contentspagefourtrue}

\ProcessOptions

%% Включаем times, если надо

\if@shouldusetimes
	\RequirePackage{pscyr}
	\def\rmdefault{ftm}
\fi	

%% Про четвертую страницу

\newcommand{\firstcontentspage}{3}
\if@contentspagefour
    \renewcommand{\firstcontentspage}{4}
\fi
