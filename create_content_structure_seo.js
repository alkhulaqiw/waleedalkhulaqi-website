const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");

const siteURL = "https://waleedalkhulaqi.website";
const authorName = "وليد الخلاقي";

const structure = {
  "website-creation": [
    "how-to-choose-a-website-platform",
    "designing-a-user-friendly-website",
    "tips-for-optimizing-website-speed",
    "incorporating-seo-into-your-website",
    "importance-of-mobile-responsiveness",
  ],
  "content-creation": [
    "choosing-right-cms",
    "creating-engaging-content",
    "best-practices-content-marketing",
    "content-repurposing-ideas",
    "analyzing-content-performance",
  ],
  "social-media-marketing": [
    "social-media-calendar",
    "increasing-social-engagement",
    "paid-advertising-social",
    "influencer-marketing",
    "platform-specific-campaigns",
  ],
  "email-marketing": [
    "building-email-list",
    "crafting-subject-lines",
    "segmenting-email-list",
    "ab-testing-email",
    "automation-email-marketing",
  ],
  seo: [
    "search-engine-algorithms",
    "keyword-research",
    "building-quality-backlinks",
    "local-seo",
    "measuring-seo-success",
  ],
  branding: [
    "brand-style-guide",
    "visual-branding-elements",
    "consistent-brand-voice",
    "brand-storytelling",
    "evolving-brand-perception",
  ],
  ecommerce: [
    "choosing-ecommerce-platform",
    "optimizing-product-pages",
    "customer-reviews-testimonials",
    "upsell-cross-sell",
    "abandoned-cart-recovery",
  ],
  "customer-experience": [
    "understanding-customer-journey",
    "personalization-customization",
    "power-of-reviews",
    "chatbots-for-service",
    "improving-customer-satisfaction",
  ],
  "digital-advertising": [
    "advertising-channels",
    "targeting-and-budgeting",
    "ad-analytics-optimization",
    "ab-testing-ads",
    "retargeting-for-conversions",
  ],
};

const baseDir = path.join(__dirname, "articles");

// دالة توليد روابط ذات صلة
function relatedLinks(category, currentTopic) {
  const links = structure[category]
    .filter((t) => t !== currentTopic)
    .slice(0, 3)
    .map(
      (t) =>
        `<li><a href="./${t}.html">${t.replace(/-/g, " ")}</a></li>`
    )
    .join("\n");
  return `<ul class="related-articles">${links}</ul>`;
}

// قالب HTML كامل
function htmlTemplate(title, category, topic) {
  const schema = {
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": title,
    "author": { "@type": "Person", "name": authorName },
    "publisher": {
      "@type": "Organization",
      "name": "waleedalkhulaqi.website",
      "logo": {
        "@type": "ImageObject",
        "url": `${siteURL}/assets/images/logo.png`,
      },
    },
    "mainEntityOfPage": `${siteURL}/articles/${category}/${topic}.html`,
    "datePublished": new Date().toISOString().split("T")[0],
  };

  return `<!doctype html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="utf-8">
  <title>${title} - ${authorName}</title>
  <meta name="description" content="${title} - مقالة من موقع ${authorName}.">
  <meta name="author" content="${authorName}">
  <meta name="robots" content="index, follow">
  <link rel="canonical" href="${siteURL}/articles/${category}/${topic}.html">
  <link rel="stylesheet" href="../../assets/css/style.css">
  <script type="application/ld+json">${JSON.stringify(schema, null, 2)}</script>
</head>
<body>
  <header>
    <h1>${title}</h1>
  </header>
  <main>
    <p>محتوى هذه المقالة قيد الإنشاء...</p>

    <section>
      <h3>مقالات ذات صلة</h3>
      ${relatedLinks(category, topic)}
    </section>
  </main>
  <footer>
    <a href="../../index.html">العودة للرئيسية</a>
  </footer>
</body>
</html>`;
}

// إنشاء المجلدات والملفات
Object.entries(structure).forEach(([category, topics]) => {
  const dirPath = path.join(baseDir, category);
  fs.mkdirSync(dirPath, { recursive: true });

  topics.forEach((topic) => {
    const fileName = `${topic}.html`;
    const filePath = path.join(dirPath, fileName);
    const title = topic.replace(/-/g, " ");
    fs.writeFileSync(filePath, htmlTemplate(title, category, topic), "utf8");
  });
});

console.log("✅ تم إنشاء المقالات مع روابط داخلية وSchema جاهز بنجاح!");

// 🔁 تحديث خريطة الموقع تلقائيًا بعد إنشاء المقالات
try {
  console.log("\n🔁 جاري تحديث خريطة الموقع (sitemap.xml)...");
  execSync("node generate_sitemap.js", { stdio: "inherit" });
  console.log("✅ تم تحديث خريطة الموقع بنجاح!");
} catch (err) {
  console.error("⚠️ حدث خطأ أثناء تحديث sitemap:", err.message);
}

// 🤖 تحديث ملف robots.txt تلقائيًا بعد تحديث sitemap
try {
  console.log("\n🤖 جاري تحديث ملف robots.txt...");
  execSync("node update_robots.js", { stdio: "inherit" });
  console.log("✅ تم تحديث robots.txt بنجاح!");
} catch (err) {
  console.error("⚠️ حدث خطأ أثناء تحديث robots.txt:", err.message);
}
