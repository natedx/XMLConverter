

# XML converter

Construit par SonarVision pour l'association apiDV.


## Bases

Pour commencer, il s'agit de comprendre les outils qu'on utilise.

### XSLT pour transformer le XML propriétaire en HTML
Lire le guide suivant :
https://developer.mozilla.org/en-US/docs/Web/XML/XSLT/Guides/Transforming_XML_with_XSLT

### Pandoc pour transformer le HTML en word
Lire le manuel suivant : https://pandoc.org/MANUAL.html

### XMLLint pour vérifier l'intégrité du XML propriétaire.
Le XML fourni par Dalloz n'est pas utilisable tel quel par XSLT, car il contient des caractères non autorisés.
Nous utilisons donc XMLLint pour vérifier que le XML est intègre avant d'essayer d'utiliser XSLT.

Voir le manuel : https://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html

Cependant, nous n'utilisons pas XMLLint pour faire les corrections, nous les faisons manuellement en Python.

### Python pour corriger le XML propriétaire

On utilise un script python tout simple pour remplacer les entités HTML par des entités XML uniquement.
Voir le fichier `parseToValidXML.py`

## Script principal `main.sh`

Lancer ce script créé des fichiers intermédiaires, et finit par sortir un certain `output.docx`.
C'est ce fichier Word qui contient le résultat de la conversion.

Pour plus d'informations, consulter les commentaires dans `main.sh`
