$(common-objpfx)string/rtld-strncmp-evex.os: \
 ../sysdeps/x86_64/multiarch/strncmp-evex.S ../include/stdc-predef.h \
 $(common-objpfx)libc-modules.h \
 ../include/libc-symbols.h \
 $(common-objpfx)config.h \
 ../sysdeps/generic/libc-symver.h ../sysdeps/generic/symbol-hacks.h \
 ../sysdeps/x86_64/multiarch/strcmp-evex.S ../sysdeps/x86/isa-level.h
../include/stdc-predef.h:
$(common-objpfx)libc-modules.h:
../include/libc-symbols.h:
$(common-objpfx)config.h:
../sysdeps/generic/libc-symver.h:
../sysdeps/generic/symbol-hacks.h:
../sysdeps/x86_64/multiarch/strcmp-evex.S:
../sysdeps/x86/isa-level.h:
