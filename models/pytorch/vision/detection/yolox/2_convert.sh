#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH
python3 $source_dir/lyncompile.py -m $model_file -o $output_dir -i $input_shapes -n "yolox-s"