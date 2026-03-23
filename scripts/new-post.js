#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const readline = require('readline');

const CONTENT_DIR = 'content';
const DATE = new Date().toISOString().split('T')[0];

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function question(query) {
  return new Promise(resolve => rl.question(query, resolve));
}

function getCategories() {
  if (!fs.existsSync(CONTENT_DIR)) return [];
  return fs.readdirSync(CONTENT_DIR)
    .filter(f => fs.statSync(path.join(CONTENT_DIR, f)).isDirectory() && !f.startsWith('.'))
    .sort();
}

function toSlug(str) {
  return str.toLowerCase()
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .trim('-');
}

async function main() {
  console.log('\n📝 创建新文章\n================\n');

  const categories = getCategories();

  if (categories.length > 0) {
    console.log('已有分类:');
    categories.forEach((c, i) => console.log(`  ${i + 1}. ${c}`));
    console.log(`  ${categories.length + 1}. + 新建分类\n`);
  }

  let category;
  const choice = await question('选择分类或输入新分类名: ');

  if (/^\d+$/.test(choice) && choice >= 1 && choice <= categories.length) {
    category = categories[choice - 1];
  } else {
    category = choice.trim();
  }

  if (!category) {
    console.log('分类名不能为空');
    process.exit(1);
  }

  const title = await question('文章标题: ');
  const description = await question('文章描述: ');
  const tagsInput = await question('标签 (逗号分隔): ');

  const tags = tagsInput ? tagsInput.split(',').map(t => t.trim()).filter(Boolean) : [];
  const slug = toSlug(title) || Date.now().toString();

  const categoryDir = path.join(CONTENT_DIR, category);
  const postDir = path.join(categoryDir, slug);
  const imagesDir = path.join(postDir, 'images');

  fs.mkdirSync(imagesDir, { recursive: true });

  const tagsYaml = tags.map(t => `  - ${t}`).join('\n');

  const content = `---
title: "${title}"
date: ${DATE}
draft: true
tags:
${tagsYaml}
description: "${description}"
---

# ${title}

在这里开始写文章...

`;

  fs.writeFileSync(path.join(postDir, 'index.md'), content);

  console.log('\n✅ 文章创建成功！\n');
  console.log(`📁 位置: ${postDir}/index.md`);
  console.log(`🖼️  图片: ${imagesDir}/\n`);
  console.log('Typora 打开后直接编辑，图片拖拽到 images/ 目录\n');

  rl.close();
}

main().catch(console.error);
