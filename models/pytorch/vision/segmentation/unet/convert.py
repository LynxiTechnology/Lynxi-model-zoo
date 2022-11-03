import torch 
import lyngor as lyn 
import sys 
from unet import UNet

argc = len(sys.argv)
if argc != 4:
    print('usage: python3 convert.py <model_file> <input_shapes> <output_dir>')
    assert(argc == 4)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))
output_dir = sys.argv[3]

# convert weights to map
net = UNet(n_channels=3, n_classes=2, bilinear=False)
net.load_state_dict(torch.load(model_file, map_location=torch.device("cpu")))
net.eval()
with torch.no_grad():
    # start build model 
    mod = lyn.DLModel()
    mod.load(net, model_type="Pytorch", inputs_dict={"data":input_shapes},
                in_type="float16",
                out_type="float16",
                transpose_axis=[(0,3,1,2)])   
    offline_builder = lyn.Builder(target="apu")
    offline_builder.build(mod.graph, mod.params, out_path=output_dir)