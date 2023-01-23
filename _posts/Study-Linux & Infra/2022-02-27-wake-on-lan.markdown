---
layout: post
title: "[Linux & Infra] wake-on-lan"
subtitle: "Last Update: 2023-01-23 MON"
categories: [Study/Linux & Infra]
tags: [Linux, Ubuntu, wake-on-lan]
comments: true
---

## Wake On Lan

Finally, I solved the problem partially that I could not use `wake on lan` before.

### 1. find required information with the following command

``` bash
ifconfig
ethtool <Your ethernet interface name>
which ethtool
```

### 2. make the file `wol.service` at `/etc/systemd/system/` and the contents are followed

``` systemd
[Unit]
Description=Enable Wake On Lan

[Service]
Type=oneshot
ExecStart = <Your ethtool filepath> --change <Your ethernet interface name> wol g

[Install]
WantedBy=basic.target
```

<details markdown=1><summary markdown="span">skip this step</summary>

### 3. add the following line at `/etc/init.d/halt`

``` config
NETDOWN=no
```

</details>

### 4. run the following command

``` bash
sudo systemctl daemon-reload
sudo systemctl enable wol.service
```

### 5. turn off the computer as `sudo systemctl suspend`

You should check your motherboard or networkcard that supports wake-on-lan while in shutdown state,
if you want to use `shutdown` command to power off the computer.

### 6. use `wakeonlan` as broadcasting

``` bash
apt install wakeonlan
wakeonlan <Your mac address>
```

Note that if you didn't specify ip address with `-i` option, the packet is broadcasted.

## The reason that I think this is an half-measure

The `wakeonlan` command was not working when I used as `wakeonlan -i <ip address> <mac address>`.\
But the computer turned on when I made the packet broadcast.\
I think that because the client that I made packet uses the same router, the broadcasting packet works.\
In other words, It won't work if I used another clients outside.\
\+ However, I have a question about that is it okay the computer can be on by the internet traffic as the perspectives of secure.

## Reference

- [Reference 1](https://www.maketecheasier.com/enable-wake-on-lan-ubuntu/#faqs507099)
- [Reference 2](http://ubuntuguide.net/remotely-turn-on-ubuntu-from-lan)
- [Reference 3](https://developer-kus.tistory.com/4)
- [Reference 4](https://necromuralist.github.io/posts/enabling-wake-on-lan/)

### init.d and systemd

- [Reference 5](https://mamu2830.blogspot.com/2021/07/init-systemd-difference.html)

### ChatGPT

Although I got an information about wake-on-lan in Reference 1~4 too, there was an information hard to search.
However I'm really surprised that ChatGPT made me get a required narrow personalized information.
