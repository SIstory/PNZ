<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="tei html"
    version="2.0">
  <!-- import base conversion style -->
  
  <xsl:import href="../../../../GitHub\Stylesheets/html/html.xsl"/>
  

  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
     <desc>
      <p> This library is free software; you can redistribute it and/or
      modify it under the terms of the GNU Lesser General Public License as
      published by the Free Software Foundation; either version 2.1 of the
      License, or (at your option) any later version. This library is
      distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
      without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
      PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
      details. You should have received a copy of the GNU Lesser General Public
      License along with this library; if not, write to the Free Software
      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA </p>
        <p>Author: See AUTHORS</p>
        <p>Id: $Id: to.xsl 12482 2013-07-28 18:39:41Z louburnard $</p>
        <p>Copyright: 2013, TEI Consortium</p>
     </desc>
  </doc>
  

  <xsl:output method="xhtml" omit-xml-declaration="yes"/>

  <!-- set stylesheet parameters -->
  <xsl:param name="autoToc">false</xsl:param>
  <xsl:param name="bottomNavigationPanel">false</xsl:param>
  <xsl:param name="cssFileInclude">false</xsl:param>
  <xsl:param name="cssInlineFile"></xsl:param>
  <xsl:param name="cssSecondaryFile">http://www2.sistory.si/publikacije/themes/css/pnz/tei-pnz.css</xsl:param>
  <xsl:param name="documentationLanguage">sl</xsl:param>
  <xsl:param name="footnoteBackLink">true</xsl:param>
  <xsl:param name="institution"></xsl:param>
  <xsl:param name="lang">sl</xsl:param>
  <xsl:param name="numberBackHeadings"></xsl:param>
  <xsl:param name="numberFigures">false</xsl:param>
  <xsl:param name="numberFrontTables">false</xsl:param>
  <xsl:param name="numberHeadings">true</xsl:param>
  <xsl:param name="numberParagraphs">true</xsl:param>
  <xsl:param name="numberTables">false</xsl:param>
  <xsl:param name="postQuote"></xsl:param>
  <xsl:param name="preQuote"></xsl:param>
  <xsl:param name="showTitleAuthor">false</xsl:param>
  <xsl:param name="splitLevel">-1</xsl:param>
  <xsl:param name="useHeaderFrontMatter">false</xsl:param>
  
  <xsl:template name="stdfooter"/>
  
  <xsl:template match="tei:docAuthor">
    <xsl:choose>
      <xsl:when test="parent::tei:div[@type='summary']">
        <p class="docAuthor">
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:otherwise>
        <div class="docAuthor">
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="tei:docImprint">
    <div class="docImprint">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="tei:idno[@type='UDC']">
    <br /><xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="tei:docImprint/tei:date">
    <br /><xsl:apply-templates/>
  </xsl:template>
  
  <!-- kopiram iz html_core.xsl, da spodaj spremenim samo ol v ul -->
  <xsl:template match="tei:listBibl">
    <xsl:if test="tei:head">
      <xsl:element name="{if (not(tei:isInline(.))) then 'div' else 'span' }">
        <xsl:attribute name="class">listhead</xsl:attribute>
        <xsl:apply-templates select="tei:head"/>
      </xsl:element>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="tei:biblStruct and $biblioStyle = 'mla'">
        <div type="listBibl" xmlns="http://www.w3.org/1999/xhtml">
          <xsl:for-each select="tei:biblStruct">
            <p class="hang" xmlns="http://www.w3.org/1999/xhtml">
              <xsl:apply-templates select="tei:analytic" mode="mla"/>
              <xsl:apply-templates select="tei:monogr" mode="mla"/>
              <xsl:apply-templates select="tei:relatedItem" mode="mla"/>
              <xsl:choose>
                <xsl:when test="tei:note">
                  <xsl:apply-templates select="tei:note"/>
                </xsl:when>
                <xsl:when test="*//tei:ref/@target and not(contains(*//tei:ref/@target, '#'))">
                  <xsl:text>Web.&#10;</xsl:text>
                  <xsl:if test="*//tei:imprint/tei:date/@type = 'access'">
                    <xsl:value-of select="*//tei:imprint/tei:date[@type = 'access']"/>
                    <xsl:text>.</xsl:text>
                  </xsl:if>
                </xsl:when>
                <xsl:when
                  test="tei:analytic/tei:title[@level = 'u'] or tei:monogr/tei:title[@level = 'u']"/>
                <xsl:otherwise>Print.&#10;</xsl:otherwise>
              </xsl:choose>
              <xsl:if test="tei:monogr/tei:imprint/tei:extent"><xsl:value-of
                select="tei:monogr/tei:imprint/tei:extent"/>. </xsl:if>
              <xsl:if test="tei:series/tei:title[@level = 's']">
                <xsl:apply-templates select="tei:series/tei:title[@level = 's']"/>
                <xsl:text>. </xsl:text>
              </xsl:if>
            </p>
          </xsl:for-each>
        </div>
      </xsl:when>
      <xsl:when test="tei:biblStruct and not(tei:bibl)">
        <ol class="listBibl {$biblioStyle}">
          <xsl:for-each select="tei:biblStruct">
            <xsl:sort
              select="
              lower-case(normalize-space((@sortKey,
              tei:*[1]/tei:author/tei:surname
              ,
              tei:*[1]/tei:author/tei:orgName
              ,
              tei:*[1]/tei:author/tei:name
              ,
              tei:*[1]/tei:author
              ,
              tei:*[1]/tei:editor/tei:surname
              ,
              tei:*[1]/tei:editor/tei:name
              ,
              tei:*[1]/tei:editor
              ,
              tei:*[1]/tei:title[1])[1]))"/>
            <xsl:sort
              select="
              lower-case(normalize-space((
              tei:*[1]/tei:author/tei:forename
              ,
              tei:*[1]/tei:editor/tei:forename
              ,
              '')[1]))"/>
            <xsl:sort select="tei:monogr/tei:imprint/tei:date"/>
            <li>
              <xsl:call-template name="makeAnchor"/>
              <xsl:apply-templates select="."/>
            </li>
          </xsl:for-each>
        </ol>
      </xsl:when>
      <xsl:when test="tei:msDesc">
        <xsl:for-each select="*[not(self::tei:head)]">
          <div class="msDesc">
            <xsl:apply-templates/>
          </div>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <ul class="listBibl">
          <xsl:for-each select="*[not(self::tei:head)]">
            <li>
              <xsl:call-template name="makeAnchor">
                <xsl:with-param name="name">
                  <xsl:apply-templates mode="ident" select="."/>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:apply-templates select="."/>
            </li>
          </xsl:for-each>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
</xsl:stylesheet>
