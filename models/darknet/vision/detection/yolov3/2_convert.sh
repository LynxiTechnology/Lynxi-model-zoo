#!/bin/bash
source setting.cfg

cd $cur_dir

echo "======Compiling model by Lyngor======="

python3 $source_dir/lyncompile.py -m $model_file_h5 -o convert_out -i $input_shapes