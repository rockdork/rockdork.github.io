# 三言二语 - 网站搭建指南

## ✅ 已完成的工作

1. ✅ 创建项目目录：`~/Projects/sanyanyu/`
2. ✅ 初始化 Git 仓库
3. ✅ 添加 PaperMod 主题（作为 git submodule）
4. ✅ 创建配置文件 `config.toml`
5. ✅ 配置 GitHub Actions 自动部署（`.github/workflows/deploy.yml`）
6. ✅ 创建示例文章和关于页面

## 📋 接下来你需要做的

### 第一步：安装 Hugo

运行我为你创建的自动安装脚本：

```bash
cd ~/Projects/sanyanyu
chmod +x install-hugo.sh
./install-hugo.sh
```

或者手动安装：
1. 访问 https://github.com/gohugoio/hugo/releases
2. 下载 `hugo_extended_*_darwin-arm64.tar.gz`（最新版本）
3. 解压并将 `hugo` 二进制文件移动到 `/usr/local/bin/`

验证安装：
```bash
hugo version
```

---

### 第二步：本地预览

安装 Hugo 后，运行以下命令启动本地服务器：

```bash
cd ~/Projects/sanyanyu
hugo server -D
```

然后打开浏览器访问：http://localhost:1313/

你应该能看到：
- 首页显示 "三言二鱼"
- 示例文章 "你好，世界！"
- 关于页面

---

### 第三步：在 GitHub 上创建仓库

1. 访问 https://github.com/new
2. 仓库名：`shizhu.github.io`
3. 可见性：Public（GitHub Pages 需要公开仓库）
4. **不要**初始化 README、.gitignore 等（我们已经有了）
5. 点击 "Create repository"

---

### 第四步：推送代码到 GitHub

```bash
cd ~/Projects/sanyanyu

# 添加远程仓库（替换为你自己的 GitHub 用户名）
git remote add origin https://github.com/shizhu/shizhu.github.io.git

# 添加所有文件到 Git
git add .

# 提交
git commit -m "Initial commit: 三言二语网站搭建完成"

# 推送到 main 分支
git push -u origin main
```

---

### 第五步：启用 GitHub Pages

1. 在 GitHub 上打开你的仓库：`https://github.com/shizhu/shizhu.github.io`
2. 点击 "Settings" 标签
3. 在左侧菜单找到 "Pages"
4. 在 "Build and deployment" 部分：
   - Source: 选择 "GitHub Actions"
5. 保存

等待 1-2 分钟，GitHub Actions 会自动构建并部署你的网站。

---

### 第六步：配置 Giscus 评论（可选）

Giscus 是基于 GitHub Discussions 的评论系统。

#### 6.1 创建 Giscus 仓库
1. 在你的仓库 `shizhu.github.io` 中：
   - 点击 "Settings" → "General"
   - 在 "Features" 部分，勾选 "Discussions"

2. 访问 https://giscus.app/
   - Repository: `shizhu/shizhu.github.io`
   - 按照提示完成配置
   - 复制生成的 `<script>` 标签中的 `data-*` 属性值

3. 更新 `config.toml` 中的 `[params.giscus]` 部分：
   ```toml
   [params.giscus]
     repo = "shizhu/shizhu.github.io"
     repoId = "你的 repoId"
     category = "Announcements"
     categoryId = "你的 categoryId"
     # ... 其他配置
   ```

---

### 第七步：开始写文章

#### 创建新文章：

```bash
cd ~/Projects/sanyanyu
hugo new posts/我的第一篇文章.md
```

然后编辑 `content/posts/我的第一篇文章.md`，去掉 `draft: true` 或改为 `false`。

#### 文章格式示例：

```markdown
---
title: "文章标题"
date: 2026-04-26T23:30:00+08:00
draft: false
tags: ["标签1", "标签2"]
categories: ["分类"]
description: "文章简介"
---

## 正文开始

你的内容 here...
```

---

### 第八步：自定义配置

#### 添加头像
1. 准备一张正方形图片（建议 120x120 或更大）
2. 放到 `static/img/profile.jpg`
3. 在 `config.toml` 中确认 `imageUrl = "img/profile.jpg"`

#### 修改主题颜色
编辑 `config.toml`，添加：
```toml
[params]
  # ... 其他配置
  
[params.style]
  backgroundColor = "#ffffff"
  primaryColor = "#4c9a2a"
```

---

## 🚀 发布流程（日常使用）

写新文章后，只需要三步：

```bash
# 1. 添加修改
git add .

# 2. 提交
git commit -m "添加新文章：文章标题"

# 3. 推送（自动触发部署）
git push origin main
```

等待 1-2 分钟，访问 https://shizhu.github.io/ 就能看到更新！

---

## 📁 项目结构

```
~/Projects/sanyanyu/
├── content/
│   ├── posts/          # 博客文章
│   └── about.md        # 关于页面
├── themes/
│   └── PaperMod/       # 主题（git submodule）
├── static/             # 静态文件（图片等）
├── config.toml         # 配置文件
├── .github/
│   └── workflows/
│       └── deploy.yml  # 自动部署配置
└── README.md
```

---

## 🔧 常用 Hugo 命令

```bash
# 本地预览（支持热更新）
hugo server -D

# 本地预览（不包含草稿）
hugo server

# 构建静态文件（生成到 public/ 目录）
hugo

# 创建新文章
hugo new posts/文章名.md

# 查看网站结构
hugo list all
```

---

## ❓ 常见问题

### Q: GitHub Pages 部署失败？
A: 检查以下几点：
1. 仓库是否是 Public？
2. GitHub Pages 是否设置为 "GitHub Actions" 模式？
3. 查看 "Actions" 标签，看具体的错误信息

### Q: 主题没有正确显示？
A: 确保 PaperMod 子模块正确初始化：
```bash
git submodule update --init --recursive
```

### Q: 如何更新主题？
```bash
cd themes/PaperMod
git pull origin master
cd ../..
git add themes/PaperMod
git commit -m "Update PaperMod theme"
git push
```

---

## 📚 参考资料

- [Hugo 官方文档](https://gohugo.io/documentation/)
- [PaperMod 主题文档](https://github.com/adityatelange/hugo-PaperMod/wiki)
- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [Giscus 文档](https://giscus.app/)

---

**搭建完成时间**: 2026-04-26 23:25 GMT+8
**网站地址**: https://shizhu.github.io/ （推送代码后生效）
**本地预览**: http://localhost:1313/ （需要先安装 Hugo）
