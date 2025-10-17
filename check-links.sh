#!/bin/bash

# رابط موقعك على GitHub Pages
BASE_URL="https://alkhulaqiw.github.io/waleedalkhulaqi-website"

# قائمة الملفات / الصفحات
PAGES=("index.html" "about.html" "ai-tools.html" "blog.html" "contact.html" "media.html" "services.html")

echo "🔍 Checking links on $BASE_URL ..."

for page in "${PAGES[@]}"
do
    URL="$BASE_URL/$page"
    STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL")
    if [ "$STATUS" -eq 200 ]; then
        echo "✅ $URL is OK"
    else
        echo "❌ $URL returned $STATUS"
    fi
done
