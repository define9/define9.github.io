---
title: "Hugo Page Bundles 使用指南"
date: 2026-03-24
draft: false
categories:
  - 技术
tags:
  - Hugo
  - 静态网站
cover: ./images/cover.png
description: "介绍 Hugo 的 Page Bundles 结构"
---

# Hugo Page Bundles 使用指南

Page Bundles 让文章和资源文件放在同一目录。

## 目录结构

```
content/posts/
├── 技术/
│   └── hugo-page-bundles/   ← 文章和图片在一起
│       ├── index.md
│       └── images/
└── 生活/
    └── 日常/
```

## 优势

1. **资源自包含** - 图片与文章同目录
2. **引用简单** - `![img](./images/xx.jpg)`
3. **URL 清晰** - `/posts/技术/hugo-page-bundles/`
