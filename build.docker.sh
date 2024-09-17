
#!/usr/bin/env bash

set -e

docker build . -t qtbase-wasm32-wasi-worker

docker run --rm --user=root \
    -v `pwd`:/home/worker/src \
    -w /home/worker/src \
    qtbase-wasm32-wasi-worker \
    sh -c "./build.sh"
