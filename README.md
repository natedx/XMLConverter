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
Le XML fourni n'est pas utilisable tel quel par XSLT, car il contient des caractères non autorisés.
Nous utilisons donc XMLLint pour vérifier que le XML est intègre avant d'essayer d'utiliser XSLT.

Voir le manuel : https://gnome.pages.gitlab.gnome.org/libxml2/xmllint.html

Cependant, nous n'utilisons pas XMLLint pour faire les corrections, nous les faisons manuellement en Python.

### Python pour corriger le XML propriétaire

On utilise un script python tout simple pour remplacer les entités HTML par des entités XML uniquement.
Voir le fichier `parseToValidXML.py`

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

- Il n'est pas obligatoire de créer `work/` et `output/`, le script s'en chargera.
- Le fichier XML **d’entrée** doit être placé dans `data/input/`
- Le script utilisera automatiquement le premier fichier `*.xml` trouvé dans ce dossier
- Les fichiers intermédiaires (y compris le fichier HTML intermédiaire) seront générés dans `data/work/`
- Le fichier final sera généré dans `data/output/output.docx`

---

### 3. Télécharger et exécuter le conteneur

Télécharger l’image Docker :

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


## Développer en local avec Docker

Docker peut également être utilisé comme **environnement de développement**, afin d’éviter toute installation locale de dépendances (Python, Pandoc, xsltproc, xmllint, etc.).

Cette approche permet de modifier les scripts **localement** tout en les exécutant **dans le conteneur**, avec un cycle de feedback rapide.

---

### Principe général

- Le conteneur fournit toutes les dépendances
- Le code source local est monté dans le conteneur
- Le dossier `data/` est monté pour conserver les entrées/sorties
- Chaque exécution utilise **la version locale des fichiers**

---

### Commande de développement

Depuis la racine du projet, construire l’image (une seule fois ou après modification du Dockerfile) :

```
docker build -t xmlconverter .
```

Puis lancer le pipeline en mode développement :

```
docker run --rm \
  -v "$(pwd):/app" \
  -v "$(pwd)/../data:/data" \
  -e DATA_DIR=/data \
  xmlconverter
```

---

### Ce que fait cette commande

- `-v "$(pwd):/app"`  
  Monte le code source local dans le conteneur  
  → toute modification de script est immédiatement prise en compte

- `-v "$(pwd)/../data:/data"`  
  Monte les entrées/sorties du pipeline  
  → les fichiers générés restent sur la machine hôte

- `-e DATA_DIR=/data`  
  Indique explicitement au script où se trouvent les données

- `--rm`  
  Supprime le conteneur après exécution (environnement jetable)

---

### Boucle de développement typique

1. Modifier `parseToValidXML.py`, `main.sh` ou `stylesheet.xsl`
2. Mettre à jour ou remplacer le fichier XML dans `data/input/`
3. Relancer la commande `docker run ...` (voir plus haut)
4. Vérifier le résultat dans `data/output/output.docx` ou `data/work/output.html`

---

💡 **Astuce** : tant que le `Dockerfile` ne change pas, il n’est pas nécessaire de reconstruire l’image (`docker build`).


## Modifier le rendu HTML et le style du document Word

La conversion repose sur **deux leviers distincts** :

- `stylesheet.xsl` : contrôle la **structure HTML intermédiaire**
- `reference.docx` : contrôle le **style final du document Word**

---

### Modifier le HTML intermédiaire (`stylesheet.xsl`)

Le fichier `stylesheet.xsl` transforme le XML source en HTML via XSLT.

Chaque règle de ce fichier indique :
- **quelle balise XML** est ciblée (`match="NIV1"`, `match="ARTI"`, etc.)
- **quel HTML** est généré (`<h1>`, `<p>`, `<b>`, listes, etc.)

Exemples simples :
- changer une balise `<h1>` en `<h2>` modifie la hiérarchie HTML
- supprimer ou ajuster une règle permet d’inclure / exclure certaines parties du document
- on pourrait même imaginer ajouter une classe CSS (`<h1 class="partie">`) pour un beau rendu sur le navigateur.

Le fichier est largement commenté : la modification se fait directement dans les templates existants.

Après modification, relancer simplement le pipeline de développement local avec Docker pour voir le résultat.

---

### Modifier le style du document Word (`reference.docx`)

Le fichier `reference.docx` est utilisé par Pandoc comme **document de référence**.

Il définit :
- les styles Word (Titres 1 à 6, Normal, Listes, etc.)
- les polices, tailles, marges, espacements
- la numérotation et la hiérarchie visuelle

Pour modifier le rendu final :

1. Ouvrir `reference.docx` dans Microsoft Word ou LibreOffice
2. Modifier les styles (ex. *Titre 1*, *Titre 2*, *Normal*)
3. Enregistrer le fichier
4. Relancer la conversion

Pandoc appliquera automatiquement ces styles au document généré.

---

### Conclusion

- **La structure** se règle dans `stylesheet.xsl`
- **L’apparence finale** se règle dans `reference.docx`, c'est superficiel

Il est recommandé de modifier d’abord le XSLT pour obtenir une structure HTML correcte, puis d’affiner le rendu Word via le document de référence.
