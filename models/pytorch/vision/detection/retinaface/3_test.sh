#!/bin/bash

set -e

source setting.cfg

cd "${source_dir}"
python3 detect_lynxi.py -m run -p ../model_myself -i ../golden/input.bin
