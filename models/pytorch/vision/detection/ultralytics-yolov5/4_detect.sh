#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH
python3 $source_dir/lyndetect.py --weights $output_dir/Net_0 --project result

echo "======output images to result/ folder, original result in golden folder======="