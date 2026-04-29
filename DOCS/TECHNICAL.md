# 三言二鱼网站 — 技术文档

> 最后更新：2026-04-29（作品页精简 + 关于页更新）
> 维护人：四两

---

## 一、技术栈

| 组件 | 详情 |
|------|------|
| 静态站点生成器 | Hugo v0.152.2（extended） |
| 主题 | PaperMod（Git Submodule） |
| 部署平台 | GitHub Pages |
| 构建/部署 | GitHub Actions（`.github/workflows/deploy.yml`） |
| 域名 | rockdork.github.io |
| 本地运行 | `hugo server -D --buildFuture` |

---

## 二、目录结构

```
rockdorky-blog/
├── content/
│   ├── posts/          # 博客文章（公众号搬运）
│   ├── moments/        # 动态列表（小红书风格，独立 section）
│   │   ├── _index.md   # section 首页必需文件
│   │   └── *.md        # 动态内容
│   ├── works.md        # 作品页（仅保留公众号「三言二鱼」入口）
│   └── about.md        # 关于页（无 date 字段）
├── layouts/
│   ├── moments/
│   │   ├── list.html   # 动态列表页模板（CSS Grid 卡片）
│   │   └── single.html # 动态详情页模板（沉浸式视图）
│   ├── works/
│   │   └── single.html # 作品页模板（仅公众号入口）
│   └── _default/
│       └── single.html # 覆盖默认文章模板（标签与日期同行）
├── assets/css/extended/
│   └── blank.css       # 全局自定义样式（565+ 行）
├── static/images/
│   └── moments/        # 动态封面图
├── themes/
│   └── PaperMod/       # 主题（submodule，commit e457685）
├── .github/workflows/
│   └── deploy.yml      # GitHub Actions 部署配置
└── config.toml         # Hugo 主配置
```

---

## 三、关键配置（config.toml）

### 基础配置
```toml
baseURL = 'https://rockdork.github.io/'
languageCode = 'zh-cn'
title = '三言二鱼'
theme = 'PaperMod'

# 首页：禁用 first-entry 特殊样式
[params]
  disableSpecial1stPost = true
  ShowToc = false
```

### 菜单配置
```toml
[[menu.main]]
  identifier = "posts"
  name = "博客"
  url = "/posts/"

[[menu.main]]
  identifier = "tags"
  name = "标签"
  url = "/tags/"

[[menu.main]]
  identifier = "works"
  name = "作品"
  url = "/works/"

[[menu.main]]
  identifier = "moments"
  name = "动态"
  url = "/moments/"

[[menu.main]]
  identifier = "search"
  name = "Search"   # 配合 CSS ::before 显示 SVG 图标
  url = "/search/"
```

### 已移除配置
- ~~`homeInfoParams`~~：已移除，首页不再显示介绍块

---

## 四、自定义样式（blank.css）

核心定制点：

| 功能 | CSS 选择器 | 说明 |
|------|-----------|------|
| 标签与日期同行 | `.entry-footer` | flex 布局，日期和标签一行显示 |
| 胶囊标签样式 | `.post-entry .entry-tags a` | 小胶囊，无描边，暖色调 |
| 搜索 SVG 图标 | `.menu-item a[href="/search/"]::before` | mask 技术显示放大镜 |
| 动态卡片网格 | `.moments-grid` | CSS Grid，16:9 卡片 |
| 动态卡片封面 | `.moment-cover img` | object-fit: cover，16:9 比例 |
| 动态详情页 | `.moment-single` | 沉浸式布局，大图 + 文字 |

---

## 五、动态列表（Moments）实现细节

### Front Matter 字段
```yaml
---
title: "标题"
date: 2026-04-29
draft: false
featured_image: "/images/moments/xxx.jpg"  # 可选，无图则纯文字
---
```

⚠️ **注意**：必须用 `featured_image`，不可用 `cover`（与 PaperMod 主题内部冲突）。

### 模板文件
- `layouts/moments/list.html`：卡片网格布局，使用 `.Paginator.Pages` 分页
- `layouts/moments/single.html`：沉浸式详情页，大图 + 正文

### 创建新动态
1. 在 `content/moments/` 新建 `.md` 文件
2. 可选添加 `featured_image` 字段
3. 运行 `hugo --buildFuture` 本地预览
4. 提交推送，GitHub Actions 自动部署

---

## 六、GitHub Actions 部署

### 工作流程（deploy.yml）
1. Checkout（含 submodules）
2. Setup Hugo v0.152.2（与本地版本一致）
3. Build with Hugo（`--gc --minify`）
4. Upload Pages Artifact
5. Deploy to GitHub Pages

### Hugo 版本管理
```yaml
env:
  HUGO_VERSION: 0.152.2  # 必须与本地 hugo version 一致
```

⚠️ **已知问题**：版本不一致会导致构建失败，每次升级 Hugo 需同步修改此配置。

---

## 七、常用命令

```bash
# 本地开发
hugo server -D --buildFuture

# 本地构建检查
hugo --buildFuture

# 提交推送
git add .
git commit -m "feat/fix: 描述"
git push origin main

# 查看 Hugo 版本
hugo version
```

---

## 八、已知问题与解决方案

| 问题 | 原因 | 解决方案 |
|------|------|----------|
| `/moments/` 404 | 缺少 `_index.md` | 创建 `content/moments/_index.md` |
| Hugo 构建失败 | `cover` 字段与主题冲突 | 改用 `featured_image` |
| 关于页显示日期 | front matter 含 `date` | 删除 `date` 字段 |
| 首页第一篇文章样式异常 | PaperMod first-entry hero 样式 | 设置 `disableSpecial1stPost = true` |
| 搜索图标不对齐 | SVG 尺寸过大 | 设置 `width: 16px; height: 16px;` |

---

## 九、维护检查清单

每次修改代码后：
- [ ] 更新 `DOCS/REQUIREMENTS.md`（如有需求变更）
- [ ] 更新 `DOCS/TECHNICAL.md`（如有技术变更）
- [ ] 本地 `hugo --buildFuture` 测试通过
- [ ] 提交信息清晰（feat/fix + 描述）
- [ ] 推送后检查 GitHub Actions 构建状态

开发新功能前：
- [ ] 阅读 `DOCS/REQUIREMENTS.md` 确认需求
- [ ] 阅读 `DOCS/TECHNICAL.md` 了解现有技术架构
- [ ] 检查是否有相关已知问题
