#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH

cd $cur_dir && python3 eval_image_lynxi.py --image ./golden/bird.jpg
echo "======output detection to print info, original result in prepare result======="