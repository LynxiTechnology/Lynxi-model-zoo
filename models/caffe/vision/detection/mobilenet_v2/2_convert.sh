#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH   
model_compile -f Caffe -m "$model_file" -w $model_weights --input_shapes "$input_shapes" --input_nodes "data" --output_nodes $output_node --output "$output_dir"
