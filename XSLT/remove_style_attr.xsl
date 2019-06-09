<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- Odstranim odvečne style atribute iz hi elementov, ki so nastali kot posledica oblikovanja v WOrdovem dokumentu -->
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:hi[@style or @xml:space]">
        <xsl:choose>
            <!-- predvidevami, da so vsi rend atributi potrebni: preveri prej z xpath -->
            <xsl:when test="@rend">
                <hi rend="{@rend}">
                    <!-- obdržim samo style atribute, ki imajo font-family -->
                    <xsl:if test="contains(@style,'font-family')">
                        <xsl:attribute name="style">
                            <xsl:value-of select="@style"/>
                        </xsl:attribute>
                    </xsl:if>
                    <!-- vse ostale atribute odstranim: @style, @xml:space: preveri, če je kaj takšmnega, kar ne smeš odstraniti -->
                    <xsl:apply-templates/>
                </hi>
            </xsl:when>
            <xsl:otherwise>
                <!-- ne procesiram hi elementa, ki ima samo @style ali @xml:space, temveč grem direktno na procesiranje child členov -->
                <!-- obdržim samo style atribute, ki imajo font-family -->
                <xsl:choose>
                    <xsl:when test="contains(@style,'font-family')">
                        <hi style="{@style}">
                            <xsl:apply-templates/>
                        </hi>
                    </xsl:when>
                    <!-- ne procesiram hi elementa -->
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>