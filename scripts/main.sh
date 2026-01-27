echo "Starting XML conversion"

python3 parseToValidXML.py

echo "Finished cleaning XML file"

xmllint --noout code_penal_fixed.xml
#xmllint --recover --noent code_penal_fixed.xml > code_penal_fixed.xml

echo "Verified that XML file is clean"

xsltproc stylesheet.xsl code_penal_fixed.xml > output.html

echo "Finished translating XML to HTML with stylesheet"

pandoc output.html -o output.docx --reference-doc=reference.docx

echo "Finished XML conversion to .docx Word"
