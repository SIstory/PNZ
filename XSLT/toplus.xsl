<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- dodaj številko, katero hočeš odšteti od originalne številke opombe v atributu n (ker note z vrednostjo atributa n * nima številka) -->
    <xsl:param name="stOpombe">-1</xsl:param>
    
    <xsl:output method="xml"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:note[ancestor::tei:body]">
        <note>
            <xsl:apply-templates select="@*"/>
            <xsl:if test="@n">
                <xsl:attribute name="n">
                    <xsl:number value="@n - $stOpombe"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    
    <!-- odstranim odstavke znotraj opomb -->
    <xsl:template match="tei:p[parent::tei:note]">
        <xsl:apply-templates/>
    </xsl:template>
    
</xsl:stylesheet>