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

    [Reference](https://www.tabnine.com/install/jupyternotebook)
3. Code prettify
4. Notify
5. Snippets Menu
6. Tree Filter
7. ExecuteTime

- I am testing a extension, [jupyter-vim-binding](https://github.com/lambdalisue/jupyter-vim-binding) on my notebook.

### References

[Reference 1](https://www.tabnine.com/blog/top-12-jupyter-notebook-extensions/)
