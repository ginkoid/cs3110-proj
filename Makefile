ESBUILD=./node_modules/.bin/esbuild --bundle --minify \
	--log-override:duplicate-case=debug --entry-names=assets/[name] \
	_build/default/app/main.bc.js ./app/main.css

.PHONY: build start utop test

build:
	dune build --profile release
	cp -r public/ dist
	$(ESBUILD) --outdir=dist

start:
	-dune build --profile release
	! ./node_modules/.bin/conc -n dune,esbuild \
	"dune build --watch --profile release" \
	"$(ESBUILD) --watch --servedir=public --outdir=public"

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe
