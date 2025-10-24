const express = require('express');
const cors = require('cors');
const EventSourceClient = require('eventsource');
const app = express();
const PORT = 3001;

app.use(cors());
app.use(express.json());

let clients = [];

app.get('/events', (req, res) => {
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');
  res.flushHeaders();

  const clientId = Date.now();
  const newClient = { id: clientId, res };
  clients.push(newClient);

  console.log(`🟢 عميل متصل: ${clientId} (عدد العملاء: ${clients.length})`);

  req.on('close', () => {
    clients = clients.filter(c => c.id !== clientId);
    console.log(`🔴 عميل فصل: ${clientId} (عدد العملاء: ${clients.length})`);
  });
});

function sendMessage(message) {
  clients.forEach(client => client.res.write(`data: ${message}\n\n`));
}

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

app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="ar" dir="rtl">
    <head>
      <meta charset="UTF-8">
      <title>واجهة SSE الوكيل</title>
      <style>
        body { font-family: Arial, sans-serif; padding: 20px; background: #f4f4f4; }
        h1 { color: #333; }
        #messages { border: 1px solid #ccc; padding: 10px; background: #fff; height: 300px; overflow-y: scroll; }
      </style>
    </head>
    <body>
      <h1>📡 رسائل الوكيل في الوقت الحقيقي</h1>
      <div id="messages"></div>
      <script>
        const evtSource = new EventSource('/events');
        const messagesDiv = document.getElementById('messages');

        evtSource.onmessage = (event) => {
          const p = document.createElement('p');
          p.textContent = event.data;
          messagesDiv.appendChild(p);
          messagesDiv.scrollTop = messagesDiv.scrollHeight;
        };

        evtSource.onerror = () => {
          const p = document.createElement('p');
          p.textContent = "❌ فشل الاتصال بالسيرفر...";
          p.style.color = "red";
          messagesDiv.appendChild(p);
        };
      </script>
    </body>
    </html>
  `);
});

app.listen(PORT, () => {
  console.log(`✅ Server listening on port ${PORT}`);
  console.log(`🌐 افتح المتصفح على http://localhost:${PORT} لتجربة SSE`);
});
