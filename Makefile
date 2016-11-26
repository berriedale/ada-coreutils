

BUILDDIR=build/obj
GPRBUILD=`which gprbuild`

all: pre ${BUILDDIR}/ls

${BUILDDIR}/ls:
	${GPRBUILD} -Puserland.gpr

pre:
	@mkdir -p ${BUILDDIR}
	@git submodule update --init

clean:
	rm -rf ${BUILDDIR}

check: all
	@PATH=${BUILDDIR}:${PATH} ./contrib/bats/bin/bats t/**/*.bats

.PHONY: all pre check clean
