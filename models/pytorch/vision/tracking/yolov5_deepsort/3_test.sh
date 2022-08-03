#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -

source setting.cfg

export YOLOV5_SHAPE=$input_shapes_yolov5
export OSNET_SHAPE=$input_shapes_osnet

# test yolov5s and osnet modle
python3 $cur_dir/test.py \
    "$output_dir_yolov5s/Net_0" $golden_dir/input_yolov5.bin  $golden_dir/output_yolov5.bin \
    "$output_dir_osnet/Net_0"   $golden_dir/input_osnet.bin   $golden_dir/output_osnet.bin \
    "float32"

