// server.js — Agent Proxy جاهز للعمل على Node 24
// مجلد: ~/waleedalkhulaqi-website/agent-proxy

const express = require('express');
const cors = require('cors');
const EventSourceClient = require('eventsource'); // مكتبة EventSource لـ Node
const app = express();
const PORT = 3001;

// تمكين CORS للصفحة
app.use(cors());
app.use(express.json());

let clients = [];

// نقطة SSE للصفحة
app.get('/events', (req, res) => {
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');
  res.flushHeaders();

  const clientId = Date.now();
  const newClient = { id: clientId, res };
  clients.push(newClient);

  req.on('close', () => {
    clients = clients.filter(c => c.id !== clientId);
  });
});

// دالة لإرسال رسالة لكل العملاء المتصلين
function sendMessage(message) {
  clients.forEach(client => client.res.write(`data: ${message}\n\n`));
}

// مثال: الاتصال بوكيل خارجي SSE (تعديل الـ URL حسب وكيلك)
const SSE_URL = "https://myaiagent12.web.dappier.com/askai/wd_01k63ndmaefqdtjvdrp9rktqwb/event?apiKey=ak_01k22rc3x1e148dcgbk3d3jaj3&sessionId=4c31700e5013abdadbe9107c132a665f5cdc11dfdea9fa7425fdc1a38b37928b";

const es = new EventSourceClient(SSE_URL);

es.onmessage = (ev) => {
  console.log("📩 رسالة من الوكيل:", ev.data);
  sendMessage(ev.data);
};

es.onerror = (err) => {
  console.error("❌ خطأ في الاتصال بالوكيل:", err);
  sendMessage("❌ فشل الاتصال بالوكيل...");
};

app.listen(PORT, () => {
  console.log(`✅ Server listening on port ${PORT}`);
});
