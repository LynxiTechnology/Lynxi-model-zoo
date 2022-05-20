#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

cd $source_dir
export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH
python3 $source_dir/inference_realesrgan.py -n RealESRGAN_x4plus_anime_6B -i $golden_dir/wolf_gray.jpg --fp32 -o $source_dir

echo "======output images to Real-ESRGAN/ folder, original result in golden folder======="