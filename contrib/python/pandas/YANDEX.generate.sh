#!/bin/bash
set -euo pipefail

function indent {
    sed 's/^/    /g'
}

sed -e '/SRCS/,$ d' -i CMakeLists.txt

cat >>CMakeLists.txt <<EOF
# SRCS and PY_SRCS generated by YANDEX.generate.sh
SRCS(
$(find pandas -name '*.c' | sort | indent)
)

PY_SRCS(
    TOP_LEVEL

    # Other pyx are included from these pyx and should not be listed directly.
    CYTHON_C
    pandas/_join.pyx
    pandas/_period.pyx
    pandas/_sparse.pyx
    pandas/_testing.pyx
    pandas/_window.pyx
    pandas/algos.pyx
    pandas/hashtable.pyx
    pandas/index.pyx
    pandas/io/sas/saslib.pyx
    pandas/lib.pyx
    pandas/parser.pyx
    pandas/tslib.pyx
    CYTHON_CPP
    pandas/msgpack/_packer.pyx
    pandas/msgpack/_unpacker.pyx

$(find pandas -name '*.py' | sort | indent)
)

END()
EOF
