#!/bin/bash

source setting.cfg

# build abc model, need use lyngor1.7.0+
model_compile -f Caffe -m $model_file -w $model_weights \
    --input_shapes $input_shapes \
    --input_nodes data \
    --output_nodes $output_node \
    --transpose_axis NHWC \
    --input_type float16 \
    --output_type float16 \
    --output $output_dir
