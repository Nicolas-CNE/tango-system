savedcmd_scripts/generate_rust_target := rustc --out-dir scripts/ --emit=dep-info=scripts/.generate_rust_target.d -Clinker-flavor=gcc -Clinker=gcc -Clink-args=' ' --edition=2021 -Zbinary_dep_depinfo=y -Astable_features -Aunused_features -Dnon_ascii_idents -Dunsafe_op_in_unsafe_fn -Wmissing_docs -Wrust_2018_idioms -Wunreachable_pub -Wclippy::all -Wclippy::as_ptr_cast_mut -Wclippy::as_underscore -Wclippy::cast_lossless -Aclippy::collapsible_if -Aclippy::collapsible_match -Wclippy::ignored_unit_patterns -Aclippy::incompatible_msrv -Wclippy::mut_mut -Wclippy::needless_bitwise_bool -Aclippy::needless_lifetimes -Wclippy::no_mangle_with_rust_abi -Wclippy::ptr_as_ptr -Wclippy::ptr_cast_constness -Wclippy::ref_as_ptr -Wclippy::undocumented_unsafe_blocks -Aclippy::uninlined_format_args -Wclippy::unnecessary_safety_comment -Wclippy::unnecessary_safety_doc -Aclippy::unwrap_or_default -Wrustdoc::missing_crate_level_docs -Wrustdoc::unescaped_backticks -O -Cstrip=debuginfo -Zallow-features=     --emit=link=scripts/generate_rust_target scripts/generate_rust_target.rs

source_scripts/generate_rust_target := scripts/generate_rust_target.rs

deps_scripts/generate_rust_target := \
    $(wildcard include/config/RUSTC_VERSION) \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-2ebcb816689cf9ff.so \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-2ebcb816689cf9ff.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-2ebcb816689cf9ff.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcore-1a290cc82a6d733f.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcore-1a290cc82a6d733f.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/liballoc-920fafc8777e923d.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/liballoc-920fafc8777e923d.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcompiler_builtins-4be0ed4f6f4d257c.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcompiler_builtins-4be0ed4f6f4d257c.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/liblibc-0596f29465de86b4.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/liblibc-0596f29465de86b4.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_std_workspace_core-9bbcc382697bf2cd.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_std_workspace_core-9bbcc382697bf2cd.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libunwind-95442fdf43c7f02c.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libunwind-95442fdf43c7f02c.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libminiz_oxide-690f56567217de72.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libminiz_oxide-690f56567217de72.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libadler2-42965b0491eb89c8.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libadler2-42965b0491eb89c8.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libhashbrown-0df9bd435d31a281.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libhashbrown-0df9bd435d31a281.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_std_workspace_alloc-020145c5a5a8f6e3.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_std_workspace_alloc-020145c5a5a8f6e3.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd_detect-14c72b087f17560f.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd_detect-14c72b087f17560f.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_demangle-7de88d99ad4fd84c.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/librustc_demangle-7de88d99ad4fd84c.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcfg_if-1c191dcc9bca534f.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libcfg_if-1c191dcc9bca534f.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libaddr2line-45f86c06c9c0c4a9.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libaddr2line-45f86c06c9c0c4a9.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libgimli-2fbe2e008af4cae5.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libgimli-2fbe2e008af4cae5.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libobject-0d122c1639b90480.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libobject-0d122c1639b90480.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libmemchr-a3e8c920f9c53d51.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libmemchr-a3e8c920f9c53d51.rmeta \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libpanic_unwind-07a66989b81d098f.rlib \
  /usr/lib/rustlib/x86_64-unknown-linux-gnu/lib/libpanic_unwind-07a66989b81d098f.rmeta \

scripts/generate_rust_target: $(deps_scripts/generate_rust_target)

$(deps_scripts/generate_rust_target):
