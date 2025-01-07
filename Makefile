
all: 
	Rscript -e 'pandoc::pandoc_activate(version = "3.1.6");	rmarkdown::render("murrell-xdvir.Rmd", output_format = "all")'
