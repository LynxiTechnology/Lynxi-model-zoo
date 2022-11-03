#!/bin/bash

source setting.cfg

# need "pip3 install lyngor-1.5.1+_xx.whl"
export PYTHONPATH=$source_dir:$PYTHONPATH   
python3 $cur_dir/convert.py $model_file $input_shapes $output_dir