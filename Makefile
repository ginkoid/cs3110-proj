.PHONY: test check

build:
	dune build

code:
	-dune build
	code .
	! dune build --watch

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

play:
	OCAMLRUNPARAM=b dune exec src/main.exe

zip:
	rm -f project.zip
	zip -r project.zip . -x@exclude.lst

clean:
	dune clean
	rm -f project.zip
