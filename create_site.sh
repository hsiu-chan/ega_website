#!/usr/bin/env bash
set -e
ROOT="dental_clinic_jinja"
rm -rf "$ROOT"
mkdir -p "$ROOT"

# create directories
mkdir -p "$ROOT/templates"
mkdir -p "$ROOT/static/css"
mkdir -p "$ROOT/static/js"
mkdir -p "$ROOT/static/img"
mkdir -p "$ROOT/.github/workflows"
mkdir -p "$ROOT/server_example"

# write files (base.html, index, about, services, contact)
cat > "$ROOT/templates/base.html" <<'EOF'
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content="專業牙科診所 — 定期檢查、矯正、植牙、美白等完整牙科服務" />
  <title>{{ title or "安心牙醫診所" }}</title>

  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="static/css/style.css" />
</head>
<body class="d-flex flex-column min-vh-100">
  <header class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
      <a class="navbar-brand fw-bold text-primary" href="index.html">{{ clinic_name or "安心牙醫診所" }}</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMain">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navMain">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="index.html">首頁</a></li>
          <li class="nav-item"><a class="nav-link" href="about.html">關於我們</a></li>
          <li class="nav-item"><a class="nav-link" href="services.html">診療項目</a></li>
          <li class="nav-item"><a class="nav-link" href="contact.html">聯絡 / 預約</a></li>
        </ul>
      </div>
    </div>
  </header>

  <main class="flex-fill">
    <div class="container py-5">
      {% block content %}{% endblock %}
    </div>
  </main>

  <footer class="bg-light text-center py-3">
    <div class="container">
      <small>© {{ current_year or "2025" }} {{ clinic_name or "安心牙醫診所" }}。All rights reserved.</small>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="static/js/script.js"></script>
</body>
</html>
EOF

cat > "$ROOT/templates/index.html" <<'EOF'
{% extends "base.html" %}
{% block content %}
<section class="row align-items-center">
  <div class="col-lg-6">
    <h1 class="display-5 text-primary">微笑，從這裡開始</h1>
    <p class="lead text-muted">我們提供溫柔、安全、以病患為中心的牙科醫療 — 預防、治療、重建與美學。</p>
    <a class="btn btn-primary me-2" href="contact.html">立即預約</a>
    <a class="btn btn-outline-primary" href="services.html">服務項目</a>
  </div>
  <div class="col-lg-6">
    <img src="static/img/hero.jpg" alt="診所" class="img-fluid rounded shadow-sm">
  </div>
</section>
{% endblock %}
EOF

cat > "$ROOT/templates/about.html" <<'EOF'
{% extends "base.html" %}
{% block content %}
<h2 class="text-primary">關於我們</h2>
<p>我們致力於提供最專業、最貼心的牙科照護。團隊專長：植牙、矯正、兒童牙科、根管治療與美學牙科。</p>
<div class="row g-3">
  <div class="col-md-4">
    <div class="card">
      <img src="static/img/dentist1.jpg" class="card-img-top" alt="醫師">
      <div class="card-body">
        <h5 class="card-title">陳醫師</h5>
        <p class="card-text">主治醫師｜植牙、全口重建</p>
      </div>
    </div>
  </div>
</div>
{% endblock %}
EOF

cat > "$ROOT/templates/services.html" <<'EOF'
{% extends "base.html" %}
{% block content %}
<h2 class="text-primary">診療項目</h2>
<div class="row row-cols-1 row-cols-md-3 g-3">
  <div class="col"><div class="card h-100"><div class="card-body"><h5>一般檢查與洗牙</h5><p class="text-muted mb-0">定期檢查、洗牙與口腔衛教</p></div></div></div>
  <div class="col"><div class="card h-100"><div class="card-body"><h5>根管治療</h5><p class="text-muted mb-0">高品質根管器械與顯微治療</p></div></div></div>
  <div class="col"><div class="card h-100"><div class="card-body"><h5>人工植牙</h5><p class="text-muted mb-0">數位規劃與微創植牙</p></div></div></div>
  <div class="col"><div class="card h-100"><div class="card-body"><h5>矯正治療</h5><p class="text-muted mb-0">隱形矯正與傳統矯正</p></div></div></div>
  <div class="col"><div class="card h-100"><div class="card-body"><h5>美學修復</h5><p class="text-muted mb-0">瓷貼片、全瓷冠與美白</p></div></div></div>
  <div class="col"><div class="card h-100"><div class="card-body"><h5>兒童牙科</h5><p class="text-muted mb-0">友善的兒童就診體驗</p></div></div></div>
</div>
{% endblock %}
EOF

cat > "$ROOT/templates/contact.html" <<'EOF'
{% extends "base.html" %}
{% block content %}
<h2 class="text-primary">聯絡 / 預約</h2>
<div class="row">
  <div class="col-md-6">
    <h5>診所資訊</h5>
    <p>地址：台北市示範路 1 號</p>
    <p>電話：<a href="tel:0212345678">02-1234-5678</a></p>
    <p>營業時間：週一–週五 09:00–18:00，週六 09:00–13:00</p>
    <hr>
    <h6>線上預約選項</h6>
    <ol>
      <li>使用 <strong>Google Forms</strong>：我們提供嵌入範例（免後端）。</li>
      <li>使用 <strong>Formspree</strong>：直接 POST 到 Formspree 以發 Email（無伺服器）。</li>
      <li>自行架設後端：範例 Flask + SendGrid 在 <code>server_example/</code>。</li>
    </ol>
  </div>
  <div class="col-md-6">
    <h5 class="mb-3">直接在本站送出（Formspree 範例）</h5>

    <!-- Formspree: 替換 ACTION 為你的 Formspree endpoint，例如 https://formspree.io/f/xyzz -->
    <form id="appointmentForm" action="https://formspree.io/f/your_form_id" method="POST" class="row g-2">
      <div class="col-12">
        <label class="form-label">姓名<input class="form-control" name="name" required></label>
      </div>
      <div class="col-12">
        <label class="form-label">電話<input class="form-control" name="phone" pattern="[0-9+\-\\s]+" required></label>
      </div>
      <div class="col-12">
        <label class="form-label">電子信箱<input class="form-control" type="email" name="_replyto"></label>
      </div>
      <div class="col-12">
        <label class="form-label">欲預約日期<input class="form-control" type="date" name="date" required></label>
      </div>
      <div class="col-12">
        <label class="form-label">備註<textarea class="form-control" name="message" rows="3"></textarea></label>
      </div>
      <div class="col-12 d-flex gap-2">
        <button type="submit" class="btn btn-primary">送出預約</button>
        <button type="reset" class="btn btn-outline-secondary">重填</button>
      </div>
      <div class="col-12">
        <div id="formResult" class="mt-2" role="status" aria-live="polite"></div>
      </div>
    </form>

    <hr>

    <h6>Google Forms（嵌入）</h6>
    <!-- 範例：將 <iframe> 的 src 替換為你的 Google Forms 發佈後取得的 URL -->
    <div class="ratio ratio-16x9">
      <iframe src="https://docs.google.com/forms/d/e/YOUR_GOOGLE_FORM_ID/viewform?embedded=true" title="Google Form"></iframe>
    </div>

  </div>
</div>
{% endblock %}
EOF

# static files
cat > "$ROOT/static/css/style.css" <<'EOF'
:root{
  --primary: #1e73be;
  --muted: #6c757d;
  --bg: #f8fbff;
  --card: #ffffff;
}
body{background:var(--bg);font-family: 'Noto Sans TC', system-ui, -apple-system, 'Helvetica Neue', Arial;}
.navbar-brand{color:var(--primary) !important}
h1,h2,h3{color:var(--primary)}
.btn-primary{background:var(--primary);border-color:var(--primary)}
.card{border-radius:12px}
EOF

cat > "$ROOT/static/js/script.js" <<'EOF'
// 表單前端小功能：Formspree 處理與回饋
document.addEventListener('DOMContentLoaded', function(){
  const form = document.getElementById('appointmentForm');
  const result = document.getElementById('formResult');
  if(!form) return;

  form.addEventListener('submit', function(e){
    e.preventDefault();
    result.textContent = '送出中…';
    const data = new FormData(form);
    const action = form.action;
    fetch(action, {
      method: 'POST',
      body: data,
      headers: {'Accept':'application/json'}
    }).then(response=>{
      if(response.ok){
        result.textContent = '已收到您的預約，我們會盡快聯絡您。';
        form.reset();
      } else {
        response.json().then(json=>{
          if(json && json.error) result.textContent = json.error;
          else result.textContent = '送出失敗，請稍後再試。';
        }).catch(()=>{ result.textContent = '送出失敗，請稍後再試。' });
      }
    }).catch(err=>{
      console.error(err);
      result.textContent = '網路錯誤，請稍後再試。';
    });
  });
});
EOF

# build.py, requirements, workflow, server example, readme
cat > "$ROOT/build.py" <<'EOF'
from jinja2 import Environment, FileSystemLoader
import os

template_dir = 'templates'
out_dir = './'

env = Environment(loader=FileSystemLoader(template_dir), autoescape=True)

pages = [
    ('index.html', {'title':'安心牙醫診所'}),
    ('about.html', {'title':'關於我們 - 安心牙醫診所'}),
    ('services.html', {'title':'診療項目 - 安心牙醫診所'}),
    ('contact.html', {'title':'聯絡 / 預約 - 安心牙醫診所'}),
]

if not os.path.exists(out_dir):
    os.makedirs(out_dir)

for filename, ctx in pages:
    tpl = env.get_template(filename)
    content = tpl.render(**ctx, current_year='2025', clinic_name='安心牙醫診所')
    with open(os.path.join(out_dir, filename), 'w', encoding='utf-8') as f:
        f.write(content)
print('Build finished.')
EOF

cat > "$ROOT/requirements.txt" <<'EOF'
Jinja2
EOF

cat > "$ROOT/.github/workflows/pages.yml" <<'EOF'
name: Deploy Jinja Website to GitHub Pages

on:
  push:
    branches: [ main ]

permissions:
  contents: write
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.x'

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Build HTML from Jinja
        run: python build.py

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}

    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
EOF

cat > "$ROOT/server_example/app.py" <<'EOF'
# Flask + SendGrid example (server-side email)
# NOTE: This is optional. GitHub Pages cannot run server code.
# To use: deploy to any Python web host (Heroku / Fly / Render / GCP Cloud Run)
from flask import Flask, request, jsonify
import os
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

app = Flask(__name__)

@app.route('/api/appointment', methods=['POST'])
def appointment():
    data = request.form
    name = data.get('name')
    phone = data.get('phone')
    email = data.get('email')
    date = data.get('date')
    message = data.get('message')

    sg_api_key = os.getenv('SENDGRID_API_KEY')
    if not sg_api_key:
        return jsonify({'error':'SendGrid API key not configured'}), 500

    content = f"New appointment:\\nName: {name}\\nPhone: {phone}\\nEmail: {email}\\nDate: {date}\\nMessage: {message}"
    mail = Mail(from_email='no-reply@example.com', to_emails='clinic@example.com', subject='New Appointment', plain_text_content=content)
    try:
        sg = SendGridAPIClient(sg_api_key)
        response = sg.send(mail)
        return jsonify({'ok':True}), 200
    except Exception as e:
        return jsonify({'error':str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
EOF

cat > "$ROOT/README.md" <<'EOF'
# Dental Clinic Jinja Site

## 內容
- Jinja 模板放在 `templates/`
- 靜態資源放在 `static/`
- 執行 `python build.py` 將渲染出的 HTML 放在專案根目錄（可直接部署到 GitHub Pages 或 `docs/`）

## 線上預約選項
1. **Google Forms**：在 `templates/contact.html` 中替換 iframe 的 src 為你的 Google Forms 分享嵌入網址。
2. **Formspree（無伺服器郵件）**：在 contact 表單中將 action 改成你的 Formspree endpoint（範例 `https://formspree.io/f/your_form_id`）。
3. **後端 SendGrid（範例在 server_example/）**：將 `server_example/app.py` 部署到有支援 Python 的伺服器，並設定 `SENDGRID_API_KEY` 環境變數。

## 部署到 GitHub Pages
- workflow 已內建：`.github/workflows/pages.yml`，會在 push 到 main 時自動 build 並 deploy。
- **首次使用請至 GitHub repo → Settings → Pages，選擇 GitHub Actions 作為來源，並啟用。**
EOF

# create placeholder images
touch "$ROOT/static/img/hero.jpg"
touch "$ROOT/static/img/dentist1.jpg"
touch "$ROOT/static/img/logo.png"

# zip
ZIP="/tmp/dental_clinic_jinja.zip"
rm -f "$ZIP"
cd "$ROOT"
zip -r "$ZIP" . >/dev/null
echo "Created zip at $ZIP"
