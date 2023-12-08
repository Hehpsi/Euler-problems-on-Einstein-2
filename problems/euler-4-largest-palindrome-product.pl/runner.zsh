#!/usr/bin/env zsh

# Set environment variable
TASK="euler-4-largest-palindrome-product"

# Exit on failure
set -e

# Compile Prolog code
swipl -O -o ${TASK}_compiled -g main -c ${TASK}.pl

# Test
for v in 2 3
do
    show-exec-command ./${TASK}_compiled --goal "largest_palindrome_product($v, X), writeln(X), halt."
done
