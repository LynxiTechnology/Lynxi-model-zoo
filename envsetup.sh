#!/bin/bash

# SHELL_FOLDER=$(dirname $(readlink -f "$0"))
SHELL_FOLDER=$(pwd)

export MODEL_ZOO_ROOT=$SHELL_FOLDER

# for tools
export MODEL_ZOO_TOOLS=$MODEL_ZOO_ROOT/common/tools
export MODEL_VERIFY=$MODEL_ZOO_TOOLS/verify.py
export PERF_TOOL=$MODEL_ZOO_TOOLS/lynperf.py

# for libs
export MODEL_ZOO_LIBS=$MODEL_ZOO_ROOT/common/libs
export PYTHONPATH=$MODEL_ZOO_LIBS:$PYTHONPATH