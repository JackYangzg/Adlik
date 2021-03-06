FROM ubuntu:bionic
RUN apt-get update && \
    apt-get install --no-install-recommends -y ca-certificates && \
    apt-get clean && \
    find /var/lib/apt/lists -delete

RUN . /etc/os-release && \
    apt-get update && \
    apt-get install --no-install-recommends -y gnupg && \
    apt-key adv --fetch-keys \
        https://apt.repos.intel.com/openvino/2020/GPG-PUB-KEY-INTEL-OPENVINO-2020 \
        https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg && \
    apt-get autoremove --purge -y gnupg && \
    apt-get clean && \
    find /var/lib/apt/lists -delete

RUN . /etc/os-release && \
    echo "deb https://apt.repos.intel.com/openvino/2020 all main\n\
deb https://storage.googleapis.com/bazel-apt stable jdk1.8" >> /etc/apt/sources.list

RUN . /etc/os-release && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        automake \
        bazel \
        patch \
        git \
        make \
        intel-openvino-runtime-ubuntu18-2020.3.194 \
        intel-openvino-dev-ubuntu18-2020.3.194 \
        libtbb2 \
        libtool \
        python3-setuptools \
        python3-wheel \
        python3.7-dev \
        python3-six \
        python3-pip && \
    apt-get clean && \
    find /var/lib/apt/lists -delete


RUN useradd -m john

USER john

WORKDIR /home/john

RUN bazel version

