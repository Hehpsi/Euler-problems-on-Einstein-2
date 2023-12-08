#!/usr/bin/env zsh

# Set environ variable
TASK="euler-1-multiples-of-3-or-5"

# Exit on failure
set -e

# Compile rust code
ghc -v0 --make ${TASK}.hs -o ${TASK}_compiled

## test
for v in 0 10 100 500 1000 5000 10000
do
	show-exec-command ./${TASK}_compiled $v
done
