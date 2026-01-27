echo "Démarrage de la conversion XML..."
echo "Début du nettoyage du XML..."

python3 parseToValidXML.py

echo "Fin du nettoyage du XML"
echo "Début de la vérification de l'intégrité du XML..."

xmllint --noout code_penal_fixed.xml

echo "Fin de la vérification de l'intégrité du XML"
echo "Début de la transformation du XML en HTML, grâce au stylesheet XSLT..."

xsltproc stylesheet.xsl code_penal_fixed.xml > output.html

echo "Fin de la transformation du XML en HTML, grâce au stylesheet"
echo "Début de la transformation du HTML en .docx, avec Pandoc et reference.docx..."

pandoc output.html -o output.docx --reference-doc=reference.docx

echo "Fin de la transformation du HTML en .docx, avec Pandoc et reference.docx"
echo "Fin de la conversion XML en .docx -> output.docx"
