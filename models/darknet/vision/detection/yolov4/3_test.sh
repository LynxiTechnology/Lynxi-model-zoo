#!/bin/bash
# generate golden
source setting.cfg

export PYTHONPATH=$golden_dir:$PYTHONPATH
cd $golden_dir && python3 generate.py $converted_model "$input_shapes" && cd -

cd ../../../../../ && source envsetup.sh && cd -

python3 "$MODEL_VERIFY" "$output_dir/Net_0" $golden_dir/input.bin $golden_dir/output.bin "float32"