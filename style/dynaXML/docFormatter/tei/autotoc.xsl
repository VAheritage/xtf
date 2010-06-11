<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xtf="http://cdlib.org/xtf" xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="#all">

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

	<xsl:template name="book.autotoc" exclude-result-prefixes="#all">
		<!-- book title -->
		<table cellpadding="0" cellspacing="0" class="title">
			<tr>
				<td>
					<div class="toc_title">
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="$doc.path"/>;brand=<xsl:value-of
									select="$brand"/>;<xsl:value-of select="$search"/>
							</xsl:attribute>
							<xsl:attribute name="target">_top</xsl:attribute>
							<xsl:value-of select="//teiHeader//biblFull//title[@type='main']"/><br/>
							<xsl:value-of select="//TEI.2/teiHeader/fileDesc/titleStmt/biblScope/date"/>
						</a>
						<br/>
						<xsl:value-of select="//teiHeader//biblFull//title[@type='sub']"/>
					</div>
					<div class="toc_byline">
						<xsl:if test="exists(//teiHeader//biblFull//author/name[@type='last']) and exists(//teiHeader//biblFull//author/name[@type='first'])">
							<xsl:value-of select="//teiHeader//biblFull//author/name[@type='last']"/>
							<xsl:text>, </xsl:text>
							<xsl:value-of select="//teiHeader//biblFull//author/name[@type='first']"/>
						</xsl:if>
						<xsl:if test="//teiHeader//biblFull//author/dateRange">
							<xsl:text> (</xsl:text>
							<xsl:value-of select="//teiHeader//biblFull//author/dateRange"/>
							<xsl:text>)</xsl:text>
						</xsl:if>
					</div>
				</td>
			</tr>
		</table>
		<!-- hit summary -->
		<xsl:if test="($query != '0') and ($query != '')">
			<!--<hr/>-->
			<xsl:call-template name="hitSummary"/>
		</xsl:if>
		<!--<hr/>-->
		<!-- front -->
		<xsl:apply-templates
			select="/*/*[local-name()='text']/*[local-name()='front']/*[matches(name(),'^div') or local-name()='titlePage']"
			mode="toc"/>
		<br/>
		<!-- body -->
		<xsl:apply-templates
			select="/*/*[local-name()='text']/*[local-name()='body']/*[matches(name(),'^div')]"
			mode="toc"/>
		<br/>
		<!-- back -->
		<xsl:apply-templates
			select="/*/*[local-name()='text']/*[local-name()='back']/*[matches(name(),'^div')]"
			mode="toc"/>
		<!-- hit summary -->
		<xsl:if test="($query != '0') and ($query != '')">
			<!--<hr/>-->
			<xsl:call-template name="hitSummary"/>
		</xsl:if>
		<!-- expand/collapse all -->
		<xsl:call-template name="expandAll"/>
	</xsl:template>

	<!-- div processing template -->
	<xsl:template match="*[matches(name(),'^div') or local-name()='titlePage']" mode="toc" exclude-result-prefixes="#all">

		<!-- head element -->
		<xsl:variable name="head">
			<xsl:choose>
				<xsl:when test="*[local-name()='head']">
					<xsl:value-of select="*[local-name()='head']"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="*[matches(name(),'^div')]"/>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:variable>
		<!-- hit count for this node -->
		<xsl:variable name="hit.count">
			<xsl:choose>
				<xsl:when test="($query != '0') and ($query != '') and (@xtf:hitCount)">
					<xsl:value-of select="@xtf:hitCount"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- hierarchical level -->
		<xsl:variable name="level" select="count(ancestor::*[matches(name(),'^div')]) + 1"/>
		<!-- number of pixels per hierarchical level -->
		<xsl:variable name="factor" select="25"/>

		<xsl:if test="$head">
			<table cellpadding="0" cellspacing="0" class="toc-line">
				<tr>
					<!-- show node hits -->
					<xsl:choose>
						<xsl:when test="($query != '0') and ($query != '')">
							<xsl:choose>
								<xsl:when test="$hit.count != '0'">
									<td width="{($level * $factor) + 10}" class="hits">
										<span class="hit-count">
											<xsl:value-of select="$hit.count"/>&#160; </span>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td width="{($level * $factor) + 10}" class="hits"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<td class="hits"
								width="{if ($level = 1) then '1' else ($level * $factor) - $factor}">
								<!--<xsl:attribute name="width">
									<xsl:choose>
										<xsl:when test="$level=1">
											<xsl:value-of select="1"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="($level * $factor) - $factor"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute> &#160; --></td>
						</xsl:otherwise>
					</xsl:choose>
					<!-- create expand/collapse buttons -->
					<xsl:choose>
						<xsl:when
							test="(number($toc.depth) &lt; ($level + 1) and *[matches(name(),'^div')]/*[local-name()='head']) and (not(@*[local-name()='id'] = key('div-id', $toc.id)/ancestor-or-self::*/@*[local-name()='id']))">
							<td class="expand">
								<xsl:call-template name="expand"/>
							</td>
						</xsl:when>
						<xsl:when
							test="(number($toc.depth) > $level and *[matches(name(),'^div')]/*[local-name()='head']) or (@*[local-name()='id'] = key('div-id', $toc.id)/ancestor-or-self::*/@*[local-name()='id'])">
							<td class="expand">
								<xsl:call-template name="collapse"/>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="expand">&#160;</td>
						</xsl:otherwise>
					</xsl:choose>
					<!-- div number, if present -->
					<xsl:if test="//*[matches(name(),'^div')]/@n">
						<td class="divnum">
							<xsl:choose>
								<xsl:when test="@n">
									<xsl:value-of select="@n"/>
									<xsl:text>.&#160;</xsl:text>
								</xsl:when>
								<xsl:otherwise>&#160;</xsl:otherwise>
							</xsl:choose>
						</td>
					</xsl:if>
					<!-- actual title -->
					<xsl:choose>
						<xsl:when test="*[local-name()='head']">
							<!-- Greg Murray (gpm2a@virginia.edu): 2010-05-31: In TOC, display main heading, not necessarily the first -->
							<xsl:choose>
								<xsl:when test="*[local-name()='head'][@type='main']">
									<td class="head">
										<xsl:apply-templates select="*[local-name()='head'][@type='main']" mode="toc"/>
									</td>
								</xsl:when>
								<xsl:otherwise>
									<td class="head">
										<xsl:apply-templates select="*[local-name()='head'][1]" mode="toc"/>
									</td>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="@type or local-name()='titlePage'">
							<td class="head">
								<div class="l1">
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="$doc.path"
												/>;chunk.id=<xsl:value-of select="@id"
												/>;toc.depth=100;brand=<xsl:value-of select="$brand"
												/><xsl:value-of select="$search"/>
										</xsl:attribute>
										<xsl:attribute name="target">_top</xsl:attribute>
										<xsl:text>[</xsl:text>
									  <xsl:choose>
									    <xsl:when test="local-name()='titlePage'">
									      <xsl:text>title page</xsl:text>
									    </xsl:when>
									    <xsl:otherwise>
									      <xsl:value-of select="@type"/>
									    </xsl:otherwise>
									  </xsl:choose>
										<xsl:text>]</xsl:text>
									</a>
								</div>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td class="head">
								<div class="l1">
									<a>
										<xsl:attribute name="href">
											<xsl:value-of select="$doc.path"
												/>;chunk.id=<xsl:value-of select="$chunk.id"
												/>;toc.depth=<xsl:value-of select="100"
												/>;brand=<xsl:value-of select="$brand"
												/><xsl:value-of select="$search"/>
										</xsl:attribute>
										<xsl:attribute name="target">_top</xsl:attribute>
										<xsl:text>[untitled]</xsl:text>
									</a>
								</div>
							</td>
						</xsl:otherwise>
					</xsl:choose>


				</tr>
			</table>
			<!-- process node children if required -->
			<xsl:if
				test="(number($toc.depth) > $level and *[matches(name(),'^div')]/*[local-name()='head']) or (@*[local-name()='id'] = key('div-id', $toc.id)/ancestor-or-self::*/@*[local-name()='id'])">
				<xsl:apply-templates select="*[matches(name(),'^div')]" mode="toc"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!-- processs head element for toc -->
	<xsl:template match="*[local-name()='head']" mode="toc" exclude-result-prefixes="#all">

		<!-- hierarchical level -->
		<xsl:variable name="level" select="count(ancestor::*[matches(name(),'^div')])"/>

		<!-- mechanism by which the proper toc branch is expanded -->
		<xsl:variable name="local.toc.id">
			<xsl:choose>
				<!-- if this node is not terminal, expand this node -->
				<xsl:when test="parent::*[matches(name(),'^div')]/*[matches(name(),'^div')]">
					<xsl:value-of select="parent::*[matches(name(),'^div')]/@*[local-name()='id']"/>
				</xsl:when>
				<!-- if this node is terminal, expand the parent node -->
				<xsl:otherwise>
					<xsl:value-of
						select="parent::*[matches(name(),'^div')]/parent::*[matches(name(),'^div')]/@*[local-name()='id']"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$chunk.id=ancestor::*[1]/@*[local-name()='id']">
				<a name="X"/>
				<div class="l{$level}">
					<span class="toc-hi">
						<xsl:call-template name="text_for_toc_heads"/>
					</span>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="l{$level}">
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="$doc.path"/>;chunk.id=<xsl:value-of
								select="ancestor::*[1]/@*[local-name()='id']"
								/>;toc.depth=<xsl:value-of select="$toc.depth"
								/>;toc.id=<xsl:value-of select="$local.toc.id"/>;brand=<xsl:value-of
								select="$brand"/><xsl:value-of select="$search"/><xsl:call-template
								name="create.anchor"/>
						</xsl:attribute>
						<xsl:attribute name="target">_top</xsl:attribute>
						<xsl:call-template name="text_for_toc_heads"/>
					</a>
				</div>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- Greg Murray (gpm2a@virginia.edu): 2010-05-28: Headings in TOC should only
	  include text nodes (no formatting or line breaks), but must not include
	  <note> or <ref> content -->
  <xsl:template name="text_for_toc_heads">
		<xsl:apply-templates select="descendant::text()[not(ancestor::*[local-name()='note']) and not(ancestor::*[local-name()='ref'])]"/>
  </xsl:template>

	<xsl:template name="hitSummary" exclude-result-prefixes="#all">

		<xsl:variable name="sum">
			<xsl:choose>
				<xsl:when test="($query != '0') and ($query != '')">
					<xsl:value-of select="number(/*/@xtf:hitCount)"/>
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

		<div class="hitSummary">
			<span class="hit-count">
				<xsl:value-of select="$sum"/>
			</span>
			<xsl:text>&#160;</xsl:text>
			<xsl:value-of select="$occur"/>
			<xsl:text> of </xsl:text>
			<span class="hit-count">
				<xsl:value-of select="$query"/>
			</span>
			<br/> [<a
				href="{$doc.path};chunk.id={$chunk.id};toc.depth={$toc.depth};toc.id={$toc.id};brand={$brand}"
				target="_top">Clear Hits</a>] </div>

	</xsl:template>

	<!-- templates for expanding and collapsing single nodes -->
	<xsl:template name="expand" exclude-result-prefixes="#all">
		<xsl:variable name="local.toc.id" select="@*[local-name()='id']"/>
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="$doc.path"/>;chunk.id=<xsl:value-of select="$chunk.id"
					/>;toc.id=<xsl:value-of select="$local.toc.id"/>;brand=<xsl:value-of
					select="$brand"/><xsl:value-of select="$search"/>
			</xsl:attribute>
			<xsl:attribute name="target">_top</xsl:attribute>
			<img src="{$icon.path}i_expand.gif" border="0" alt="expand section"/>
		</a>
	</xsl:template>

	<xsl:template name="collapse" exclude-result-prefixes="#all">
		<xsl:variable name="local.toc.id">
			<!-- HERE -->
			<xsl:choose>
				<xsl:when test="*[local-name()='head'] and @*[local-name()='id']">
					<xsl:value-of
						select="parent::*[*[local-name()='head'] and @*[local-name()='id']]/@*[local-name()='id']"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="$doc.path"/>;chunk.id=<xsl:value-of select="$chunk.id"
					/>;toc.id=<xsl:value-of select="$local.toc.id"/>;brand=<xsl:value-of
					select="$brand"/><xsl:value-of select="$search"/>
			</xsl:attribute>
			<xsl:attribute name="target">_top</xsl:attribute>
			<img src="{$icon.path}i_colpse.gif" border="0" alt="collapse section"/>
		</a>
	</xsl:template>

	<!-- expand or collapse entire hierarchy -->
	<xsl:template name="expandAll" exclude-result-prefixes="#all">
		<!--<hr/>-->
		<div class="expandAll">
			<img src="{$icon.path}i_colpse.gif" border="0" alt="collapse section"/>
			<xsl:text>&#160;</xsl:text>
			<a>
				<xsl:attribute name="href">
					<xsl:value-of select="$doc.path"/>;chunk.id=<xsl:value-of select="$chunk.id"
						/>;toc.depth=<xsl:value-of select="1"/>;brand=<xsl:value-of select="$brand"
						/><xsl:value-of select="$search"/>
				</xsl:attribute>
				<xsl:attribute name="target">_top</xsl:attribute>
				<xsl:text>Collapse All</xsl:text>
			</a>
			<xsl:text> | </xsl:text>
			<a>
				<xsl:attribute name="href">
					<xsl:value-of select="$doc.path"/>;chunk.id=<xsl:value-of select="$chunk.id"
						/>;toc.depth=<xsl:value-of select="100"/>;brand=<xsl:value-of
						select="$brand"/><xsl:value-of select="$search"/>
				</xsl:attribute>
				<xsl:attribute name="target">_top</xsl:attribute>
				<xsl:text>Expand All</xsl:text>
			</a>
			<xsl:text>&#160;</xsl:text>
			<img src="{$icon.path}i_expand.gif" border="0" alt="expand section"/>
		</div>
	</xsl:template>

</xsl:stylesheet>
