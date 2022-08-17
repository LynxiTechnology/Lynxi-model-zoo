import torch
import numpy as np
import sys

argc = len(sys.argv)
if argc != 5:
    print('usage: python3 generate.py <model_file1> <input_shapes1> <model_file2> <input_shapes2>')
    assert(argc == 5)

# generate yolov5s model
from models.experimental import attempt_load  
model_file_yolov5 = sys.argv[1]
input_shapes_yolov5 = tuple(map(int, sys.argv[2].split(",")))      

data_yolov5 = np.random.uniform(0.0, 1.0, input_shapes_yolov5).astype('float32')          # yolov5s input float32 data
model_yolov5 = attempt_load(model_file_yolov5, device="cpu", inplace=False, fuse=False)
model_yolov5.eval()

out_yolov5 = model_yolov5(torch.from_numpy(data_yolov5))
data_yolov5.tofile('../golden/input_yolov5.bin')
out_yolov5[0].detach().numpy().tofile('../golden/output_yolov5.bin')       


# generate osnet model 
sys.path.insert(0, "Yolov5_StrongSORT_OSNet/strong_sort")
from strong_sort.deep.reid.torchreid.models import build_model
from strong_sort.deep.reid.torchreid.utils import load_pretrained_weights
model_file_osnet = sys.argv[3]
input_shapes_osnet = tuple(map(int, sys.argv[4].split(",")))          

data_osnet = np.random.uniform(-3.0, 3.0, input_shapes_osnet).astype('float32')             # osnet input float32 data
model_osnet = build_model(
                "osnet_x0_25",
                num_classes=1,
                pretrained=False,
                use_gpu=False
                )
model_osnet.eval()
load_pretrained_weights(model_osnet, model_file_osnet)
with torch.no_grad():
    out_osnet = model_osnet(torch.from_numpy(data_osnet))
    data_osnet.tofile('../golden/input_osnet.bin')
    out_osnet.detach().numpy().tofile('../golden/output_osnet.bin')  



