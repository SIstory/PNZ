<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- ne dela optimalno, zato ne uporabljaj -->
    <!-- TEI specifične @rend za tabele spremenim v CSS -->
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:cell[@rend]">
        <cell>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="@rend='both'">
                    <!-- ne procesiram -->
                </xsl:when>
                <xsl:when test="@rend='left'">
                    <!-- privzeto oblikovaje je text-align:left; , zato ne procesiram -->
                </xsl:when>
                <xsl:when test="@rend='right'">
                    <xsl:attribute name="style">text-align:right;</xsl:attribute>
                </xsl:when>
                <xsl:when test="@rend='center'">
                    <xsl:attribute name="style">text-align:center;</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>Unknown value <xsl:value-of select="@rend"/> of cell/@rend attribute</xsl:message>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </cell>
    </xsl:template>
    
</xsl:stylesheet>