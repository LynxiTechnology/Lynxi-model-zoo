import torch
import numpy as np
import sys
from basicsr.archs.rrdbnet_arch import RRDBNet

argc = len(sys.argv)
if argc != 3:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))

data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')
model = RRDBNet(num_in_ch=3, num_out_ch=3, num_feat=64, num_block=6, num_grow_ch=32, scale=4)  
loadnet = torch.load(model_file, map_location=torch.device('cpu'))     # weights
if 'params_ema' in loadnet:
    keyname = 'params_ema'
else:
    keyname = 'params'
model.load_state_dict(loadnet[keyname], strict=True)
model.eval()
model = model.to("cpu")

out = model(torch.from_numpy(data))
data.tofile('input.bin')
out.detach().numpy().tofile('output.bin')   