#!/bin/bash
# ------------------------------------------------------
# سكربت يومي لتحديث موقع waleedalkhulaqi.website
# يقوم بإنشاء المقالات، تحديث sitemap.xml وrobots.txt
# يرسل إشعار Telegram بعد التحديث
# ------------------------------------------------------

# ⚡ إعدادات Telegram
BOT_TOKEN="7947543146:AAGoo18yqInJKHAJynLrKq4145ACuRazR7c"
CHAT_ID="7154547734"

# الانتقال لمجلد المشروع
cd ~/waleedalkhulaqi-website || exit

# التأكد من الفرع الصحيح
git checkout v2

# جلب ودمج آخر نسخة من GitHub
git fetch origin
git pull origin v2

# رفع أي تغييرات محلية (إذا وجدت)
git add .
git commit -m "تحديث يومي: إنشاء مقالات وSEO" || echo "لا توجد تغييرات جديدة للرفع"
git push origin v2

# تشغيل سكربت إنشاء المقالات وتحديث sitemap وrobots
node create_content_structure_seo.js

# جمع معلومات التقرير
NUM_ARTICLES=$(node -e "const fs=require('fs'); const path=require('path'); const baseDir=path.join(__dirname,'articles'); console.log(Object.values(require('fs').readdirSync(baseDir)).reduce((acc,cat)=>acc+fs.readdirSync(path.join(baseDir,cat)).length,0))")
DATE=$(date +"%Y-%m-%d %H:%M:%S")

REPORT="✅ تحديث الموقع تم بنجاح!
🗓 التاريخ: $DATE
📄 عدد المقالات الموجودة الآن: $NUM_ARTICLES
🌐 sitemap.xml و robots.txt تم تحديثهم!"

# إرسال الإشعار إلى Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
-d chat_id="$CHAT_ID" \
-d text="$REPORT" > /dev/null

echo "$REPORT"
echo "📩 تم إرسال إشعار Telegram بنجاح!"
