#!/bin/sh

sed -i 's/musicmode{[0-9]/musicmode{1/' SongSheet.tex
latexmk -pdflua SongSheet.tex
mv SongSheet.pdf SongSheetWithChords.pdf
sed -i 's/musicmode{[0-9]/musicmode{0/' SongSheet.tex
latexmk -pdflua SongSheet.tex
latexmk -c
