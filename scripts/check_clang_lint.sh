#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
BASE_DIR="$SCRIPT_DIR/.."

cd "$BASE_DIR"

WARNINGS=(
    -Wshift-op-parentheses
    -Wtautological-compare
    -Wpointer-bool-conversion
)

FLAGS=(
    --target=powerpc-unknown-eabi
    -fsyntax-only
    -std=gnu++14
    -fsigned-char
    -fshort-wchar
    -fno-exceptions
    -fno-rtti
    -fms-extensions
    -fms-compatibility
    -fdelayed-template-parsing
    -fdeclspec
    -D__INTELLISENSE__
    -IKamekInclude
    -IGameSource
    -IPulsarEngine
    -ILoader
    -Wno-everything
    "${WARNINGS[@]}"
    -Werror
)

if find PulsarEngine -iname "*.cpp" -print0 | sort -z | xargs -0 -n 1 -P "$(nproc)" clang++ "${FLAGS[@]}"; then
    exit 0
else
    exit 1
fi
