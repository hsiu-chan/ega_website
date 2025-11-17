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
