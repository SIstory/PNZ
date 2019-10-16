<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Odstranim odvečne value/seg element. Ker element value ni del TEI sheme, moram pred tem odstraniti tei namespace -->
    
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="value">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="value/seg">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="hi[@style='font-family:LyonText-Regular-Web']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="hi[@rend='color(333333)']">
        <xsl:apply-templates/>
    </xsl:template>
    
</xsl:stylesheet>