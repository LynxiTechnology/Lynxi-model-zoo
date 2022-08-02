#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH

cd $source_dir
python3 lyncompile.py 

cd $cur_dir/golden
python3 generate.py $yolo_model "$yolo_shapes"

cd $cur_dir