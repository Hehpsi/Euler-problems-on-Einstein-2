#!/usr/bin/env zsh

# Set environment variable
TASK="euler-3-largest-prime-factor"

# Exit on failure
set -e

# Compile Prolog code
swipl -O -o ${TASK}_compiled -g main -c ${TASK}.pl

# Test
for v in 13195 1313346 600851475143
do
    show-exec-command ./${TASK}_compiled --goal "answer($v, Answer), writeln(Answer), halt."
done
