const fs = require("fs");
const path = require("path");

const siteURL = "https://waleedalkhulaqi.website";
const baseDir = path.join(__dirname, "articles");
const sitemapPath = path.join(__dirname, "sitemap.xml");

// دالة لجمع كل ملفات HTML داخل مجلد المقالات
function getAllArticles(dir, folder = "") {
  let urls = [];
  const items = fs.readdirSync(dir, { withFileTypes: true });

  for (const item of items) {
    if (item.isDirectory()) {
      urls = urls.concat(getAllArticles(path.join(dir, item.name), `${folder}${item.name}/`));
    } else if (item.isFile() && item.name.endsWith(".html")) {
      urls.push(`${siteURL}/articles/${folder}${item.name}`);
    }
  }
  return urls;
}

// إنشاء الـ XML بناءً على الروابط
function generateSitemap(urls) {
  const lastmod = new Date().toISOString().split("T")[0];
  const urlsXML = urls
    .map(
      (url) => `
  <url>
    <loc>${url}</loc>
    <lastmod>${lastmod}</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.8</priority>
  </url>`
    )
    .join("\n");

  return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>${siteURL}/</loc>
    <lastmod>${lastmod}</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>
${urlsXML}
</urlset>`;
}

// تنفيذ التوليد
const allArticles = getAllArticles(baseDir);
const sitemapContent = generateSitemap(allArticles);
fs.writeFileSync(sitemapPath, sitemapContent, "utf8");

console.log(`✅ تم إنشاء أو تحديث sitemap.xml بنجاح!`);
console.log(`📄 عدد المقالات المضافة: ${allArticles.length}`);
