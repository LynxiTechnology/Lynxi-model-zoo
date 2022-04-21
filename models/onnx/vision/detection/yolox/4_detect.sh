#!/bin/bash

cd ../../../../../ && source envsetup.sh && cd -
source setting.cfg

export PYTHONPATH=$MODEL_ZOO_TOOLS:$PYTHONPATH

python3 $source_dir/lyndetect.py -s 0.3 --input_shape $onnx_input_shapes --image_path $source_dir/assets/dog.jpg --model $output_dir/Net_0

echo "======output images to demo_output, original result in golden folder======="
