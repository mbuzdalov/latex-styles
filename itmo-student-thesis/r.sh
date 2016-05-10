#!/bin/bash

for i in bachelor master; do
	pdflatex $i-thesis
	biber 	 $i-thesis
	pdflatex $i-thesis
	pdflatex $i-thesis
    diffpdf reference/$i-thesis.pdf $i-thesis.pdf
done

rm {bachelor,master}-thesis.{bib,aux,log,bbl,bcf,blg,run.xml,toc,tct}
