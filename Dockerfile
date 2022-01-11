FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Install apt-getable dependencies
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        cmake \
        git \
        libeigen3-dev \
        libopencv-dev \
        libceres-dev \
        python3-dev \
        python3-numpy \
        python3-opencv \
        python3-pip \
        python3-pyproj \
        python3-scipy \
        python3-yaml \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY . /source/OpenSfM

WORKDIR /source/OpenSfM

RUN pip3 install -r requirements.txt \
  && python3 setup.py build \
  && ./viewer/node_modules.sh \
  && bin/opensfm_run_all data/berlin
#   && bin/opensfm_run_all data/lund
#   && bin/opensfm_run_all data/test

CMD ["python3", "viewer/server.py", "-d", "data", "-p", "9000"]

