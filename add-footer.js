const fs = require("fs");
const path = require("path");

const footerCode = `
<!-- تضمين الفوتر -->
<div id="footer"></div>
<script>
  fetch('footer-section.html')
    .then(res => res.text())
    .then(data => document.getElementById('footer').innerHTML = data);
</script>
`;

const folder = "./";

function processFile(filePath) {
  let content = fs.readFileSync(filePath, "utf8");

  // إذا الكود مضاف مسبقاً، نتجاوزه
  if (content.includes("fetch('footer-section.html')")) {
    console.log(`⏭ تم تخطي ${filePath} (الكود موجود بالفعل)`);
    return;
  }

  // إضافة الكود قبل </body>
  content = content.replace("</body>", `${footerCode}\n</body>`);
  fs.writeFileSync(filePath, content, "utf8");
  console.log(`✅ تم تعديل: ${filePath}`);
}

function scanDir(dir) {
  fs.readdirSync(dir).forEach(file => {
    const fullPath = path.join(dir, file);
    if (fs.statSync(fullPath).isDirectory()) {
      scanDir(fullPath);
    } else if (file.endsWith(".html")) {
      processFile(fullPath);
    }
  });
}

scanDir(folder);
console.log("🎉 تمت إضافة كود الفوتر لجميع ملفات HTML بنجاح!");
