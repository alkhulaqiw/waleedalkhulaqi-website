const fs = require("fs");
const path = require("path");

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

const htmlTemplate = (title) => `<!doctype html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="utf-8">
  <title>${title} - وليد الخلاقي</title>
  <meta name="description" content="${title} - مقالة من موقع وليد الخلاقي.">
  <link rel="stylesheet" href="../../assets/css/style.css">
</head>
<body>
  <header><h1>${title}</h1></header>
  <main>
    <p>محتوى هذه المقالة قيد الإنشاء...</p>
  </main>
  <footer><a href="../../index.html">العودة للرئيسية</a></footer>
</body>
</html>`;

// إنشاء المجلدات والملفات
Object.entries(structure).forEach(([category, topics]) => {
  const dirPath = path.join(baseDir, category);
  fs.mkdirSync(dirPath, { recursive: true });

  topics.forEach((topic) => {
    const fileName = `${topic}.html`;
    const filePath = path.join(dirPath, fileName);
    const title = topic.replace(/-/g, " ");
    fs.writeFileSync(filePath, htmlTemplate(title), "utf8");
  });
});

console.log("✅ تم إنشاء جميع المجلدات والملفات بنجاح داخل مجلد 'articles/'.");
