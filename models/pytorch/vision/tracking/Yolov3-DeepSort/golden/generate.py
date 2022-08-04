import torch
import sys
import numpy as np

sys.path.append('../deep_sort_pytorch/thirdparty/fast-reid')

argc = len(sys.argv)
if argc != 5:
    print('usage: python3 generate.py <yolo_model_file> <track_model_file> <yolo_input_shapes> <track_input_shapes>')
    assert(argc == 5)

yolo_model_file = sys.argv[1]
track_model_file = sys.argv[2]
yolo_input_shapes = tuple(map(int, sys.argv[3].split(",")))
track_input_shapes = tuple(map(int, sys.argv[4].split(",")))

yolo_input = torch.rand(yolo_input_shapes)
track_input = torch.rand(track_input_shapes)

yolo_model = torch.load(yolo_model_file)
track_model = torch.load(track_model_file)
yolo_model.eval()
track_model.eval()
y_out0, y_out1, y_out2 = yolo_model(yolo_input)
track_out = track_model(track_input)

yolo_input.numpy().tofile('yolo_input.bin')
track_input.numpy().tofile('track_input.bin')

tmp = np.append(y_out0.detach().numpy().flatten(), y_out1.detach().numpy().flatten())
yolo_out = np.append(tmp, y_out2.detach().numpy().flatten())

yolo_out.tofile('yolo_out.bin')
track_out.detach().numpy().tofile('track_out.bin')