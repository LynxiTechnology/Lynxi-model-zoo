#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH

cd $source_dir
python3 deepsort.py $cur_dir/golden/test.png --cpu
python3 lyncompile.py 

cd $cur_dir/golden
python3 generate.py $yolo_model $track_model "$yolo_shapes" "$track_shape"

cd $cur_dir