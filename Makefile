.PHONY: build serve check clean pagefind

# zola build + 搜索索引（Pagefind）
# 注意：不要加 --minify，Zola 0.23 的压缩器会把属性引号去掉，Pagefind 解析不了。
build:
	zola build
	pagefind --site public

# 本地预览（改完刷新即生效）
serve:
	zola serve

# 构建 + 生成索引 + 起本地服务预览搜索结果
dev:
	zola build
	pagefind --site public
	zola serve

check:
	zola check

clean:
	rm -rf public