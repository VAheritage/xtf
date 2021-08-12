<xsl:stylesheet version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xtf="http://cdlib.org/xtf"
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:session="java:org.cdlib.xtf.xslt.Session"
   xmlns:math="http://www.ora.com/XSLTCookbook/math"
   extension-element-prefixes="session"
   exclude-result-prefixes="#all">
   
   <!-- ====================================================================== -->
   <!-- Common DynaXML Stylesheet                                              -->
   <!-- ====================================================================== -->
   
   <!--
      Copyright (c) 2008, Regents of the University of California
      All rights reserved.
      
      Redistribution and use in source and binary forms, with or without 
      modification, are permitted provided that the following conditions are 
      met:
      
      - Redistributions of source code must retain the above copyright notice, 
      this list of conditions and the following disclaimer.
      - Redistributions in binary form must reproduce the above copyright 
      notice, this list of conditions and the following disclaimer in the 
      documentation and/or other materials provided with the distribution.
      - Neither the name of the University of California nor the names of its
      contributors may be used to endorse or promote products derived from 
      this software without specific prior written permission.
      
      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
      AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
      IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
      ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
      LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
      CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
      SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
      INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
      CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
      ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
      POSSIBILITY OF SUCH DAMAGE.
   -->
   
   <!-- ====================================================================== -->
   <!-- Global Keys                                                            -->
   <!-- ====================================================================== -->
   
   <xsl:key name="hit-num-dynamic" match="xtf:hit" use="@hitNum"/>
   <xsl:key name="hit-rank-dynamic" match="xtf:hit" use="@rank"/>
   
   <!-- ====================================================================== -->
   <!-- Global Parameters                                                      -->
   <!-- ====================================================================== -->
   
   <!-- Path Parameters -->
   
   <xsl:param name="servlet.path"/>
   <xsl:param name="root.path"/>
   <!-- Greg Murray (gpm2a@virginia.edu): 2010-05-07: Changed default value of
   $xtfURL param to remove the hardwired use of "xtf.lib":
      select="'http://xtf.lib.virginia.edu/xtf/'"
   to allow XTF troubleshooting/development in environments (local computer,
   xtfdev.lib) other than the xtf.lib production environment. The out-of-the-box
   value
      select="$root.path"
   seems to work. Alternatively
      select="'/xtf/'"
   also works.

   -->
   
   <!-- Placed here by Tim S on 1/25/20. Setting to hardcoded value of https and xtf.internal.lib.virginia.edu" -->
   <xsl:param name="xtfURL"  select="replace($root.path, 'http', 'https')"/>
   <xsl:param name="dynaxmlPath" select="if (matches($servlet.path, 'org.cdlib.xtf.crossQuery.CrossQuery')) then 'org.cdlib.xtf.dynaXML.DynaXML' else 'view'"/>
   
   <xsl:param name="docId"/>
   <xsl:param name="docPath" select="replace($docId, '[A-Za-z0-9]+\.xml$', '')"/>
   <xsl:param name="page" select="'0'"></xsl:param>
   
   <!-- If an external 'source' document was specified, include it in the
      query string of links we generate. -->
   <xsl:param name="source" select="''"/>
   
   <xsl:variable name="sourceStr">
      <xsl:if test="$source">;source=<xsl:value-of select="$source"/></xsl:if>
   </xsl:variable>
   
   <xsl:param name="query.string" select="concat('docId=', $docId, $sourceStr)"/>
   
   <xsl:param name="doc.path"><xsl:value-of select="$xtfURL"/><xsl:value-of select="$dynaxmlPath"/>?<xsl:value-of select="$query.string"/></xsl:param>
   
   <xsl:variable name="systemId" select="saxon:systemId()" xmlns:saxon="http://saxon.sf.net/"/>
   
   <xsl:param name="doc.dir">
      <xsl:choose>
         <xsl:when test="starts-with($systemId, 'http://')">
            <xsl:value-of select="replace($systemId, '/[^/]*$', '')"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="concat($xtfURL, 'data/', $docPath)"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:param>
   
   <xsl:param name="figure.path" select="concat($doc.dir, '/figures/')"/>
   
   <xsl:param name="pdf.path" select="concat($doc.dir, '/pdfs/')"/>
   
   <!-- navigation parameters -->
   
   <xsl:param name="doc.view" select="'0'"/>
   
   <xsl:param name="toc.depth" select="1"/>
   
   <xsl:param name="anchor.id" select="'0'"/>
   
   <xsl:param name="set.anchor" select="'0'"/>
   
   <xsl:param name="chunk.id"/>
      
   <xsl:param name="toc.id"/>
   
   <!-- search parameters -->
   
   <xsl:param name="query"/>
   <xsl:param name="query-join"/>
   <xsl:param name="query-exclude"/>
   <xsl:param name="sectionType"/>
   
   <xsl:param name="search">
      <xsl:if test="$query">
         <xsl:value-of select="concat(';query=', replace($query, ';', '%26'))"/>
      </xsl:if>
      <xsl:if test="$query-join">
         <xsl:value-of select="concat(';query-join=', $query-join)"/>
      </xsl:if>
      <xsl:if test="$query-exclude">
         <xsl:value-of select="concat(';query-exclude=', $query-exclude)"/>
      </xsl:if>
      <xsl:if test="$sectionType">
         <xsl:value-of select="concat(';sectionType=', $sectionType)"/>
      </xsl:if>
   </xsl:param>  
   
   <xsl:param name="hit.rank" select="'0'"/>
   
   <!-- Branding Parameters -->
   
   <xsl:param name="brand" select="'default'"/>
   
   <xsl:variable name="brand.file">
      <xsl:choose>
         <xsl:when test="$brand != ''">
            <xsl:copy-of select="document(concat('../../../../brand/',$brand,'.xml'))"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="document('../../../../brand/default.xml')"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>
   
   <xsl:param name="brand.links" select="$brand.file/brand/dynaxml.links/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
   <xsl:param name="brand.header" select="$brand.file/brand/dynaxml.header/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
   <xsl:param name="brand.footer" select="$brand.file/brand/footer/*" xpath-default-namespace="http://www.w3.org/1999/xhtml"/>
   
   <!-- Special Robot Parameters -->
   
   <xsl:param name="http.user-agent"/>
   <!-- WARNING: Inclusion of 'Wget' is for testing only, please remove before going into production -->
   <xsl:param name="robots" select="'Googlebot|Slurp|msnbot|Teoma|Wget'"/>
   
   
   <!-- ====================================================================== -->
   <!-- Button Bar Templates                                                   -->
   <!-- ====================================================================== -->
   
   <xsl:template name="bbar">
    <form action="{$xtfURL}{$dynaxmlPath}" method="GET">
      <input type="hidden" name="docId">
        <xsl:attribute name="value">
          <xsl:value-of select="$docId"/>
        </xsl:attribute>
      </input>
      <input type="hidden" name="chunk.id">
        <xsl:attribute name="value">
          <xsl:value-of select="$chunk.id"/>
        </xsl:attribute>
      </input>
      <span class="search-text">Search this document</span>
      <input name="query" type="text" size="15" id="bbar-query-box"/>&#160;<input type="submit" value="Go" id="bbar-submit-button"/>
    </form>
   </xsl:template>
   
   <!-- ====================================================================== -->
   <!-- Citation Template                                                      -->
   <!-- ====================================================================== -->
   
   <xsl:template name="citation">
      
      <html xml:lang="en" lang="en">
         <head>
            <title>
               <xsl:value-of select="$doc.title"/>
            </title>
            <link rel="stylesheet" type="text/css" href="{$css.path}bbar.css"/>
         </head>
         <body>
            <xsl:copy-of select="$brand.header"/>
            <div class="container">
               <h2>Citation</h2>
               <div class="citation">
                  <p><xsl:value-of select="/*/*[local-name()='meta']/*[local-name()='creator'][1]"/>. 
                     <xsl:value-of select="/*/*[local-name()='meta']/*[local-name()='title'][1]"/>. 
                     <xsl:value-of select="/*/*[local-name()='meta']/*[local-name()='year'][1]"/>.<br/>
                     [<xsl:value-of select="concat($xtfURL,$dynaxmlPath,'?docId=',$docId)"/>]</p>
                  <a>
                     <xsl:attribute name="href">javascript://</xsl:attribute>
                     <xsl:attribute name="onClick">
                        <xsl:text>javascript:window.close('popup')</xsl:text>
                     </xsl:attribute>
                     <span class="down1">Close this Window</span>
                  </a>
               </div>
            </div>
         </body>
      </html>
     
   </xsl:template>
   
   <!-- ====================================================================== -->
   <!-- Robot Template                                                         -->
   <!-- ====================================================================== -->
   
   <xsl:template name="robot">
      <html>
         <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title><xsl:value-of select="//xtf:meta/title[1]"/></title>
         </head>
         <body>
            <div>
               <xsl:apply-templates select="//text()" mode="robot"/>
            </div>
         </body>
      </html>
   </xsl:template>
   
   <xsl:template match="text()" mode="robot">
      <xsl:value-of select="."/><xsl:text> </xsl:text>
   </xsl:template>
   <!-- Handle Roman Numerals  -->
   <math:romans>
      <math:roman value="1">i</math:roman>
      <math:roman value="1">I</math:roman>
      <math:roman value="5">v</math:roman>
      <math:roman value="5">V</math:roman>
      <math:roman value="10">x</math:roman>
      <math:roman value="10">X</math:roman>
      <math:roman value="50">l</math:roman>
      <math:roman value="50">L</math:roman>
      <math:roman value="100">c</math:roman>
      <math:roman value="100">C</math:roman>
      <math:roman value="500">d</math:roman>
      <math:roman value="500">D</math:roman>
      <math:roman value="1000">m</math:roman>
      <math:roman value="1000">M</math:roman>
   </math:romans>
   
   <xsl:variable name="math:roman-nums" select="document('')/*/*/math:roman"/>
   
   <xsl:template name="math:roman-to-number">
      <xsl:param name="roman"/>
      
      <xsl:variable name="valid-roman-chars">
         <xsl:value-of select="document('')/*/math:romans"/>
      </xsl:variable>
      
      <xsl:choose>
         <xsl:when test="translate($roman,$valid-roman-chars,'')">NaN</xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="math:roman-to-number-impl">
               <xsl:with-param name="roman" select="$roman"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>  
   </xsl:template>
   
   <xsl:template name="math:roman-to-number-impl">
      <xsl:param name="roman"/>
      <xsl:param name="value" select="0"/>
      
      <xsl:variable name="len" select="string-length($roman)"/>
      
      <xsl:choose>
         <xsl:when test="not($len)">
            <xsl:value-of select="$value"/>
         </xsl:when>
         <xsl:when test="$len = 1">
            <xsl:value-of select="$value + $math:roman-nums[. = $roman]/@value"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:variable name="roman-num"  
               select="$math:roman-nums[. = substring($roman, 1, 1)]"/>
            <xsl:choose>
               <xsl:when test="$roman-num/following-sibling::math:roman =
                  substring($roman, 2, 1)">
                  <xsl:call-template name="math:roman-to-number-impl">
                     <xsl:with-param name="roman" select="substring($roman,2,$len - 1)"/>
                     <xsl:with-param name="value" select="$value - $roman-num/@value"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:call-template name="math:roman-to-number-impl">
                     <xsl:with-param name="roman" select="substring($roman,2,$len - 1)"/>
                     <xsl:with-param name="value" select="$value + $roman-num/@value"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
      
   </xsl:template>
</xsl:stylesheet>
