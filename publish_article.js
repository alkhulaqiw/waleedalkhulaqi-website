// ===============================
// سكربت نشر المقالات تلقائيًا إلى GitHub
// إعداد: وليد الخلاقي + GPT-5
// ===============================

import fs from "fs";
import fetch from "node-fetch";

// إعدادات المستخدم
const GITHUB_USERNAME = "alkhulaqiw";
const REPO_NAME = "waleedalkhulaqi-website";
const BRANCH = "master";
const TOKEN = "ضع_الرمز_الخاص_بك_هنا"; // GitHub Personal Access Token
const SAVE_FOLDER = "articles";

// 📝 دالة لإنشاء المقال ورفعه
async function publishArticle(filename, content) {
  const path = `${SAVE_FOLDER}/${filename}`;
  const apiUrl = `https://api.github.com/repos/${GITHUB_USERNAME}/${REPO_NAME}/contents/${path}`;

  // تحويل النص إلى Base64
  const base64Content = Buffer.from(content, "utf8").toString("base64");

  // طلب API
  const response = await fetch(apiUrl, {
    method: "PUT",
    headers: {
      "Authorization": `token ${TOKEN}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      message: `إضافة مقال جديد: ${filename}`,
      content: base64Content,
      branch: BRANCH,
    }),
  });

  const data = await response.json();

  if (response.ok) {
    console.log(`✅ تم نشر المقال بنجاح: ${data.content.path}`);
  } else {
    console.error(`❌ فشل النشر:`, data);
  }
}

// ✨ مثال للاستخدام
const exampleTitle = "مثال-أول-مقال.html";
const exampleContent = `
<html lang="ar">
<head><meta charset="UTF-8"><title>مقال تجريبي</title></head>
<body><h1>مرحبًا بكم في أول مقال من لوحة وليد الذكية</h1></body>
</html>
`;

publishArticle(exampleTitle, exampleContent);
