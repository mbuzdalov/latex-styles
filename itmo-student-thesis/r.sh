#!/bin/bash

for i in bachelor master; do
	xelatex $i-thesis
	biber   $i-thesis
	xelatex $i-thesis
	xelatex $i-thesis
done

for i in bachelor; do
    pdflatex $i-thesis-legacy
    biber    $i-thesis-legacy
    pdflatex $i-thesis-legacy
    pdflatex $i-thesis-legacy
done

rm -f {bachelor,master}-thesis{,-legacy}.{bib,aux,log,bbl,bcf,blg,run.xml,toc,tct}
