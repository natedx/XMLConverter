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

    <!-- Num + Intitulé = titre (niveau auto selon la profondeur NIV*) -->
    <xsl:template match="PRENIV">
        <xsl:variable name="lvl" select="count(ancestor::*[starts-with(name(),'NIV')])"/>
        <xsl:variable name="hasNum" select="string-length(normalize-space(NUME)) &gt; 0"/>
        <xsl:variable name="hasIntt" select="string-length(normalize-space(INTT)) &gt; 0"/>

        <xsl:choose>
            <xsl:when test="$lvl &lt;= 1">
                <h2>
                    <xsl:if test="$hasNum">
                        <xsl:value-of select="normalize-space(NUME)"/>
                    </xsl:if>
                    <xsl:if test="$hasNum and $hasIntt">
                        <xsl:text> — </xsl:text>
                    </xsl:if>
                    <xsl:if test="$hasIntt">
                        <xsl:value-of select="normalize-space(INTT)"/>
                    </xsl:if>
                </h2>
            </xsl:when>
            <xsl:when test="$lvl = 2">
                <h3>
                    <xsl:if test="$hasNum">
                        <xsl:value-of select="normalize-space(NUME)"/>
                    </xsl:if>
                    <xsl:if test="$hasNum and $hasIntt">
                        <xsl:text> — </xsl:text>
                    </xsl:if>
                    <xsl:if test="$hasIntt">
                        <xsl:value-of select="normalize-space(INTT)"/>
                    </xsl:if>
                </h3>
            </xsl:when>
            <xsl:when test="$lvl = 3">
                <h4>
                    <xsl:if test="$hasNum">
                        <xsl:value-of select="normalize-space(NUME)"/>
                    </xsl:if>
                    <xsl:if test="$hasNum and $hasIntt">
                        <xsl:text> — </xsl:text>
                    </xsl:if>
                    <xsl:if test="$hasIntt">
                        <xsl:value-of select="normalize-space(INTT)"/>
                    </xsl:if>
                </h4>
            </xsl:when>
            <xsl:when test="$lvl = 4">
                <h5>
                    <xsl:if test="$hasNum">
                        <xsl:value-of select="normalize-space(NUME)"/>
                    </xsl:if>
                    <xsl:if test="$hasNum and $hasIntt">
                        <xsl:text> — </xsl:text>
                    </xsl:if>
                    <xsl:if test="$hasIntt">
                        <xsl:value-of select="normalize-space(INTT)"/>
                    </xsl:if>
                </h5>
            </xsl:when>
            <xsl:otherwise>
                <h6>
                    <xsl:if test="$hasNum">
                        <xsl:value-of select="normalize-space(NUME)"/>
                    </xsl:if>
                    <xsl:if test="$hasNum and $hasIntt">
                        <xsl:text> — </xsl:text>
                    </xsl:if>
                    <xsl:if test="$hasIntt">
                        <xsl:value-of select="normalize-space(INTT)"/>
                    </xsl:if>
                </h6>
            </xsl:otherwise>
        </xsl:choose>

        <!-- Éléments optionnels liés au titre (sources, renvois) -->
        <xsl:apply-templates select="SOUR|RENV|REFI|NB|NOTE"/>
    </xsl:template>

    <!-- Article -->
    <xsl:template match="ARTI">
        <xsl:variable name="hasIntt" select="string-length(normalize-space(INTT)) &gt; 0"/>
        <h4>
            <xsl:text>Article </xsl:text>
            <xsl:value-of select="normalize-space(NUME)"/>
            <xsl:if test="$hasIntt">
                <xsl:text> — </xsl:text>
                <xsl:value-of select="normalize-space(INTT)"/>
            </xsl:if>
        </h4>

        <xsl:apply-templates select="ALIN|CMNT|JURI|BIBLLEG|BIBLJURI|BIBO|THEMATISATION|THEME|INDEX"/>
    </xsl:template>

    <!-- Texte (inline) -->
    <xsl:template match="TXTA">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Gras / Ital -->
    <xsl:template match="GRAS">
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

    <xsl:template match="ITAL">
        <em><xsl:apply-templates/></em>
    </xsl:template>


    <!-- ========================= -->
    <!-- Structure générale        -->
    <!-- ========================= -->

    <xsl:template match="CODALLOZ">
        <xsl:apply-templates select="CODE|PREFACE"/>
    </xsl:template>

    <xsl:template match="PREFACE">
        <div class="preface">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="CODE">
        <xsl:apply-templates select="PRECODE"/>
        <xsl:apply-templates select="NIVO"/>
        <xsl:apply-templates select="APPE"/>
    </xsl:template>

    <xsl:template match="PRECODE">
        <h1>
            <xsl:choose>
                <xsl:when test="string-length(normalize-space(TITR)) &gt; 0">
                    <xsl:value-of select="normalize-space(TITR)"/>
                </xsl:when>
                <xsl:when test="string-length(normalize-space(TICOUR)) &gt; 0">
                    <xsl:value-of select="normalize-space(TICOUR)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Document</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </h1>
        <xsl:apply-templates select="TICOUR|THEMATISATION"/>
    </xsl:template>

    <xsl:template match="TITR">
        <h3><xsl:apply-templates/></h3>
    </xsl:template>

    <!-- Titres en cartouche (souvent 2 colonnes) -->
    <xsl:template match="TICOUR">
        <div class="ticour">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="PAIR">
        <table class="pair"><tr>
            <td class="gauche"><xsl:apply-templates select="GAUCHE"/></td>
            <td class="droite"><xsl:apply-templates select="DROITE"/></td>
        </tr></table>
    </xsl:template>

    <xsl:template match="GAUCHE|DROITE">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="NIVO">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Niveaux hiérarchiques (NIV1, NIV4, NIV7, NIV10, ...) -->
    <xsl:template match="NIV1|NIV2|NIV4|NIV7|NIV10|NIV13|NIV15|NIV18">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="SOUSCODE">
        <div class="souscode">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="APPE">
        <div class="annexes">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- ========================= -->
    <!-- Paragraphes / retours     -->
    <!-- ========================= -->

    <xsl:template match="ALIN">
        <p>
            <xsl:apply-templates select="TXTA|TXT"/>
        </p>
        <xsl:apply-templates select="CMNT"/>
    </xsl:template>

    <xsl:template match="TXT">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="BR">
        <br/>
    </xsl:template>

    <!-- ========================= -->
    <!-- Liens / références        -->
    <!-- ========================= -->

    <xsl:template match="LIEN">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="concat(@BASE,':',@IDENTIF)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <!-- Champs bibliographiques / jurisprudence : afficher clairement -->
    <xsl:template match="SOUR">
        <span class="source"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="RENV">
        <span class="renvoi"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="REFI|REFJ">
        <span class="ref"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- ========================= -->
    <!-- Commentaires / notes      -->
    <!-- ========================= -->

    <xsl:template match="CMNT">
        <blockquote class="comment">
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>

    <xsl:template match="PTCAP">
        <p class="ptcap"><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="POINTS">
        <xsl:text>• </xsl:text>
    </xsl:template>

    <xsl:template match="NOTE|NB">
        <small class="note"><xsl:apply-templates/></small>
    </xsl:template>

    <!-- ========================= -->
    <!-- Bibliographie             -->
    <!-- ========================= -->

    <xsl:template match="BIBLLEG">
        <div class="bibl biblleg">
            <h5>Références législatives</h5>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="BIBLJURI">
        <div class="bibl bibljuri">
            <h5>Références jurisprudentielles</h5>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="BIBO|BIBLNIV">
        <div class="bibl biblo">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="PARBIBL">
        <p class="parbibl"><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="BPARA">
        <p class="bpara"><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="BNUM">
        <strong class="bnum"><xsl:apply-templates/></strong>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template match="BTXT">
        <span class="btxt"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- ========================= -->
    <!-- Jurisprudence             -->
    <!-- ========================= -->

    <xsl:template match="JURI">
        <div class="juri">
            <h5>Jurisprudence</h5>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="DECI">
        <div class="deci">
            <p>
                <xsl:if test="string-length(normalize-space(TRIBUNAL)) &gt; 0">
                    <strong><xsl:value-of select="normalize-space(TRIBUNAL)"/></strong>
                </xsl:if>
                <xsl:if test="string-length(normalize-space(VILLE)) &gt; 0">
                    <xsl:text> — </xsl:text>
                    <xsl:value-of select="normalize-space(VILLE)"/>
                </xsl:if>
                <xsl:if test="string-length(normalize-space(DATE)) &gt; 0">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="normalize-space(DATE)"/>
                </xsl:if>
                <xsl:if test="string-length(normalize-space(NAFF)) &gt; 0">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="normalize-space(NAFF)"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
            </p>
            <xsl:apply-templates select="NJUR|IJUR|NATX|SOUR|REFJ|REFI"/>
        </div>
    </xsl:template>

    <xsl:template match="NJUR|IJUR|NATX|NAFF|TRIBUNAL|VILLE|DATE">
        <span class="field"><xsl:apply-templates/></span>
        <xsl:text> </xsl:text>
    </xsl:template>

    <!-- ========================= -->
    <!-- Thématisation              -->
    <!-- ========================= -->

    <xsl:template match="THEMATISATION">
        <div class="themat">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="THEME">
        <div class="theme">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="THM-NIV1|THM-NIV2|THM-LIB">
        <span class="thm"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- ========================= -->
    <!-- Petits utilitaires texte  -->
    <!-- ========================= -->

    <xsl:template match="ABRV">
        <abbr><xsl:apply-templates/></abbr>
    </xsl:template>

    <xsl:template match="TSPEC">
        <span class="tspec"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="TICOUR/BR">
        <br/>
    </xsl:template>

    <!-- Éléments purement techniques / index : ignorer par défaut -->
    <xsl:template match="INDEX|INTERVAL|ARTE|CHAM|TYPE|NATX">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- fallback : continuer -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>

</xsl:stylesheet>
