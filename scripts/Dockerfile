FROM ubuntu:24.04

# Évite les prompts interactifs pendant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Dépendances nécessaires au pipeline :
# - python3 : parseToValidXML.py
# - xmllint : libxml2-utils
# - xsltproc : transformation XSLT
# - pandoc : HTML -> DOCX
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    python3 \
    libxml2-utils \
    xsltproc \
    pandoc \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copie du script et des ressources nécessaires
COPY main.sh parseToValidXML.py stylesheet.xsl reference.docx /app/

# Rend le script exécutable
RUN chmod +x /app/main.sh

# Par défaut on utilise /data (volume Docker) comme racine des I/O
ENV DATA_DIR=/data
VOLUME ["/data"]

# Exécute le pipeline. On peut surcharger DATA_DIR via -e DATA_DIR=... ou passer un argument.
ENTRYPOINT ["/app/main.sh"]

