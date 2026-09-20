#!/bin/bash
builddir=`dirname "$0"`
GCONV_PATH="${builddir}/iconvdata"

usage () {
cat << EOF
Usage: $0 [OPTIONS] <program> [ARGUMENTS...]

  --tool=TOOL  Run with the specified TOOL. It can be strace, rpctrace,
               valgrind or container. The container will run within
               support/test-container.  For strace and valgrind,
               additional arguments can be passed after the tool name.
EOF

  exit 1
}

toolname=default
while test $# -gt 0 ; do
  case "$1" in
    --tool=*)
      toolname="${1:7}"
      shift
      ;;
    --*)
      usage
      ;;
    *)
      break
      ;;
  esac
done

if test $# -eq 0 ; then
  usage
fi

case "$toolname" in
  default)
    exec   env GCONV_PATH="${builddir}"/iconvdata LOCPATH="${builddir}"/localedata LC_ALL=C  "${builddir}"/elf/ld-linux-x86-64.so.2 --library-path "${builddir}":"${builddir}"/math:"${builddir}"/elf:"${builddir}"/dlfcn:"${builddir}"/nss:"${builddir}"/nis:"${builddir}"/rt:"${builddir}"/resolv:"${builddir}"/mathvec:"${builddir}"/support:"${builddir}"/nptl ${1+"$@"}
    ;;
  strace*)
    exec $toolname  -EGCONV_PATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/iconvdata  -ELOCPATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/localedata  -ELC_ALL=C  /root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf/ld-linux-x86-64.so.2 --library-path /root/tango-packages/pkgs/glibc/src/glibc-2.38/build:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/math:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/dlfcn:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nss:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nis:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/rt:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/resolv:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/mathvec:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/support:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nptl ${1+"$@"}
    ;;
  rpctrace)
    exec rpctrace  -EGCONV_PATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/iconvdata  -ELOCPATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/localedata  -ELC_ALL=C  /root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf/ld-linux-x86-64.so.2 --library-path /root/tango-packages/pkgs/glibc/src/glibc-2.38/build:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/math:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/dlfcn:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nss:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nis:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/rt:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/resolv:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/mathvec:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/support:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nptl ${1+"$@"}
    ;;
  valgrind*)
    exec env GCONV_PATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/iconvdata LOCPATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/localedata LC_ALL=C $toolname  /root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf/ld-linux-x86-64.so.2 --library-path /root/tango-packages/pkgs/glibc/src/glibc-2.38/build:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/math:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/dlfcn:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nss:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nis:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/rt:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/resolv:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/mathvec:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/support:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nptl ${1+"$@"}
    ;;
  container)
    exec env GCONV_PATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/iconvdata LOCPATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/localedata LC_ALL=C  /root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf/ld-linux-x86-64.so.2 --library-path /root/tango-packages/pkgs/glibc/src/glibc-2.38/build:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/math:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/dlfcn:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nss:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nis:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/rt:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/resolv:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/mathvec:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/support:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nptl /root/tango-packages/pkgs/glibc/src/glibc-2.38/build/support/test-container env GCONV_PATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/iconvdata LOCPATH=/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/localedata LC_ALL=C  /root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf/ld-linux-x86-64.so.2 --library-path /root/tango-packages/pkgs/glibc/src/glibc-2.38/build:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/math:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/elf:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/dlfcn:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nss:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nis:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/rt:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/resolv:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/mathvec:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/support:/root/tango-packages/pkgs/glibc/src/glibc-2.38/build/nptl ${1+"$@"}
    ;;
  *)
    usage
    ;;
esac
