
all: 
	Rscript -e 'pandoc::pandoc_activate(version = "3.1.6");	rmarkdown::render("murrell-xdvir.Rmd", output_format = "all")'
	rm *.log
	Rscript -e 'rjtools::initial_check_article(".", pkg="xdvir")'
	rm initial_checks.log

submission:
	zip submission/murrell-xdvir.zip \
	# output
	murrell-xdvir.html \
	murrell-xdvir.pdf \
	# motivating letter
	motivation-letter/motivation-letter.pdf \
	# source
	murrell-xdvir.Rmd \
	murrell-xdvir.bib \
	# reproducibility
	murrell-xdvir.R \
	data/ \
	annotate-equations/ \
	diagram/ \
	Fonts/ \
	scripts/ \
	TeX/
