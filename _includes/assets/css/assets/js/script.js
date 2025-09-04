document.addEventListener("DOMContentLoaded", function () {
  const toggleBtn = document.getElementById("darkModeToggle");
  const body = document.body;

  // تحقق من حالة الوضع الداكن من localStorage
  const isDarkMode = localStorage.getItem("darkMode") === "true";

  if (isDarkMode) {
    body.classList.add("dark-mode");
    toggleBtn.setAttribute("aria-label", "تفعيل الوضع الفاتح");
  }

  // تفعيل التبديل
  toggleBtn.addEventListener("click", function () {
    body.classList.toggle("dark-mode");

    const isDark = body.classList.contains("dark-mode");
    localStorage.setItem("darkMode", isDark);

    // تغيير النص حسب الحالة
    if (isDark) {
      toggleBtn.setAttribute("aria-label", "تفعيل الوضع الفاتح");
    } else {
      toggleBtn.setAttribute("aria-label", "تفعيل الوضع الداكن");
    }
  });

  // تحميل الوضع عند تحميل الصفحة
  if (isDarkMode) {
    body.classList.add("dark-mode");
  }
});
