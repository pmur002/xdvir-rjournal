
all:
	latexmk -pdf murrell-xdvir.tex

.PHONY: submission
submission:
	make
	rm murrell-xdvir.pdf
	tar -zcvvf submission/murrell-xdvir-arXiv.tar.gz \
	*.tex \
	*.sty \
	*.pdf \
	*.bbl 

.PHONY: submission-test
submission-test:
	rm -r submission-test
	mkdir submission-test
	cp submission/murrell-xdvir-arXiv.tar.gz submission-test/
	cd submission-test && \
	tar -zxvvf murrell-xdvir-arXiv.tar.gz && \
	latexmk -pdf murrell-xdvir.tex

