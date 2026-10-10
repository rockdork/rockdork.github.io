# AGENTS.md — rockdorky-blog

**本仓是什么**：三言二鱼博客（[blog.rockdork.cn](https://blog.rockdork.cn)）的 **Hugo 框架仓**——模板、布局、配置、固定页面。**文章正文不在这里**。详见 [README.md](README.md) 与 [DOCS/](DOCS/)。

## 约定

- 界面文案、注释、文档、提交信息**一律中文**。
- 🚫 **不要在本仓写文章**：文章源在私有仓 `rockdork/sanyan-content`，发布时由 GitHub Actions 拉取合并（链路见 README）。
- `content/` 下只维护**固定页面**（`about.md` / `works.md` / `snote/` / `sanyan-tutu/`）；文章不落在这里。
- 主题 `themes/PaperMod/` 是 **git submodule**——要改主题走 submodule 流程，不要在仓内直接改。
- 🚫 不要删 `CNAME`（`blog.rockdork.cn`）。
- 构建产物 `public/`、`resources/` 已被 gitignore，不要提交。

## 本仓的上下文

本仓来自一个**本地多项目工作区**，该工作区有一整套**约束、公共脚本与基础设施记录**——
但它们**只存在于本机，不入任何仓库**，本仓（公开）里没有，也不必在这里找。

若你是在该本地工作区中工作，**开工前先读工作区根目录的 `AGENTS.md`**（`~/Projects/AGENTS.md`）。
