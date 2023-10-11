#!/bin/sh

src_dir=files
build_dir=build

if [ -e "$build_dir" ]; then
	echo >&2 "build directory already exists!"
	exit 1
fi

cp -r $src_dir $build_dir &&
lua build-scripts/resolve-templates.lua &&
lua build-scripts/compile-stories.lua ${1:+"$1"} &&
lua build-scripts/compile-search-data.lua &&
echo "ALL DONE"
