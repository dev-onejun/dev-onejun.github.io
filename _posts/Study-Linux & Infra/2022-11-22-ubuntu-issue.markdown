---
layout: post
title: "[Linux & Infra] ubuntu issues"
subtitle: ""
categories: [Study/Linux & Infra]
tags: [Linux, ubuntu]
comments: true
---

## Issues

### Ubuntu 22.04.01 LTS

#### Video Related Issue

There is a video related issue in ubuntu 22.04.01 version.\
Video Recording is continuously stopped using the program such as screencast (ubuntu standard video recording program) and Peek (making gif file)\
There are some solutions, but it does not solved the problem.\

##### First Solution

``` bash
rm -rf ~/.cache/gstreamer-1.0
```

##### Second Solution

``` bash
sudo apt reinstall gstreamer1.0-pipewire
```

#### Application caffeine error

The application `caffeine` emitted an error on every boot.\
The error messages are like below.
![caffeine error](/assets/img/ubuntu-issue/caffeine-error.png)

##### Solution

It was because my computer was not installed `python3-tk` apt packages.\
I don't know exactly that the package `python3-tk` was not installed only on my computer.\
Anyway, the solution is simple.

``` bash
apt install python3-tk
```
