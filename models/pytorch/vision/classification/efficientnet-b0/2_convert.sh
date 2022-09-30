#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH
python3 $source_dir/lyncompile.py -o $output_dir -i $input_shapes -n $model_file
