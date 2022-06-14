import lynpy
import sys
from numpy.random import rand
import pylynchipsdk as sdk

argc = len(sys.argv)
if argc < 3:
    print('usage: python3 lynperf.py <model path> <repeat count> [device id]')
    exit(1)

model_path = sys.argv[1]
repeat_count = int(sys.argv[2])
device_id = 0

if argc == 4:
    device_id = int(sys.argv[3])

# use async mode
model = lynpy.Model(path=model_path, dev_id=device_id, sync=False)
input = model.input_tensor()
data = rand(input.data_size).astype('uint8')
input.from_numpy(data)

start_event,ret = sdk.lyn_create_event()
end_event,ret = sdk.lyn_create_event()

# skip the first frame time, which has special time cost
model(input.apu()).cpu()

sdk.lyn_record_event(model.stream, start_event)
for i in range(repeat_count):
    # model(input)
    model(input.apu()).cpu()
sdk.lyn_record_event(model.stream, end_event)

# wait for all task done
model.synchronize()

time_cost, ret = sdk.lyn_event_elapsed_time(start_event, end_event)
time_cost /= 1000 # ms to s

print(f'===run {repeat_count} times cost {time_cost}s, frame rate {repeat_count/time_cost}fps===')