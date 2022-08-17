#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH

cd $source_dir
python3 eval_image_lyn.py --image cat.jpg

echo "======output detection to print info, original result in prepare result======="