import torch
import numpy as np
import sys
from model import *

argc = len(sys.argv) 
if argc != 3:
    print('usage: python3 generate.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))

input_data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')

if  "sarn_fuse_se_all.pth" in model_file:
    sarn_net = SARNet_fuse_se_all()  
    sarn_net.load_state_dict(torch.load(model_file, map_location='cpu'))  # weights
    sarn_net.eval()
    with torch.no_grad():
        out = sarn_net(torch.from_numpy(input_data))

        input_data.astype("float16").tofile('input_sarn_fuse_se_all.bin')
        out.numpy().astype("float16").tofile('output_sarn_fuse_se_all.bin')   
        print(" === save  sarn_fuse_se_all golden success ===") 

if "sarn_fuse_se_all_bam.pth" in model_file:
    sarn_net = SARNet_fuse_se_all_bam() 
    sarn_net.load_state_dict(torch.load(model_file, map_location='cpu'))  # weights
    sarn_net.eval()
    with torch.no_grad():
        out = sarn_net(torch.from_numpy(input_data))

        input_data.astype("float16").tofile('input_sarn_fuse_se_all_bam.bin')
        out.numpy().astype("float16").tofile('output_sarn_fuse_se_all_bam.bin')    
        print(" === save  sarn_fuse_se_all_bam golden success ===") 

