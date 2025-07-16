
all: 
	Rscript -e 'pandoc::pandoc_activate(version = "3.1.6");	rmarkdown::render("murrell-xdvir.Rmd", output_format = "all")'
	rm *.log
	Rscript -e 'rjtools::initial_check_article(".", pkg="xdvir")'
	rm initial_checks.log

.PHONY: submission
submission:
	zip -r submission/murrell-xdvir.zip \
	murrell-xdvir.html \
	murrell-xdvir.pdf \
	motivation-letter/motivation-letter.pdf \
	murrell-xdvir.Rmd \
	murrell-xdvir.bib \
	murrell-xdvir.R \
	data \
	diagram/*.tex \
	Fonts/*.ttf \
	scripts \
	TeX/*.tex \
	TeX/*.sty \
	Review/murrell-xdvir-response.pdf

.PHONY: submission-test
submission-test:
	rm -r submission-test/*
	cp submission/murrell-xdvir.zip submission-test/
	cd submission-test && \
	unzip murrell-xdvir.zip && \
	Rscript -e 'pandoc::pandoc_activate(version = "3.1.6");	rmarkdown::render("murrell-xdvir.Rmd", output_format = "all")' && \
	rm *.log && \
	Rscript -e 'rjtools::initial_check_article(".", pkg="xdvir", logfile=tempfile())'
