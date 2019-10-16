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

   <xsl:import href="sistory-profile.xsl"/>
   
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
  
   <xsl:output method="xhtml" indent="no"/>
   
   
   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   <!-- ../../../../pub/  -->
   <!-- http://www2.sistory.si/publikacije/ -->
   <xsl:param name="path-general"></xsl:param>
   
   <xsl:param name="outputDir">pdf/</xsl:param>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template name="headHook"/>
   <xsl:param name="cssFile"></xsl:param>
   <xsl:param name="cssPrintFile"></xsl:param>
   <xsl:param name="cssSecondaryFile"></xsl:param>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook"></xsl:template>
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" class="hook">
      <desc>[html] Hook where Javascript calls can be inserted  just after &lt;body&gt;</desc>
      <param name="thisLanguage"></param>
   </doc>
   <xsl:template name="bodyJavascriptHook">
      <xsl:param name="thisLanguage"/>
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc/>
   </xsldoc:doc>
   <xsl:template name="bodyEndHook"></xsl:template>
   
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>dodam specifične stile za PNZ</desc>
   </doc>
   <xsl:template name="cssHook"/>
         
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc> naredi index.html datoteko: odstranim nepotrebna procesiranja za PDF </xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="pageLayoutSimple">
      <!-- če je locale, naredim index-jezikovna_koda.html še za ostale jezike (ki niso izhodični) -->
      <xsl:if test="$languages-locale='true'">
         <xsl:call-template name="pageLayoutSimple-locale"/>
      </xsl:if>
      <html>
         <xsl:call-template name="addLangAtt"/>
         <xsl:variable name="pagetitle">
            <xsl:sequence select="tei:generateTitle(.)"/>
         </xsl:variable>
         <!--<xsl:sequence select="tei:htmlHead($pagetitle, 3)"/>-->
         <head>
            <title>
               <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[1]"/>
            </title>
            <meta name="author" content="" />
            <meta name="description" content="{$description}"/>
            <meta name="keywords" content="{$keywords}"/>
            <meta charset="utf-8" />
         </head>
         <body class="simple" id="TOP">
            <xsl:copy-of select="tei:text/tei:body/@unload"/>
            <xsl:copy-of select="tei:text/tei:body/@onunload"/>
            <xsl:call-template name="bodyMicroData"/>
            <xsl:call-template name="bodyJavascriptHook">
               <xsl:with-param name="thisLanguage" select="$languages-locale-primary"/>
            </xsl:call-template>
            <xsl:call-template name="bodyHook"/>
            <!-- začetek vsebine -->
            <div>
               <xsl:if test="not(tei:text/tei:front/tei:titlePage)">
                  <div class="stdheader autogenerated">
                     <xsl:call-template name="stdheader">
                        <xsl:with-param name="title">
                           <xsl:sequence select="tei:generateTitle(.)"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </div>
               </xsl:if>
               <xsl:comment>TEI  front matter </xsl:comment>
               <xsl:apply-templates select="tei:text/tei:front"/>
               <xsl:choose>
                  <xsl:when test="tei:text/tei:group">
                     <xsl:apply-templates select="tei:text/tei:group"/>
                  </xsl:when>
                  <xsl:when test="tei:match(@rend, 'multicol')">
                     <table>
                        <tr>
                           <xsl:apply-templates select="tei:text/tei:body"/>
                        </tr>
                     </table>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:comment>TEI body matter </xsl:comment>
                     <xsl:call-template name="startHook"/>
                     <xsl:variable name="ident">
                        <xsl:apply-templates mode="ident" select="."/>
                     </xsl:variable>
                     <xsl:apply-templates select="tei:text/tei:body"/>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:comment>TEI back matter </xsl:comment>
               <xsl:apply-templates select="tei:text/tei:back"/>
               <!-- obvezno odstrani na koncu izpisane opombe -->
               <!--<xsl:call-template name="printNotes"/>-->
               <xsl:call-template name="htmlFileBottom"/>
               <xsl:call-template name="bodyEndHook"/>
            </div>
         </body>
      </html>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Procesiram note v skladu s potrebami Oxygen XML - Chemistry</desc>
   </doc>
   <xsl:template match="tei:note[@place='foot']">
      <xsl:choose>
         <xsl:when test="parent::tei:docAuthor[parent::tei:front]">
            <span class="authornote" content="{@n}">
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   
</xsl:stylesheet>
