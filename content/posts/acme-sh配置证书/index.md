---
title: "acme.sh配置证书"
date: 2024-10-16T21:31:22+08:00
lastmod: 2024-10-16T22:52:27+08:00
slug: 2024/10/16/acme-sh配置证书
tags: ["服务器配置"]
---

## 安装

```bash
curl  https://get.acme.sh | sh
cd 
acme.sh --register-account -m xxx@xx.com
./acme.sh --dns --issue -d syhu.com.cn --yes-I-know-dns-manual-mode-enough-go-ahead-please
# 添加完dns的txt解析后,提示用renew重新执行
./acme.sh --dns --renew -d syhu.com.cn --yes-I-know-dns-manual-mode-enough-go-ahead-please
# 提示证书文件位置
```

## Nginx配置

案例:

```text
# Load modular configuration files from the /etc/nginx/conf.d directory.
# See http://nginx.org/en/docs/ngx_core_module.html#include
# for more information.
# include /etc/nginx/conf.d/*.conf;

server {
	server_name x6.a.com x.a.com;
	
	# SSL configuration
	listen 443 ssl;
	listen [::]:443 ssl;
    
    # cer / crt证书文件 证书文件 key的路径
    ssl_certificate /path/syhu.com.cn.cer;
    ssl_certificate_key /path/syhu.com.cn.key;
    
    ssl_session_timeout 5m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on;
	
	# Load configuration files for the default server block.
	# include /etc/nginx/default.d/*.conf;
	
	location / {
		proxy_pass http://alist;
		#proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header Range $http_range;
		proxy_set_header If-Range $http_if_range;
		proxy_redirect off;
		
		#the max size of file to upload
		client_max_body_size 20000m;
	}
}
```
