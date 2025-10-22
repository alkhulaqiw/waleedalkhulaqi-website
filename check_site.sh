#!/bin/bash
# =========================================
# 🔍 فحص موقع GitHub Pages وDNS
# النطاق: waleedalkhulaqi.website
# =========================================

DOMAIN="waleedalkhulaqi.website"
WWW_DOMAIN="www.$DOMAIN"

echo "==============================="
echo "🔹 فحص DNS لنطاق $DOMAIN"
echo "==============================="
echo "--- CNAME / A Records ---"
nslookup $DOMAIN
nslookup $WWW_DOMAIN
echo ""

echo "==============================="
echo "🔹 اختبار الوصول للموقع (HTTP)"
echo "==============================="
echo "--- curl HTTP headers ---"
curl -I https://$DOMAIN
curl -I https://$WWW_DOMAIN
echo ""

echo "==============================="
echo "🔹 التحقق من GitHub Pages محليًا"
echo "==============================="
if [ -d "$HOME/waleedalkhulaqi-website/v2" ]; then
    cd $HOME/waleedalkhulaqi-website/v2
    echo "--- التحقق من وجود index.html ---"
    if [ -f "index.html" ]; then
        echo "✅ index.html موجود"
    else
        echo "❌ index.html غير موجود!"
    fi

    echo "--- التحقق من ملف CNAME ---"
    if [ -f "CNAME" ]; then
        echo "✅ CNAME موجود ويحتوي على:"
        cat CNAME
    else
        echo "❌ CNAME غير موجود!"
    fi
else
    echo "❌ مجلد v2 غير موجود في $HOME/waleedalkhulaqi-website"
fi
echo ""

echo "==============================="
echo "🔹 اختبار SSL و HTTPS"
echo "==============================="
curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" https://$DOMAIN
curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" https://$WWW_DOMAIN
echo ""

echo "==============================="
echo "🔹 مسح DNS cache (اختياري)"
echo "==============================="
ndc resolver flushdefaultif 2>/dev/null || echo "⚠️ لم يتمكن من مسح DNS cache (قد لا يؤثر)"
echo ""
echo "✅ تم الانتهاء من الفحص."
