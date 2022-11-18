import torch 
import lyngor as lyn 
from model import *
import sys 

argc = len(sys.argv)
if argc != 4:
    print('usage: python3 convert.py <model_file> <input_shapes> <output_dir>')
    assert(argc == 4)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))
output_dir = sys.argv[3]

if  "sarn_fuse_se_all.pth" in model_file:
    sarn_net = SARNet_fuse_se_all()  
    sarn_net.load_state_dict(torch.load(model_file, map_location='cpu'))  # weights
    sarn_net.eval()
 
elif "sarn_fuse_se_all_bam.pth" in model_file:
    sarn_net = SARNet_fuse_se_all_bam() 
    sarn_net.load_state_dict(torch.load(model_file, map_location='cpu'))  # weights
    sarn_net.eval()

with torch.no_grad():
    # start build model（use lyngor 1.3.0） 
    mod = lyn.DLModel()
    mod.load(sarn_net, model_type="Pytorch", inputs_dict={"data":input_shapes},
                in_type="float16",
                out_type="float16")   
    offline_builder = lyn.Builder(target="apu")
    offline_builder.build(mod.graph, mod.params, out_path=output_dir, build_mode="auto")   
    print(' === build model build end! save out_path is ', output_dir)