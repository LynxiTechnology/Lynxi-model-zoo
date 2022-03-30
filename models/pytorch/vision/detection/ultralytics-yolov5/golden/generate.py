import torch
import numpy as np
import sys
from models.experimental import attempt_load

argc = len(sys.argv)
if argc != 3:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))

print(input_shapes)

data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')
model = attempt_load(model_file, map_location='cpu', inplace=False, fuse=False)
out, _ = model(torch.from_numpy(data))

data.tofile('input.bin')
out.numpy().tofile('output.bin')