#!/usr/bin/env zsh

# Set the TASK environment variable to the name of your C++ file without the extension
TASK="euler-3-largest-prime-factor"

# Fail (exit) immediately if any of the following commands fail.
set -e

# Compile the C++ code
ghc --make -v0 ${TASK}.hs -o ${TASK}_compiled

# The show-exec-command is available in the Einstein execution environment.
# It is also available in the `bin` directory in the project repo.  You can
# install it locally from there for testing.
for v in 13195 1313346 600851475143
do
  show-exec-command ./${TASK}_compiled $v
done
