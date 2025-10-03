# 1. إنشاء مجلد المشروع
mkdir waleedalkhulaqi-site
cd waleedalkhulaqi-site
# 2. تهيئة مشروع React + Vite
npm create vite@latest . -- --template react
npm install
# 3. إنشاء ملف vite.config.js
cat > vite.config.js << 'EOF'
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  base: "/", // عدلها إذا استضفت بغير النطاق المخصص
});
EOF

# 4. إنشاء ملف README.md
cat > README.md << 'EOF'
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

http://waleedalkhulaqi.website/
cat vite.config.js
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  base: '/',
})
EOF

git add vite.config.js
git commit -m "Fix base path - final"
git pull origin main          # لجلب أي تغييرات من GitHub
git push origin main          # لإرسال التصحيح
git fetch origin && git reset --hard origin/main && git checkout main && git pull origin main && npm install && npm run build && git add . && git commit -m "Final fix for deployment" && git push origin main
nano src/main.jsx
nano src/App.jsx
# أعد بناء المشروع
npm run build
# ادفع التغييرات إلى GitHub
git add .
git commit -m "Keep default App.jsx content"
git push origin main
cat dist/index.html
cat public/CNAME
echo "waleedalkhulaqi.website" > public/CNAME
git add public/CNAME
git commit -m "Fix CNAME for custom domain"
git push origin main
bash npm install
npm install
npm run build
git add .
git commit -m "Rebuild after fixing CNAME"
git push origin main
git config --global user.name "Alkhulaqiw"
git config --global user.email "kas201066@gmail.com"
git config --global user.name
git config --global user.email
git add .
git commit -m "Fix git identity"
git push origin main
dig +short waleedalkhulaqi.website
dig +short www.waleedalkhulaqi.website
curl -I https://waleedalkhulaqi.website
- name: Build
- name: Deploy
# 1. إنشاء مجلد المشروع
mkdir waleedalkhulaqi-site
cd waleedalkhulaqi-site
# 2. تهيئة مشروع React + Vite
npm create vite@latest . -- --template react
npm install
# 3. إنشاء ملف vite.config.js
cat > vite.config.js << 'EOF'
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  base: "/", // عدلها إذا استضفت بغير النطاق المخصص
});
EOF

# 4. إنشاء ملف README.md
cat > README.md << 'EOF'
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
EOF

npm install
npm run build
git add vite.config.js
git commit -m "Fix base path for custom domain"
git push origin main
cd ~/waleedalkhulaqi-website && pkg install nodejs git nano -y && cat > vite.config.js << 'EOF'
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
git pull origin main
git pull --rebase origin main
git pull origin main && \
git push origin main

