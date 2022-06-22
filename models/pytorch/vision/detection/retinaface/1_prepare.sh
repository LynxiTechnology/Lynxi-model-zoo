#!/bin/bash

set -e

source setting.cfg

cd "$TOP"
[[ ! -d "${source_dir}" ]] && git clone "${source_url}"

cd "${source_dir}"
git checkout b984b4b775b2c4dced95c1eadd195a5c7d32a60b
git am ../patch/*.patch

[[ ! -d "weights" ]] && mkdir weights
[[ ! -d "dump_log" ]] && mkdir dump_log
cd weights
tempFile="${TOP}/patch/mobilenet0.25_Final.pth"
[[ -f "${tempFile}" ]] && cp -f "${tempFile}" .
tempFile="${TOP}/patch/mobilenetV1X0.25_pretrain.tar"
[[ -f "${tempFile}" ]] && cp -f "${tempFile}" .
pip3 install -r "${TOP}/golden/requirements.txt"
