#!/bin/sh

# Increment version number
ver=$(grep -Po [0-9]\.[0-9]\.[0-9][0-9] Head.tex | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}')
sed -i "s/ssver{[0-9]\.[0-9]\.[0-9][0-9]/ssver{$ver/" Head.tex

# Build
cat Head.tex Songs/*.tex Psalms/* Foot.tex > SongSheet.tex

# Compile
sed -i 's/musicmode{[0-9]/musicmode{1/' SongSheet.tex
latexmk -pdflua SongSheet.tex
mv SongSheet.pdf SongSheetWithChords.pdf
sed -i 's/musicmode{[0-9]/musicmode{0/' SongSheet.tex
latexmk -pdflua SongSheet.tex
latexmk -c

# Copy to website
cp *.pdf /home/bodleum/archive/web/website/songsheetpdfs
pushd /home/bodleum/archive/web
./upload
