#!/bin/bash

# Hugo 文章创建脚本
# 用法: ./new-post.sh

set -e

CONTENT_DIR="content"
DATE=$(date +%Y-%m-%d)

# 获取已有分类（目录名）
get_categories() {
    find "$CONTENT_DIR" -mindepth 1 -maxdepth 1 -type d ! -name ".*" 2>/dev/null | xargs -r basename -a | sort
}

# 显示菜单
show_menu() {
    echo ""
    echo "📝 创建新文章"
    echo "================"
    echo ""
}

# 选择或创建分类
select_category() {
    local categories
    mapfile -t categories < <(get_categories)
    
    if [ ${#categories[@]} -eq 0 ]; then
        echo "暂无分类，请创建第一个分类"
    else
        echo "已有分类："
        for i in "${!categories[@]}"; do
            echo "  $((i+1)). ${categories[$i]}"
        done
        echo "  $(( ${#categories[@]} + 1 )). + 新建分类"
    fi
    
    echo ""
    read -p "选择分类 [1-${#categories[@]}] 或输入新分类名: " choice
    
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#categories[@]} ]; then
        CATEGORY="${categories[$((choice-1))]}"
    elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -eq $((${#categories[@]}+1)) ]; then
        read -p "输入新分类名: " CATEGORY
    else
        CATEGORY="$choice"
    fi
    
    CATEGORY=$(echo "$CATEGORY" | xargs)
    if [ -z "$CATEGORY" ]; then
        echo "分类名不能为空"
        exit 1
    fi
}

# 输入文章信息
input_info() {
    read -p "文章标题: " TITLE
    read -p "文章描述: " DESCRIPTION
    read -p "标签 (逗号分隔): " TAGS_INPUT
    
    # 转换为 YAML 格式
    if [ -n "$TAGS_INPUT" ]; then
        TAGS_YAML=$(echo "$TAGS_INPUT" | tr ',' '\n' | sed 's/^[[:space:]]*//' | awk '{print "  - " $0}' | tr '\n' ' ' | sed 's/  - /\n  - /g' | tail -c +2)
    else
        TAGS_YAML=""
    fi
    
    # 生成 slug
    SLUG=$(echo "$TITLE" | iconv -f utf-8 -t ascii//TRANSLIT | tr -cs 'a-z0-9-' '-' | tr '[:upper:]' '[:lower:]' | sed 's/^-//;s/-$//')
    
    if [ -z "$SLUG" ]; then
        SLUG=$(date +%s)
    fi
}

# 创建文章
create_post() {
    local category_dir="$CONTENT_DIR/$CATEGORY"
    local post_dir="$category_dir/$SLUG"
    local images_dir="$post_dir/images"
    
    # 创建目录
    mkdir -p "$images_dir"
    
    # 创建 index.md
    cat > "$post_dir/index.md" << EOF
---
title: "${TITLE}"
date: ${DATE}
draft: true
tags:
${TAGS_YAML}
description: "${DESCRIPTION}"
---

# ${TITLE}

在这里开始写文章...

EOF
    
    echo ""
    echo "✅ 文章创建成功！"
    echo ""
    echo "📁 位置: ${post_dir}/index.md"
    echo "🖼️  图片: ${images_dir}/"
    echo ""
    echo "Typora 打开后直接编辑，图片拖拽到 images/ 目录"
}

# 主流程
show_menu
select_category
input_info
create_post
