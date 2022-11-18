#!/bin/bash

source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH   
# convert sarn_fuse_se_all
python3 $cur_dir/convert.py $model_file_1 $input_shapes $output_dir_1

# convert sarn_fuse_se_all_bam
python3 $cur_dir/convert.py $model_file_2 $input_shapes $output_dir_2