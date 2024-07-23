const express = require('express');
const app = express();
const https = require('https');
const fs = require('fs');

const port = 3000;

// Middleware to parse JSON bodies
app.use(express.json());

// Example route
app.get('/', (req, res) => {
  res.send('Hello from Node.js API!');
});

// Start HTTPS server
const serverOptions = {
  key: fs.readFileSync('/etc/nginx/certs/nginx.key'),
  cert: fs.readFileSync('/etc/nginx/certs/nginx.crt')
};

https.createServer(serverOptions, app).listen(port, () => {
  console.log(`Server is running on https://localhost:${port}`);
});
