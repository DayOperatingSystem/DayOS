#!/bin/sh
cd chapters/uml

rm -f *.aux
plantuml *.puml -tlatex

## Strip out garbage
sed -i -e '/document/d' -e '/usepackage/d' *.latex
cd ../../
