import torch 
import lyngor as lyn 
from basicsr.archs.rrdbnet_arch import RRDBNet
import sys 

argc = len(sys.argv)
if argc != 4:
    print('usage: python3 convert.py <model_file> <input_shapes> <output_dir>')
    assert(argc == 4)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))
output_dir = sys.argv[3]

# convert weights to map
model = RRDBNet(num_in_ch=3, num_out_ch=3, num_feat=64, num_block=6, num_grow_ch=32, scale=4)  
loadnet = torch.load(model_file, map_location=torch.device('cpu'))     # weights
if 'params_ema' in loadnet:
    keyname = 'params_ema'
else:
    keyname = 'params'
model.load_state_dict(loadnet[keyname], strict=True)
model.eval()
model = model.to("cpu")

# start build model（use lyngor 1.0.5.0） 
mod = lyn.DLModel()
mod.load(model, model_type="Pytorch", inputs_dict={"data":input_shapes})   
offline_builder = lyn.Builder(target="apu")
offline_builder.build(mod.graph, mod.params, out_path=output_dir)