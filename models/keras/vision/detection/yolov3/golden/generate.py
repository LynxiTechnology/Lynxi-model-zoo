import numpy as np
import sys
from keras.models import load_model

argc = len(sys.argv) 
if argc != 3:
    print('usage: python3 generate.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))

input_data = np.random.uniform(0.0, 1.0, input_shapes).astype('float32')
model = load_model(model_file, compile=False) 
out = model.predict(input_data)                        # keras forward ---          

input_data.astype("float16").tofile('input.bin')
out_all = np.concatenate([i.flatten() for i in out])   # 3个结果合并在一起
out_all.astype("float16").tofile('output.bin') 
print(" === save keras yolov3 golden success ===") 

