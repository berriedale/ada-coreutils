

BUILDDIR=build/obj
GPRBUILD=`which gprbuild`

all: pre
	${GPRBUILD} -Puserland.gpr

pre:
	@mkdir -p ${BUILDDIR}
	@git submodule update --init
	@./scripts/generate-version

clean:
	rm -rf ${BUILDDIR}

check: all
	@./contrib/bats/bin/bats t/**/*.bats

.PHONY: all pre check clean
