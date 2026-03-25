#!/bin/bash
set -e

POSTS_DIR="content/posts"
ARCHETYPE="archetypes/default.md"

list_all_categories() {
    find "$POSTS_DIR" -mindepth 1 -type d | sed "s|$POSTS_DIR/||" | sort
}

select_or_create_category() {
    echo "=== 选择分类 ==="
    echo ""

    mapfile -t categories < <(list_all_categories)

    if [ ${#categories[@]} -eq 0 ]; then
        echo "  (暂无分类)"
    else
        for i in "${!categories[@]}"; do
            echo "  [$((i+1))] ${categories[$i]}"
        done
    fi
    echo "  [N] 新建分类"
    echo ""

    read -p "请选择 (1-${#categories[@]} 或 N): " choice

    if [[ "$choice" =~ ^[Nn]$ ]]; then
        read -p "输入分类路径 (如: 技术/前端): " new_cat
        new_cat=$(echo "$new_cat" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        [ -z "$new_cat" ] && echo "分类不能为空" && exit 1
        [[ "$new_cat" =~ ^/ ]] && new_cat="${new_cat:1}"
        CATEGORY="$new_cat"
    elif [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#categories[@]}" ]; then
        CATEGORY="${categories[$((choice-1))]}"
    else
        echo "无效选择" && exit 1
    fi
}

echo "=== 新建文章 ==="
echo ""

read -p "文章标题: " TITLE
[ -z "$TITLE" ] && echo "标题不能为空" && exit 1

select_or_create_category

FILENAME=$(echo "$TITLE" | sed 's/[^a-zA-Z0-9\u4e00-\u9fa5]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//' | tr '[:upper:]' '[:lower:]')

echo ""
echo "=== 确认 ==="
echo "标题: $TITLE"
echo "分类: $CATEGORY"
echo "路径: $POSTS_DIR/$CATEGORY/$FILENAME"
echo ""

read -p "确认创建? (Y/n): " confirm
confirm=${confirm:-Y}

[[ ! "$confirm" =~ ^[Yy]$ ]] && echo "已取消" && exit 0

TARGET_FILE="$POSTS_DIR/$CATEGORY/$FILENAME/index.md"

[ -e "$TARGET_FILE" ] && echo "错误: $TARGET_FILE 已存在" && exit 1

mkdir -p "$(dirname "$TARGET_FILE")"

sed -e "s/{{ \.Date }}/$(date -Iseconds)/" \
    -e "s/{{ replace \.File\.ContentBaseName \"-\" \" \" | title }}/$TITLE/" \
    "$ARCHETYPE" > "$TARGET_FILE"

echo ""
echo "=== 文章已创建 ==="
echo "路径: $TARGET_FILE"
echo ""

[ -n "$EDITOR" ] && $EDITOR "$TARGET_FILE" || cat "$TARGET_FILE"
