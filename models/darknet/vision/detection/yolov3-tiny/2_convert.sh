#!/bin/bash
source setting.cfg

cd $cur_dir

echo "======Compiling model by Lyngor======="

model_compile -f Tensorflow -m $converted_model --input_shapes "$input_shapes" --input_nodes "input_1" --output "$output_dir"