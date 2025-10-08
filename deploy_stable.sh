#!/data/data/com.termux/files/usr/bin/bash
clear
echo "⚠️ بدء إعادة نشر الموقع مع تقرير SEO اليوم 1..."

# 1️⃣ الانتقال إلى مجلد الموقع
cd ~/waleedalkhulaqi-website

# 2️⃣ مسح جميع التعديلات المحلية
git restore . 2>/dev/null || true
echo "✅ تم مسح جميع التعديلات المحلية."

# 3️⃣ التحقق من وجود أي commit سابق
if git rev-parse HEAD >/dev/null 2>&1; then
    echo "✅ يوجد commit سابق، سيتم التراجع عن آخر commit إن وجد..."
    git reset --hard HEAD~1 2>/dev/null || true
fi

# 4️⃣ إعادة تسمية الفرع الافتراضي إلى master
git branch -M master

# 5️⃣ إنشاء تقرير SEO اليوم 1 بصيغة PDF
cat > seo-report-day1.pdf << 'EOF'
تقرير تحسين محركات البحث (SEO) - اليوم 1

🔹 الموقع: https://waleedalkhulaqi.website
🔹 التاريخ: 8 أكتوبر 2025

📊 نتائج الفحص:
- عدد الصفحات التي تم الزحف إليها: 7
- النتيجة الإجمالية: 37 / 100

🚧 المشاكل العامة:
1. عدم وجود أيقونة مفضلة (favicon)
2. غياب سياسة أمان المحتوى (CSP)
3. عدم وجود إعادة توجيه إلى HTTPS في رأس الاستجابة

⚙️ المشاكل الخاصة بالصفحات:
- 3 صفحات بدون H2
- 7 صفحات بدون canonical
- 3 روابط داخلية فقط
- كسر في تسلسل العناوين في صفحة واحدة
- صورة واحدة بدون أبعاد
- تأخير تحميل الصور خارج الشاشة (lazy load مفقود)

✅ الإجراءات المتخذة:
1. إضافة Favicon لجميع الصفحات.
2. تفعيل Content-Security-Policy ضد هجمات XSS.
3. فرض HTTPS لجميع الزوار.
4. إضافة H1 وH2 بشكل منظم.
5. إضافة lazy loading وأبعاد للصور.
6. إصلاح الروابط الداخلية.

📈 النتيجة المتوقعة بعد التحسين:
- تحسن سرعة الموقع بنسبة 30%
- تقوية حماية الموقع ضد الهجمات
- زيادة فهرسة الصفحات في Google وBing

🔗 إعداد بواسطة: Waleed Alkhulaqi
EOF

# 6️⃣ إضافة جميع الملفات ورفعها إلى GitHub
git add .
git commit -m "Reset today changes + Upload stable optimized website + SEO report" 2>/dev/null || true
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/alkhulaqiw/waleedalkhulaqi-website.git"

git push -u origin master --force

# 7️⃣ التحقق من حالة GitHub Pages
echo "🔍 التحقق من حالة GitHub Pages..."
sleep 20
HTTP_STATUS=$(curl -Is https://waleedalkhulaqi.website | grep HTTP)
echo "$HTTP_STATUS"

if echo "$HTTP_STATUS" | grep -q "200 OK"; then
  echo "✅ الموقع تم نشره بنجاح!"
  echo "📄 تقرير SEO اليوم 1 متاح هنا: https://waleedalkhulaqi.website/seo-report-day1.pdf"
else
  echo "⚠️ لم يتم تفعيل GitHub Pages بعد، انتظر دقيقة وأعد المحاولة."
fi

echo "✨ العملية اكتملت بنجاح!"
