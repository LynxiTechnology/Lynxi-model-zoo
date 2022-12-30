import numpy as np 
import sys 
from models.mobilenet import mobilenet
import torch 

argc = len(sys.argv)
if argc != 3:
    print('usage: python3 generate.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))

input_data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')
input_data = torch.from_numpy(input_data)

net = mobilenet()
net.load_state_dict(torch.load(model_file, map_location=torch.device("cpu")))
net.eval()
with torch.no_grad():
    out = net(input_data)

    input_data.numpy().astype("float16").transpose(0,2,3,1).tofile('input.bin')
    out.numpy().astype("float16").tofile('output.bin') 
    print("===== generate input.bin and output.bin done! =====")    