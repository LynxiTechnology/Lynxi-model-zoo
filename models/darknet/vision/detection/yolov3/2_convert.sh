#!/bin/bash
source setting.cfg

cd $cur_dir

echo "======Compiling model by Lyngor======="

# model_compile -f Keras_tf -m $model_file_h5 --input_shapes "$input_shapes" --input_nodes "input_1" --output "$output_dir"
python lyncompile.py -m $model_file_h5 -o convert_out -i $input_shapes