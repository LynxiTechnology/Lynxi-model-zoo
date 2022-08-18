import sys 
import numpy as np
import lynpy

argc = len(sys.argv)
if argc != 6:
    print('usage: python3 test.py <model_path> <golden_input> <golden_output> <input_shapes> <numpy_dtype>')
    assert(argc == 6)

numpy_dtype = sys.argv[5]
input_shape = tuple(map(int, sys.argv[4].split(","))) 


def lyn_loss(golden, sample):
    return np.sqrt(
                np.sum( (np.float32(sample)-np.float32(golden))**2 ) \
                / np.sum( np.float32(golden)**2 )
            )


def infer(model_path, data):
    model = lynpy.Model(path=model_path)
    input = model.input_tensor().from_numpy(data).apu()
    output = model(input).cpu().numpy()
    return output


def run():
    test_data = np.fromfile(sys.argv[2], dtype=np.dtype(numpy_dtype))
    model_data = test_data.reshape(input_shape)    # add 
    model_data = np.ascontiguousarray(model_data.transpose(0,2,3,1)).astype("float16")
    golden = np.fromfile(sys.argv[3],  dtype=np.dtype(numpy_dtype))

    sample = infer(sys.argv[1], model_data)
    sample.dtype = np.dtype("float16")              # add 
    loss = lyn_loss(sample, golden)
    print(f'=======[run_yolov5] test done, loss({loss})=======')


# 测试误差率 -----------------
run()