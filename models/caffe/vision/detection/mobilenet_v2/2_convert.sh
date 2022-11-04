#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH   
# method 1
model_compile -f Caffe -m "$model_file" -w $model_weights \
    --input_shapes "$input_shapes" \
    --input_nodes "data" \
    --output_nodes $output_node \
    --input_type "float16" \
    --output_type "float16" \
    --transpose_axis NHWC \
    --output "$output_dir"
