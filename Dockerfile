FROM python:3

# Install deps
RUN apt update && apt install -y --no-install-recommends git libgtest-dev cmake wget unzip libtinfo-dev libz-dev \
     libcurl4-openssl-dev libopenblas-dev g++ sudo python3-dev

# Build gtest
RUN cd /usr/src/gtest && cmake CMakeLists.txt && make && cp *.a /usr/lib

# LLVM
RUN echo deb http://apt.llvm.org/buster/ llvm-toolchain-buster-8 main \
     >> /etc/apt/sources.list.d/llvm.list && \
     wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - && \
     apt-get update && apt-get install -y llvm-8

# Build TVM
RUN cd /usr && git clone --depth=1 https://github.com/dmlc/tvm --recursive
WORKDIR /usr/tvm
RUN bash -c \
     "echo set\(USE_LLVM llvm-config-8\) >> config.cmake && \
     echo set\(USE_SORT ON\) >> config.cmake && \
     echo set\(USE_GRAPH_RUNTIME ON\) >> config.cmake && \
     echo set\(USE_BLAS openblas\) >> config.cmake && \
     mkdir -p build && \
     cd build && \
     cmake .. && \
     make -j10"
ENV PYTHONPATH=/usr/tvm/python:/usr/tvm/topi/python:/usr/tvm/nnvm/python/:/usr/tvm/vta/python:${PYTHONPATH}

# Basic deps, deep learning frameworks, and jupyter notebook.
# TODO(jknight) how many of these are necessary?
RUN pip3 install numpy pytest cython decorator scipy && \
     mxnet tensorflow keras gluoncv dgl

# RUN pip3 install matplotlib Image Pillow jupyter[notebook]

WORKDIR /root
CMD ["bash"]
