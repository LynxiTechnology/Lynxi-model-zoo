#!/bin/bash

model_file="mobilenetv3.onnx"
output="convert_out"

#
### [N,C,H,W], 可以调整N编译多batch
#
input_shapes="1,3,224,224"

model_compile -f ONNX -m "$model_file" --input_shapes "$input_shapes" --output "$output"