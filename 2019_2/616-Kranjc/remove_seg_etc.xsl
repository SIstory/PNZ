<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- Odstranim odvečne seg elemente z odvečnimi atributi; odstranim note/p, kjer je samo en p -->
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:note/tei:p">
        <xsl:choose>
            <xsl:when test=" preceding-sibling::tei:*[1][self::tei:p] or following-sibling::tei:*[1][self::tei:p]">
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:seg">
        <xsl:choose>
            <xsl:when test="contains(@rend,'italic')">
                <!-- Zelo zanimivo!! Tako označeni deli besedil so bili dvojni zapis istega dela besedila,
                    ki jim je neposredno sledil. Zato se to odstrani -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend='article-title' or @rend='Naslov1' or @rend='publication' or @rend='permalink' or @rend='color(231F20)' or @rend='color(333333)' or @rend='Naslov2']">
        <xsl:apply-templates/>
    </xsl:template>
    
</xsl:stylesheet>