ESBUILD=./node_modules/.bin/esbuild --bundle --minify \
	--log-override:duplicate-case=debug _build/default/app/main.bc.js

.PHONY: test check

build:
	dune build --profile release
	cp -r public/ dist
	$(ESBUILD) --outfile=dist/app.js

start:
	-dune build --profile release
	! ./node_modules/.bin/conc -n dune,esbuild \
	"dune build --watch --profile release" \
	"$(ESBUILD) --watch --servedir=public --outfile=public/app.js"

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe
