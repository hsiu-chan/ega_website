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
