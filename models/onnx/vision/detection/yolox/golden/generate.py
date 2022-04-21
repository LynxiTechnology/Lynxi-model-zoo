import sys
import torch
import numpy as np
import onnxruntime

argc = len(sys.argv)
if argc != 3:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
onnx_input_shape = tuple(map(int, sys.argv[2].split(",")))

input = np.random.uniform(0.0, 1.0, onnx_input_shape).astype('float32')
session = onnxruntime.InferenceSession(model_file)
ort_inputs = {session.get_inputs()[0].name: input}
inname = [input.name for input in session.get_inputs()]

output1 = session.run(None, ort_inputs)

input.tofile('input.bin')
np.array(output1).tofile('output.bin')
