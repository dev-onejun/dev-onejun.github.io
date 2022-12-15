---
layout: post
title: "How to install ML Libraries with Conda"
subtitle: ""
categories: [Study/Artificial Intelligence]
tags: [tensorflow, pytorch, python, library, anaconda, conda]
comments: true
---

## Anaconda

1. Install Miniconda

``` bash
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

You can check various versions of miniconda on [here](https://docs.conda.io/en/latest/miniconda.html)

2. Create a Conda Environment

``` bash
conda create --name tensorflow python=3.9
```

3. GPU Setup with Conda

``` bash
conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0
```

You can check various repositories published for packages for packages on [here](https://anaconda.org/anaconda/repo)

4. Configure System Paths

``` bash
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
```

### Tensorflow

``` bash
pip install -U tensorflow
```

cf. You don't need to set all of these in this article, if you used [Docker](https://hub.docker.com/r/tensorflow/tensorflow/tags)

### Pytorch

``` bash
pip install -U torch torchvision torchaudio
```
