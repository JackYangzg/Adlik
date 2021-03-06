# Adlik

[![Build Status](https://dev.azure.com/Adlik/GitHub/_apis/build/status/Adlik.Adlik?branchName=master)](https://dev.azure.com/Adlik/GitHub/_build/latest?definitionId=1&branchName=master)
[![Tests](https://img.shields.io/azure-devops/tests/Adlik/GitHub/1/master)](https://dev.azure.com/Adlik/GitHub/_build/latest?definitionId=1&branchName=master)
[![Coverage](https://img.shields.io/azure-devops/coverage/Adlik/GitHub/1/master)](https://dev.azure.com/Adlik/GitHub/_build/latest?definitionId=1&branchName=master)
[![Bors enabled](https://bors.tech/images/badge_small.svg)](https://app.bors.tech/repositories/20625)

***Adlik*** [ædlik] is an end-to-end optimizing framework for deep learning models. The goal of Adlik is to accelerate deep
learning inference process both on cloud and embedded environment.

![Adlik schematic diagram](resources/arch.PNG)

With Adlik framework, different deep learning models can be deployed to different platforms with high performance in a
much flexible and easy way.

![Using Adlik to Deploy Models in Cloud/Edge/Device](resources/deployment.PNG)

1. In cloud environment, the compiled model and Adlik Inference Engine should be built as a docker image, and deployed
as a container.

2. In edge environment, Adlik Inference Engine should be deployed as a container. The compiled model should be transferred
to edge environment, and the Adlik Inference Engine should automatically update and load model.

3. In device environment, Adlik Inference Engine and the compiled model should be compiled into a binary file (***so***
or ***lib***). Users who want to run model inference on device should link user defined AI function and Adlik binary
file to the execution file, and run directly.

## Inference performance of Adlik

We test the inference performance of Adlik on the same CPU or GPU using
the simple cnn model (mnist model) and the resnet50 model with different runtimes. The CPU and GPU parameters used in
the test are as follows:

|     |                   type                    | number |
| --- | :---------------------------------------: | :----: |
| CPU | Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz |   1    |
| GPU |           Tesla V100 SXM2 32GB            |   1    |

### The test result of the mnist model

|                      | speed of client (pictures/sec) | speed of serving engine (pictures/sec) | tail latency of one picture (sec) |
| -------------------- | :----------------------------: | :------------------------------------: | :-------------------------------: |
| keras-tf1.14         |            2200.372            |                2291.584                |             1.81E-05              |
| keras-tf2.1          |            2003.901            |                2077.644                |             1.77E-05              |
| keras-OpenVINO       |            2647.344            |                2788.087                |             1.90E-05              |
| keras-TensorRT       |           37342.687            |               163058.592               |             2.06E-05              |
| keras-tfGPU1.14      |           19414.208            |               52247.525                |             3.24E-05              |
| keras-tfGPU2.1       |           19395.129            |               53640.456                |             3.29E-05              |
| keras-TFLiteCPU      |            778.890             |                790.150                 |             1.82E-05              |
| tensorflow-tf1.14    |            1486.878            |                1531.337                |             1.95E-05              |
| tensorflow-tf2.1     |            2160.331            |                2248.311                |             1.81E-05              |
| tensorflow-tfGPU1.14 |           19043.582            |               51448.587                |             3.31E-05              |
| tensorflow-tfGPU2.1  |           19244.343            |               50705.164                |             3.22E-05              |
| tensorflow-TFLiteCPU |            3114.246            |                3250.399                |             1.34E-05              |
| pytorch-OpenVINO     |            9053.677            |               10226.869                |             1.27E-05              |
| pytorch-TensorRT     |           46318.234            |               249302.706               |             1.76E-05              |

>Note
>
>>i. In the first column of the table, words before '-' represent different runtimes, and words after '-' represent
>different inference engines.
>>
>>ii. The tf and OpenVINO serving engine are test in the CPU environment, and the TensorRT and tfGPU serving engine are
>test in the GPU environment.
>>
>>iii. The test model of TensorFlow Lite is an unquantified model, and the number of threads is set to 1 during testing.

### The test result of the resnet50 model

|                      | speed of client (pictures/sec) | speed of serving engine (pictures/sec) | tail latency of one picture (sec) |
| -------------------- | :----------------------------: | :------------------------------------: | :-------------------------------: |
| keras-tf1.14         |             3.599              |                 3.640                  |              0.00311              |
| keras-tf2.1          |             6.183              |                 6.301                  |              0.00302              |
| keras-OpenVINO       |             9.359              |                 9.642                  |              0.00313              |
| keras-TensorRT       |            237.176             |                1402.338                |              0.00350              |
| keras-tfGPU1.14      |            175.423             |                433.627                 |              0.00339              |
| keras-tfGPU2.1       |            170.680             |                420.814                 |              0.00348              |
| keras-TFLiteCPU      |             2.838              |                 2.862                  |              0.00298              |
| tensorflow-tf1.14    |             3.669              |                 3.711                  |              0.00305              |
| tensorflow-tf2.1     |             6.554              |                 6.684                  |              0.00298              |
| tensorflow-tfGPU1.14 |            181.118             |                454.013                 |              0.00331              |
| tensorflow-tfGPU2.1  |            176.710             |                473.091                 |              0.00354              |
| tensorflow-TFLiteCPU |             2.870              |                 2.895                  |              0.00296              |
| pytorch-OpenVINO     |             9.274              |                 9.552                  |              0.00313              |
| pytorch-TensorRT     |            238.244             |                1332.449                |              0.00344              |

## Contents

### [Model Optimizer](https://github.com/Adlik/model_optimizer/blob/master/README.md)

***Model optimizer*** focuses on specific hardware and runs on it to achieve acceleration.  The proposed
framework mainly consists of two categories of algorithm components, i.e. pruner and quantizer.

### [Model compiler](model_compiler/README.md)

***Model compiler*** supports several optimizing technologies like pruning, quantization and structural compression,
which can be easily used for models developed with TensorFlow, Keras, PyTorch, etc.

### [Serving Engine](adlik_serving/README.md)

***Serving Engine*** provides deep learning models with optimized runtime based on the deployment environment. Put
simply, based on a deep learning model, the users of Adlik can optimize it with model compiler and then deploy it to a
certain platform with Adlik serving platform.

## Build

This guide is for building Adlik on [Ubuntu](https://ubuntu.com) systems.

First, install [Git](https://git-scm.com/download) and [Bazel](https://docs.bazel.build/install.html).

Then, clone Adlik and change the working directory into the source directory:

```sh
git clone https://github.com/ZTE/Adlik.git
cd Adlik
```

### Build clients

1. Install the following packages:
   - `python3-setuptools`
   - `python3-wheel`
2. Build clients:

   ```sh
   bazel build //adlik_serving/clients/python:build_pip_package -c opt
   ```

3. Build pip package:

   ```sh
   mkdir /tmp/pip-packages && bazel-bin/adlik_serving/clients/python/build_pip_package /tmp/pip-packages
   ```

### Build serving

First, install the following packages:

- `automake`
- `libtbb2`
- `libtool`
- `make`
- `python3-six`

#### Build serving with OpenVINO runtime

1. Install `intel-openvino-runtime-ubuntu<OS_VERSION>-<VERSION>` package from
   [OpenVINO](https://docs.openvinotoolkit.org/2020.3/_docs_install_guides_installing_openvino_apt.html).
2. Assume the installation path of OpenVINO is `/opt/intel/openvino_VERSION`, run the following command:

   ```sh
   export INTEL_CVSDK_DIR=/opt/intel/openvino_VERSION
   export InferenceEngine_DIR=$INTEL_CVSDK_DIR/deployment_tools/inference_engine/share
   bazel build //adlik_serving \
       --config=openvino \
       -c opt
   ```

#### Build serving with TensorFlow CPU runtime

Run the following command:

```sh
bazel build //adlik_serving \
    --config=tensorflow-cpu \
    -c opt
```

#### Build serving with TensorFlow GPU runtime

Assume builing with CUDA version 10.2.

1. Install the following packages from
   [here](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu-installation) and
   [here](https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html#ubuntu-network-installation):

   - `cuda-cufft-dev-10-2`
   - `cuda-cupti-dev-10-2`
   - `cuda-curand-dev-10-2`
   - `cuda-cusolver-dev-10-2`
   - `cuda-cusparse-dev-10-2`
   - `libcublas-dev=10.2.*`
   - `libcudnn7=*+cuda10.2`
   - `libcudnn7-dev=*+cuda10.2`
2. Run the following command:

   ```sh
   env TF_CUDA_VERSION=10.2 \
       bazel build //adlik_serving \
           --config=tensorflow-gpu \
           -c opt \
           --incompatible_use_specific_tool_files=false
   ```

#### Build serving with TensorFlow Lite CPU runtime

Run the following command:

```sh
bazel build //adlik_serving \
    --config=tensorflow-lite-cpu \
    -c opt
```

#### Build serving with TensorRT runtime

Assume building with CUDA version 10.2.

1. Install the following packages from
   [here](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#ubuntu-installation) and
   [here](https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html#ubuntu-network-installation):

   - `cuda-cufft-10-2`
   - `cuda-cupti-dev-10-2`
   - `cuda-curand-10-2`
   - `cuda-cusolver-10-2`
   - `cuda-cusparse-10-2`
   - `cuda-nvml-dev-10-2`
   - `cuda-nvrtc-10-2`
   - `libcublas-dev=10.2.*`
   - `libcudnn7=*+cuda10.2`
   - `libcudnn7-dev=*+cuda10.2`
   - `libnvinfer7=*+cuda10.2`
   - `libnvinfer-dev=*+cuda10.2`
   - `libnvonnxparsers7=*+cuda10.2`
   - `libnvonnxparsers-dev=*+cuda10.2`
2. Run the following command:

   ```sh
   env TF_CUDA_VERSION=10.2 \
       bazel build //adlik_serving \
           --config=tensorrt \
           -c opt \
           --action_env=LIBRARY_PATH=/usr/local/cuda-10.2/lib64/stubs \
           --incompatible_use_specific_tool_files=false
   ```

### Build in Docker

The `ci/docker/build.sh` file can be used to build a Docker images that contains all the requirements for building
Adlik. You can build Adlik with the Docker image.

>Note: If you build the runtime with GPU in a Docker image, you need to add the CUDA environment variables in the
>Dockerfile, such as:
>
>```dockerfile
>ENV NVIDIA_VISIBLE_DEVICES all
>ENV NVIDIA_DRIVER_CAPABILITIES compute, utility
>```

## Getting Started

- [Tutorials](TUTORIALS.md)

- [Samples](examples)

### Release

The version of the service engine adlik supports.

|            | TensorFlow 1.14 | TensorFlow 2.1 | OpenVINO 2020 | Tensorrt 6 | Tensorrt 7 |
| ---------- | :-------------: | :------------: | :-----------: | :--------: | :--------: |
| keras      |        ✓        |       ✓        |       ✓       |     ✓      |     ✓      |
| TensorFlow |        ✓        |       ✓        |       ✓       |     ✓      |     ✓      |
| PyTorch    |        ✗        |       ✗        |       ✓       |     ✓      |     ✗      |

## License

Apache License 2.0
