
all: 
	Rscript -e 'pandoc::pandoc_activate(version = "3.1.6");	rmarkdown::render("murrell-xdvir.Rmd", output_format = "all")'
	rm *.log
	Rscript -e 'rjtools::initial_check_article(".", pkg="xdvir")'
	rm initial_checks.log
