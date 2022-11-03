import torch
import numpy as np
import sys
from unet import UNet

argc = len(sys.argv)
if argc != 3:
    print('usage: python3 generate.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))

data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')
net = UNet(n_channels=3, n_classes=2, bilinear=False)
net.load_state_dict(torch.load(model_file, map_location=torch.device("cpu")))
net.eval()
with torch.no_grad():
    output = net(torch.from_numpy(data))

    data.transpose(0,2,3,1).astype("float16").tofile('input.bin')
    output.detach().numpy().astype("float16").tofile('output.bin')   