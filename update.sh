#!/bin/bash

find . -type d -name ".git" -print0 | while IFS= read -r -d '' gitdir; do
    repo_dir="$(dirname "$gitdir")"
    (cd "$repo_dir" && git submodule update --init --recursive --remote)
    echo
done

