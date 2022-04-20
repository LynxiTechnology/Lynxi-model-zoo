#!/bin/bash
source setting.cfg

export PYTHONPATH=$source_dir:$PYTHONPATH

#convert darknet to tensorflow
python3 $source_dir/convert_weights_pb.py --class_names $source_dir/cfg/coco.names --weights_file $model_file --data_format NHWC --output_graph $converted_model

cd $cur_dir

export PYTHONPATH=$cur_dir:$PYTHONPATH

echo "======Compiling model by Lyngor======="

model_compile -f Tensorflow -m $converted_model --input_shapes "$input_shapes" --input_nodes "inputs" --output "$output_dir"

