---
title: "手机查看自身热点IP"
date: 2023-07-13T22:35:41+08:00
lastmod: 2026-01-10T00:16:34+08:00
slug: 2023/07/13/showMeIP
aliases: ["/2023/07/13/showMeIP/"]
tags: ["魔改"]
---

v2ray梯子可以局域网共享，这样其他设备就可以科学上网，但在热点共享的时候需要填手机ip和端口，获取ip可以有一下几种方式，端口看提示socks5默认10808

#### **命令行**

随便进入一个终端，比如 Termux 输入ifconfig，没有工具会提示安装

#### **android App**

随便写几行代码，编译打包App

源代码: [define9/AndroidTools at v0.1 ( __](https://github.com/define9/AndroidTools/tree/v0.1)github.com[) __](https://github.com/define9/AndroidTools/tree/v0.1)

编译好的APP [Release v0.1 AndroidTools ( __](https://github.com/define9/AndroidTools/releases/tag/v0.1)github.com[) __](https://github.com/define9/AndroidTools/releases/tag/v0.1)

本来以为v2rayN开源直接魔改，结果由于一些原因作者不开了，等以后有精力一定搞自己的APP

#### 2023/06/05更新

由于, [ClashForAndroid __](https://github.com/define9/ClashForAndroid)这个GUI软件开源(好像作者不怎么更新了), 那不就正好fork魔改一下嘛…

修改后的代码: [https://github.com/define9/ClashForAndroid __](https://github.com/define9/ClashForAndroid)
