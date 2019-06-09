<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- pri citiranju author/literature s tem stilom dodam seznamu literature originalne identifikatorje -->
    <!-- iste identifikaterje moraš popraviti na roke -->
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:listBibl/tei:bibl[not(@xml:id)]">
        <xsl:variable name="firstAuthor">
            <xsl:analyze-string select="." regex="^(.*?),">
                <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <xsl:variable name="year">
            <xsl:analyze-string select="normalize-space(.)" regex="\.\s(\d{{4}})\.">
                <xsl:matching-substring>
                    <xsl:value-of select="regex-group(1)"/>
                </xsl:matching-substring>
            </xsl:analyze-string>
        </xsl:variable>
        <bibl xml:id="{$firstAuthor}.{$year}">
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </bibl>
    </xsl:template>
    
</xsl:stylesheet>