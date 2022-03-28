import numpy as np
import onnxruntime

data = np.random.uniform(0.0, 1.0, (1, 3, 224, 224)).astype('float32')
sess = onnxruntime.InferenceSession('../resnet50.onnx')
out, = sess.run(None, {"inputs": data})

data.tofile('batch1_input.bin')
out.tofile('batch1_output.bin')