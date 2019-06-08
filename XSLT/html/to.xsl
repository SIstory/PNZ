<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="tei html xs"
    version="2.0">
  <!-- import base conversion style -->
  <!-- ../../../../GitHub\Stylesheets/html/html.xsl -->
  <xsl:import href="../../../../pub-XSLT/tei-xsl-7.47.0/xml/tei/stylesheet/html/html.xsl"/>
  

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
  
  <!-- Obvezno spremeni kodo za jezik glede na jezikovno varianto članka: sl, en -->
  <xsl:param name="documentationLanguage">en</xsl:param>
  
  <!-- set stylesheet parameters -->
  <xsl:param name="autoToc">false</xsl:param>
  <xsl:param name="bottomNavigationPanel">false</xsl:param>
  <xsl:param name="cssFileInclude">false</xsl:param>
  <xsl:param name="cssInlineFile"></xsl:param>
  <xsl:param name="cssFile" as="xs:string">https://www.tei-c.org/release/xml/tei/stylesheet/tei.css</xsl:param>
  <xsl:param name="cssPrintFile" as="xs:string">https://www.tei-c.org/release/xml/tei/stylesheet/tei-print.css</xsl:param>
  <xsl:param name="cssSecondaryFile">http://www2.sistory.si/publikacije/themes/css/pnz/tei-pnz.css</xsl:param>
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
  
  <!-- sem ga moral dodati, ker po novem ne procesira več ol/@rend kot a A i I vrednosti -->
  <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
    <desc>
      <p>Process element list</p>
      <p>
        <p xmlns="http://www.w3.org/1999/xhtml">Lists. Depending on the value of the 'type' attribute, various HTML
          lists are generated: <dl><dt>bibl</dt><dd>Items are processed in mode 'bibl'</dd><dt>catalogue</dt><dd>A gloss list is created, inside a paragraph</dd><dt>gloss</dt><dd>A gloss list is created, expecting alternate label and item
            elements</dd><dt>glosstable</dt><dd>Label and item pairs are laid out in a two-column table</dd><dt>inline</dt><dd>A comma-separate inline list</dd><dt>inline</dt><dd>An inline list with bullets between items</dd><dt>unordered</dt><dd>A simple unordered list</dd><dt>ordered</dt><dd>A simple ordered list</dd><dt>valList</dt><dd>(Identical to glosstable)</dd></dl>
        </p>
      </p>
    </desc>
  </doc>
  <xsl:template match="tei:list">
    <xsl:if test="tei:head">
      <xsl:element name="{if (tei:isInline(.)) then 'span' else 'div' }">
        <xsl:attribute name="class">listhead</xsl:attribute>
        <xsl:apply-templates select="tei:head"/>
      </xsl:element>
    </xsl:if>
    <xsl:variable name="listcontents">
      <xsl:choose>
        <xsl:when test="@type='catalogue'">
          <p>
            <dl>
              <xsl:call-template name="makeRendition">
                <xsl:with-param name="default">false</xsl:with-param>
              </xsl:call-template>
              <xsl:for-each select="*[not(self::tei:head)]">
                <p/>
                <xsl:apply-templates mode="gloss" select="."/>
              </xsl:for-each>
            </dl>
          </p>
        </xsl:when>
        <xsl:when test="@type='gloss' and tei:match(@rend,'multicol')">
          <xsl:variable name="nitems">
            <xsl:value-of select="count(tei:item) div 2"/>
          </xsl:variable>
          <p>
            <table>
              <xsl:call-template name="makeRendition">
                <xsl:with-param name="default">false</xsl:with-param>
              </xsl:call-template>
              <tr>
                <td style="vertical-align:top;">
                  <dl>
                    <xsl:apply-templates mode="gloss" select="tei:item[position()&lt;=$nitems ]"/>
                  </dl>
                </td>
                <td style="vertical-align:top;">
                  <dl>
                    <xsl:apply-templates mode="gloss" select="tei:item[position() &gt;$nitems]"/>
                  </dl>
                </td>
              </tr>
            </table>
          </p>
        </xsl:when>
        <xsl:when test="tei:isGlossList(.)">
          <dl>
            <xsl:call-template name="makeRendition">
              <xsl:with-param name="default">false</xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates mode="gloss"
              select="*[not(self::tei:head or self::tei:trailer)]"/>
          </dl>
        </xsl:when>
        <xsl:when test="tei:isGlossTable(.)">
          <table>
            <xsl:call-template name="makeRendition">
              <xsl:with-param name="default">false</xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates mode="glosstable"
              select="*[not(self::tei:head  or self::tei:trailer)]"/>
          </table>
        </xsl:when>
        <xsl:when test="tei:isInlineList(.)">
          <xsl:apply-templates select="*[not(self::tei:head or self::tei:trailer)]"  mode="inline"/>
        </xsl:when>
        <xsl:when test="@type='inline' or @type='runin'">
          <p>
            <xsl:apply-templates select="*[not(self::tei:head or self::tei:trailer)]"  mode="inline"/>
          </p>
        </xsl:when>
        <xsl:when test="@type='bibl'">
          <xsl:apply-templates select="*[not(self::tei:head or self::tei:trailer)]"  mode="bibl"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="{if (tei:isOrderedList(.)) then 'ol' else 'ul'}">
            <xsl:call-template name="makeRendition">
              <xsl:with-param name="default">false</xsl:with-param>
            </xsl:call-template>
            <xsl:if test="starts-with(@type,'ordered:')">
              <xsl:attribute name="start">
                <xsl:value-of select="substring-after(@type,':')"/>
              </xsl:attribute>
            </xsl:if>
            <!-- dodam še za type atribut: ol/@type -->
            <xsl:if test="matches(@rend,':a|:A|:i|:I')">
              <xsl:attribute name="type">
                <xsl:value-of select="substring-after(@rend,':')"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="*[not(self::tei:head or self::tei:trailer)]" />
          </xsl:element>
          <xsl:apply-templates select="tei:trailer" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <!--
	<xsl:variable name="n">
      <xsl:number level="any"/>
    </xsl:variable>
    <xsl:result-document href="/tmp/list{$n}.xml">
      <xsl:copy-of select="$listcontents"/>
      </xsl:result-document>
      -->
    <xsl:apply-templates mode="inlist" select="$listcontents"/>
  </xsl:template>
  
  
  
</xsl:stylesheet>
