#!/bin/bash

set -e

source setting.cfg

cd "${source_dir}"
python3 test_lynxi.py -m build -p ./curve/target_net.pth
