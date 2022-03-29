#!/bin/bash

cur_dir=$(pwd)
source_dir="$cur_dir/yolov5"

model_file="yolov5s.pt"
output="convert_out"

#
### [N,C,H,W], 可以调整N编译多batch
#
input_shapes="1,3,640,640"

export PYTHONPATH=$source_dir:$PYTHONPATH
model_compile -f Pytorch -m "$model_file" --input_shapes "$input_shapes" --input_nodes "data" --output_nodes "model/24" --output "$output"