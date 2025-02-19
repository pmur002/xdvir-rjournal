---
output: pdf_document
fontsize: 12pt
---

\thispagestyle{empty}
\today

Editor   
The R Journal  
\bigskip

Dear Professor Hurley,
\bigskip

Please consider the article titled "Rendering LaTeX in R" for publication in the
R Journal.

The manuscript introduces a new package called `xdvir` which allows users to
render LaTeX fragments in R plots, including labels and data symbols for
`ggplot2` plots.  The article covers basic usage of the `xdvir` package, but
because there is a range of scenarios in which the package can be used,
the article also goes into some
lower-level detail, plus several extended examples.

I believe the readers of the R Journal will find this article helpful for their
work because it provides access to the sophisticated typesetting capabilities of
LaTeX, for example the
ability to render high-quality mathematical equations,
when drawing text labels and annotations on R plots.

I have successfully built the article on Linux (Ubuntu), 
Windows, and Mac OS.
There is one remaining ERROR, one remaining WARNING, and one remaining NOTE
from `rjtools::initial_check_article()`:

* Some section titles are not in sentence case because they contain proper nouns
  (e.g., "R").  

* The `anzj2025` citation has no link because it is "in press".

* There are "spelling errors" because there are several software
  and symbol names that are not English words.

The only requirement for building the article 
(beyond a TeX installation) is that 
the fonts TeX Gyre Adventor 
[(https://www.gust.org.pl/projects/e-foundry/tex-gyre/adventor)](https://www.gust.org.pl/projects/e-foundry/tex-gyre/adventor)
and Lato Light 
[(https://fonts.google.com/specimen/Lato)](https://fonts.google.com/specimen/Lato)
must be installed:

* On Linux, there should be just a package, e.g., `tex-gyre` and `fonts-lato`
  on Ubuntu.  

* On Windows, the fonts can be downloaded from 
  [https://online-fonts.com/fonts/tex-gyre-adventor](https://online-fonts.com/fonts/tex-gyre-adventor) and
  [https://fonts.google.com/specimen/Lato](https://fonts.google.com/specimen/Lato)
  and then double-click your heart out 
  until you see an "install" button and click that.
  Be sure to install all fonts, e.g., the bold and italic variants, as well
  as the "regular" font.
  Also make sure that MikTeX knows about the new fonts by refreshing its
  font map (under the Tools menu in the MikTeX Console).

* On Mac OS, download the fonts and install as for Windows.

For a smooth build, please ensure that the following R packages are installed:
`ggplot2`, `gridGraphics`, `gggrid`, `gridBezier`, `ggtext`, `signs`, plus of
course `xdvir` itself and its dependencies.  The TikZ examples may also
require a full TeX install (e.g., TeX Live, MikTeX, or MacTeX)
rather than just TinyTeX.

As recommended in the `rjtools` documentation, the best recipe for 
building is:

```
pandoc::pandoc_activate(version = '3.1.6')
rmarkdown::render("murrell-xdvir.Rmd", output_format = "all")
```


\bigskip
\bigskip

Regards,
    
\includegraphics{/home/pmur002/fosFiles/Admin/digitalSig.png}
    
Paul Murrell  
Department of Statistics  
The University of Auckland  
Auckland, New Zealand  
paul@stat.auckland.ac.nz    

\bigskip

