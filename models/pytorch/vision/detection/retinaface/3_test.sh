#!/bin/bash

set -e

source setting.cfg

cd "${source_dir}"
python3 test_lynxi.py -m run \
    -p ./curve/model_myself -i ./curve/input.bin
