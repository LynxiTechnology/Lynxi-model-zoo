#!/bin/bash
echo " ### Warning: Check whether lyngor1.1.0 is installed ###"
cd ../../../../../ && source envsetup.sh && cd -

source setting.cfg

cd $source_dir

export PYTHONPATH=$source_dir/yolov5:$PYTHONPATH      

python3 $cur_dir/convert.py\
    $model_file_yolov5 $input_shapes_yolov5 $output_dir_yolov5s\
    $model_file_osnet  $input_shapes_osnet  $output_dir_osnet