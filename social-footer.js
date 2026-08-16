// social-footer.js - Shadow DOM v20260816
document.addEventListener("DOMContentLoaded", function() {
  if (document.getElementById("waleed-social-footer")) return;
  const host = document.createElement("footer");
  host.id = "waleed-social-footer";
  host.setAttribute("role","contentinfo");
  host.setAttribute("lang","ar");
  host.setAttribute("dir","rtl");
  document.body.appendChild(host);
  const shadow = host.attachShadow({mode:"open"});
  const year = new Date().getFullYear();
  shadow.innerHTML = `
    <style>
      :host{display:block;margin-top:40px}
      .wrapper{background:#111;color:#fff;padding:25px 10px;text-align:center;font-family:Tahoma,Arial,sans-serif;direction:rtl}
      nav{display:flex;gap:18px;justify-content:center;flex-wrap:wrap;font-size:15px}
      a{color:inherit;text-decoration:none;display:inline-flex;gap:5px}
      a:hover{text-decoration:underline;opacity:.8}
    </style>
    <div class="wrapper">
      <div style="margin-bottom:14px;font-weight:600">تواصل معي - Waleed Al-Khulaqi © ${year}</div>
      <nav>
        <a href="https://x.com/waleedalkhulaqi" target="_blank" rel="noopener noreferrer" style="color:#1DA1F2">𝕏 تويتر</a>
        <a href="https://instagram.com/waleedalkhulaqi" target="_blank" rel="noopener noreferrer" style="color:#E1306C">📸 انستا</a>
        <a href="https://www.facebook.com/100001570730388" target="_blank" rel="noopener noreferrer" style="color:#1877F2">📘 فيسبوك</a>
        <a href="https://www.threads.com/@waleedalkhulaqi" target="_blank" rel="noopener noreferrer" style="color:#fff">🧵 ثريدز</a>
        <a href="mailto:kas201066@gmail.com" style="color:#FFD700">✉️ ايميل</a>
      </nav>
    </div>`;
});
