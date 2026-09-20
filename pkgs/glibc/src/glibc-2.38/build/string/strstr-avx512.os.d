$(common-objpfx)string/strstr-avx512.os: \
 ../sysdeps/x86_64/multiarch/strstr-avx512.c ../include/stdc-predef.h \
 $(common-objpfx)libc-modules.h \
 ../include/libc-symbols.h \
 $(common-objpfx)config.h \
 ../sysdeps/generic/libc-symver.h ../sysdeps/generic/symbol-hacks.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/immintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/x86gprintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/ia32intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/stddef.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/adxintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/bmiintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/bmi2intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/cetintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/cldemoteintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/clflushoptintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/clwbintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/clzerointrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/cmpccxaddintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/enqcmdintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/fxsrintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/lzcntintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/lwpintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/movdirintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/mwaitintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/mwaitxintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/pconfigintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/popcntintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/pkuintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/prfchiintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/raointintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/rdseedintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/rtmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/serializeintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/sgxintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/tbmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/tsxldtrkintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/uintrintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/waitpkgintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/wbnoinvdintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xsaveintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xsavecintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xsaveoptintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xsavesintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xtestintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/hresetintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/usermsrintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/mmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xmmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/mm_malloc.h \
 ../include/stdlib.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/stdbool.h \
 ../sysdeps/x86/bits/floatn.h ../include/features.h \
 ../include/features-time64.h \
 ../sysdeps/unix/sysv/linux/features-time64.h \
 ../sysdeps/x86/bits/wordsize.h \
 ../sysdeps/unix/sysv/linux/x86/bits/timesize.h ../include/sys/cdefs.h \
 ../misc/sys/cdefs.h ../sysdeps/ieee754/ldbl-96/bits/long-double.h \
 ../include/gnu/stubs.h ../bits/floatn-common.h ../stdlib/stdlib.h \
 ../bits/libc-header-start.h ../sysdeps/unix/sysv/linux/bits/waitflags.h \
 ../bits/waitstatus.h ../include/bits/types/locale_t.h \
 ../locale/bits/types/locale_t.h ../include/bits/types/__locale_t.h \
 ../locale/bits/types/__locale_t.h ../include/sys/types.h \
 ../posix/sys/types.h ../include/bits/types.h ../posix/bits/types.h \
 ../sysdeps/unix/sysv/linux/x86/bits/typesizes.h ../bits/time64.h \
 ../include/bits/types/clock_t.h ../time/bits/types/clock_t.h \
 ../include/bits/types/clockid_t.h ../time/bits/types/clockid_t.h \
 ../include/bits/types/time_t.h ../time/bits/types/time_t.h \
 ../include/bits/types/timer_t.h ../time/bits/types/timer_t.h \
 ../bits/stdint-intn.h ../include/endian.h ../string/endian.h \
 ../include/bits/endian.h ../string/bits/endian.h \
 ../sysdeps/x86/bits/endianness.h ../bits/byteswap.h \
 ../bits/uintn-identity.h ../include/sys/select.h ../misc/sys/select.h \
 ../bits/select.h ../include/bits/types/sigset_t.h \
 ../signal/bits/types/sigset_t.h \
 ../sysdeps/unix/sysv/linux/bits/types/__sigset_t.h \
 ../include/bits/types/struct_timeval.h \
 ../time/bits/types/struct_timeval.h \
 ../include/bits/types/struct_timespec.h \
 ../time/bits/types/struct_timespec.h ../include/bits/select-decl.h \
 ../misc/bits/select-decl.h ../sysdeps/nptl/bits/pthreadtypes.h \
 ../sysdeps/nptl/bits/thread-shared-types.h \
 ../sysdeps/x86/nptl/bits/pthreadtypes-arch.h \
 ../include/bits/atomic_wide_counter.h ../bits/atomic_wide_counter.h \
 ../sysdeps/x86/nptl/bits/struct_mutex.h \
 ../sysdeps/x86/nptl/bits/struct_rwlock.h ../include/alloca.h \
 ../stdlib/alloca.h ../include/stackinfo.h ../sysdeps/x86_64/stackinfo.h \
 ../include/elf.h ../elf/elf.h ../include/stdint.h ../stdlib/stdint.h \
 ../bits/wchar.h ../bits/stdint-uintn.h ../include/libc-pointer-arith.h \
 ../sysdeps/generic/dl-dtprocnum.h ../sysdeps/pthread/allocalim.h \
 ../include/limits.h /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/limits.h \
 ../include/bits/posix1_lim.h ../posix/bits/posix1_lim.h \
 ../sysdeps/unix/sysv/linux/bits/local_lim.h /usr/include/linux/limits.h \
 ../sysdeps/unix/sysv/linux/include/bits/pthread_stack_min-dynamic.h \
 ../sysdeps/unix/sysv/linux/bits/pthread_stack_min.h \
 ../include/bits/posix2_lim.h ../posix/bits/posix2_lim.h \
 ../include/bits/xopen_lim.h ../sysdeps/unix/sysv/linux/bits/uio_lim.h \
 ../bits/stdlib-bsearch.h ../include/bits/stdlib-float.h \
 ../stdlib/bits/stdlib-float.h ../include/sys/stat.h ../io/sys/stat.h \
 ../sysdeps/unix/sysv/linux/bits/stat.h \
 ../sysdeps/unix/sysv/linux/x86/bits/struct_stat.h \
 ../include/bits/statx.h ../io/bits/statx.h \
 ../include/bits/statx-generic.h ../io/bits/statx-generic.h \
 ../include/bits/types/struct_statx_timestamp.h \
 ../io/bits/types/struct_statx_timestamp.h \
 ../include/bits/types/struct_statx.h ../io/bits/types/struct_statx.h \
 ../sysdeps/unix/sysv/linux/x86/xstatver.h \
 ../include/struct___timespec64.h \
 ../sysdeps/unix/sysv/linux/struct_stat_time64.h ../include/rtld-malloc.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/emmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/pmmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/tmmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/smmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/wmmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxvnniintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxifmaintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxvnniint8intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxvnniint16intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx2intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512fintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512cdintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bwintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512dqintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vlbwintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vldqintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512ifmaintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512ifmavlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vbmiintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vbmivlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vpopcntdqintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vbmi2intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vbmi2vlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vnniintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vnnivlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vpopcntdqvlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bitalgintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bitalgvlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vp2intersectintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vp2intersectvlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512fp16intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512fp16vlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/shaintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/sm3intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/sha512intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/sm4intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/fmaintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/f16cintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/gfniintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/vaesintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/vpclmulqdqintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bf16vlintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bf16intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxneconvertintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxtileintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxint8intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxbf16intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxcomplexintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxavx512intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxtf32intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxfp8intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/prfchwintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/keylockerintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxfp16intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2mediaintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2convertintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2bf16intrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2satcvtintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2minmaxintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2copyintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/movrsintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxmovrsintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bmmintrin.h \
 /usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bmmvlintrin.h \
 ../include/inttypes.h ../stdlib/inttypes.h ../include/string.h \
 ../include/locale.h ../locale/locale.h ../include/bits/locale.h \
 ../locale/bits/locale.h ../string/string.h ../include/strings.h \
 ../string/strings.h
../include/stdc-predef.h:
$(common-objpfx)libc-modules.h:
../include/libc-symbols.h:
$(common-objpfx)config.h:
../sysdeps/generic/libc-symver.h:
../sysdeps/generic/symbol-hacks.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/immintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/x86gprintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/ia32intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/stddef.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/adxintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/bmiintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/bmi2intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/cetintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/cldemoteintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/clflushoptintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/clwbintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/clzerointrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/cmpccxaddintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/enqcmdintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/fxsrintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/lzcntintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/lwpintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/movdirintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/mwaitintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/mwaitxintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/pconfigintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/popcntintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/pkuintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/prfchiintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/raointintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/rdseedintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/rtmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/serializeintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/sgxintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/tbmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/tsxldtrkintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/uintrintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/waitpkgintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/wbnoinvdintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xsaveintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xsavecintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xsaveoptintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xsavesintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xtestintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/hresetintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/usermsrintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/mmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/xmmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/mm_malloc.h:
../include/stdlib.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/stdbool.h:
../sysdeps/x86/bits/floatn.h:
../include/features.h:
../include/features-time64.h:
../sysdeps/unix/sysv/linux/features-time64.h:
../sysdeps/x86/bits/wordsize.h:
../sysdeps/unix/sysv/linux/x86/bits/timesize.h:
../include/sys/cdefs.h:
../misc/sys/cdefs.h:
../sysdeps/ieee754/ldbl-96/bits/long-double.h:
../include/gnu/stubs.h:
../bits/floatn-common.h:
../stdlib/stdlib.h:
../bits/libc-header-start.h:
../sysdeps/unix/sysv/linux/bits/waitflags.h:
../bits/waitstatus.h:
../include/bits/types/locale_t.h:
../locale/bits/types/locale_t.h:
../include/bits/types/__locale_t.h:
../locale/bits/types/__locale_t.h:
../include/sys/types.h:
../posix/sys/types.h:
../include/bits/types.h:
../posix/bits/types.h:
../sysdeps/unix/sysv/linux/x86/bits/typesizes.h:
../bits/time64.h:
../include/bits/types/clock_t.h:
../time/bits/types/clock_t.h:
../include/bits/types/clockid_t.h:
../time/bits/types/clockid_t.h:
../include/bits/types/time_t.h:
../time/bits/types/time_t.h:
../include/bits/types/timer_t.h:
../time/bits/types/timer_t.h:
../bits/stdint-intn.h:
../include/endian.h:
../string/endian.h:
../include/bits/endian.h:
../string/bits/endian.h:
../sysdeps/x86/bits/endianness.h:
../bits/byteswap.h:
../bits/uintn-identity.h:
../include/sys/select.h:
../misc/sys/select.h:
../bits/select.h:
../include/bits/types/sigset_t.h:
../signal/bits/types/sigset_t.h:
../sysdeps/unix/sysv/linux/bits/types/__sigset_t.h:
../include/bits/types/struct_timeval.h:
../time/bits/types/struct_timeval.h:
../include/bits/types/struct_timespec.h:
../time/bits/types/struct_timespec.h:
../include/bits/select-decl.h:
../misc/bits/select-decl.h:
../sysdeps/nptl/bits/pthreadtypes.h:
../sysdeps/nptl/bits/thread-shared-types.h:
../sysdeps/x86/nptl/bits/pthreadtypes-arch.h:
../include/bits/atomic_wide_counter.h:
../bits/atomic_wide_counter.h:
../sysdeps/x86/nptl/bits/struct_mutex.h:
../sysdeps/x86/nptl/bits/struct_rwlock.h:
../include/alloca.h:
../stdlib/alloca.h:
../include/stackinfo.h:
../sysdeps/x86_64/stackinfo.h:
../include/elf.h:
../elf/elf.h:
../include/stdint.h:
../stdlib/stdint.h:
../bits/wchar.h:
../bits/stdint-uintn.h:
../include/libc-pointer-arith.h:
../sysdeps/generic/dl-dtprocnum.h:
../sysdeps/pthread/allocalim.h:
../include/limits.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/limits.h:
../include/bits/posix1_lim.h:
../posix/bits/posix1_lim.h:
../sysdeps/unix/sysv/linux/bits/local_lim.h:
/usr/include/linux/limits.h:
../sysdeps/unix/sysv/linux/include/bits/pthread_stack_min-dynamic.h:
../sysdeps/unix/sysv/linux/bits/pthread_stack_min.h:
../include/bits/posix2_lim.h:
../posix/bits/posix2_lim.h:
../include/bits/xopen_lim.h:
../sysdeps/unix/sysv/linux/bits/uio_lim.h:
../bits/stdlib-bsearch.h:
../include/bits/stdlib-float.h:
../stdlib/bits/stdlib-float.h:
../include/sys/stat.h:
../io/sys/stat.h:
../sysdeps/unix/sysv/linux/bits/stat.h:
../sysdeps/unix/sysv/linux/x86/bits/struct_stat.h:
../include/bits/statx.h:
../io/bits/statx.h:
../include/bits/statx-generic.h:
../io/bits/statx-generic.h:
../include/bits/types/struct_statx_timestamp.h:
../io/bits/types/struct_statx_timestamp.h:
../include/bits/types/struct_statx.h:
../io/bits/types/struct_statx.h:
../sysdeps/unix/sysv/linux/x86/xstatver.h:
../include/struct___timespec64.h:
../sysdeps/unix/sysv/linux/struct_stat_time64.h:
../include/rtld-malloc.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/emmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/pmmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/tmmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/smmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/wmmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxvnniintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxifmaintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxvnniint8intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxvnniint16intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx2intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512fintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512cdintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bwintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512dqintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vlbwintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vldqintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512ifmaintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512ifmavlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vbmiintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vbmivlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vpopcntdqintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vbmi2intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vbmi2vlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vnniintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vnnivlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vpopcntdqvlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bitalgintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bitalgvlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vp2intersectintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512vp2intersectvlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512fp16intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512fp16vlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/shaintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/sm3intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/sha512intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/sm4intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/fmaintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/f16cintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/gfniintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/vaesintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/vpclmulqdqintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bf16vlintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bf16intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avxneconvertintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxtileintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxint8intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxbf16intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxcomplexintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxavx512intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxtf32intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxfp8intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/prfchwintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/keylockerintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxfp16intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2mediaintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2convertintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2bf16intrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2satcvtintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2minmaxintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx10_2copyintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/movrsintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/amxmovrsintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bmmintrin.h:
/usr/lib/gcc/x86_64-pc-linux-gnu/16/include/avx512bmmvlintrin.h:
../include/inttypes.h:
../stdlib/inttypes.h:
../include/string.h:
../include/locale.h:
../locale/locale.h:
../include/bits/locale.h:
../locale/bits/locale.h:
../string/string.h:
../include/strings.h:
../string/strings.h:
