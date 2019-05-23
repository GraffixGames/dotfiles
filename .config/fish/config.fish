if test -z "$RUST_SRC_PATH"
    set -x RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/src"
end

alias :q exit
