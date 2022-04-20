#!/bin/bash

source setting.cfg

cd $cur_dir

export PYTHONPATH=$source_dir:$PYTHONPATH
python3 $source_dir/lyn_inference.py "$image_path" "$input_shapes" "$class_name" "$output_dir"

echo "======output images to result/ folder, original result in golden folder======="