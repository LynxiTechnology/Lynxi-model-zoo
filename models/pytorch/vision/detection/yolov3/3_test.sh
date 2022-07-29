#!/bin/bash
source setting.cfg

cd ../../../../../ && source envsetup.sh && cd -

echo "*********** Detection error：***********"
python3 "$MODEL_VERIFY" "$yolo_compiled/Net_0" $golden_yolo_i $golden_yolo_o "float32"

