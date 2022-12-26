---
layout: post
title: "Jupyter Notebook Settings"
subtitle: ""
categories: [Study/Artificial Intelligence]
tags:
comments: true
---

## Jupyter Notebook Extensions

### Installation

``` bash
pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install
```

### Extensions that I installed

1. Move selected cells
2. Tabnine
    - To use `Tabnine`, you should install some packages additionally.

    ``` bash
    pip install jupyter-tabnine --user
    jupyter nbextension install --py jupyter_tabnine --user
    jupyter nbextension enable --py jupyter_tabnine --user
    jupyter serverextension enable --py jupyter_tabnine --user
    ```

3. Code prettify
4. Notify
5. Snippets Menu
6. Tree Filter
7. ExecuteTime

- I am testing a extension, [jupyter-vim-binding](https://github.com/lambdalisue/jupyter-vim-binding) on my notebook.

### References

[Reference 1](https://www.tabnine.com/blog/top-12-jupyter-notebook-extensions/)
[Reference 2](https://www.tabnine.com/install/jupyternotebook)

## Running a public Jupyter Notebook with SSL/HTTPS

### Step by Step

1. Make a self-signed certificate with `openssl`

    ``` bash
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout mykey.key -out mycert.pem
    ```

2. Set jupyter notebook settings

    1. make config file with the following command

        ``` bash
        jupyter notebook --generate-config
        ```

        This will generate `jupyter_notebook_config.py` in the `~/.jupyter` directory.

    2. set appropriate value like below

        ``` python
        c.NotebookApp.certfile = u'/absolute/path/to/your/certificate/mycert.pem'
        c.NotebookApp.keyfile = u'/absolute/path/to/your/certificate/mykey.key'

        c.NotebookApp.ip = '*'
        c.NotebookApp.open_browser = False
        c.NotebookApp.port = 9999
        ```
