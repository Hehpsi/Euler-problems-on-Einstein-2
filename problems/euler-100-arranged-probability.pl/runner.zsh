#!/usr/bin/env zsh

# Set environment variable
TASK="euler-100-arranged-probability"

# Exit on failure
set -e

# Compile Prolog code
swipl -O -o ${TASK}_compiled -g main -c ${TASK}.pl

# Test
for v in 1000 1000000 1000000000 1000000000000
do
    show-exec-command ./${TASK}_compiled --goal "start(85, 120, $v), halt."
done
