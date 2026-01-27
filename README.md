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

## Utilisation avec Docker

Cette méthode est la plus simple et la plus fiable pour exécuter le convertisseur, sans installer manuellement toutes les dépendances (Python, Pandoc, XSLT, XMLLint, etc.).

### 1. Installer Docker

Docker est disponible sur tous les principaux systèmes :

- **macOS / Windows**  
  Télécharger et installer Docker Desktop :  
  https://www.docker.com/products/docker-desktop/

- **Linux (Ubuntu / Debian)**  
  ```
  sudo apt update
  sudo apt install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
  ```

Vérifier que Docker fonctionne :
```
docker --version
```

---

### 2. Préparer la structure des fichiers (volume `/data`)

Le conteneur utilise un volume monté sur `/data` pour les entrées et sorties.

Sur votre machine, créez la structure suivante :

```
data/
├── input/
│   └── mon_fichier.xml
├── work/
└── output/
```

- Le fichier XML **d’entrée** doit être placé dans `data/input/`
- Le script utilisera automatiquement le premier fichier `*.xml` trouvé dans ce dossier
- Les fichiers intermédiaires seront générés dans `data/work/`
- Le fichier final sera généré dans `data/output/output.docx`

---

### 3. Télécharger et exécuter le conteneur

Télécharger l’image Docker (à adapter si nécessaire avec le nom exact du dépôt) :

```
docker pull n8dx/xmlconverter:latest
```

Exécuter le conteneur en montant le dossier `data/` :

```
docker run --rm \
  -v "$(pwd)/data:/data" \
  n8dx/xmlconverter:latest
```

Après l’exécution, le fichier Word converti sera disponible dans :

```
data/output/output.docx
```

---

### Remarques

- Le conteneur peut être exécuté depuis n’importe quel dossier tant que le volume `data/` est correctement monté
- Le chemin `/data` est la valeur par défaut, mais il peut être surchargé si nécessaire via la variable d’environnement `DATA_DIR`
