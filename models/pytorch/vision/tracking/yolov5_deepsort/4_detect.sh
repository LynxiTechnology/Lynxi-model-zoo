#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

cd $source_dir

export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH
export PYTHONPATH=$source_dir/yolov5:$PYTHONPATH 

export MODEL_YOLOVS=$output_dir_yolov5s            
export MODEL_OSNET=$output_dir_osnet
export BATCH_SIZE=$bs
export DEV_ID0=$dev_id0
export DEV_ID1=$dev_id1 

python3 track.py --yolo-weights $model_file_yolov5 --strong-sort-weights $model_file_osnet --source $golden_dir/jiedao.mp4 --device cpu --show-vid

echo "======output images show, original result show in step 1_prepare.sh ======="