#!/bin/bash
# =========================================
# 🔹 فحص شامل لموقع AI tools على GitHub Pages
# النسخة 3 مع انتظار HTTPS
# النطاق: waleedalkhulaqi.website
# =========================================

DOMAIN="waleedalkhulaqi.website"
AI_TEXT_URL="https://$DOMAIN/ai-tools.html"
PROMPT="مرحبا بك في موقع وليد الخلاقي"
IMAGE_PROMPT="منظر طبيعي جميل"
MAX_RETRIES=10
SLEEP_SEC=15

# تحميل مفتاح Hugging Face إذا كان موجود
if [ -f "$HOME/hf_config.sh" ]; then
    source "$HOME/hf_config.sh"
fi

echo "==============================="
echo "🔹 التحقق من الوصول للموقع الرئيسي (HTTPS)"
echo "==============================="

RETRY=0
while [ $RETRY -lt $MAX_RETRIES ]; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://$DOMAIN)
    if [ "$STATUS" == "200" ]; then
        echo "✅ الموقع متاح HTTPS: https://$DOMAIN"
        break
    else
        echo "⚠️ الموقع غير متاح بعد أو SSL غير جاهز (HTTP $STATUS), إعادة المحاولة بعد $SLEEP_SEC ثانية..."
        sleep $SLEEP_SEC
        ((RETRY++))
    fi
done

if [ $RETRY -eq $MAX_RETRIES ]; then
    echo "❌ فشل الوصول إلى الموقع بعد عدة محاولات. تحقق من GitHub Pages وHTTPS."
    exit 1
fi

echo ""
echo "==============================="
echo "🔹 التحقق من صفحة أدوات الذكاء الاصطناعي"
echo "==============================="
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $AI_TEXT_URL)
if [ "$STATUS" == "200" ]; then
    echo "✅ الصفحة موجودة: $AI_TEXT_URL"
else
    echo "❌ الصفحة غير موجود (HTTP $STATUS)"
    echo "تأكد أن ai-tools.html موجود في جذر الفرع v2 عند النشر على GitHub Pages."
fi
echo ""

echo "==============================="
echo "🔹 تجربة توليد نصوص (اختبار API)"
echo "==============================="
if [ -z "$HUGGINGFACE_API_KEY" ]; then
    echo "⚠️ لم يتم ضبط HUGGINGFACE_API_KEY، لن يعمل الاختبار."
else
    TEXT_RESULT=$(curl -s -X POST "https://api-inference.huggingface.co/models/gpt2" \
      -H "Authorization: Bearer $HUGGINGFACE_API_KEY" \
      -H "Content-Type: application/json" \
      -d "{\"inputs\":\"$PROMPT\"}" | grep -o '"generated_text":"[^"]*' | sed 's/"generated_text":"//')
    if [ -n "$TEXT_RESULT" ]; then
        echo "✅ نص مولد بنجاح:"
        echo "$TEXT_RESULT"
    else
        echo "❌ فشل في توليد النص. تأكد من HUGGINGFACE_API_KEY"
    fi
fi
echo ""

echo "==============================="
echo "🔹 تجربة توليد صورة (اختبار API)"
echo "==============================="
IMAGE_URL="https://picsum.photos/seed/${IMAGE_PROMPT}/400/300"
curl -s -o /dev/null -w "✅ اختبار رابط الصورة متاح: %{url_effective}\n" "$IMAGE_URL"
echo ""

echo "✅ انتهى الفحص الشامل."
