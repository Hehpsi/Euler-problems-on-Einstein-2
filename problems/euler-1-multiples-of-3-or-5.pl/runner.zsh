#!/usr/bin/env zsh

# Set environment variable
TASK="euler-1-multiples-of-3-or-5"

# Exit on failure
set -e

# Compile Prolog code
swipl -O -o ${TASK}_compiled -g main -c ${TASK}.pl

# Test
for v in 0 10 100 500 1000 5000 10000
do
    show-exec-command ./euler-1-multiples-of-3-or-5_compiled --goal "problem1($v, Answer), writeln(Answer), halt."
done
