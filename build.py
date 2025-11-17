import os
import json
from jinja2 import Environment, FileSystemLoader

# 讀取 data.json
with open('data.json', 'r', encoding='utf-8') as f:
    config = json.load(f)

template_dir = 'templates'
out_dir = './'

env = Environment(loader=FileSystemLoader(template_dir), autoescape=True)

pages = config.get("pages", {})

# 確保輸出資料夾存在
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

# Render 各頁面
for filename, ctx in pages.items():
    tpl = env.get_template(filename)
    merged_ctx = {
        **ctx,
        "clinic_name": config.get("clinic_name", ""),
        "current_year": config.get("current_year", ""),
        "address": config.get("address", ""),
        "phone": config.get("phone", ""),
        "business_hours": config.get("business_hours", ""),
        "hero_img":config.get("hero_img",""),
        "doctors": config.get("doctors", []),
        "services": config.get("services", [])
        
    }
    output = tpl.render(**merged_ctx)

    with open(os.path.join(out_dir, filename), 'w', encoding='utf-8') as f:
        f.write(output)

print("Build finished with data.json.")
