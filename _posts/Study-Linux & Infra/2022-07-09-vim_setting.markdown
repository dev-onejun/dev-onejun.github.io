---
layout: post
title: "[VIM] VIM Setting"
subtitle: ""
categories: [Study/Linux & Infra]
tags: [Linux, ubuntu, ubuntu server, VIM]
comments: true
---

## Javascript Settings

- [how to set vim for nodejs developer](https://www.google.com/search?q=how+to+setting+vim+for+nodejs+developer&oq=how+to+setting+vim+for+nodejs+developer&aqs=chrome..69i57.5175j0j9&sourceid=chrome&ie=UTF-8)
  - [Configuring Vim for NodeJs Development](https://theselfhostingblog.com/posts/configuring-vim-for-node-js-development/)
  - [A guide to setting up Vim for Javascript Development](https://freshman.tech/vim-javascript/)
- [Turning vim into a javscript IDE](https://maxim-danilov.github.io/vim-to-js-ide/)

## Python Settings

- [what i used](https://realpython.com/vim-and-python-a-match-made-in-heaven/)
- [else..](https://www.fullstackpython.com/vim.html)
\
You can make if-elif block with the two codes below.

### conda virtual environment

``` vim
" Python Virtual Environment Support
python3 << EOF
import os
import subprocess

if "CONDA_PREFIX" in os.environ:
  project_base_dir = os.environ["CONDA_PREFIX"]
  script = os.path.join(project_base_dir, "bin/activate")
  pipe = subprocess.Popen(". %s; env" % script, stdout=subprocess.PIPE, shell=True)
  output = pipe.communicate()[0].decode('utf8').splitlines()
  env = dict((line.split("=", 1) for line in output))
  os.environ.update(env)

EOF
```

### venv virtual environment

``` vim
" Python Virtual Environment Support
python3 << EOF
import os
import subprocess

if "VIRTUAL_ENV" in os.environ:
    project_base_dir = os.environ["VIRTUAL_ENV"]
    script = os.path.join(project_base_dir, "bin/activate")
    pipe = subprocess.Popen(". %s; env" % script, stdout=subprocess.PIPE, shell=True)
    output = pipe.communicate()[0].decode('utf8').splitlines()
    env = dict((line.split("=", 1) for line in output))
    os.environ.update(env)

EOF
```

## My Current .vimrc Settings

<script src="https://gist.github.com/dev-onejun/0513c8e0a3fb9607b3f8c7a5d3411401.js"></script>
