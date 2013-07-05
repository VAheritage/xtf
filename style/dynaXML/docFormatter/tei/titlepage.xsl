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

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="uniqueKey" select="replace(replace($docId,'^.+/',''), '\.xml$', '')"/>

  <!-- ======================================================================= -->
  <!-- Templates for displaying title page as a specially-formatted front page -->
  <!-- ======================================================================= -->

  <xsl:template match="titlePage" mode="titlepage">
    <table width="100%" cellpadding="5" cellspacing="5" style="border-style: double; margin: 0px 0px 40px; text-align: center; background-color: rgb(255, 248, 220);">
      <tr>
        <td>
          <xsl:apply-templates mode="titlepage"/>
        </td>
      </tr>
    </table>

    <hr/>

    <div align="center">
      <span class="down1">
        <xsl:if test="/TEI.2/text/front/div1[@type='dedication']">
          <xsl:text> [</xsl:text>
          <a>
            <xsl:attribute name="href">javascript://</xsl:attribute>
            <xsl:attribute name="onClick">
              <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/>&#038;doc.view=popup&#038;chunk.id=<xsl:value-of select="/TEI.2/text/front/div1[@type='dedication']/@id"/><xsl:text>','popup','width=300,height=300,resizable=yes,scrollbars=yes')</xsl:text>
            </xsl:attribute>
            <xsl:text>Dedication</xsl:text>
          </a>
          <xsl:text>] </xsl:text>
        </xsl:if>
        <xsl:if test="/TEI.2/text/front/div1[@type='copyright']">
          <xsl:text> [</xsl:text>
          <a>
            <xsl:attribute name="href">javascript://</xsl:attribute>
            <xsl:attribute name="onClick">
              <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/>&#038;doc.view=popup&#038;chunk.id=<xsl:value-of select="/TEI.2/text/front/div1[@type='copyright']/@id"/><xsl:text>','popup','width=300,height=300,resizable=yes,scrollbars=yes')</xsl:text>
            </xsl:attribute>
            <xsl:text>Copyright</xsl:text>
          </a>
          <xsl:text>] </xsl:text>
        </xsl:if>
        <xsl:if test="/TEI.2/text/front/div1[@type='epigraph']">
          <xsl:text> [</xsl:text>
          <a>
            <xsl:attribute name="href">javascript://</xsl:attribute>
            <xsl:attribute name="onClick">
              <xsl:text>javascript:window.open('</xsl:text><xsl:value-of select="$doc.path"/>&#038;doc.view=popup&#038;chunk.id=<xsl:value-of select="/TEI.2/text/front/div1[@type='epigraph']/@id"/><xsl:text>','popup','width=300,height=300,resizable=yes,scrollbars=yes')</xsl:text>
            </xsl:attribute>
            <xsl:text>Epigraph</xsl:text>
          </a>
          <xsl:text>] </xsl:text>
        </xsl:if>
      </span>
    </div>

  </xsl:template>

  <xsl:template match="titlePart" mode="titlepage">
    <xsl:choose>
      <xsl:when test="@type='subtitle'">
        <h4>
          <i>
            <xsl:apply-templates/>
          </i>
        </h4>
      </xsl:when>
      <xsl:otherwise>
        <h2 style="margin-top: 40px; margin-bottom: 0px; font-family: 'Times New Roman',Times,Georgia,serif; font-size: 2em; color: rgb(39, 64, 139); line-height: 46px;">
          <xsl:apply-templates/>
        </h2>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="docAuthor" mode="titlepage">
    <xsl:choose>
      <xsl:when test="name">
        <xsl:apply-templates mode="titlepage"/>
      </xsl:when>
      <xsl:otherwise>
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="docAuthor/name" mode="titlepage">
    <h4>
      <xsl:apply-templates/>
    </h4>
  </xsl:template>

  <xsl:template match="docAuthor/address" mode="titlepage">
    <h5>
      <xsl:apply-templates/>
    </h5>
  </xsl:template>

  <!-- Greg Murray (gpm2a@virginia.edu): 2010-06-11: Exclude the content of
    the verso of the title page -->
  <xsl:template match="docImprint" mode="titlepage">
    <xsl:variable name="verso" select="ancestor::titlePage/descendant::pb[2]"/>
    <xsl:apply-templates select="node()[not(preceding::pb[1] is $verso)]" mode="titlepage"/>
  </xsl:template>

  <xsl:template match="docImprint/publisher" mode="titlepage">
    <h6>
      <xsl:apply-templates/>
    </h6>
  </xsl:template>

  <xsl:template match="docImprint/pubPlace" mode="titlepage">
    <h6>
      <i>
        <xsl:apply-templates/>
      </i>
    </h6>
  </xsl:template>

  <xsl:template match="docImprint/docDate" mode="titlepage">
    <h6>
      <xsl:text>&#169; </xsl:text>
      <xsl:apply-templates/>
    </h6>
  </xsl:template>

  <xsl:template match="div1[@type='dedication']" mode="titlepage">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="div1[@type='copyright']" mode="titlepage">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="div1[@type='epigraph']" mode="titlepage">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="pb" mode="titlepage"/>

  <xsl:template match="biblFull" mode="titlepage">
    <table width="100%" cellpadding="5" cellspacing="5" style="border-style: double; margin: 0px 0px 40px; text-align: center; background-color: rgb(255, 248, 220);">
      <tr>
        <td>
          <h2 style="margin-top: 40px; margin-bottom: 0px; font-family: 'Times New Roman',Times,Georgia,serif; font-size: 2em; color: rgb(39, 64, 139); line-height: 46px;">
            <xsl:value-of select="titleStmt/title[@type='main']"/>
          </h2>
          <h2 style="margin-bottom: 0px; font-family: 'Times New Roman',Times,Georgia,serif; font-size: 1.5em; color: rgb(39, 64, 139); line-height: 46px;">
            <xsl:value-of select="//TEI.2/teiHeader/fileDesc/titleStmt/biblScope/date"/>
          </h2>
          <h4>
            <i>
              <xsl:value-of select="titleStmt/title[@type='sub']"/>
            </i>
          </h4>
          <h4>
          <xsl:choose>
           <xsl:when test="titleStmt/author/name">
            <xsl:value-of select="titleStmt/author/name[@type='first']"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="titleStmt/author/name[@type='last']"/>
           </xsl:when>
           <xsl:otherwise>
            <xsl:value-of select="string-join(titleStmt/author, '; ')"/>
           </xsl:otherwise>
          </xsl:choose>
          </h4>
          <xsl:value-of select="titleStmt/author/dateRange"/>

          <h6>
            <xsl:value-of select="publicationStmt/publisher"/>
          </h6>
          <h6>
            <i>
              <xsl:value-of select="publicationStmt/pubPlace"/>
            </i>
          </h6>
          <h6>
            <xsl:value-of select="publicationStmt/date"/>
          </h6>
        </td>
      </tr>
    </table>
    <hr/>
  </xsl:template>

  <!-- Greg Murray (gpm2a@virginia.edu): 2010-06-09: Added templates for
    displaying title page content in the normal page-by-page manner, in the
    context of surrounding content - that is, *without* the special formatting
    used to display title page content as the front page of the TEI document
    (when no chunk.id is passed in). See JIRA ticket HYDRA-429 for rationale.
  -->

  <!-- ====================================================================== -->
  <!-- Templates for displaying title page without special formatting         -->
  <!-- ====================================================================== -->

  <xsl:template match="titlePage">
    <div class="tei_titlePage">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="docTitle">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="titlePart">
    <xsl:choose>
      <xsl:when test="@type='main'">
        <div class="tei_titlePart tei_titlePart_main">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:when test="@type='sub' or @type='desc'">
        <div class="tei_titlePart tei_titlePart_sub">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="tei_titlePart tei_titlePart_other">
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- <byline> and <docAuthor> are handled in component.xsl -->

  <xsl:template match="docDate |
    docEdition |
    docImprint |
    docImprint/publisher |
    docImprint/pubPlace |
    imprimatur">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

</xsl:stylesheet>
