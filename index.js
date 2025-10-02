const https = require('https');

function fetchOpenRouter(prompt, apiKey, referer) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      model: "meta-llama/llama-3.1-8b-instruct:free",
      messages: [{ role: "user", content: prompt.trim() }],
      max_tokens: 500,
    });

    const options = {
      hostname: 'openrouter.ai',
      port: 443,
      path: '/api/v1/chat/completions',
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${apiKey}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(data),
        'HTTP-Referer': referer,
        'X-Title': 'Waleed Alkhulaqi Site',
      },
    };

    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', (chunk) => body += chunk);
      res.on('end', () => {
        try {
          const json = JSON.parse(body);
          if (res.statusCode >= 200 && res.statusCode < 300) {
            resolve(json);
          } else {
            reject(new Error(json.error?.message || `Status ${res.statusCode}`));
          }
        } catch (e) {
          reject(new Error('Invalid JSON response'));
        }
      });
    });

    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

module.exports.handler = async (req, res, context) => {
  const allowedOrigins = [
    'https://waleedalkhulaqi.website',
    'http://localhost:5173',
    'https://*.stackblitz.io',
  ];
  const origin = req.headers.origin;
  let corsOrigin = '*';
  if (origin) {
    const match = allowedOrigins.find(allowed => 
      allowed.includes('*') 
        ? origin.endsWith(allowed.replace('*.', ''))
        : origin === allowed
    );
    if (match) corsOrigin = origin;
  }

  res.setHeader('Access-Control-Allow-Origin', corsOrigin);
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.status(200).send('');
    return;
  }

  if (req.method !== 'POST') {
    res.status(405).json({ error: 'Method not allowed' });
    return;
  }

  try {
    const body = JSON.parse(req.body);
    const prompt = body.prompt;

    if (!prompt || typeof prompt !== 'string') {
      res.status(400).json({ error: 'Prompt is required' });
      return;
    }

    const apiKey = process.env.OPENROUTER_API_KEY;
    if (!apiKey) {
      res.status(500).json({ error: 'API key not configured' });
      return;
    }

    const result = await fetchOpenRouter(prompt, apiKey, 'https://waleedalkhulaqi.website');
    const output = result.choices?.[0]?.message?.content || 'No content generated.';

    res.status(200).json({ output });

  } catch (err) {
    console.error('Proxy error:', err.message);
    res.status(500).json({ error: 'AI generation failed' });
  }
};
