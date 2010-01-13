<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:math="http://www.ora.com/XSLTCookbook/math" xmlns:xtf="http://cdlib.org/xtf"
	xmlns="http://www.w3.org/1999/xhtml" xmlns:session="java:org.cdlib.xtf.xslt.Session"
	extension-element-prefixes="session" exclude-result-prefixes="#all">

	<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
	<!-- dynaXML Stylesheet                                                     -->
	<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

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
	<!-- Import Common Templates                                                -->
	<!-- ====================================================================== -->

	<xsl:import href="../common/docFormatterCommon.xsl"/>

	<!-- ====================================================================== -->
	<!-- Output Format                                                          -->
	<!-- ====================================================================== -->

	<xsl:output method="xhtml" indent="no" encoding="UTF-8" media-type="text/html; charset=UTF-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
		exclude-result-prefixes="#all" omit-xml-declaration="yes"/>

	<xsl:output name="frameset" method="xhtml" indent="no" encoding="UTF-8"
		media-type="text/html; charset=UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Frameset//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"
		omit-xml-declaration="yes" exclude-result-prefixes="#all"/>

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

	<xsl:key name="pb-id" match="*[matches(name(),'^pb$|^milestone$')]" use="@*[local-name()='id']"/>
	<xsl:key name="ref-id" match="*[matches(name(),'^ref$')]" use="@*[local-name()='id']"/>
	<xsl:key name="fnote-id" match="*[matches(name(),'^note$')][@type='footnote' or @place='foot']"
		use="@*[local-name()='id']"/>
	<xsl:key name="endnote-id" match="*[matches(name(),'^note$')][@type='endnote' or @place='end']"
		use="@*[local-name()='id']"/>
	<xsl:key name="div-id" match="*[matches(name(),'^div')]" use="@*[local-name()='id']"/>
	<xsl:key name="generic-id"
		match="*[matches(name(),'^note$')][not(@type='footnote' or @place='foot' or @type='endnote' or @place='end')]|*[matches(name(),'^figure$|^bibl$|^table$')]"
		use="@*[local-name()='id']"/>

	<!-- ====================================================================== -->
	<!-- TEI-specific parameters                                                -->
	<!-- ====================================================================== -->

	<!-- If a query was specified but no particular hit rank, jump to the first hit 
        (in document order) 
   -->
	<xsl:param name="hit.rank">
		<xsl:choose>
			<xsl:when test="$query and not($query = '0')">
				<xsl:value-of select="key('hit-num-dynamic', '1')/@rank"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>

	<!-- To support direct links from snippets, the following two parameters must check value of $hit.rank -->
	<xsl:param name="chunk.id">
		<xsl:choose>
			<xsl:when
				test="$hit.rank != '0' and key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')]">
				<xsl:value-of
					select="key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')][1]/@*[local-name()='id']"
				/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>

	<xsl:param name="toc.id">
		<xsl:choose>
			<xsl:when
				test="$hit.rank != '0' and key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')]">
				<xsl:value-of
					select="key('hit-rank-dynamic', $hit.rank)/ancestor::*[matches(name(),'^div')][1]/parent::*/@*[local-name()='id']"
				/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>

	<!-- ====================================================================== -->
	<!-- Root Template                                                          -->
	<!-- ====================================================================== -->

	<xsl:template match="/">
		<xsl:choose>
			<!-- robot solution -->
			<xsl:when test="matches($http.user-agent,$robots)">
				<xsl:call-template name="robot"/>
			</xsl:when>
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
			<xsl:when test="$doc.view='citation'">
				<xsl:call-template name="citation"/>
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

	<xsl:template name="frames" exclude-result-prefixes="#all">

		<xsl:variable name="bbar.href"><xsl:value-of select="$query.string"
				/>&#038;doc.view=bbar&#038;chunk.id=<xsl:value-of select="$chunk.id"
				/>&#038;toc.depth=<xsl:value-of select="$toc.depth"
				/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of select="$search"/></xsl:variable>
		<xsl:variable name="toc.href"><xsl:value-of select="$query.string"
				/>&#038;doc.view=toc&#038;chunk.id=<xsl:value-of select="$chunk.id"
				/>&#038;toc.depth=<xsl:value-of select="$toc.depth"
				/>&#038;brand=<xsl:value-of select="$brand"/>&#038;toc.id=<xsl:value-of
				select="$toc.id"/><xsl:value-of select="$search"/>#X</xsl:variable>
		<xsl:variable name="content.href"><xsl:value-of select="$query.string"
				/>&#038;doc.view=content&#038;chunk.id=<xsl:value-of select="$chunk.id"
				/>&#038;toc.depth=<xsl:value-of select="$toc.depth"
				/>&#038;brand=<xsl:value-of select="$brand"/>&#038;anchor.id=<xsl:value-of
				select="$anchor.id"/><xsl:value-of select="$search"/><xsl:call-template
				name="create.anchor"/></xsl:variable>

		<xsl:result-document format="frameset" exclude-result-prefixes="#all">
			<html xml:lang="en" lang="en">
				<!-- InstanceBegin template="/Templates/lib_home.dwt" codeOutsideHTMLIsLocked="false" -->
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
					<!-- InstanceBeginEditable name="doctitle" -->
					<title><xsl:value-of select="//teiHeader//biblFull//title[@type='main']"/> :: <xsl:value-of select="//TEI.2/teiHeader/fileDesc/titleStmt/biblScope/date"/> :: University of Virginia Library</title>

					<link
						href="http://www.lib.virginia.edu/scripts/yui-2.2.0a/build/grids/grids.css"
						rel="stylesheet" type="text/css"/>
					<link href="http://www2.lib.virginia.edu/styles/main.css" rel="stylesheet"
						type="text/css"/>
					<link rel="stylesheet" type="text/css" href="{$css.path}dl.css"/>
					<link rel="stylesheet" type="text/css" href="{$css.path}toc.css"/>
					<link rel="stylesheet" type="text/css" href="{$css.path}table.css"/>
					<link rel="stylesheet" type="text/css" href="{$css.path}uva_blacklight_tei.css"/>
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
					<script type="text/javascript"
						src="http://www2.lib.virginia.edu/scripts/main.js"/>

					<!-- InstanceBeginEditable name="head" -->
					<link href="http://www2.lib.virginia.edu/styles/components/news.css"
						rel="stylesheet" type="text/css"/>
					<link href="http://www2.lib.virginia.edu/styles/home.css" rel="stylesheet"
					type="text/css"/>
					<!-- InstanceEndEditable -->
					
					<!--jquery and blacklight-xtf specific js -->
					<script type="text/javascript" src="{$xtfURL}script/jquery-1.2.6.min.js"/>
					<script type="text/javascript" src="{$xtfURL}script/showpage.js"/>
				</head>
				<body id="home" class="uvalib-dl uvalib-hd1">
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
									<div class="bbar">
										<xsl:call-template name="bbar"/>
									</div>
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
		</xsl:result-document>
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
			<xsl:when test="($query != '0' and $query != '') and $chunk.id != '0'">
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

	<xsl:template name="toc" exclude-result-prefixes="#all">
		<div class="toc">
			<xsl:call-template name="book.autotoc"/>
		</div>
	</xsl:template>

	<!-- ====================================================================== -->
	<!-- Content Template                                                       -->
	<!-- ====================================================================== -->

	<xsl:template name="content" exclude-result-prefixes="#all">

		<xsl:variable name="navbar">
			<xsl:call-template name="navbar"/>
		</xsl:variable>
		<div id="mainContent">


			<!-- navigation table -->
			<table class="navbar">
				<xsl:copy-of select="$navbar"/>
				<tr>
					<td colspan="3">
						<hr class="hr-title"/>
					</td>
				</tr>
			</table>


			<!-- BEGIN CONTENT ROW -->
			<div class="content">
				<!-- BEGIN CONTENT -->
				<xsl:choose>
					<xsl:when test="$chunk.id = '0' and //text/front/titlePage">
						<xsl:apply-templates
							select="/*/*[local-name()='text']/*[local-name()='front']/*[local-name()='titlePage']"
						/>
					</xsl:when>
					<xsl:when test="$chunk.id = '0'">
						<xsl:apply-templates select="//biblFull" mode="titlepage"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="key('div-id', $chunk.id)"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>

			<!-- navigation table -->
			<table class="navbar">
				<xsl:copy-of select="$navbar"/>
				<tr>
					<td colspan="3">
						<hr class="hr-title"/>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>

	<!-- ====================================================================== -->
	<!-- Print Template                                                  -->
	<!-- ====================================================================== -->

	<xsl:template name="print" exclude-result-prefixes="#all">
		<html xml:lang="en" lang="en">
			<head>
				<title>
					<xsl:value-of select="$doc.title"/>
				</title>
				<link rel="stylesheet" type="text/css" href="{$css.path}{$content.css}"/>
			</head>
			<body bgcolor="white">
				<hr class="hr-title"/>
				<div align="center">
					<table width="95%">
						<tr>
							<td>
								<xsl:choose>
									<xsl:when test="$chunk.id != '0'">
										<xsl:apply-templates select="key('div-id', $chunk.id)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:apply-templates select="/*/*[local-name()='text']/*"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</table>
				</div>
				<hr class="hr-title"/>
			</body>
		</html>
	</xsl:template>

	<!-- ====================================================================== -->
	<!-- Popup Window Template                                                  -->
	<!-- ====================================================================== -->

	<xsl:template name="popup" exclude-result-prefixes="#all">
		<html xml:lang="en" lang="en">
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
						<xsl:otherwise>
							<xsl:text>popup</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</title>
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
							<xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"
							/>
						</xsl:when>
						<xsl:when test="key('div-id', $chunk.id)/@type = 'copyright'">
							<xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"
							/>
						</xsl:when>
						<xsl:when test="key('div-id', $chunk.id)/@type = 'epigraph'">
							<xsl:apply-templates select="key('div-id', $chunk.id)" mode="titlepage"
							/>
						</xsl:when>
						<xsl:when test="$fig.ent != '0'">
							<img src="{$fig.ent}" alt="full-size image"/>
						</xsl:when>
					</xsl:choose>
					<p>
						<a>
							<xsl:attribute name="href">javascript://</xsl:attribute>
							<xsl:attribute name="onclick">
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
	<!-- Navigation Bar Template                                                -->
	<!-- ====================================================================== -->

	<xsl:template name="navbar" exclude-result-prefixes="#all">

		<xsl:variable name="prev">
			<xsl:choose>
				<!-- preceding div sibling -->
				<xsl:when
					test="key('div-id', $chunk.id)/preceding-sibling::*[*[local-name()='head']][@*[local-name()='id']]">
					<xsl:value-of
						select="key('div-id', $chunk.id)/preceding-sibling::*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"
					/>
				</xsl:when>
				<!-- last div node in preceding div sibling of parent -->
				<xsl:when
					test="key('div-id', $chunk.id)/parent::*/preceding-sibling::*[*[local-name()='head']][@*[local-name()='id']]">
					<xsl:value-of
						select="key('div-id', $chunk.id)/parent::*/preceding-sibling::*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"
					/>
				</xsl:when>
				<!-- last div node in any preceding structure-->
				<xsl:when
					test="key('div-id', $chunk.id)/ancestor::*/preceding-sibling::*/*[*[local-name()='head']][@*[local-name()='id']]">
					<xsl:value-of
						select="key('div-id', $chunk.id)/ancestor::*/preceding-sibling::*[1]/*[*[local-name()='head']][@*[local-name()='id']][position()=last()]/@*[local-name()='id']"
					/>
				</xsl:when>
				<!-- top of tree -->
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="prev_toc">
			<xsl:choose>
				<xsl:when
					test="key('div-id', $prev)/*[*[local-name()='head']][@*[local-name()='id']]">
					<xsl:value-of select="key('div-id', $prev)/@*[local-name()='id']"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="key('div-id', $prev)/parent::*[*[local-name()='head']][@*[local-name()='id']]/@*[local-name()='id']"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="next">
			<xsl:choose>
				<!-- following div sibling -->
				<xsl:when
					test="key('div-id', $chunk.id)/following-sibling::*[*[local-name()='head']][@*[local-name()='id']]">
					<xsl:value-of
						select="key('div-id', $chunk.id)/following-sibling::*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"
					/>
				</xsl:when>
				<!-- first div node in following div sibling of parent -->
				<xsl:when
					test="key('div-id', $chunk.id)/parent::*/following-sibling::*[*[local-name()='head']][@*[local-name()='id']]">
					<xsl:value-of
						select="key('div-id', $chunk.id)/parent::*/following-sibling::*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"
					/>
				</xsl:when>
				<!-- first div node in any following structure -->
				<xsl:when
					test="key('div-id', $chunk.id)/ancestor::*/following-sibling::*/*[*[local-name()='head']][@*[local-name()='id']]">
					<xsl:value-of
						select="key('div-id', $chunk.id)/ancestor::*/following-sibling::*[1]/*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"
					/>
				</xsl:when>
				<!-- no previous $chunk.id (i.e. titlePage) -->
				<xsl:when test="$chunk.id='0'">
					<xsl:value-of
						select="/*/*[local-name()='text']/*[*[*[local-name()='head']][@*[local-name()='id']]][1]/*[*[local-name()='head']][@*[local-name()='id']][1]/@*[local-name()='id']"
					/>
				</xsl:when>
				<!-- bottom of tree -->
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="next_toc">
			<xsl:choose>
				<xsl:when
					test="key('div-id', $next)/*[*[local-name()='head']][@*[local-name()='id']]">
					<xsl:value-of select="key('div-id', $next)/@*[local-name()='id']"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="key('div-id', $next)/parent::*[*[local-name()='head']][@*[local-name()='id']]/@*[local-name()='id']"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr>
			<td width="25%" align="left">
				<!-- BEGIN PREVIOUS SELECTION -->
				<a target="_top">
					<xsl:choose>
						<xsl:when test="$prev != '0'">
							<xsl:attribute name="href">
								<xsl:value-of select="$doc.path"/>
								<xsl:text>&#038;chunk.id=</xsl:text>
								<xsl:value-of select="$prev"/>
								<xsl:text>&#038;toc.id=</xsl:text>
								<xsl:value-of select="$prev_toc"/>
								<xsl:text>&#038;brand=</xsl:text>
								<xsl:value-of select="$brand"/>
								<xsl:value-of select="$search"/>
							</xsl:attribute>
							<img src="{$icon.path}b_prev.gif" width="15" height="15" border="0"
								alt="previous"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="{$icon.path}d_prev.gif" width="15" height="15" border="0"
								alt="no previous"/>
						</xsl:otherwise>
					</xsl:choose>
				</a>
				<!-- END PREVIOUS SELECTION -->
			</td>
			<td width="50%" align="center">
				<span class="chapter-text">
					<xsl:value-of
						select="key('div-id', $chunk.id)/ancestor-or-self::*[matches(@*[local-name()='type'],'fmsec|chapter|bmsec')][1]/*[local-name()='head'][1]"
					/>
					<xsl:value-of select="//teiHeader//biblFull//title[@type='main']"/><br/>
					<xsl:value-of select="//TEI.2/teiHeader/fileDesc/titleStmt/biblScope/date"/>
				</span>
			</td>
			<td width="25%" align="right">
				<!-- BEGIN NEXT SELECTION -->
				<a target="_top">
					<xsl:choose>
						<xsl:when test="$next != '0'">
							<xsl:attribute name="href">
								<xsl:value-of select="$doc.path"/>
								<xsl:text>&#038;chunk.id=</xsl:text>
								<xsl:value-of select="$next"/>
								<xsl:text>&#038;toc.id=</xsl:text>
								<xsl:value-of select="$next_toc"/>
								<xsl:text>&#038;brand=</xsl:text>
								<xsl:value-of select="$brand"/>
								<xsl:value-of select="$search"/>
							</xsl:attribute>
							<img src="{$icon.path}b_next.gif" width="15" height="15" border="0"
								alt="next"/>
						</xsl:when>
						<xsl:otherwise>
							<img src="{$icon.path}d_next.gif" width="15" height="15" border="0"
								alt="no next"/>
						</xsl:otherwise>
					</xsl:choose>
				</a>
				<!-- END NEXT SELECTION -->
			</td>
		</tr>

	</xsl:template>

</xsl:stylesheet>
