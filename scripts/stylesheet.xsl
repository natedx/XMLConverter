<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- ========================= -->
    <!-- Racine HTML               -->
    <!-- ========================= -->

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                <title>Document</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <!-- ========================= -->
    <!-- TITRES                    -->
    <!-- ========================= -->

    <!-- Titres hiérarchiques : PRENIV -->
    <xsl:template match="PRENIV">
        <xsl:variable name="lvl" select="count(ancestor::*[starts-with(name(),'NIV')])"/>
        <xsl:choose>
            <xsl:when test="$lvl &lt;= 1"><h1><xsl:apply-templates/></h1></xsl:when>
            <xsl:when test="$lvl = 2"><h2><xsl:apply-templates/></h2></xsl:when>
            <xsl:when test="$lvl = 3"><h3><xsl:apply-templates/></h3></xsl:when>
            <xsl:when test="$lvl = 4"><h4><xsl:apply-templates/></h4></xsl:when>
            <xsl:otherwise><h5><xsl:apply-templates/></h5></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Article = titre -->
    <xsl:template match="ARTI">
        <h3>
            <xsl:text>Article </xsl:text>
            <xsl:value-of select="normalize-space(NUME)"/>
        </h3>
        <xsl:apply-templates select="ALIN"/>
    </xsl:template>

    <!-- Numéro / intitulé = inline -->
    <xsl:template match="NUME|INTT">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- ========================= -->
    <!-- PARAGRAPHES               -->
    <!-- ========================= -->

    <!-- Alinéa = paragraphe -->
    <xsl:template match="ALIN">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Texte inline -->
    <xsl:template match="TXTA|TXT">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- ========================= -->
    <!-- FORMAT INLINE SIMPLE      -->
    <!-- ========================= -->

    <xsl:template match="GRAS">
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

    <xsl:template match="ITAL">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <xsl:template match="BR">
        <br/>
    </xsl:template>

    <!-- ========================= -->
    <!-- IGNORER / TRAVERSER       -->
    <!-- ========================= -->

    <!-- Tous les conteneurs structurels -->
    <xsl:template match="CODALLOZ|CODE|NIVO|NIV1|NIV2|NIV4|NIV7|NIV10|NIV13|NIV15|NIV18|SOUSCODE|APPE|PRECODE|TICOUR|PAIR|GAUCHE|DROITE|PREFACE">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Par défaut : continuer -->
    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>

</xsl:stylesheet>
