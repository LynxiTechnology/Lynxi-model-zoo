#!/bin/bash
source setting.cfg
cd ../../../../../ && source envsetup.sh && cd -

# export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH

cd $source_dir
python3 lyninference.py ../golden

echo "======output images to result/ folder, original result in golden folder======="