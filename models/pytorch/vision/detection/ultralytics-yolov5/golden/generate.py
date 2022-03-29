import torch
import numpy as np
from models.experimental import attempt_load

data = np.random.uniform(0.0, 1.0, (1, 3, 640, 640)).astype('float32')
# model = torch.load('../yolov5s.pt', map_location='cpu')
model = attempt_load('../yolov5s.pt', map_location='cpu', inplace=False, fuse=False)
out, _ = model(torch.from_numpy(data))

data.tofile('batch1_input.bin')
out.numpy().tofile('batch1_output.bin')