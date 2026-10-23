#!/bin/sh
printf '\033c\033]0;%s\a' Rom2
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Rom2.arm64" "$@"
