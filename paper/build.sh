#!/bin/bash
# Build main.pdf (pdflatex -> bibtex -> pdflatex x2). Usage: bash build.sh
cd "$(dirname "$0")"
pdflatex -interaction=nonstopmode main.tex > /dev/null
bibtex main > /dev/null
pdflatex -interaction=nonstopmode main.tex > /dev/null
pdflatex -interaction=nonstopmode main.tex > /dev/null
grep -E '^!|Undefined|undefined|Overfull \\hbox \(([2-9][0-9]|[1-9][0-9][0-9])' main.log | head -20
grep -c Warning main.blg 2>/dev/null | sed 's/^/bibtex warnings: /'
pdfinfo main.pdf | grep Pages
