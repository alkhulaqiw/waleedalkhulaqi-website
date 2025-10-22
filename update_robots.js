// 🧠 تحديث ملف robots.txt تلقائيًا للإشارة إلى sitemap.xml
const fs = require("fs");
const path = require("path");

const robotsPath = path.join(__dirname, "robots.txt");
const sitemapUrl = "https://waleedalkhulaqi.website/sitemap.xml";

let robotsContent = `
User-agent: *
Allow: /

Sitemap: ${sitemapUrl}
`.trim();

try {
  fs.writeFileSync(robotsPath, robotsContent, "utf8");
  console.log("✅ تم إنشاء أو تحديث ملف robots.txt بنجاح!");
} catch (err) {
  console.error("⚠️ حدث خطأ أثناء تحديث robots.txt:", err.message);
}
