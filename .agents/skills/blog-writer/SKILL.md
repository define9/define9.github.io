---
name: blog-writer
description: 自动生成 Hugo 博客文章。当用户想要写博客、写文章、创建博客文章、基于某个主题写一篇文章时触发。也适用于"帮我写一篇关于X的文章"、"生成一篇博客"等请求。这是一个写博客的专用工具。
---

# Blog Writer - Hugo 博客文章生成器

## 项目结构

当前 Hugo 博客采用 **Page Bundles** 结构：

```
content/posts/
├── 技术/                    ← 分类（目录名）
│   └── hugo-page-bundles/  ← 文章名（目录名）
│       ├── index.md         ← 文章内容
│       └── images/          ← 文章图片目录
└── 杂谈/
    └── exeLaunchFail/
        ├── index.md
        └── images/
```

## 工作流程

### 1. 确认文章信息

向用户收集以下信息（如果用户未提供）：
- **主题/话题**：文章要写什么
- **分类**：现有分类有 `技术`、`杂谈`，或指定新分类
- **标签**：1-3 个标签（可选）
- **文章名**：用于目录命名（可选，默认用主题生成）

### 2. 生成文章

#### 目录结构
- 文章目录：`content/posts/{分类}/{文章名}/`
- 图片目录：`content/posts/{分类}/{文章名}/images/`
- 文章文件：`content/posts/{分类}/{文章名}/index.md`

#### Frontmatter 模板

```yaml
---
title: "{文章标题}"
date: {当前日期，格式: YYYY-MM-DD}
draft: true
categories:
  - {分类}
tags:
  - {标签1}
  - {标签2}
cover: ./images/cover.png
description: "{简短描述，30字以内}"
---

# {文章标题}

{正文内容...}
```

#### 文章存放位置

**必须**在博客仓库中创建文章文件，路径为：
```
content/posts/{分类}/{文章名}/index.md
```

例如：`content/posts/技术/git-workflow/index.md`

同时创建图片目录：
```
content/posts/{分类}/{文章名(英文文件夹)}/images/
```

#### 内容要求

1. **语言**：使用中文撰写
2. **风格**：技术类文章清晰简洁、图文并茂；杂谈类文章轻松自然
3. **结构**：包含多级标题（##、###），适当使用列表
4. **图片**：优先使用 `mmx image generate` 生成配图，保存到 images 目录
5. **AI 生成声明**：文章末尾**必须**添加 AI 生成声明：

```markdown
---
*本文由 AI 生成，如有疏漏请留言指正。*
---
```

#### 图片生成

使用 `mmx image generate` 命令生成文章配图：

```bash
mmx image generate --prompt "<图片描述>" --out-dir <图片目录> --out-prefix <图片名前缀>
```

**策略**：
- 每篇文章生成 **2-4 张核心配图**（封面 + 章节图）
- 在文章开头、重要章节之间添加图片
- 图片描述要具体，包含风格、构图等细节

**图片描述技巧**：
- ✅ "简洁的技术示意图，显示 AI 代理协作流程图，深色背景"
- ❌ "一张图"

**Markdown 引用**：
```markdown
![封面](./images/cover.png)
![任务分解](./images/task-decomposition.png)
```

### 3. 创建文件

1. 创建文章目录和图片目录
2. 使用 `mmx image generate` 生成配图，保存到 images 目录
3. 写入 `index.md` 文件（引用生成的图片）
4. 设置 `draft: true`（默认草稿），让用户确认后再发布

## 示例

**用户请求**：「帮我写一篇关于 Git 工作流的博客」

**执行步骤**：
1. 确认分类：`技术`
2. 确认标签：`Git`、`版本控制`
3. 生成简短的文章名：`git-workflow`
4. **创建目录**：`content/posts/技术/git-workflow/`
5. **创建图片目录**：`content/posts/技术/git-workflow/images/`
6. **生成配图**：
   - 封面图：`mmx image generate --prompt "Git 工作流图解，多分支示意图" --out-dir content/posts/技术/git-workflow/images/ --out-prefix cover`
   - 章节图：`mmx image generate --prompt "代码合并流程图，简化风格" --out-dir content/posts/技术/git-workflow/images/ --out-prefix merge-flow`
7. **写入文件**：`content/posts/技术/git-workflow/index.md`（引用图片：`![封面](./images/cover.png)`）
8. 设置 `draft: true`，提示用户预览后再发布

## 注意事项

- **必须**在实际博客目录创建文件，不要输出到临时目录
- 文章名使用英文或拼音（避免中文目录名）
- 日期使用当前日期
- draft 默认为 true，生成后提示用户预览和发布
- 如果文章涉及 OpenCode 相关内容，agent 名称使用正确的命名：
  - `task()` 函数（不是 `call_omo_agent`）
  - `explore`、`librarian`、`oracle`（不是探索/图书管理员/预言家代理）