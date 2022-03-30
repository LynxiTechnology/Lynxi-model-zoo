import numpy as np
import onnxruntime
import sys

argc = len(sys.argv)
if argc != 3:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))

data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')
sess = onnxruntime.InferenceSession(model_file)
out, = sess.run(None, {"inputs": data})

data.tofile('input.bin')
out.tofile('output.bin')