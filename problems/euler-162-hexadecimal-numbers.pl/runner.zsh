#!/usr/bin/env zsh

# Set environment variable
TASK="euler-162-hexadecimal-numbers"

# Exit on failure
set -e

# Compile Prolog code
swipl -O -o ${TASK}_compiled -g main -c ${TASK}.pl

# Test
for v in 3 10 16
do
    show-exec-command ./${TASK}_compiled --goal "s($v), halt."
done
