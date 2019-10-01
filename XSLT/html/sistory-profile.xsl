<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../../../../pub-XSLT/Stylesheets/html5-foundation6-chs/to.xsl"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6 http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed:
            
            1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
            Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
            
            2. http://www.opensource.org/licenses/BSD-2-Clause
            
            
            
            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are
            met:
            
            * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.
            
            * Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.
            
            This software is provided by the copyright holders and contributors
            "as is" and any express or implied warranties, including, but not
            limited to, the implied warranties of merchantability and fitness for
            a particular purpose are disclaimed. In no event shall the copyright
            holder or contributors be liable for any direct, indirect, incidental,
            special, exemplary, or consequential damages (including, but not
            limited to, procurement of substitute goods or services; loss of use,
            data, or profits; or business interruption) however caused and on any
            theory of liability, whether in contract, strict liability, or tort
            (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage.
         </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
  
   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- ../../../../pub/  -->
   <!-- http://www2.sistory.si/publikacije/ -->
   <xsl:param name="path-general">https://www2.sistory.si/publikacije/</xsl:param>
   
   <xsl:param name="outputDir"></xsl:param>
   
   <xsl:param name="splitLevel">-1</xsl:param>
   
   <xsl:param name="topNavigation">false</xsl:param>
   
   <xsl:param name="chapterAsSIstoryPublications">false</xsl:param>
   
   <xsl:param name="documentationLanguage">en</xsl:param>
   
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <!-- če želiš procesirati MathML ipd. formule v vseh brskalnikih -->
   <xsl:param name="math">true</xsl:param>
   
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description"></xsl:param>
   <xsl:param name="keywords"></xsl:param>
   <xsl:param name="title"></xsl:param>
   
   <xsl:param name="numberBackHeadings"></xsl:param>
   <xsl:param name="numberFigures">false</xsl:param>
   <xsl:param name="numberFrontTables">false</xsl:param>
   <xsl:param name="numberHeadings">true</xsl:param>
   <xsl:param name="numberParagraphs">true</xsl:param>
   <xsl:param name="numberTables">false</xsl:param>
   <xsl:param name="postQuote"></xsl:param>
   <xsl:param name="preQuote"></xsl:param>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>dodam specifične stile za PNZ</desc>
   </doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of select="concat($path-general,'themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"  rel="stylesheet" type="text/css" />
      <!-- PNZ specific CSS -->
      <style type="text/css">
         div.stdheader{
           text-align:center;
         }
         
         div.docAuthor{
           text-align:center;
           font-size: 120%;
           }
         
         div.docImprint{
           border-top:3pt solid black;
           border-bottom:1pt solid black;
         }
         
         section.abstract{
           border-bottom:1pt solid black;
         }
         
         section.abstract h2{
           font-size: 120%;
         }
         
         section.summary{
           border-top:1pt solid black;
         }
         
         p.docAuthor{
           text-align:center;
           font-size: 120%;
           }
         
         p {
           text-align: justify;
         }
         
         dl, ol, ul {
           padding: 0 1.25em 0 0.5625em;
           margin-bottom: 1rem;
         }
      </style>
   </xsl:template>
   <!-- p margin-bottom: 1rem; -->
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="stdfooter"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
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
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:docImprint">
      <div class="docImprint">
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:idno[@type='UDC']">
      <br /><xsl:apply-templates/>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:docImprint/tei:date">
      <br /><xsl:apply-templates/>
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
