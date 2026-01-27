#!/usr/bin/env bash
set -e

INPUT_DIR="input"
OUTPUT_DIR="output"
WORK_DIR="work"

mkdir -p "$INPUT_DIR" "$OUTPUT_DIR" "$WORK_DIR"

XML_INPUT_FILE=$(ls "$INPUT_DIR"/*.xml 2>/dev/null | head -n 1)

if [ -z "$XML_INPUT_FILE" ]; then
  echo "Aucun fichier .xml trouvé dans le dossier input/"
  exit 1
fi

echo "Fichier XML utilisé : $XML_INPUT_FILE"

echo "Démarrage de la conversion XML..."
echo "Début du nettoyage du XML..."

python3 parseToValidXML.py "$XML_INPUT_FILE" "$WORK_DIR/code_penal_fixed.xml"

echo "Fin du nettoyage du XML"
echo "Début de la vérification de l'intégrité du XML..."

xmllint --noout "$WORK_DIR/code_penal_fixed.xml"

echo "Fin de la vérification de l'intégrité du XML"
echo "Début de la transformation du XML en HTML, grâce au stylesheet XSLT..."

xsltproc stylesheet.xsl "$WORK_DIR/code_penal_fixed.xml" > "$WORK_DIR/output.html"

echo "Fin de la transformation du XML en HTML, grâce au stylesheet"
echo "Début de la transformation du HTML en .docx, avec Pandoc et reference.docx..."

pandoc "$WORK_DIR/output.html" -o "$OUTPUT_DIR/output.docx" --reference-doc=reference.docx

echo "Fin de la transformation du HTML en .docx, avec Pandoc et reference.docx"
echo "Fin de la conversion XML en .docx -> $OUTPUT_DIR/output.docx"
