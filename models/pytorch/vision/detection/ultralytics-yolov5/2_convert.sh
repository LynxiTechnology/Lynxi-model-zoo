#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH
# model_compile -f Pytorch -m "$model_file" --input_shapes "$input_shapes" --input_nodes "data" --output_nodes $output_node --output "$output_dir"
model_compile -f Pytorch -m "$model_file" \
    --input_shapes "$input_shapes" \
    --input_nodes "data" \
    --output_nodes $output_node \
    --output "$output_dir" \
    --input_type "uint8" \
    --output_type "float16" \
    --normalization --mean 0,0,0 --variance 255,255,255 \
    --transpose_axis NHWC    