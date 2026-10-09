# rockdorky-blog

三言二鱼博客的 **Hugo 框架仓**。放模板、布局、配置和固定页面。

> **文章正文不在这里。** 文章源在私有仓 `rockdork/sanyan-content`，发布时由 GitHub Actions 拉取合并。
> 线上站点：[blog.rockdork.cn](https://blog.rockdork.cn)

## 发布链路

```text
在 sanyan-content 写文章（私有仓）
        │  git push main
        ▼
sanyan-content/.github/workflows/trigger-build.yml
        │  repository_dispatch: content-updated
        ▼
本仓 .github/workflows/deploy.yml
        │  ① checkout 本仓（框架）
        │  ② 用 CONTENT_DEPLOY_KEY 拉取 sanyan-content
        │  ③ 合并进 content/
        │  ④ Hugo 构建
        │  ⑤ 部署 GitHub Pages
        ▼
blog.rockdork.cn
```

## 有什么

```text
rockdorky-blog/
├── config.toml        站点配置（标题 / 菜单 / 分类法 / 分页）
├── CNAME              blog.rockdork.cn
├── content/           固定页面（文章正文由 CI 注入，本地没有）
│   ├── about.md       关于
│   ├── works.md       作品
│   ├── snote/_index.md
│   └── sanyan-tutu/_index.md
├── layouts/           自建模板（已脱离 PaperMod 默认样式）
│   ├── _default/  moments/  moods/  works/
│   ├── sanyan-tutu/  snote/  tags/
│   ├── partials/  shortcodes/
├── assets/  static/  data/  i18n/
├── themes/PaperMod/   主题（git submodule）
├── scripts/
│   └── wechat_img_download.py   公众号文章图片下载（配合图床）
├── DOCS/
│   ├── REQUIREMENTS.md   需求文档
│   └── TECHNICAL.md      技术文档
├── SETUP_GUIDE.md     首版搭建记录（部分内容已过时，见下）
└── .github/workflows/deploy.yml
```

## 本地跑起来

需要 **Hugo extended**（CI 用 `0.152.2`；`install-hugo.sh` 装的是 `0.160.1`）。

```bash
# 首次：拉主题子模块
git submodule update --init --recursive

# 预览（含草稿）
hugo server -D            # → http://localhost:1313/

# 仅构建静态产物到 public/
hugo
```

⚠️ **本地预览看不到文章**：正文在 `sanyan-content`，本仓的 `content/` 只有固定页面。
要本地看全文效果，先把文章源复制进来：

```bash
cp -r ../sanyan-content/* content/
```

（这是临时手段，别提交——CI 会自己注入。）

## 改主题 / 样式

- 模板在 `layouts/`，配色与字体在 `assets/`。
- 主题早先基于 PaperMod，现已自建模板与暖色纸张风格；`themes/PaperMod` 仍作为 submodule 存在。
- 改样式前先在本仓 `hugo server -D` 看一眼效果，再 push。

## 写文章 / 发布文章

**不在本仓操作。** 去 `sanyan-content`（或 iCloud 里的 `三言二鱼` 库）写 `.md`，push 后自动上线。

## 相关文档

- [DOCS/REQUIREMENTS.md](DOCS/REQUIREMENTS.md) — 站点需求
- [DOCS/TECHNICAL.md](DOCS/TECHNICAL.md) — 技术说明
- [SETUP_GUIDE.md](SETUP_GUIDE.md) — 2026-04-26 首版搭建记录
  ⚠️ 其中「仓库名 `shizhu.github.io`／目录 `~/Projects/sanyanyu/`／`hugo new posts/` 发布」等描述**已过时**：现在仓库是 `rockdork/rockdork.github.io`，目录是 `~/Projects/rockdorky-blog/`，文章走 `sanyan-content`。
