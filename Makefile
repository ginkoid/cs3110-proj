.PHONY: test check

build:
	dune build

code:
	-dune build
	! dune build --watch

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

play:
	OCAMLRUNPARAM=b dune exec cmd/main.exe
