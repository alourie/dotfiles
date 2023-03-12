#!/usr/bin/env bash

g=$(git rev-parse --is-inside-work-tree 2> /dev/null)
if [ "$g" = "true" ]; then
    proj=$(basename $(git rev-parse --show-toplevel))
    branch=$(git branch --show-current)
    echo "[$proj]  $branch"
else
    echo "not git"
fi
