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
- 图片描述要具体、详细、富有视觉表现力

**图片提示词模板**（详细版）

```
[主体描述], [构图方式], [视觉风格], [光线氛围], [色彩方案], [细节要求], [比例/尺寸]
```

**各部分说明**：

| 组成部分 | 示例 | 说明 |
|---------|------|------|
| 主体描述 | "一个机器人正在处理代码文件" | 明确画面核心内容 |
| 构图方式 | "居中构图，45度俯视视角" | 或"鸟瞰视角"、"侧面特写" |
| 视觉风格 | "扁平化插画风格" | 可选：写实摄影、赛博朋克、极简主义、手绘风、像素风、水彩风、科技感插画 |
| 光线氛围 | "柔和的环境光" | 或"明暗对比强烈"、"霓虹灯光"、"自然光" |
| 色彩方案 | "蓝色和橙色为主色调" | 明确配色方案，符合文章主题 |
| 细节要求 | "背景有模糊的电路纹理" | 添加装饰元素增加层次感 |
| 比例/尺寸 | "16:9 横向" | 或"1:1 正方形"、"9:16 纵向" |

**提示词示例**：

**✅ 优秀提示词（细节丰富）**：
```
A futuristic robot assistant analyzing code on multiple holographic screens, center composition with slight low angle, clean tech illustration style with glowing cyan accent lines, soft ambient lighting with subtle lens flare, deep navy blue and electric blue color palette with orange highlights, abstract digital grid pattern in the background, 16:9 horizontal aspect ratio, high detail, professional tech blog cover
```

```
中文版：未来风格机器人助手正在多个全息屏幕上分析代码，居中构图配合轻微低角度，清新的科技插画风格带发光青色线条，柔和环境光配合微妙镜头光晕，深海军蓝与电蓝色调为主搭配橙色高光，背景有抽象数字网格纹理，16:9横向比例，高细节，专业科技博客封面图
```

**✅ 技术类文章提示词示例**：

| 图片用途 | 英文提示词 | 中文提示词 |
|---------|----------|----------|
| 封面图 | "Professional tech blog cover, abstract neural network visualization with glowing nodes and connections, dark gradient background (#1a1a2e to #16213e), vibrant cyan and purple gradient nodes, clean minimalist style, subtle particle effects, 16:9 horizontal" | 专业科技博客封面，抽象神经网络可视化，节点和连接线发光，深色渐变背景(#1a1a2e到#16213e)，青色和紫色渐变节点，简洁极简风格，微妙的粒子效果，16:9横向 |
| 流程图 | "Clean flowchart diagram showing CI/CD pipeline stages, connected by glowing arrows, isometric 2.5D perspective, modern flat design with soft shadows, step icons (code, build, test, deploy), blue gradient accent, white background with subtle grid lines" | 清晰的流程图展示CI/CD流水线各阶段，连接箭头发光，等轴测2.5D视角，现代扁平设计带柔和阴影，步骤图标（代码、构建、测试、部署），蓝色渐变强调色，白色背景带微妙网格线 |
| 架构图 | "Microservices architecture diagram, Docker containers arranged in hexagonal pattern, Kubernetes orchestration shown as central hub, connection lines with data flow animation hints, modern tech illustration style, dark mode friendly (dark gray nodes, colored borders)" | 微服务架构图，Docker容器以六边形排列，Kubernetes编排显示为中心枢纽，连接线带有数据流动画暗示，现代科技插画风格，暗色模式友好（深灰节点，彩色边框） |

**✅ 杂谈类文章提示词示例**：

| 图片用途 | 英文提示词 | 中文提示词 |
|----------|----------|----------|
| 封面图 | "Cozy coffee shop scene with person typing on laptop, warm golden hour sunlight streaming through window, soft bokeh background with hanging plants, watercolor illustration style with warm tones (amber, soft brown, cream), relaxed and inviting atmosphere, 3:2 horizontal" | 温馨咖啡店场景，一个人在窗边敲笔记本，金色时段阳光透过窗户洒入，柔和背景虚化的挂绿植，水彩插画风格，暖色调（琥珀、柔和棕、奶油色），轻松愉悦的氛围，3:2横向 |
| 插画图 | "Abstract concept of balance between work and life, stylized human figure sitting on a swing between laptop and palm tree beach, pastel color palette (soft pink, mint green, sky blue), gentle brush strokes, dreamlike quality, square format" | 工作生活平衡的抽象概念，风格化人物坐在秋千上，秋千一边是笔记本电脑一边是海滩棕榈树，柔和粉彩色调（柔粉、薄荷绿、天蓝），柔和笔触，梦一般质感，正方形构图 |

**❌ 避免的低质量提示词**：
```
❌ "一张图" / "some image" / "技术图片"
❌ "a computer" (太模糊)
❌ "code on screen" (缺少细节)
```

**生成技巧**：
1. **封面图**：突出主题核心概念，使用吸引眼球的视觉元素
2. **章节图**：配合文字内容，解释或延伸概念
3. **图标/小图**：使用极简风格，清晰的视觉焦点
4. **背景图**：低调不抢眼，可使用纹理或模糊处理

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