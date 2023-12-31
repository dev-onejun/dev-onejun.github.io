---
layout: post
title: "[Raspberry Pi] A Network Configuration Issue During its First Installation"
subtitle: ""
categories: [Study/Linux & Infra]
tags: [Raspberry Pi, ubuntu server]
comments: true
---

## Problem Descriptions

I bought a Raspberry Pi to replace a previous VPN machine which stopped working in recent months. However, I encountered a network issue while I installed and configured Ubuntu 22.04 on the board. I tried to connect the Pi to the Internet with its LAN port in the following environments:

* Raspberry Pi 4 Model B (1GB)
* Ubuntu Server 22.04.3 LTS
* Edited wifi-configuration to use the initial Internet connection with the Pi-Imager
* Directly linked to the Internet modem with a CAT7 cable

## Step by Step

### 1

The LAN port, eth0, was not active at the first boot.

``` bash
$ ip a
…
Eth0: <BROADCAST, MULTICAST>
…
```

In order to enable the interface,

``` bash
$ ip link set up dev eth0
```

was required.

The goal of this step is

``` bash
$ ip a
…
Eth0: <BROADCAST, MULTICAST, UP, LOWER_UP>
…
```

Although this makes the Pi machine connect to the Internet with the physical cable, the configuration resets after rebooting.

### 2

The network configuration process during booting was required to update. `/etc/netplan/00-installer-config.yaml` was written as

``` yaml
# manual configuration file
network:
  ethernets:
    eth0:
      dhcp4: true
```

And `netplan apply` or rebooting was entailed to apply this change.

### 3

The wifi connection was still active after rebooting. A similar process like _2_ was needed to permanently disable the connection which was automatically on. I changed the file name, `/etc/netplan/50-cloud-init.yaml` which configured the network setting of the board while its booting as `_50-cloud-init.yaml.wifi-enabled.backup`.

## Solutions

Update or make the file, `/etc/netplan/00-installer-config.yaml`

``` yaml
# manual configuration file
network:
  ethernets:
    eth0:
      dhcp4: true
```

and run the command `netplan apply`.

## Conclusions

The problem occurred since the ethernet connection was not automatically active. With the updates in the configuration files during booting, the board connected to the Internet with the physical LAN cable.

## References

[1] [https://community.element14.com/products/raspberry-pi/f/forum/19194/ethernet-not-working-on-rpi---my-fault-or-the-pi-s](https://community.element14.com/products/raspberry-pi/f/forum/19194/ethernet-not-working-on-rpi---my-fault-or-the-pi-s)\
[2] [https://askubuntu.com/questions/1025008/ipv6-is-working-but-ipv4-isnt](https://askubuntu.com/questions/1025008/ipv6-is-working-but-ipv4-isnt)\
[3] [https://superuser.com/questions/1479454/disable-wifi-auto-connect-on-ubuntu-linux#:~:text=1%20Answer&text=Open%20Network%20Manager%2C%20click%20on,that%20says%20%22Connect%20Automatically%22](https://superuser.com/questions/1479454/disable-wifi-auto-connect-on-ubuntu-linux#:~:text=1%20Answer&text=Open%20Network%20Manager%2C%20click%20on,that%20says%20%22Connect%20Automatically%22)

