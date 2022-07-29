import numpy as np 
import sys 
import caffe

argc = len(sys.argv)
if argc != 4:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 4)

model_file = sys.argv[1]
model_weights = sys.argv[2]
input_shapes = tuple(map(int, sys.argv[3].split(",")))

caffe.set_mode_cpu()
net = caffe.Net(model_file, model_weights, caffe.TEST)

input_data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')
net.blobs['data'].data[...] = input_data

out = net.forward()['prob']

input_data.tofile('input.bin')
out.tofile('output.bin')   