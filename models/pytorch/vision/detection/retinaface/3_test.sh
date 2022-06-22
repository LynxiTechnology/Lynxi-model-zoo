#!/bin/bash

set -e

source setting.cfg

cd "${source_dir}"
python3 main_myself.py -m ./weights/mobilenet0.25_Final.pth \
    --network mobile0.25 --cpu --target "myself"
