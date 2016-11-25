

BUILDDIR=build/obj
GPRBUILD=`which gprbuild`

all: pre ${BUILDDIR}/ls

${BUILDDIR}/ls:
	${GPRBUILD} -Puserland.gpr

pre:
	@mkdir -p ${BUILDDIR}
	git submodule update --init

clean:
	rm -rf ${BUILDDIR}

check: all

.PHONY: all pre check clean
