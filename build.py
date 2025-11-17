import json
from jinja2 import Environment, FileSystemLoader

# 載入資料
with open("data.json", "r", encoding="utf-8") as f:
    data = json.load(f)

# 設定 Jinja2 模板路徑
env = Environment(loader=FileSystemLoader("templates"))

template = env.get_template("index.html.j2")
rendered = template.render(data)

# 輸出到 GitHub Pages 預設根目錄
with open("index.html", "w", encoding="utf-8") as f:
    f.write(rendered)

print("Generated index.html")
