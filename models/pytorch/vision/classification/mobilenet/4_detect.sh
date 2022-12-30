#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH

python3 $source_dir/test_lynxi.py -net mobilenet -weights $model_file -b 1
echo "======output detection to print info, original result in 1.prepare.sh result======="