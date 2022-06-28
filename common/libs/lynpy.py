# -*- coding: utf-8 -*-
"""
============================================================
© 2018 北京灵汐科技有限公司 版权所有。
* 注意：
以下内容均为北京灵汐科技有限公司原创，
未经本公司允许，不得转载，否则将视为侵权；
对于不遵守此声明或者其他违法使用以下内容者，
本公司依法保留追究权。

© 2018 Lynxi Technologies Co., Ltd. All rights reserved.
* NOTICE:
All information contained here is,
and remains the property of Lynxi.
This file can not be copied or distributed without
the permission of Lynxi Technologies Co., Ltd.
============================================================

@file: lynpy.py
@author: huangfei.xiao@lynxi.com

"""

import sys
sys.path.append('/usr/lib')

import pylynchipsdk as sdk
import numpy as np


SDK_DTYPE = {
    sdk.lyn_data_type_t.DT_INT8: 'int8',
    sdk.lyn_data_type_t.DT_UINT8: 'uint8',
    sdk.lyn_data_type_t.DT_INT32: 'int32',
    sdk.lyn_data_type_t.DT_UINT32: 'uint32',
    sdk.lyn_data_type_t.DT_FLOAT: 'float32',
    sdk.lyn_data_type_t.DT_FLOAT16: 'float16',
}

class Tensor(object):
    '''lynpy.Tensor is a common data object which used to manage the data on device memory.
    '''

    def __init__(self, dev_id=0, size=0, allocate=True):
        """init function.

        Parameters
        ----------
        dev_id : int32
            set which the device to be used.

        size : int32
            the tensor size in bytes.

        allocate : True or False
            True, will allcate device memory when create tensor.
            False, allcate when tensor.apu(), or can set tensor.devptr manually.
        """
        super(Tensor, self).__init__()
        self.__numpydata = None
        self.devptr = None
        self.__child = False
        self.data_size = size
        self.dev_id = dev_id

        ##
        # from numpy
        self.shape = None
        self.dtype = None
        self.size = 0
        self.itemsize = 0

        self.context, ret = sdk.lyn_create_context(self.dev_id)
        assert ret == 0

        ##
        # for split case, not need to allocate device memory
        if (self.data_size != 0) and (allocate == True):
            self.devptr, ret = sdk.lyn_malloc(self.data_size)
            assert ret == 0

    def __del__(self):
        if (self.devptr != None) and (self.__child == False):
            sdk.lyn_set_current_context(self.context)
            sdk.lyn_free(self.devptr)
        self.__numpydata = None
        self.devptr = None
        self.data_size = 0

        sdk.lyn_destroy_context(self.context)

    def __str__(self):
        msg = 'Tensor: {} {} \n{}'.format(
                self.__numpydata.shape,
                self.__numpydata.dtype,
                str(self.__numpydata))
        return msg

    def __update_numpydata_info(self):
        self.shape = self.__numpydata.shape
        self.dtype = self.__numpydata.dtype
        self.size = self.__numpydata.size
        self.itemsize = self.__numpydata.itemsize

    def from_numpy(self, data):
        """set tensor.apu() source data or tensor.cpu() destination data.

        Parameters
        ----------
        data : numpy.ndarray or List[numpy.ndarray]

        Returns
        -------
        Tensor : reference to self.
        """
        total_size = 0
        self.__numpydata = []

        if isinstance(data, list):
            for d in data:
                assert isinstance(d, np.ndarray)

                if d.flags["C_CONTIGUOUS"] == False:
                    self.__numpydata.append(np.ascontiguousarray(d))
                else:
                    self.__numpydata.append(d)

                total_size = total_size + d.size * d.itemsize
        elif isinstance(data, np.ndarray):
            if data.flags["C_CONTIGUOUS"] == False:
                self.__numpydata = np.ascontiguousarray(data)
            else:
                self.__numpydata = data

            total_size = data.size * data.itemsize
            self.__update_numpydata_info()
        else:
            assert 0

        if self.data_size == 0:
            self.data_size = total_size

        assert self.data_size == total_size, 'required {}, input {}'.format(self.data_size, total_size)
        return self

    def view_as(self, shape, dtype='float32'):
        """change the view of data shape/dtype, will not change the data in memory.

        Parameters
        ----------
        shape : Tuple

        dtype : numpy.dtype

        Returns
        -------
        Tensor : reference to self.
        """
        if self.__numpydata is None:
            data = np.empty(shape, dtype=dtype)
            assert self.data_size == data.size * data.itemsize, 'required {}, input {}'.format(self.data_size, data.size * data.itemsize)
            self.__numpydata = data
        else:
            # force convert
            self.__numpydata.dtype = dtype
            self.__numpydata.shape = shape

        self.__update_numpydata_info()
        return self

    def numpy(self):
        '''return the numpy object'''
        return self.__numpydata

    def cpu(self):
        '''copy data from server to device'''
        assert self.data_size != 0
        assert self.devptr != None

        if self.__numpydata is None:
            self.__numpydata = np.empty(self.data_size, dtype=np.byte)
            self.__update_numpydata_info()

        sdk.lyn_set_current_context(self.context)

        if isinstance(self.__numpydata, np.ndarray):
            assert 0 == sdk.lyn_memcpy(sdk.lyn_numpy_to_ptr(self.__numpydata),
                                self.devptr, self.data_size,
                                sdk.lyn_memcpy_dir_t.ServerToClient)
        else: # numpy list
            offset = 0
            for d in self.__numpydata:
                size = d.size * d.itemsize
                assert 0 == sdk.lyn_memcpy(sdk.lyn_numpy_to_ptr(d),
                                sdk.lyn_addr_seek(self.devptr, offset),
                                size,
                                sdk.lyn_memcpy_dir_t.ServerToClient)
                offset = offset + size

                assert offset > self.data_size # overflow

        return self

    def apu(self):
        '''copy data from device to server'''
        assert self.data_size != 0
        assert self.__numpydata is not None

        sdk.lyn_set_current_context(self.context)

        if self.devptr == None:
            self.devptr, ret = sdk.lyn_malloc(self.data_size)
            assert ret == 0

        if isinstance(self.__numpydata, np.ndarray):
            assert 0 == sdk.lyn_memcpy(self.devptr,
                            sdk.lyn_numpy_to_ptr(self.__numpydata),
                            self.data_size,
                            sdk.lyn_memcpy_dir_t.ClientToServer)
        else: # numpy list
            offset = 0
            for d in self.__numpydata:
                size = d.size * d.itemsize
                assert 0 == sdk.lyn_memcpy(sdk.lyn_addr_seek(self.devptr, offset),
                                sdk.lyn_numpy_to_ptr(d),
                                size,
                                sdk.lyn_memcpy_dir_t.ClientToServer)
                offset = offset + size

        return self

    def split(self, size_list):
        """split a tensor to tensor list.

        Parameters
        ----------
        size_list : List[int32]
            a list of size in bytes

        Returns
        -------
        Tensor : List[Tensor]
        """
        assert self.devptr != None

        result = []
        offset = 0

        if self.__numpydata is not None:
            data = self.__numpydata.flatten()
            data.dtype = np.int8

        for size in size_list:
            if offset + size > self.data_size:
                break

            new_obj = Tensor(dev_id=self.dev_id, size=size, allocate=False)
            new_obj.devptr = sdk.lyn_addr_seek(self.devptr, offset)
            new_obj.__child = True

            if self.__numpydata is not None:
                new_obj = new_obj.from_numpy(data[offset:offset+size])
            result.append(new_obj)

            offset = offset + size

        if offset < self.data_size:
            size = self.data_size - offset
            new_obj = Tensor(dev_id=self.dev_id, size=size, allocate=False)
            new_obj.devptr = sdk.lyn_addr_seek(self.devptr, offset)
            new_obj.__child = True

            if self.__numpydata is not None:
                new_obj = new_obj.from_numpy(data[offset:])
            result.append(new_obj)

        return result

    def copy_to(self, to, stream=None):
        """copy data to another tensor. support copy tensor over device.

        Parameters
        ----------
        stream : sdk stream object
            if stream not none, will use asynchronous copy method.
            will be ignored when copy tensor over device
        """
        assert self.data_size == to.data_size, 'required {}, input {}'.format(self.data_size, to.data_size)
        assert self.devptr != None and to.devptr != None

        if self.dev_id == to.dev_id:
            sdk.lyn_set_current_context(self.context)

            if stream == None:
                assert 0 == sdk.lyn_memcpy(to.devptr, self.devptr, self.data_size,
                                sdk.lyn_memcpy_dir_t.ServerToServer)
            else:
                assert 0 == sdk.lyn_memcpy_async(stream, to.devptr, self.devptr, self.data_size,
                                sdk.lyn_memcpy_dir_t.ServerToServer)

            if self.__numpydata is not None:
                to.from_numpy(self.__numpydata)
        else:
            self.cpu()
            to.from_numpy(self.__numpydata)
            to.apu()

class Model(object):
    '''lynpy.Model is a module to do inference.
    '''
    def __init__(self, dev_id=0, path=None, stream=None, sync=True):
        """init function.

        Parameters
        ----------
        dev_id : int32
            set which the device to be used.

        path : str
            the model file path.

        stream : sdk stream object
            if not set, will create a default stream.
            also can use the others stream by Model.stream.

        sync : True or False
            True, blocking wait the infering done.
            False, should call Model.synchronize() before accsess output data.
        """
        super(Model, self).__init__()
        self.path = path
        self.dev_id = dev_id
        self.sync = sync
        self.stream = stream
        self.model = None
        self.__input = None
        self.__output = None
        self.__input_list = None
        self.__output_list = None
        self.input_size = 0
        self.output_size = 0
        self.batch_size = 0
        self.__model_desc = None

        self.context, ret = sdk.lyn_create_context(self.dev_id)
        assert ret == 0

        if self.stream == None:
            self.stream, ret = sdk.lyn_create_stream()
            assert ret == 0

        if self.path != None:
            self.load()

    def __del__(self):
        self.unload()
        sdk.lyn_destroy_stream(self.stream)
        sdk.lyn_destroy_context(self.context)

    def __call__(self, input, output=None):
        '''do infering'''
        return self.infer(input, output)

    def load(self, path=None):
        '''load model from file'''
        if self.path == None:
            self.path = path
        assert self.path != None

        sdk.lyn_set_current_context(self.context)
        self.model, ret = sdk.lyn_load_model(self.path)
        assert ret == 0

        self.__model_desc, ret = sdk.lyn_model_get_desc(self.model)
        self.batch_size = self.__model_desc.inputTensorAttrArray[0].batchSize

        self.input_size, ret = sdk.lyn_model_get_input_data_total_len(self.model)
        self.output_size, ret = sdk.lyn_model_get_output_data_total_len(self.model)

        self.input_size *= self.batch_size
        self.output_size *= self.batch_size

    def unload(self):
        '''unload model'''
        if self.model != None:
            sdk.lyn_set_current_context(self.context)
            sdk.lyn_unload_model(self.model)
            self.model = None

    def infer(self, input: Tensor, output: Tensor=None) -> Tensor:
        '''do infering, can set output tensor or create automatic'''
        assert self.model != None
        assert input.data_size == self.input_size, 'required {}, input {}'.format(self.data_size, input.data_size)

        self.__input = input
        if output is not None:
            assert output.data_size == self.output_size, 'required {}, input {}'.format(self.output_size, output.data_size)
            self.__output = output
        elif self.__output is None:
            self.__output = Tensor(dev_id=self.dev_id, size=self.output_size)

        sdk.lyn_set_current_context(self.context)
        assert 0 == sdk.lyn_execute_model_async(self.stream, self.model,
                                            self.__input.devptr, self.__output.devptr,
                                            self.batch_size)

        if self.sync == True:
            assert 0 == sdk.lyn_synchronize_stream(self.stream)

        return self.__output

    def synchronize(self):
        '''blocking wait for infering done'''
        sdk.lyn_set_current_context(self.context)
        assert 0 == sdk.lyn_synchronize_stream(self.stream)

    def output_tensor(self):
        if self.__output is None:
            self.__output = Tensor(dev_id=self.dev_id, size=self.output_size)
        return self.__output

    def input_tensor(self):
        if self.__input is None:
            self.__input = Tensor(dev_id=self.dev_id, size=self.input_size)
        return self.__input

    def output_list(self):
        """get output tensors as a list, view as below:

            [batch0][tensor0, tensor1, ..., tensorX]
            [batch1][tensor0, tensor1, ..., tensorX]
            ...
            [batchN][tensor0, tensor1, ..., tensorX]

        Note:
            output_list() tensors will keep the latest value with output_tensor() at device memory,
            but the different value at host memory, you should use cpu() to synchronize data before access
        """
        if self.__output_list is None:
            self.__output_list = []

            if self.batch_size == 1:
                batch_list = [self.output_tensor()]
            else:
                split_size = []
                for i in range(self.batch_size):
                    split_size.append(self.__model_desc.outputDataLen)
                batch_list = self.output_tensor().split(split_size)

            shape_list = []
            dtype_list = []
            tensor_size = []
            tensor_num = self.__model_desc.outputTensorAttrArrayNum
            for i in range(tensor_num):
                shape, ret = sdk.lyn_model_get_output_tensor_dims_by_index(self.model, i)
                dtype = self.__model_desc.outputTensorAttrArray[i].dtype
                size = self.__model_desc.outputTensorAttrArray[i].dataLen
                shape_list.append(shape)
                dtype_list.append(SDK_DTYPE[dtype])
                tensor_size.append(size)

            for batch in batch_list:
                tensor_list = batch.split(tensor_size)
                for i in range(tensor_num):
                    tensor_list[i].view_as(shape=shape_list[i], dtype=dtype_list[i])

                self.__output_list.append(tensor_list)

        return self.__output_list

    def input_list(self):
        """get input tensors as a list, view as below:

            [batch0][tensor0, tensor1, ..., tensorX]
            [batch1][tensor0, tensor1, ..., tensorX]
            ...
            [batchN][tensor0, tensor1, ..., tensorX]

        Note:
            input_list() tensors will keep the latest value with input_tensor() at device memory,
            but the different value at host memory, you should use cpu() to synchronize data before access
        """
        if self.__input_list is None:
            self.__input_list = []

            if self.batch_size == 1:
                batch_list = [self.input_tensor()]
            else:
                split_size = []
                for i in range(self.batch_size):
                    split_size.append(self.__model_desc.inputDataLen)
                batch_list = self.input_tensor().split(split_size)

            shape_list = []
            dtype_list = []
            tensor_size = []
            tensor_num = self.__model_desc.inputTensorAttrArrayNum
            for i in range(tensor_num):
                shape, ret = sdk.lyn_model_get_input_tensor_dims_by_index(self.model, i)
                dtype = self.__model_desc.inputTensorAttrArray[i].dtype
                size = self.__model_desc.inputTensorAttrArray[i].dataLen
                shape_list.append(shape)
                dtype_list.append(SDK_DTYPE[dtype])
                tensor_size.append(size)

            for batch in batch_list:
                tensor_list = batch.split(tensor_size)
                for i in range(tensor_num):
                    tensor_list[i].view_as(shape=shape_list[i], dtype=dtype_list[i])

                self.__input_list.append(tensor_list)

        return self.__input_list