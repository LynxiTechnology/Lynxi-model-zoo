import sys
import numpy as np
import lynpy

def lyn_loss(golden, sample):
    # return np.sqrt(
    #             np.sum( (np.float32(sample)-np.float32(golden))**2 ) \
    #             / np.sum( np.float32(golden)**2 )
    #         )

    # mean absolute error rate
    return np.mean(
                np.abs(
                    (np.float32(sample)-np.float32(golden)) \
                    / np.float32(golden)
                )
            )

def mse_loss(golden, sample):
    return ((np.float32(sample)-np.float32(golden))**2).mean()

def infer(model_path, data):
    model = lynpy.Model(path=model_path)
    input = model.input_tensor()
    input.from_numpy(data).apu()
    output = model(input).cpu()
    return output.numpy()

def run(model_path, golden_in, golden_out, numpy_dtype):
    test_data = np.fromfile(golden_in, dtype=np.dtype(numpy_dtype))
    golden = np.fromfile(golden_out,  dtype=np.dtype(numpy_dtype))
    sample = infer(model_path, test_data)

    sample.dtype = np.dtype(numpy_dtype)
    loss = lyn_loss(golden, sample)

    print(f'=======test done, loss({loss})=======')


argc = len(sys.argv)
if argc != 5:
    print('usage: python3 verify.py <model_path> <golden_input> <golden_output> <numpy_dtype>')
    assert(argc == 5)
else:
    run(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])