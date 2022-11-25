#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

cd $source_dir && python3 detect_one_abc.py --output $golden_dir
echo "====== output detection to golden_dir, original result is golden/demo.jpg ======="