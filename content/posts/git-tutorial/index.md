---
title: "git-tutorial"
date: 2023-07-13T22:37:10+08:00
lastmod: 2024-10-16T21:32:56+08:00
slug: 2023/07/13/git-tutorial
tags: ["教程"]
---

## **Git使用**

#### **Git提交本地代码**

  * 先去 gitee 新建仓库, 添加一个README使其有master分支
  * 在本地里

```bash
git init # 初始化本地的 git 仓库

git remote add origin http://*.git # 添加 第一步初始化的网站

git pull origin master # pull更新 下载README文件

# 如果 pull 更新成功, 则表示已建立连接 

  

git add . # 添加文件

git commit -m "first push" # commit 附带信息

git push origin master # push 提交
```

#### **Git版本回退**

```bash
git log # 查看历史commit, 并记录地址

git reset --hard address # address为 git log中的目标地址

git push -f # 强制提交, 如果提示分支请按需添加 比如: git push -f origin master
```

#### **Git添加第三方库**

```bash
mkdir third_party # 新建第三方库文件夹

git submodule add url



# 新库更新 submodule 更新 初始化 递归

git submodule update --init --recursive
```

#### **Git新建分支**

分置内容 [强烈推荐知乎 __](https://zhuanlan.zhihu.com/p/47841635)

```bash
git branch dev # 新建dev分支

git checkout dev # 切换到dev分支

# dev分支测试完成后

git checkout master # 切换回master分支

git merge dev       # git merge 命令用于合并指定分支到当前分支

git branch -d dev   # 删除dev分支



git push origin --delete dev # 删除远程分支dev
```

更多Git待更新 …
