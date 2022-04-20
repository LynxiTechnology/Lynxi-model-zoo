import numpy as np
import sys
import tensorflow as tf
from tensorflow.python.platform import gfile

argc = len(sys.argv)

if argc != 3:
    print('usage: python3 verify.py <model_file> <input_shapes>')
    assert(argc == 3)

model_file = sys.argv[1]
input_shapes = tuple(map(int, sys.argv[2].split(",")))

data = np.random.randint(0, 256, input_shapes).astype('float32')

#inference by tensorflow model
config = tf.ConfigProto()
sess = tf.Session(config=config)
with gfile.FastGFile(model_file, 'rb') as f:
    
    graph_def = tf.GraphDef()
    graph_def.ParseFromString(f.read())
    sess.graph.as_default()
    tf.import_graph_def(graph_def, name='')
    opname = [tensor.name for tensor in tf.get_default_graph().as_graph_def().node] 

x = tf.get_default_graph().get_tensor_by_name("inputs:0")   
pred = tf.get_default_graph().get_tensor_by_name("output_boxes:0") 
pre = sess.run(pred, feed_dict={x:data})

data.tofile('input.bin')
pre.tofile('output.bin')