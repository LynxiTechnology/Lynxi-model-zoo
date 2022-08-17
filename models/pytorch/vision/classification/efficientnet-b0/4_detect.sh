#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH

python3 $source_dir/lyndetect.py -m $output_dir/Net_0 -p $source_dir/examples/simple/img2.jpg -i $input_shapes -l $source_dir/examples/simple/labels_map.txt -s 1000

echo "====== lynxi classification result ======="
