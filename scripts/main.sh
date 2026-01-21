python3 parseToValidXML.py

xmllint --noout code_penal_fixed.xml
#xmllint --recover --noent code_penal_fixed.xml > code_penal_fixed.xml

xsltproc stylesheet.xsl code_penal_fixed.xml > output.html

pandoc output.html \
  --from=html \
  --to=docx \
  --standalone \
  -o output.docx
