import re
import html
import sys

# Entités XML à NE PAS toucher
XML_BUILTINS = {"amp", "lt", "gt", "quot", "apos"}

if len(sys.argv) != 3:
    print("Usage: python3 parseToValidXML.py <input.xml> <output.xml>")
    sys.exit(1)

input_path = sys.argv[1]
output_path = sys.argv[2]

with open(input_path, "r", encoding="utf-8", errors="replace") as f:
    data = f.read()

# Convertit uniquement les entités nommées NON XML (ex: egrave, eacute...)
def repl(m):
    name = m.group(1)
    if name in XML_BUILTINS:
        return "&" + name + ";"   # on garde tel quel
    # sinon on convertit en entité numérique décimale
    # ex: &egrave; -> &#232;
    ch = html.unescape("&" + name + ";")
    if ch.startswith("&"):  # entité inconnue
        return "&" + name + ";"
    return "&#" + str(ord(ch)) + ";"

data = re.sub(r"&([A-Za-z][A-Za-z0-9]+);", repl, data)

# On supprime la déclaration DOCTYPE qui est inconnue et propriétaire.
data = re.sub(r'<!DOCTYPE[^>]*>', '', data)

with open(output_path, "w", encoding="utf-8") as f:
    f.write(data)
