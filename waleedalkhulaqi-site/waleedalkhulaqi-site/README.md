# Waleed Alkhulaqi – Personal Website

هذا مشروع موقع شخصي احترافي مبني باستخدام **React + Vite**  
ومجهز للنشر مباشرة على **GitHub Pages** مع نطاق مخصص.

---

## 🚀 خطوات النشر على GitHub Pages

1. ارفع المشروع إلى مستودع جديد على GitHub.
2. تأكد أن الملفات التالية موجودة:
   - `vite.config.js`
   - `.github/workflows/deploy.yml`
   - `public/CNAME`
3. ادفع التغييرات (push) إلى الفرع `main`.
4. من إعدادات المستودع في GitHub:
   - ادخل إلى **Settings → Pages**
   - اجعل النشر يتم من **GitHub Actions**.
5. بعد أول push، الموقع سينشر تلقائيًا على نطاقك:
   👉 https://waleedalkhulaqi.website

---

## 🛠️ أوامر التطوير محليًا

- تثبيت الحزم:
  ```bash
  npm install
cd ~/waleedalkhulaqi-website && \
pkg install nodejs git nano -y && \
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/',
})
EOF && \
npm install && \
npm run build && \
git add vite.config.js && \
git commit -m "Fix base path for custom domain" && \
git push origin main
cd ~/waleedalkhulaqi-website
pkg install nodejs git nano -y
y
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/',
})
