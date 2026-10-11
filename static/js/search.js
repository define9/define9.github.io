// 站内搜索：Pagefind 索引在构建后生成（zola build && pagefind --site public）
// 不引第三方 UI 包，直接用 pagefind.js 的 dynamicSearch 接口。
(async () => {
  const input = document.getElementById('search-input');
  const list = document.getElementById('search-results');
  const status = document.getElementById('search-status');
  if (!input || !list || !status) return;

  // 从自身位置推导 pagefind 目录，站点放在子路径下也能用
  const pagefindUrl = new URL('../pagefind/pagefind.js', document.currentScript.src).href;
  let pagefind;
  try {
    pagefind = await import(pagefindUrl);
  } catch {
    status.textContent = '搜索索引未生成（构建时需要跑 pagefind）。';
    return;
  }
  await pagefind.init();

  status.textContent = '输入关键词开始搜索。';

  let timer;
  input.addEventListener('input', () => {
    clearTimeout(timer);
    timer = setTimeout(run, 250);
  });

  async function run() {
    const query = input.value.trim();
    list.innerHTML = '';
    if (!query) {
      status.textContent = '输入关键词开始搜索。';
      return;
    }
    const search = await pagefind.search(query);
    if (!search.results.length) {
      status.textContent = `没有找到与「${query}」有关的内容。`;
      return;
    }
    status.textContent = `找到 ${search.results.length} 条结果。`;

    for (const result of search.results.slice(0, 50)) {
      const data = await result.data();
      const li = document.createElement('li');
      const a = document.createElement('a');
      a.href = data.url;
      a.textContent = data.meta.title;
      li.appendChild(a);
      if (data.excerpt) {
        const p = document.createElement('p');
        p.className = 'desc';
        p.innerHTML = data.excerpt;
        li.appendChild(p);
      }
      list.appendChild(li);
    }
  }

  input.focus();
})();