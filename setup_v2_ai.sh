#!/bin/bash
echo "🚀 بدء إعداد النسخة الذكية v2 لموقع وليد الخلاقي..."

# التأكد من التواجد في المسار الصحيح
cd ~/waleedalkhulaqi-website || exit

# التأكد من وجود مجلد v2
if [ ! -d "v2" ]; then
  echo "⚠️ لم يتم العثور على مجلد v2، تأكد من أنك على الفرع الصحيح!"
  exit 1
fi

cd v2

# إنشاء مجلد المقالات
mkdir -p posts
touch posts/index.json
echo "[]" > posts/index.json

# إنشاء مثال لمقال Markdown
cat > posts/مرحبا-بكم.md <<EOF
# مرحباً بكم في موقعي الجديد 🎉

هذا أول مقال في النسخة الذكية من موقعي الشخصي **وليد الخلاقي**.
يمكنك الآن قراءة المقالات، واستخدام أدوات الذكاء الاصطناعي مباشرة من الموقع.

📅 التاريخ: $(date +%Y-%m-%d)
EOF

# إنشاء شعار SVG باسمك
cat > logo.svg <<'EOF'
<svg width="250" height="60" viewBox="0 0 250 60" xmlns="http://www.w3.org/2000/svg">
  <rect width="250" height="60" fill="white"/>
  <text x="50%" y="50%" text-anchor="middle" dominant-baseline="middle" 
        font-family="Tajawal, sans-serif" font-size="22" fill="#0F172A">وليد الخلاقي</text>
</svg>
EOF

# إنشاء ملف الإعدادات للمفاتيح
cat > config.js <<'EOF'
const CONFIG = {
  HUGGINGFACE_API_KEY: "",  // ضع مفتاحك من https://huggingface.co/settings/tokens
  REPLICATE_API_KEY: ""     // اختياري
};
EOF

# إنشاء صفحة أدوات الذكاء الاصطناعي التفاعلية
cat > ai-tools.html <<'EOF'
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>أدوات الذكاء الاصطناعي - وليد الخلاقي</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.3/dist/tailwind.min.css">
</head>
<body class="bg-gray-50 text-gray-900 font-sans">
  <header class="bg-white shadow-md p-4 text-center">
    <img src="logo.svg" alt="logo" class="mx-auto mb-2 w-32">
    <h1 class="text-xl font-bold">أدوات الذكاء الاصطناعي</h1>
    <a href="index.html" class="text-blue-600 underline text-sm">🏠 العودة للرئيسية</a>
  </header>

  <main class="max-w-2xl mx-auto mt-8 space-y-8 p-4">

    <!-- مولد النصوص -->
    <section class="bg-white p-4 rounded-xl shadow">
      <h2 class="font-bold mb-2">✍️ مولد النصوص</h2>
      <textarea id="prompt" rows="3" class="w-full border p-2 rounded" placeholder="أدخل فكرة النص..."></textarea>
      <button onclick="generateText()" class="mt-2 bg-blue-600 text-white px-4 py-2 rounded">توليد</button>
      <pre id="result" class="mt-3 bg-gray-100 p-3 rounded text-sm"></pre>
    </section>

    <!-- مولد الصور -->
    <section class="bg-white p-4 rounded-xl shadow">
      <h2 class="font-bold mb-2">🎨 توليد الصور</h2>
      <input id="imagePrompt" type="text" class="w-full border p-2 rounded" placeholder="صف الصورة التي تريدها...">
      <button onclick="generateImage()" class="mt-2 bg-green-600 text-white px-4 py-2 rounded">توليد الصورة</button>
      <div id="imageResult" class="mt-3 flex justify-center"></div>
    </section>

  </main>

  <script src="config.js"></script>
  <script>
  async function generateText() {
    const prompt = document.getElementById("prompt").value;
    const result = document.getElementById("result");
    result.textContent = "⏳ جاري توليد النص...";
    try {
      const response = await fetch("https://api-inference.huggingface.co/models/gpt2", {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${CONFIG.HUGGINGFACE_API_KEY}`,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ inputs: prompt })
      });
      const data = await response.json();
      result.textContent = data[0]?.generated_text || "لم يتم توليد نص.";
    } catch (err) {
      result.textContent = "⚠️ حدث خطأ أثناء التوليد.";
    }
  }

  async function generateImage() {
    const prompt = document.getElementById("imagePrompt").value;
    const container = document.getElementById("imageResult");
    container.innerHTML = "⏳ جاري توليد الصورة...";
    try {
      const img = document.createElement("img");
      img.src = `https://picsum.photos/seed/${encodeURIComponent(prompt)}/400/300`;
      img.className = "rounded-xl shadow mt-2";
      container.innerHTML = "";
      container.appendChild(img);
    } catch (err) {
      container.innerHTML = "⚠️ لم يتم إنشاء الصورة.";
    }
  }
  </script>
</body>
</html>
EOF

# حفظ وإظهار النتيجة
echo "✅ تم إنشاء نظام المقالات والشعار وصفحة أدوات الذكاء الاصطناعي بنجاح."
echo "📂 المسار: $(pwd)"
echo "---------------------------"
echo "⚙️ بعد ذلك:"
echo "1. افتح config.js وأضف مفاتيحك (اختياري)."
echo "2. لتشغيل محلياً:"
echo "   cd ~/waleedalkhulaqi-website/v2"
echo "   python3 -m http.server 8000"
echo "   ثم افتح: http://localhost:8000"
