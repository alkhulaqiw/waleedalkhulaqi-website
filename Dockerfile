# المرحلة الأولى: بناء المشروع (Builder)
# نستخدم نسخة خفيفة من Node.js لبناء المشروع
FROM node:18-alpine AS builder

# تحديد مجلد العمل داخل الـ container
WORKDIR /app

# نسخ ملفات package.json و package-lock.json
COPY package*.json ./

# تثبيت الاعتماديات (dependencies)
RUN npm install

# نسخ جميع ملفات المشروع
COPY . .

# بناء المشروع للـ production
RUN npm run build

# المرحلة الثانية: التشغيل (Runner)
# نستخدم نسخة أخف لتقليل حجم الـ image النهائي
FROM node:18-alpine

WORKDIR /app

# نسخ مجلد .next من مرحلة البناء
COPY --from=builder /app/.next ./.next

# نسخ مجلد public
COPY --from=builder /app/public ./public

# نسخ ملفات package.json
COPY --from=builder /app/package.json ./package.json

# تعريف متغير بيئة التشغيل
ENV NODE_ENV=production

# فتح منفذ 3000
EXPOSE 3000

# الأمر الافتراضي لتشغيل التطبيق
CMD ["npm", "start"]
