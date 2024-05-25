#!/bin/sh
set -e

sudo apk add wget wasi-sdk samurai python3 clang lld llvm binaryen inotify-tools

test -d core || (
	wget -O mimimi.tar https://zamfofex.neocities.org/mimimi/mimimi-M50.tar
	tar xf mimimi.tar --strip-components=1
)

test -d meson || (
	git clone https://github.com/mesonbuild/meson
	cd meson
	git fetch origin pull/11862/head:pull-11862
	git checkout pull-11862
	git apply ../meta/meson.diff || true
	rm -rf .git
)

rm -rf build
meson/meson.py setup --cross-file=meta/wasm32.txt build
ln -sf build/mimimi-chapter-I-async.wasm mimimi.wasm
