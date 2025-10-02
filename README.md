# AI Proxy for Alibaba Cloud Function Compute

## كيفية النشر
1. افتح [Function Compute Console](https://fc.console.aliyun.com/)
2. أنشئ خدمة باسم `ai-proxy-service`
3. أنشئ دالة باسم `ai-proxy-function` باستخدام Runtime: Node.js 18
4. ارفع هذا المجلد كـ ZIP
5. في Environment Variables، أضف:
   - Key: `OPENROUTER_API_KEY`
   - Value: `ak_01k22rc3x1e148dcgbk3d3jaj3`
6. أضف HTTP Trigger (POST, OPTIONS)
7. استخدم الرابط في موقع React الخاص بك
