#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

cd $source_dir
export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH
python3 $source_dir/predict_lynxi.py --model $model_file -i $golden_dir/car_256.jpg -o $golden_dir/car_apu.jpg 

echo "======output images to golden/car_apu.jpg, original result in golden folder======="