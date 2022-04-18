#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -

source setting.cfg

python3 "$MODEL_VERIFY" "$output_dir/Net_0" $golden_dir/input.bin $golden_dir/output.bin "float32"