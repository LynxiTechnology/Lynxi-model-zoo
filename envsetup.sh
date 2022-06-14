#!/bin/bash

# SHELL_FOLDER=$(dirname $(readlink -f "$0"))
SHELL_FOLDER=$(pwd)

export MODEL_ZOO_ROOT=$SHELL_FOLDER
export MODEL_ZOO_TOOLS=$MODEL_ZOO_ROOT/common
export MODEL_VERIFY=$MODEL_ZOO_TOOLS/verify.py
export PERF_TOOL=$MODEL_ZOO_TOOLS/lynperf.py