#!/bin/bash

set -ex

NCCL_VERSION=""
if [[ ${CUDA_VERSION:0:2} == "11" ]]; then
  NCCL_VERSION="v2.21.5-1"
elif [[ ${CUDA_VERSION:0:2} == "12" ]]; then
  NCCL_VERSION="v2.26.2-1"
fi

if [[ -z "$NCCL_VERSION" ]]; then
  git clone -b $NCCL_VERSION --depth 1 https://github.com/NVIDIA/nccl.git
  cd nccl && make -j src.build
  cp -a build/include/* /usr/local/cuda/include/
  cp -a build/lib/* /usr/local/cuda/lib64/
  cd ..
  rm -rf nccl
  ldconfig
fi
