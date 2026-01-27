<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- HTML Root -->

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                <title>Code Pénal</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <!-- Première Page -->

    <xsl:template match="PRECODE">
<!--        <h1>-->
<!--            <xsl:value-of select="TICOUR"/>-->
<!--        </h1>-->
<!--        <xsl:apply-templates select="NIV4"/>-->
    </xsl:template>

    <!-- Mise en page des entêtes : NUME correspond à la numérotation (Première Partie, Livre I, Titre I, Chapitre I, Art. 111-1...) et INTT à l'intitulé. -->

    <xsl:template match="PRENIV">
        <xsl:value-of select="NUME"/> - <xsl:value-of select="INTT"/>
    </xsl:template>

    <!-- NIV0 englobe tout le livre -->
    <xsl:template match="NIV0">
        <xsl:apply-templates select="NIV1"/>
    </xsl:template>

    <!-- NIV1 correspond aux Parties -->
    <xsl:template match="NIV1">
        <h1>
            <xsl:apply-templates select="PRENIV"/>
        </h1>
        <xsl:apply-templates select="NIV4"/>
    </xsl:template>

    <!-- NIV4 correspond aux Livres -->
    <xsl:template match="NIV4">
        <h2>
            <xsl:apply-templates select="PRENIV"/>
        </h2>
        <xsl:apply-templates select="PRENIV/BIBLLEG"/>

        <xsl:apply-templates select="NIV7"/>
    </xsl:template>

    <!-- NIV7 correspond aux Titres -->
    <xsl:template match="NIV7">
        <h3>
            <xsl:apply-templates select="PRENIV"/>
        </h3>
        <xsl:apply-templates select="PRENIV/BIBLLEG"/>
        <xsl:apply-templates select="NIV10 | PRENIV/ARTI"/>
    </xsl:template>

    <!-- NIV10 correspond aux Chapitres -->
    <xsl:template match="NIV10">
        <h4>
            <xsl:apply-templates select="PRENIV"/>
        </h4>
        <xsl:apply-templates select="PRENIV/ARTI"/>
    </xsl:template>

    <!-- ARTI correspond aux Articles -->
    <xsl:template match="ARTI">
<!--        <p>-->
<!--            <i><xsl:value-of select="INDEX"/></i>-->
<!--        </p>-->
        <h5>
            <xsl:value-of select="NUME"/> - <xsl:value-of select="ALIN"/>
        </h5>

        <xsl:apply-templates select="BIBLLEG"/>
        <xsl:apply-templates select="JURI"/>
    </xsl:template>

    <!-- JURI correspond à la Jurisprudence -->
    <xsl:template match="JURI">

        <p>
            Jurisprudence
            <ul>
                <xsl:apply-templates select="BNUM | NIJ1"/>
            </ul>
        </p>
    </xsl:template>

    <!-- JURI correspond à un élément de Jurisprudence, ils sont numérotés par NUME et dispose parfois d'un intitule INTT, de texte BTXT ou de bibliographie juridique BIBLJURI-->
    <xsl:template match="BNUM">
        <li>
            <b><xsl:value-of select="NUME"/>. <xsl:value-of select="INTT"/> - </b><xsl:value-of select="BTXT"/>
            <xsl:value-of select="BIBLJURI"/>
        </li>
        <br/>
    </xsl:template>

    <!-- NIJ 1 à 5 correspondent parfois à une organisation en niveaux de la jurisprudence qui peut parfois être longue.-->
    <xsl:template match="NIJ1">
        <b><xsl:value-of select="NUME"/>. <xsl:value-of select="INTT"/> </b><xsl:value-of select="BTXT"/>
        <br/>
        <xsl:apply-templates select="BNUM | NIJ2"/>
    </xsl:template>

    <xsl:template match="NIJ2">
        <b><xsl:value-of select="NUME"/>. <xsl:value-of select="INTT"/> </b><xsl:value-of select="BTXT"/>
        <br/>
        <xsl:apply-templates select="BNUM | NIJ3"/>
    </xsl:template>

    <xsl:template match="NIJ3">
        <b><xsl:value-of select="NUME"/>. <xsl:value-of select="INTT"/> </b><xsl:value-of select="BTXT"/>
        <br/>
        <xsl:apply-templates select="BNUM | NIJ4"/>
    </xsl:template>

    <xsl:template match="NIJ4">
        <b><xsl:value-of select="NUME"/>. <xsl:value-of select="INTT"/> </b><xsl:value-of select="BTXT"/>
        <br/>
        <xsl:apply-templates select="BNUM | NIJ5"/>
    </xsl:template>

    <xsl:template match="NIJ5">
        <b><xsl:value-of select="NUME"/>. <xsl:value-of select="INTT"/> </b><xsl:value-of select="BTXT"/>
        <br/>
        <xsl:apply-templates select="BNUM"/>
    </xsl:template>

    <!-- BIBLLEG correspond à la bibliographie-->
    <xsl:template match="BIBLLEG">
        <p>
            <xsl:value-of select="BIBO"/>
            <ul>
                <xsl:apply-templates select="PARBIBL"/>
            </ul>
        </p>
    </xsl:template>

    <!-- PARBIBL correspond à un élément de bibliographie-->
    <xsl:template match="PARBIBL">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>


</xsl:stylesheet>
