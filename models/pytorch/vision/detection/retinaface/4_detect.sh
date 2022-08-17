#!/bin/bash

set -e

source setting.cfg

cd "${source_dir}"
python3 detect_target.py -m "${STOP}/${file_depend1}" --network mobile0.25 \
    --cpu --save_image --platform "lynxi" \
    --output_result "${STOP}/golden/output_myself.jpg"
