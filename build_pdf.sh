mkdir -p _build/chapters

latexmk -outdir=_build -pdf main.tex
if [ $? -eq 0 ]; then
    mkdir -p _deploy
    cp _build/main.pdf _deploy/main.pdf
fi

