---
title: "rm"
date: 2023-07-13T22:21:16+08:00
lastmod: 2023-07-22T01:46:03+08:00
slug: 2023/07/13/rm
tags: ["rm"]
---

# RoboMaster环境配置

两种方式 :

  * 方式一
    * **WSL**( Windows Subsystem for Linux )
    * **[MobaXterm __](https://mobaxterm.mobatek.net/)**(自带ui的终端软件, 用于imshow)
    * 缺陷 : 不能调用相机SDK
  * 方式二
    * **双系统ubuntu** [下载Ubuntu Tuna镜像源 __](https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/)[开源U盘启动器(Refus) __](http://rufus.ie/zh/)

**注意 : **

  * 在需要调试串口Robot 需要的串口接口
  * 安装时好看清输出信息, 理解至上

## **[OpenCV __](https://gitee.com/mirrors/opencv.git)**

```bash
# 安装g++ cmake ...

sudo apt update && sudo apt install -y cmake g++ wget unzip

# 安装依赖

sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

sudo apt-get install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev  ffmpeg libavcodec-dev libavformat-dev libswscale-dev libavutil-dev

sudo apt install libjasper1 libjasper-dev

# 下载 OpenCV, 这里应该注意版本, 可以切换分支

git clone https://gitee.com/mirrors/opencv.git

cd opencv

mkdir build

cd build

# 编译的时候开启相关设置

cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local  -D OPENCV_GENERATE_PKGCONFIG=ON -D WITH_FFMPEG=ON ..

# j后面为核数, nproc 指令可以查看, 尽量不要跑满, 

make -j 16

sudo make install
```

## 安装[googletest __](https://github.com/google/googletest)

```bash
# 下载

git clone https://github.com/google/googletest.git

cd googletest && mkdir build && cd build

cmake ..

make -j8

sudo make install
```

## **[spdlog __](https://github.com/gabime/spdlog)**

```bash
git clone https://github.com/gabime/spdlog.git

cd spdlog && mkdir build && cd build

cmake .. && make -j

sudo make install
```

## **[BehaviorTree.CPP __](https://github.com/BehaviorTree/BehaviorTree.CPP)**

```bash
# 需要安装Googletest再安装 行为树 : 

sudo apt-get install libzmq3-dev libboost-dev

git clone https://github.com/BehaviorTree/BehaviorTree.CPP.git

mkdir build; cd build

cmake ..

make

sudo make install
```
