#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

cd $source_dir && python3 yolo_video.py --image --input $golden_dir/mot15.jpg --output $golden_dir/apu.jpg
echo "======output images to golden/apu.jpg, original result in golden folder======="