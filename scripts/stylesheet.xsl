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

    <xsl:template match="TICOUR">
        <h1>
            <xsl:value-of select="."/>
        </h1>
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

<!--    <xsl:template match="PRENIV">-->
<!--        <h2>-->
<!--            <xsl:value-of select="NUME"/> - <xsl:value-of select="INTT"/>-->
<!--        </h2>-->
<!--    </xsl:template>-->
<!--    -->


</xsl:stylesheet>
