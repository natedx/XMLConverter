import html, sys

with open("code_penal.xml", "r", encoding="utf-8", errors="replace") as f:
    data = f.read()

# convertit &eacute; &agrave; &mdash; etc en vrais caractères UTF-8
data = html.unescape(data)

with open("code_penal_fixed.xml", "w", encoding="utf-8") as f:
    f.write(data)
