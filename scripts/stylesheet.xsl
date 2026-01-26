<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <!-- HTML Root -->

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                <title>Transpilation XML Dalloz</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <!-- Titres -->

    <xsl:template match="PRECODE">
        <h1>
            <xsl:value-of select="TICOUR"/>
        </h1>
        <xsl:apply-templates select="NIV4"/>
    </xsl:template>

    <xsl:template match="PRENIV">
        <div>
            <xsl:value-of select="NUME"/> - <xsl:value-of select="INTT"/>
        </div>
    </xsl:template>

    <xsl:template match="NIV0">
        <xsl:apply-templates select="NIV1"/>
    </xsl:template>

    <xsl:template match="NIV1">
        <h1>
            <xsl:apply-templates select="PRENIV"/>
        </h1>
        <xsl:apply-templates select="NIV4"/>
    </xsl:template>

    <xsl:template match="NIV4">
        <h2>
            <xsl:apply-templates select="PRENIV"/>
        </h2>
        <xsl:apply-templates select="PRENIV/BIBLLEG"/>

        <xsl:apply-templates select="NIV7"/>
    </xsl:template>

    <xsl:template match="NIV7">
        <h3>
            <xsl:apply-templates select="PRENIV"/>
        </h3>
        <xsl:apply-templates select="PRENIV/BIBLLEG"/>
    </xsl:template>

<!--    Thématisation-->
    <xsl:template match="THEMATISATION">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="ARTI">
        <p>
            <xsl:value-of select="NUME"/> - <xsl:value-of select="ALIN"/>
        </p>
    </xsl:template>

    <xsl:template match="BIBLLEG">
        <p>
            <xsl:value-of select="BIBO"/>
            <ul>
                <xsl:apply-templates select="PARBIBL"/>
            </ul>
        </p>
    </xsl:template>


    <xsl:template match="PARBIBL">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>


</xsl:stylesheet>
