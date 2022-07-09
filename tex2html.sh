for fn in index
do
  pandoc index.tex \
    --output _build/html/$fn.html \
    --template _static/template.html5 \
    --css bootstrap.min.css \
    --css style.css \
    --toc \
    --toc-depth=3 \
    --citeproc \
    --bibliography=references.bib \
    --csl=_static/acm-siggraph.csl \
    --mathjax \
    --variable editat=$fn \
    --extract-media _build/html

done

for file in content/*.tex
do
  fn=${file%.tex}
  pandoc $file \
    --output _build/html/$fn.html \
    --template _static/template.html5 \
    --css bootstrap.min.css \
    --css style.css \
    --toc \
    --toc-depth=3 \
    --citeproc \
    --bibliography=references.bib \
    --csl=_static/acm-siggraph.csl \
    --mathjax \
    --variable rootdir="../" \
    --variable editat=$fn \
    --extract-media _build/html
done


for file in content/ads-b/*.tex
do
  fn=${file%.tex}
  pandoc $file \
    --output _build/html/$fn.html \
    --template _static/template.html5 \
    --css bootstrap.min.css \
    --css style.css \
    --toc \
    --toc-depth=3 \
    --citeproc \
    --bibliography=references.bib \
    --csl=_static/acm-siggraph.csl \
    --mathjax \
    --variable rootdir="../../" \
    --variable editat=$fn \
    --extract-media _build/html
done

for file in content/mode-s/*.tex
do
  fn=${file%.tex}
  pandoc $file \
    --output _build/html/$fn.html \
    --template _static/template.html5 \
    --css bootstrap.min.css \
    --css style.css \
    --toc \
    --toc-depth=3 \
    --citeproc \
    --bibliography=references.bib \
    --csl=_static/acm-siggraph.csl \
    --mathjax \
    --variable rootdir="../../" \
    --variable editat=$fn \
    --extract-media _build/html
done


for file in misc/*.tex
do
  fn=${file%.tex}
  pandoc $file \
    --output _build/html/$fn.html \
    --template _static/template.html5 \
    --css bootstrap.min.css \
    --css style.css \
    --toc \
    --toc-depth=3 \
    --citeproc \
    --bibliography=references.bib \
    --csl=_static/acm-siggraph.csl \
    --mathjax \
    --variable rootdir="../" \
    --variable editat=$fn
done

find _build/html/content/ -name '*.html' -exec sed -i 's/embed\(.*\)pdf/img\1png/g' {} \;

find _build/html/content/ads-b/ -maxdepth 1 -name '*.html' -exec sed -i 's/_build\/html/\.\.\/\.\./g' {} \;
find _build/html/content/mode-s/ -maxdepth 1 -name '*.html' -exec sed -i 's/_build\/html/\.\.\/\.\./g' {} \;
find _build/html/content/ -maxdepth 1 -name '*.html' -exec sed -i 's/_build\/html/\.\./g' {} \;
find _build/html/ -maxdepth 1 -name '*.html' -exec sed -i 's/_build\/html\///g' {} \;

sed -i 's/embed\(.*\)pdf/img\1png/g' _build/html/index.html;
sed -i 's/<img/<img class="cover" /g' _build/html/index.html;


cd _build/html/
# for pdf_file in *.pdf ; do
#   echo "converting ${pdf_file}"
#   convert -density 100 "${pdf_file}" -colorspace RGB "${pdf_file%.*}".png
#   rm ${pdf_file}
# done

find cover figures -type f -name '*.pdf' -print0 |
  while IFS= read -r -d '' pdf_file; do 
    convert -density 100 "${pdf_file}" -colorspace RGB "${pdf_file%.*}".png
    rm ${pdf_file}
  done