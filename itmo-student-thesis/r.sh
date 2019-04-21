#!/bin/bash

if [[ "$1" == "clean" ]]; then
    rm -f {bachelor,master}-thesis.{bib,aux,log,bbl,bcf,blg,run.xml,toc,tct,pdf,out}
else
    for i in bachelor master; do
        xelatex $i-thesis
        biber   $i-thesis
        xelatex $i-thesis
        xelatex $i-thesis
    done

    rm -f {bachelor,master}-thesis.{bib,aux,log,bbl,bcf,blg,run.xml,toc,tct,out}
fi
