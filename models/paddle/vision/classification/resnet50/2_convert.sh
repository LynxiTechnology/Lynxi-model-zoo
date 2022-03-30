#!/bin/bash

source setting.cfg

model_compile -f ONNX -m $model_file --input_shapes $input_shapes --output "$output_dir"