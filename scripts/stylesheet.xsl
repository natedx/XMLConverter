<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

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

    <!-- Num + Intitulé = titre -->
    <xsl:template match="PRENIV">
        <h2>
            <xsl:value-of select="normalize-space(NUME)"/>
            <xsl:text> — </xsl:text>
            <xsl:value-of select="normalize-space(INTT)"/>
        </h2>
    </xsl:template>

    <!-- Article -->
    <xsl:template match="ARTI">
        <h3><xsl:value-of select="normalize-space(NUME)"/></h3>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Alinéa -->
    <xsl:template match="TXTA">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <!-- Gras / Ital -->
    <xsl:template match="GRAS">
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

    <xsl:template match="ITAL">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <!-- fallback : continuer -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
