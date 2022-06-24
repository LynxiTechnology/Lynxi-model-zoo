#!/bin/bash

set -e

source setting.cfg

cd "$STOP"
[[ ! -d "${source_dir}" ]] && git clone "${source_url}"

cd "${source_dir}"
git checkout b984b4b775b2c4dced95c1eadd195a5c7d32a60b
git am ../patch/*.patch

[[ ! -d "weights" ]] && mkdir "weights"
tempFile="${STOP}/${file_depend2}"
[[ -f "${tempFile}" ]] && cp -f "${tempFile}" ./weights
tempFile="${STOP}/golden/${file_img}"
[[ -f "${tempFile}" ]] && cp -f "${tempFile}" ./curve/test.jpg
pip3 install -r "${STOP}/requirements.txt"

python3 detect_target.py -m "${STOP}/${file_depend1}" --network mobile0.25 \
    --cpu --save_image --output_result "${STOP}/golden/output_target.jpg"
cd -
