import sys
import torch
import numpy as np
import onnxruntime
from yolox.exp import get_exp
import torch.nn as nn
from yolox.utils import postprocess

argc = len(sys.argv)
if argc != 3:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
exp = get_exp(exp_name="yolox-s")
model = exp.get_model()
model.eval()
ckpt = torch.load(model_file, map_location="cpu")
model.load_state_dict(ckpt["model"])
model.head.decode_in_inference = False
input_shape = tuple(map(int, sys.argv[2].split(",")))
input = np.random.uniform(0.0, 1.0, input_shape).astype('float32')
x = torch.ones(input_shape)
outputs = model(x)
input.tofile('input.bin')
np.array(outputs.detach()).tofile('output.bin')