<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- dynaXML Stylesheet                                                     -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<!--
   Copyright (c) 2005, Regents of the University of California
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

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:math="http://www.ora.com/XSLTCookbook/math" xmlns:xtf="http://cdlib.org/xtf">

  <!-- ====================================================================== -->
  <!-- Import Common Templates                                                -->
  <!-- ====================================================================== -->

  <xsl:import href="../common/docFormatterCommon.xsl"/>

  <xsl:output method="html" indent="yes" encoding="utf-8" media-type="text/html"
    doctype-public="-//W3C//DTD HTML 4.0//EN"/>

  <!-- ====================================================================== -->
  <!-- Strip Space                                                            -->
  <!-- ====================================================================== -->

  <xsl:strip-space elements="*"/>

  <!-- ====================================================================== -->
  <!-- Included Stylesheets                                                   -->
  <!-- ====================================================================== -->

  <xsl:include href="autotoc.xsl"/>
  <xsl:include href="component.xsl"/>
  <xsl:include href="search.xsl"/>
  <xsl:include href="parameter.xsl"/>
  <xsl:include href="structure.xsl"/>
  <xsl:include href="table.xsl"/>
  <xsl:include href="titlepage.xsl"/>

  <!-- ====================================================================== -->
  <!-- Define Keys                                                            -->
  <!-- ====================================================================== -->

  <xsl:key name="pb-id" match="pb|milestone" use="@id"/>
  <xsl:key name="ref-id" match="ref" use="@id"/>
  <xsl:key name="formula-id" match="formula" use="@id"/>
  <xsl:key name="fnote-id" match="note[@type='footnote' or @place='foot']" use="@id"/>
  <xsl:key name="endnote-id" match="note[@type='endnote' or @place='end']" use="@id"/>
  <xsl:key name="div-id" match="div1|div2|div3|div4|div5|div6" use="@id"/>
  <xsl:key name="hit-num-dynamic" match="xtf:hit" use="@hitNum"/>
  <xsl:key name="hit-rank-dynamic" match="xtf:hit" use="@rank"/>
  <xsl:key name="generic-id"
    match="note[not(@type='footnote' or @place='foot' or @type='endnote' or @place='end')]|figure|bibl|table"
    use="@id"/>

  <!-- ====================================================================== -->
  <!-- Root Template                                                          -->
  <!-- ====================================================================== -->

  <xsl:template match="/">

    <xsl:choose>
      <xsl:when test="$doc.view='bbar'">
        <xsl:call-template name="bbar"/>
      </xsl:when>
      <xsl:when test="$doc.view='toc'">
        <xsl:call-template name="toc"/>
      </xsl:when>
      <xsl:when test="$doc.view='content'">
        <xsl:call-template name="content"/>
      </xsl:when>
      <xsl:when test="$doc.view='popup'">
        <xsl:call-template name="popup"/>
      </xsl:when>
      <xsl:when test="$doc.view='print'">
        <xsl:call-template name="print"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="frames"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- Frames Template                                                        -->
  <!-- ====================================================================== -->

  <xsl:template name="frames">


    <html xmlns="http://www.w3.org/1999/xhtml">
      <!-- InstanceBegin template="/Templates/lib_home.dwt" codeOutsideHTMLIsLocked="false" -->
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <!-- InstanceBeginEditable name="doctitle" -->
        <title>University of Virginia Library - <xsl:value-of
            select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='main']"/>:
            <xsl:value-of select="/TEI.2/teiHeader/fileDesc/titleStmt/biblScope/date"/></title>

        <link href="http://www.lib.virginia.edu/scripts/yui-2.2.0a/build/grids/grids.css"
          rel="stylesheet" type="text/css"/>
        <link href="http://www2.lib.virginia.edu/styles/main.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="{$css.path}dl.css"/>
        <link
          href="http://www.lib.virginia.edu/scripts/yahoo/2.3.0/build/button/assets/skins/sam/button.css"
          rel="stylesheet" type="text/css"/>
        <script type="text/javascript"
          src="http://www.lib.virginia.edu/scripts/yahoo/2.3.0/build/yahoo-dom-event/yahoo-dom-event.js"/>
        <script type="text/javascript"
          src="http://www.lib.virginia.edu/scripts/yui-2.2.0a/build/element/element-beta-min.js"/>

        <script type="text/javascript"
          src="http://www.lib.virginia.edu/scripts/yui-2.2.0a/build/animation/animation-min.js"/>
        <script type="text/javascript"
          src="http://www.lib.virginia.edu/scripts/yui-2.2.0a/build/tabview/tabview-min.js"/>
        <script type="text/javascript"
          src="http://www.lib.virginia.edu/scripts/yahoo/2.3.0/build/button/button-beta-min.js"/>
        <script type="text/javascript" src="http://www2.lib.virginia.edu/scripts/main.js"/>

        <!-- InstanceBeginEditable name="head" -->
        <link href="http://www2.lib.virginia.edu/styles/components/news.css" rel="stylesheet"
          type="text/css"/>
        <link href="http://www2.lib.virginia.edu/styles/home.css" rel="stylesheet" type="text/css"/>

        <!-- InstanceEndEditable -->

      </head>
      <body id="home" class="uvalib-t3 uvalib-hd1">
        <div id="globalHd">
          <div class="docWrap">
            <div id="skipToNav" class="imgReplace">
              <strong>Skip directly to:</strong>
              <a href="#content">Main content</a>
              <a href="#globalNav">Main navigation</a>
            </div>
            <hr/>
            <div id="bookmarkMotif"> </div>

            <div id="branding">
              <h1 id="logo" class="imgReplace">University of Virginia Library</h1>
            </div>
          </div>
        </div>
        <div id="content">
          <div class="docWrap">

            <div id="subContent1">
              <div name="leftcolumn" class="leftcolumn">
                <xsl:call-template name="toc"/>
              </div>
            </div>
            <div id="docText" class="bd gA">
              <div class="addPadding">
                <xsl:call-template name="content"/>
              </div>
            </div>

          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- Anchor Template                                                        -->
  <!-- ====================================================================== -->

  <xsl:template name="create.anchor">
    <xsl:choose>
      <xsl:when test="($query != '0' and $query != '') and $hit.rank != '0'">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="key('hit-rank-dynamic', $hit.rank)/@hitNum"/>
      </xsl:when>
      <xsl:when test="($query != '0' and $query != '') and $set.anchor != '0'">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="$set.anchor"/>
      </xsl:when>
      <xsl:when test="$query != '0' and $query != ''">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="key('div-id', $chunk.id)/@xtf:firstHit"/>
      </xsl:when>
      <xsl:when test="$anchor.id != '0'">
        <xsl:text>#X</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- TOC Template                                                           -->
  <!-- ====================================================================== -->

  <xsl:template name="toc">
    <xsl:variable name="sum">
      <xsl:choose>
        <xsl:when test="($query != '0') and ($query != '')">
          <xsl:value-of select="number(/*[1]/@xtf:hitCount)"/>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="occur">
      <xsl:choose>
        <xsl:when test="$sum != 1">occurrences</xsl:when>
        <xsl:otherwise>occurrence</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <div class="toc">
      <div class="toc_title">
        <xsl:value-of
          select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/author/name[@type='last']"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of
        select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/author/name[@type='first']"/>
        <br/>
        <xsl:value-of select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/author/dateRange"></xsl:value-of>
        <br/><br/>
        <xsl:value-of
        select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='main']"/>
      </div>
      <p style="line-height: 1.4em;"><xsl:value-of
        select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='sub']"
      /> <br/><br/><b><xsl:value-of select="/TEI.2/teiHeader/fileDesc/titleStmt/biblScope[@type='volume']/num"></xsl:value-of></b></p>
      <hr/>
      <h5><xsl:value-of select="//availability/p[@n='copyright']"></xsl:value-of></h5>
      <xsl:if test="($query != '0') and ($query != '')">
        <div align="center">
          <b>
            <span class="hit-count">
              <xsl:value-of select="$sum"/>
            </span>
            <xsl:text> </xsl:text>
            <xsl:value-of select="$occur"/>
            <xsl:text> of </xsl:text>
            <span class="hit-count">
              <xsl:value-of select="$query"/>
            </span>
          </b>
          <br/>
          <xsl:text> [</xsl:text>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="$doc.path"/>&#038;chunk.id=<xsl:value-of select="$chunk.id"
                />&#038;toc.depth=<xsl:value-of select="$toc.depth"
                />&#038;toc.id=<xsl:value-of select="$toc.id"/>&#038;brand=<xsl:value-of
                select="$brand"/>
            </xsl:attribute>
            <xsl:attribute name="target">_top</xsl:attribute>
            <xsl:text>Clear Hits</xsl:text>
          </a>
          <xsl:text>]</xsl:text>
        </div>
        <hr/>
      </xsl:if>
      <xsl:apply-templates select="/TEI.2/text/body/div1" mode="toc"/>
      <xsl:apply-templates select="//div2/head" mode="toc"/>
    </div>
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- Content Template                                                       -->
  <!-- ====================================================================== -->

  <xsl:template name="content">

    <xsl:variable name="titlePage">
      <xsl:value-of select="//pb[ends-with(@entity, 'title')]/@entity"/>
    </xsl:variable>

    <xsl:variable name="titleNum">
      <xsl:choose>
        <xsl:when test="$titlePage=''">
          <xsl:value-of select="1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of
            select="number(substring-before(substring-after(substring-after($titlePage, //idno[@type='DLPS ID']), '_'), '_'))"
          />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="pageNum">
      <xsl:choose>
        <xsl:when test="$page != '0'">
          <xsl:value-of select="number($page)"></xsl:value-of>          
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number($titleNum)"></xsl:value-of>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <xsl:variable name="prevPage">
      <xsl:choose>
        <xsl:when test="exists(//pb[number(substring-before(substring-after(substring-after(@entity, //idno[@type='DLPS ID']), '_'), '_')) &lt; $pageNum])">
          <xsl:value-of select="$pageNum - 1"></xsl:value-of>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$pageNum"></xsl:value-of>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="nextPage">
      <xsl:choose>
        <xsl:when test="exists(//pb[number(substring-before(substring-after(substring-after(@entity, //idno[@type='DLPS ID']), '_'), '_')) &gt; $pageNum])">
          <xsl:value-of select="$pageNum + 1"></xsl:value-of>          
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$pageNum"></xsl:value-of>
        </xsl:otherwise>        
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="pageExists">
      <xsl:choose>
      <xsl:when test="exists(//pb[number(substring-before(substring-after(substring-after(@entity, //idno[@type='DLPS ID']), '_'), '_')) = $pageNum])">
        <xsl:value-of select="true"></xsl:value-of>
      </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'false'"></xsl:value-of>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    

    <div id="mainContent">
      <!-- BEGIN CONTENT ROW -->
      <table class="content">
        <tr>
          <td align="left" valign="top">
            <div class="content">
              <h1><xsl:value-of
                  select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='main']"
              /></h1>
              <!-- BEGIN CONTENT -->
              <form action="view" style="text-align: center;">
              <span class="navbar">
                <xsl:choose>
                  <xsl:when test="$prevPage &lt; $pageNum">
                    <b><a href="?docId={$docId}&amp;page={$prevPage}" id="prevPage">&lt; Previous</a></b>    
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>Previous</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text> | </xsl:text>
                <a href="?docId={$docId}&amp;page={$titleNum}"> Return to Title </a>
                <xsl:text> | </xsl:text>
                <a style="color: #0F3E83">Turn to page: </a> 
                  <input name="docId" id="docId" value="{$docId}" type="hidden"/>
                  <input name="page" id="page" size="4" type="text"/>
                    <input name="submit" id="submit" type="submit" value="Go"/>
                <xsl:text> | </xsl:text>
                <xsl:choose>
                  <xsl:when test="$nextPage &gt; $pageNum">
                    <b><a href="?docId={$docId}&amp;page={$nextPage}" id="nextPage">Next &gt;</a></b>          
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>Next</xsl:text>          
                  </xsl:otherwise>
                </xsl:choose>
              </span>
              </form>
              
                <xsl:if test="$pageExists='false'">
                <br/>
                <br/>
                <h3 style="width: 100%; text-align: center;">
                <xsl:text>That page does not exist.</xsl:text>
                </h3>      
                </xsl:if>
              
              <xsl:apply-templates select="//div1/pb">
                <xsl:with-param name="position" select="$pageNum"/>
              </xsl:apply-templates>
            </div>
          </td>
        </tr>
      </table>
    </div>
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- Print Template                                                  -->
  <!-- ====================================================================== -->

  <xsl:template name="print">
    <html>
      <head>
        <title>
          <xsl:value-of select="$doc.title"/>
        </title>
        <xsl:copy-of select="$brand.links"/>
        <link rel="stylesheet" type="text/css" href="{$css.path}{$content.css}"/>
      </head>
      <body bgcolor="white">
        <hr class="hr-title"/>
        <div align="center">
          <table width="95%">
            <tr>
              <td>
                <xsl:apply-templates select="/TEI.2/text"/>
              </td>
            </tr>
          </table>
        </div>
        <hr class="hr-title"/>
      </body>
    </html>
  </xsl:template>

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
      <input name="query" type="text" size="15" id="bbar-query-box"/>&#160;<input type="submit"
        value="Go" id="bbar-submit-button"/>
    </form>

  </xsl:template>

  <!-- ====================================================================== -->
  <!-- Popup Window Template                                                  -->
  <!-- ====================================================================== -->

  <xsl:template name="popup">
    <html>
      <head>
        <title>
          <xsl:choose>
            <xsl:when
              test="(key('fnote-id', $chunk.id)/@type = 'footnote') or (key('fnote-id', $chunk.id)/@place = 'foot')">
              <xsl:text>Footnote</xsl:text>
            </xsl:when>
            <xsl:when test="key('div-id', $chunk.id)/@type = 'dedication'">
              <xsl:text>Dedication</xsl:text>
            </xsl:when>
            <xsl:when test="key('div-id', $chunk.id)/@type = 'copyright'">
              <xsl:text>Copyright</xsl:text>
            </xsl:when>
            <xsl:when test="key('div-id', $chunk.id)/@type = 'epigraph'">
              <xsl:text>Epigraph</xsl:text>
            </xsl:when>
            <xsl:when test="$fig.ent != '0'">
              <xsl:text>Illustration</xsl:text>
            </xsl:when>
            <xsl:when test="$formula.id != '0'">
              <xsl:text>Formula</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>popup</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </title>
        <xsl:copy-of select="$brand.links"/>
        <link rel="stylesheet" type="text/css" href="{$css.path}{$content.css}"/>
      </head>
      <body>
        <div class="content">
          <xsl:choose>
            <xsl:when
              test="(key('fnote-id', $chunk.id)/@type = 'footnote') or (key('fnote-id', $chunk.id)/@place = 'foot')">
              <xsl:apply-templates select="key('fnote-id', $chunk.id)"/>
            </xsl:when>
            <xsl:when test="key('div-id', $chunk.id)/@type = 'dedication'">
              <xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"/>
            </xsl:when>
            <xsl:when test="key('div-id', $chunk.id)/@type = 'copyright'">
              <xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"/>
            </xsl:when>
            <xsl:when test="key('div-id', $chunk.id)/@type = 'epigraph'">
              <xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"/>
            </xsl:when>
            <xsl:when test="$fig.ent != '0'">
              <img src="{$fig.ent}" alt="full-size image"/>
            </xsl:when>
            <xsl:when test="$formula.id != '0'">
              <div align="center">
                <applet code="HotEqn.class" archive="{$xtfURL}applets/HotEqn.jar" height="550"
                  width="550" name="{$formula.id}" align="middle">
                  <param name="equation">
                    <xsl:attribute name="value">
                      <xsl:value-of select="key('formula-id', $formula.id)"/>
                    </xsl:attribute>
                  </param>
                  <param name="fontname" value="TimesRoman"/>
                  <param name="bgcolor" value="CCCCCC"/>
                  <param name="fgcolor" value="0000ff"/>
                  <param name="halign" value="center"/>
                  <param name="valign" value="middle"/>
                  <param name="debug" value="true"/>
                </applet>
              </div>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="custom"/>
            </xsl:otherwise>
          </xsl:choose>
          <p>
            <a>
              <xsl:attribute name="href">javascript://</xsl:attribute>
              <xsl:attribute name="onClick">
                <xsl:text>javascript:window.close('popup')</xsl:text>
              </xsl:attribute>
              <span class="down1">Close this Window</span>
            </a>
          </p>
        </div>
      </body>
    </html>
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- Customization Template                                                 -->
  <!-- ====================================================================== -->

  <xsl:template name="custom">
    <!-- Dead Template -->
  </xsl:template>

  <!-- ====================================================================== -->
  <!-- Navigation Bar Template                                                -->
  <!-- ====================================================================== -->

  <xsl:template name="navbar">
    

   </xsl:template>

</xsl:stylesheet>
