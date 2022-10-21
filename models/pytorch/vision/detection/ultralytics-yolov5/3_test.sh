#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -

source setting.cfg

export YOLOV5_SHAPE=$input_shapes

# python3 "$MODEL_VERIFY" "$output_dir/Net_0" $golden_dir/input.bin $golden_dir/output.bin "float32"
python3 $cur_dir/test.py "$output_dir/Net_0" $golden_dir/input.bin  $golden_dir/output.bin "float32"
