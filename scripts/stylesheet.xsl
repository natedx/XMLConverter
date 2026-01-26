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

    <!-- Titles -->

    <xsl:template match="PRECODE">
        <h1>
            <xsl:value-of select="TITR"/>
        </h1>
    </xsl:template>

    <xsl:template match="PRENIV">
        <h2>
            <xsl:value-of select="NUME"/> - <xsl:value-of select="INTT"/>
        </h2>
    </xsl:template>

    <xsl:template match="BIBLLEG">
        <p>
            Référence
            <ul>
                <li>
                    <xsl:value-of select="PARBIBL"/>
                </li>
            </ul>
        </p>

    </xsl:template>


</xsl:stylesheet>
