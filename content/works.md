---
title: 作品
description: 创作作品集
layout: works
---

<script>
// 作品数据
const works = [
  {
    category: '📝 长篇小说',
    items: [
      {
        title: '信仰抉择',
        desc: '军旅题材。交出证据是叛徒，不交同类悲剧重演——一个关于信仰与抉择的故事。',
        tags: ['军旅', '悬疑'],
        status: '连载中',
        link: '#'
      }
    ]
  },
  {
    category: '✍️ 公众号',
    items: [
      {
        title: '三言二鱼',
        desc: '三言两语，鱼游深水。简短记录，但不止于表面。',
        tags: ['个人成长', '感悟', '写作'],
        status: '持续更新',
        link: '#'
      }
    ]
  },
  {
    category: '🛠️ 项目',
    items: [
      {
        title: '四两',
        desc: 'AI 秘书 Agent，基于 OpenClaw 构建。管理写作、资讯、灵感等多个自动化任务流。',
        tags: ['AI Agent', '自动化'],
        status: '运行中',
        link: '#'
      },
      {
        title: '章章',
        desc: '男频网文写作 Agent，由四两管理。专注网文写作技巧拆解与创作灵感生成。',
        tags: ['AI Agent', '网文写作'],
        status: '运行中',
        link: '#'
      }
    ]
  }
];

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('works-container');
  works.forEach(cat => {
    const section = document.createElement('div');
    section.className = 'works-category';
    section.innerHTML = `<h2 class="works-category-title">${cat.category}</h2>`;
    const grid = document.createElement('div');
    grid.className = 'works-grid';
    cat.items.forEach(item => {
      const card = document.createElement('a');
      card.className = 'works-card';
      card.href = item.link;
      card.innerHTML = `
        <div class="works-card-header">
          <h3>${item.title}</h3>
          <span class="works-status">${item.status}</span>
        </div>
        <p class="works-desc">${item.desc}</p>
        <div class="works-tags">${item.tags.map(t => `<span class="works-tag">${t}</span>`).join('')}</div>
      `;
      grid.appendChild(card);
    });
    section.appendChild(grid);
    container.appendChild(section);
  });
});
</script>

<div id="works-container"></div>
