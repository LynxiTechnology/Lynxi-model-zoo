import numpy as np 
import sys 
import caffe

argc = len(sys.argv)
if argc != 4:
    print('usage: python3 generate.py <model_file> <model_weights> <input_shapes>')
    assert(argc == 4)

model_file = sys.argv[1]
model_weights = sys.argv[2]
input_shapes = tuple(map(int, sys.argv[3].split(",")))

caffe.set_mode_cpu()
net = caffe.Net(model_file, model_weights, caffe.TEST)

input_data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')
net.blobs['data'].data[...] = input_data

out = net.forward() 
out_list = [out["layer82-conv"], out["layer94-conv"], out["layer106-conv"]]

input_data.transpose(0,2,3,1).astype("float16").tofile('input.bin')
out_all = np.concatenate([i.flatten() for i in out_list])   # 3个结果合并在一起
out_all.astype("float16").tofile('output.bin') 
print(" === save yolov3 caffe golden success ===")    