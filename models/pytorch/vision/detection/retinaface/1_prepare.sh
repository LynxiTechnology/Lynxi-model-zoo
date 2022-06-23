#!/bin/bash

set -e

source setting.cfg

cd "$STOP"
[[ ! -d "${source_dir}" ]] && git clone "${source_url}"

cd "${source_dir}"
git checkout b984b4b775b2c4dced95c1eadd195a5c7d32a60b
git am ../patch/*.patch

tempFile="${STOP}/${file_depend1}"
[[ -f "${tempFile}" ]] && cp -f "${tempFile}" ./curve
tempFile="${STOP}/${file_depend2}"
[[ -f "${tempFile}" ]] && cp -f "${tempFile}" ./curve
tempFile="${STOP}/golden/${file_depend3}"
[[ -f "${tempFile}" ]] && cp -f "${tempFile}" ./curve
pip3 install -r "${STOP}/requirements.txt"

python3 detect.py -m ./curve/"${file_depend1}" --network mobile0.25 \
    --cpu --save_image
cd -
