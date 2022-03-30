#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH
model_compile -f Pytorch -m "$model_file" --input_shapes "$input_shapes" --input_nodes "data" --output_nodes $output_node --output "$output_dir"