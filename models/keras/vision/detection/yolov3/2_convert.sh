#!/bin/bash

source setting.cfg

# model_compile tool have not keras 
python3 $cur_dir/convert.py $model_file $input_shapes $output_dir


