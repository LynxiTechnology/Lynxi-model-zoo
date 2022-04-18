#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH
model_compile -f ONNX -m "$model_file" --input_shapes "$input_shapes" --input_nodes "images" --output "$output_dir"


