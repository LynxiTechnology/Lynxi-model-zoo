import sys
import numpy as np
from keras.models import load_model
import tensorflow as tf
import keras.backend as K

argc = len(sys.argv)

if argc != 3:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 3)    

model_file = sys.argv[1]
input_shape = tuple(map(int, sys.argv[2].split(",")))
inputs = np.random.uniform(0.0, 1.0, input_shape).astype('float32')

yolo_model = load_model(model_file.replace("weights", "h5"))
output0 = yolo_model.predict(inputs)[0]
output1 = yolo_model.predict(inputs)[1]

o1 = tf.keras.backend.flatten(output0)
o2 = tf.keras.backend.flatten(output1)
golden_output = K.concatenate([o1, o2])
k_output = K.eval(golden_output)

inputs.tofile('input.bin')
k_output.tofile('output.bin')