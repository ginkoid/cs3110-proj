ESBUILD=./node_modules/.bin/esbuild --bundle \
	--external:fs --external:constants --external:tty --external:child_process \
	--log-override:duplicate-case=debug _build/default/app/main.bc.js

.PHONY: test check

build:
	dune build
	cp -r public/ dist
	$(ESBUILD) --minify --outfile=dist/app.js

start:
	-dune build
	! ./node_modules/.bin/conc -n dune,esbuild \
	"dune build --watch" \
	"$(ESBUILD) --watch --servedir=public --outfile=public/app.js"

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe
