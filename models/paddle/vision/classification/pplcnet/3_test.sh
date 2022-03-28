#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -

output="convert_out"

python3 "$MODEL_VERIFY" "$output/Net_0" golden/batch1_input.bin golden/batch1_output.bin "float32"