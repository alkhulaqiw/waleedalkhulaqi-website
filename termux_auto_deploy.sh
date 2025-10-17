#!/bin/bash
# ======================================================
# 🌍 نشر موقع وليد الخلاقي تلقائيًا على Alibaba Cloud OSS
# 🤖 طلب فهرسة Google Indexing API
# 📧 إرسال تقرير يومي عبر البريد
# ⚡ إعداد كامل في Termux
# ======================================================

# ----- إعدادات أساسية -----
OSSUTIL="$HOME/ossutilarm64"
BUCKET="oss://waleedalkhulaqi-website"
LOCAL_DIR="$HOME/waleedalkhulaqi-website"
LOG_FILE="$LOCAL_DIR/full_auto_log.txt"
GOOGLE_KEY_PATH="$LOCAL_DIR/google-key.json"
SITE_URL="https://waleedalkhulaqi.website"
REPORT_EMAIL="info@waleedalkhulaqi.website"  # ضع بريدك هنا
CRON_TIME="0 9 * * *"                        # توقيت التشغيل اليومي

# ----- تثبيت الأدوات المطلوبة -----
pkg update -y
pkg install -y python3 curl git proot
pkg install -y msmtp       # بديل sendmail
pip install --upgrade google-auth google-auth-httplib2 google-auth-oauthlib

# ----- تهيئة تقرير msmtp -----
cat > ~/.msmtprc <<EOL
account default
host smtp.gmail.com
port 587
auth on
user $REPORT_EMAIL
password ضع_كلمة_المرور_هنا
tls on
tls_starttls on
logfile ~/.msmtp.log
EOL
chmod 600 ~/.msmtprc

# ----- وظيفة رفع الموقع -----
upload_site() {
    echo "⬆️ رفع الملفات إلى OSS..."
    $OSSUTIL sync "$LOCAL_DIR" "$BUCKET" --update --delete >> "$LOG_FILE" 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ رفع الملفات تم!" | tee -a "$LOG_FILE"
    else
        echo "❌ فشل رفع الملفات!" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# ----- وظيفة إرسال طلب فهرسة Google -----
index_site() {
    echo "🔍 إرسال طلب فهرسة Google..."
    ACCESS_TOKEN=$(python3 - <<END
import google.auth.transport.requests
from google.oauth2 import service_account
creds = service_account.Credentials.from_service_account_file(
    "$GOOGLE_KEY_PATH",
    scopes=["https://www.googleapis.com/auth/indexing"]
)
request = google.auth.transport.requests.Request()
creds.refresh(request)
print(creds.token)
END
)
    curl -s -X POST "https://indexing.googleapis.com/v3/urlNotifications:publish" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -d "{\"url\": \"$SITE_URL\", \"type\": \"URL_UPDATED\"}" >> "$LOG_FILE" 2>&1
    echo "✅ طلب الفهرسة تم!" | tee -a "$LOG_FILE"
}

# ----- وظيفة إرسال التقرير بالبريد -----
send_report() {
    echo "📧 إرسال تقرير النشر إلى البريد..."
    SUBJECT="تقرير نشر موقع وليد الخلاقي $(date '+%Y-%m-%d')"
    BODY=$(cat "$LOG_FILE")
    echo -e "Subject:${SUBJECT}\n\n${BODY}" | msmtp "$REPORT_EMAIL"
    echo "✅ التقرير أرسل!" | tee -a "$LOG_FILE"
}

# ----- تسجيل الوقت -----
echo "--------------------------------------" >> "$LOG_FILE"
echo "📅 $(date)" >> "$LOG_FILE"

# ----- تنفيذ المهام -----
upload_site
index_site
send_report

echo "🌟 العملية اكتملت بنجاح!" | tee -a "$LOG_FILE"

# ----- إضافة Cron تلقائي -----
(crontab -l 2>/dev/null; echo "$CRON_TIME $HOME/waleedalkhulaqi-website/termux_auto_deploy.sh") | crontab -
echo "⏰ تم جدولة السكريبت للتشغيل يوميًا حسب Cron."
