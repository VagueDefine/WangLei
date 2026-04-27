```dataviewjs
// ========= 1️⃣ 获取数据 =========
const pages = dv.pages('"300高速电路设计与电磁兼容技术指南"')
    .where(p => p.title);

// ========= 2️⃣ 构建 三级结构 =========
// 结构：书 → 章节 → 小节 → 笔记
let tree = {};

for (let p of pages) {
    let parts = p.file.folder.split("/");

    let book = parts[0] ?? "未分类";
    let chapter = parts[1] ?? "未分类";
    let section = parts[2] ?? "未分类";

    if (!tree[chapter]) tree[chapter] = {};
    if (!tree[chapter][section]) tree[chapter][section] = [];

    tree[chapter][section].push(p);
}

// ========= 3️⃣ 排序函数 =========
function sortByNumber(arr, keyFunc) {
    return arr.sort((a, b) => {
        let aName = keyFunc(a);
        let bName = keyFunc(b);

        let numA = parseInt(aName.match(/^\d+/));
        let numB = parseInt(bName.match(/^\d+/));

        if (!isNaN(numA) && !isNaN(numB)) {
            return numA - numB;
        }
        return aName.localeCompare(bName);
    });
}

// ========= 4️⃣ 渲染 =========

// 排序章节
let chapters = Object.keys(tree);
chapters = sortByNumber(chapters, x => x);

for (let chapter of chapters) {

    // 📘 章节
    dv.header(2, `📘 ${chapter}`);

    let sections = Object.keys(tree[chapter]);
    sections = sortByNumber(sections, x => x);

    for (let section of sections) {

        // 📂 小节
        dv.header(3, `📂 ${section}`);

        let notes = tree[chapter][section];

        notes = sortByNumber(notes, p => p.file.name);

        // 📄 笔记列表
        dv.list(
            notes.map(p => p.file.link)
        );
    }
}

```

