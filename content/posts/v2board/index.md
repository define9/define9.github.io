+++
title = "v2board docker的安装"
date = 2023-09-20T22:35:41+08:00
updated = 2023-09-23T09:32:15+08:00
path = "2023/09/20/v2board"

[taxonomies]
tags = ["教程"]
+++

## 环境

  * Ubuntu 20.04 纯净

## 过程

### 安装Docker与Docker Compose

```bash
# 使用一键脚本快速部署docker环境
curl -sSL https://get.docker.com/ | sh 
systemctl start docker 
systemctl enable docker

# 安装docker-compose
curl -L https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
```

### 拉取V2Board Docker

```bash
git clone https://github.com/hashcott/v2board-docker.git
cd v2board-docker/
git submodule update --init
echo '  branch = master' >> .gitmodules
git submodule update --remote
```

### 修改配置文件

分为修改`数据库配置`和`caddy配置`, 这里网上很多教程带过了

```bash
## 修改数据库信息, 修改 MYSQL_ROOT_PASSWORD(root密码) 和 MYSQL_DATABASE(数据库名)
vi docker-compose.yaml

## 修改caddy服务器配置, 把http(s)://domain, http和https的这俩domain改成你的域名
vi caddy.conf
```

### 启动v2board依赖的环境

```bash
docker-compose up -d
```

### 下载v2board并启动

```bash
## 进入刚刚启动的docker内环境, 以下指令都是在容器内执行
docker-compose exec www bash

## 下载composer.phar, 下载下来的是一个程序,网上好像有很多下载了承载页, 导致运行不了
wget https://getcomposer.org/installer -O composer.phar

php composer.phar
php composer.phar install

## 安装v2board
php artisan v2board:install

## 其中:
## 数据库地址： mysql
## 数据库名：(上面你修改的数据库名字 MYSQL_DATABASE)
## 数据库用户名：root
## 数据库密码：(上面你修改的数据库地址 MYSQL_ROOT_PASSWORD)
## 管理员邮箱: 输入你的邮箱
##
## 此时, 终端会打印 面板后台的地址, 例如:
## 一切就绪
## 管理员邮箱：xxxx@xx.com
## 管理员密码：xxxxxxxxxxxxxxxxxxxxx
## 访问 http(s)://你的站点/xxxx 进入管理面板，你可以在用户中心修改你的密码。

## 启动队列
php artisan horizon &
```

## 对接后端

### [XrayR __](https://xrayr-project.github.io/XrayR-doc/xrayr-xia-zai-he-an-zhuang/install/one-click.html)

#### 一键安装

```bash
bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)
```
