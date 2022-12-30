#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH  
# build abc model, need use lyngor1.7.0+
python3 $cur_dir/convert.py $model_file $input_shapes $output_dir
