---
layout: post
title: "[Linux & Infra] Multipass"
subtitle: ""
categories: [Study/Linux & Infra]
tags: [Linux, ubuntu, Multipass]
comments: true
---

## Multipass

VM in Ubuntu

### How to install Multipass

1. `snap install multipass`
2. Make VM specifying name(-n) and memory(-m)
    `multipass launch -m 4Gb -n <vm-name>`
3. Enter to the VM
    `multipass shell <vm-name>`

- it installed automatically the latest version of ubuntu.

