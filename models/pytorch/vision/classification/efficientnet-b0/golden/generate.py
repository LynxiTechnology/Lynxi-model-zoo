import sys
import torch
import numpy as np
from efficientnet_pytorch import EfficientNet

argc = len(sys.argv)
if argc != 3:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
model = EfficientNet.from_pretrained(model_file)
input_shape = tuple(map(int, sys.argv[2].split(",")))
input = np.random.uniform(0.0, 1.0, input_shape).astype('float32')
model.eval()
with torch.no_grad():
    outputs = model(torch.from_numpy(input))
input.tofile('input.bin')
np.array(outputs.detach()).tofile('output.bin')
