<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml" xmlns:math="http://www.ora.com/XSLTCookbook/math"
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

	<!-- ====================================================================== -->
	<!-- Heads                                                                  -->
	<!-- ====================================================================== -->

	<xsl:template match="head">

		<xsl:variable name="type" select="parent::*/@type"/>

		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="@rend">
					<xsl:value-of select="@rend"/>
				</xsl:when>
				<xsl:otherwise>normal</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="@type='sub' or @type='subtitle'">
				<!-- Needs more choices here -->
				<h3 class="{$class}">
					<xsl:apply-templates/>
				</h3>
			</xsl:when>
			<xsl:when test="$type='fmsec'">
				<h2 class="{$class}">
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="$type='volume'">
				<h2 class="{$class}">
					<xsl:if test="parent::*/@n">
						<xsl:value-of select="parent::*/@n"/>
						<xsl:text>. </xsl:text>
					</xsl:if>
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="$type='part'">
				<h2 class="{$class}">
					<xsl:if test="parent::*/@n">
						<xsl:value-of select="parent::*/@n"/>
						<xsl:text>. </xsl:text>
					</xsl:if>
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="$type='chapter'">
				<h2 class="{$class}">
					<xsl:if test="parent::*/@n and not(contains(., parent::*/@n))">
						<xsl:value-of select="parent::*/@n"/>
						<xsl:text>. </xsl:text>
					</xsl:if>
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="$type='ss1'">
				<h3 class="{$class}">
					<xsl:if test="parent::*/@n">
						<xsl:value-of select="parent::*/@n"/>
						<xsl:text>. </xsl:text>
					</xsl:if>
					<xsl:apply-templates/>
				</h3>
			</xsl:when>
			<xsl:when test="$type='ss2'">
				<h3 class="{$class}">
					<xsl:apply-templates/>
				</h3>
			</xsl:when>
			<xsl:when test="$type='ss3'">
				<h3 class="{$class}">
					<xsl:apply-templates/>
				</h3>
			</xsl:when>
			<xsl:when test="$type='ss4'">
				<h4 class="{$class}">
					<xsl:apply-templates/>
				</h4>
			</xsl:when>
			<xsl:when test="$type='ss5'">
				<h4 class="{$class}">
					<xsl:apply-templates/>
				</h4>
			</xsl:when>
			<xsl:when test="$type='bmsec'">
				<h2 class="{$class}">
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="$type='appendix'">
				<h2 class="{$class}">
					<xsl:if test="parent::*/@n">
						<xsl:value-of select="parent::*/@n"/>
						<xsl:text>. </xsl:text>
					</xsl:if>
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="$type='endnotes'">
				<h3 class="{$class}">
					<xsl:apply-templates/>
				</h3>
			</xsl:when>
			<xsl:when test="$type='bibliography'">
				<h2 class="{$class}">
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="$type='glossary'">
				<h2 class="{$class}">
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="$type='index'">
				<h2 class="{$class}">
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:otherwise>
				<h4 class="{$class}">
					<xsl:apply-templates/>
				</h4>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[local-name()='docAuthor']">
		<h4>
			<xsl:apply-templates/>
		</h4>
	</xsl:template>

	<!-- ====================================================================== -->
	<!-- Verse                                                                  -->
	<!-- ====================================================================== -->

	<xsl:template match="lg">
		<div class="tei_lg">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="l">
		<xsl:choose>
			<xsl:when test="@rend='indent'">
				<span class="line_indent">
					<xsl:apply-templates/>
				</span>
				<br/>
			</xsl:when>
			<xsl:otherwise>
				<span>
					<xsl:apply-templates/>
				</span>
				<br/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="seg">
		<!--
		<xsl:if test="position() > 1">
			<xsl:text>&#160;&#160;&#160;&#160;</xsl:text>
		</xsl:if>
		<xsl:apply-templates/>
		<br/>
		-->
		<xsl:param name="force"/>
		<xsl:choose>
			<xsl:when test="@type='postscript' or @type='call-out' or @rend='block'">
				<div>
					<xsl:attribute name="class">
						<xsl:value-of select="@type"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:when test="@type='note-symbol'"/><!-- skip; we're using @n on <note> instead -->
			<xsl:otherwise>
				<span>
					<xsl:attribute name="class">
						<xsl:value-of select="@type"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ====================================================================== -->
	<!-- Speech                                                                 -->
	<!-- ====================================================================== -->

	<xsl:template match="sp">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>

	<xsl:template match="speaker">
		<b>
			<xsl:apply-templates/>
		</b>
		<br/>
	</xsl:template>

	<xsl:template match="stage">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>

	<xsl:template match="sp/p">
		<p class="noindent">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<!-- ====================================================================== -->
	<!-- Lists                                                                  -->
	<!-- ====================================================================== -->

	<xsl:template match="list">
		<xsl:choose>
			<xsl:when test="@type='gloss'">
				<dl>
					<xsl:apply-templates/>
				</dl>
			</xsl:when>
			<xsl:when test="@type='simple'">
				<ul class="nobull">
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="@type='ordered'">
				<xsl:choose>
					<xsl:when test="@rend='alpha'">
						<ol class="alpha">
							<xsl:apply-templates/>
						</ol>
					</xsl:when>
					<xsl:otherwise>
						<ol>
							<xsl:apply-templates/>
						</ol>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@type='unordered'">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:when test="@type='bulleted'">
				<xsl:choose>
					<xsl:when test="@rend='dash'">
						<ul class="nobull">
							<xsl:text>- </xsl:text>
							<xsl:apply-templates/>
						</ul>
					</xsl:when>
					<xsl:otherwise>
						<ul>
							<xsl:apply-templates/>
						</ul>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@type='bibliographic'">
				<ol>
					<xsl:apply-templates/>
				</ol>
			</xsl:when>
			<xsl:when test="@type='special'">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="item">
		<xsl:choose>
			<xsl:when test="parent::list[@type='gloss']">
				<dd>
					<xsl:apply-templates/>
				</dd>
			</xsl:when>
			<xsl:when test="child::*[1][local-name()='table']">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="child::*[1][local-name()='list']">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<li>
					<xsl:apply-templates/>
				</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="label">
		<h4>
			<xsl:apply-templates/>
		</h4>
	</xsl:template>

	<!-- ====================================================================== -->
	<!-- Notes                                                                  -->
	<!-- ====================================================================== -->

	<xsl:template match="note">
		<xsl:param name="force"/>
		<xsl:variable name="note_id">
		  <xsl:choose>
		    <xsl:when test="@xml:id"><xsl:value-of select="@xml:id"/></xsl:when>
		    <xsl:otherwise><xsl:value-of select="@id"/></xsl:otherwise>
		  </xsl:choose>
		</xsl:variable>
		<xsl:choose>
		  <xsl:when test="@place='end' and not($force) and not(ancestor::*[matches(local-name(),'^div')][1] is //*[local-name()='ref'][@target=$note_id][1]/ancestor::*[matches(local-name(),'^div')][1])">
		    <!-- this endnote does not occur in same div as its ref (that is, note
		      occurs in a separate div containing endnotes), so display it -->
		      <xsl:call-template name="process_this_note">
		        <xsl:with-param name="note_id" select="$note_id"/>
		      </xsl:call-template>
		  </xsl:when>
			<xsl:when test="(@place='foot' or @place='end') and not($force)">
			  <!-- skip for now; this note will processed at the end of the div; see template for divs in structure.xsl -->
		  </xsl:when>
			<xsl:otherwise>
			  <xsl:call-template name="process_this_note">
			    <xsl:with-param name="note_id" select="$note_id"/>
			  </xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
  
  <xsl:template name="process_this_note">
    <xsl:param name="note_id"/>
    <div>
      <!-- set class -->
      <xsl:choose>
        <xsl:when test="@place='foot'">
          <xsl:attribute name="class">tei_note_foot</xsl:attribute>
        </xsl:when>
        <xsl:when test="@place='end'">
          <xsl:attribute name="class">tei_note_end</xsl:attribute>
        </xsl:when>
        <xsl:when test="@place='left'">
          <xsl:attribute name="class">tei_note_left</xsl:attribute>
        </xsl:when>
        <xsl:when test="@place='right'">
          <xsl:attribute name="class">tei_note_right</xsl:attribute>
        </xsl:when>
      </xsl:choose>
      <!-- output anchor, which <ref> links can point to -->
      <xsl:if test="$note_id">
        <a>
          <xsl:attribute name="name" select="$note_id"/>
        </a>
      </xsl:if>
      <!-- output note-reference number -->
      <xsl:if test="@n and not(@anchored='no')">
        <div class="tei_note_number">
          <xsl:text>[</xsl:text>
          <xsl:value-of select="@n"/>
          <xsl:text>]</xsl:text>
        </div>
      </xsl:if>
      <!-- process <note> content -->
      <xsl:apply-templates/>
    </div>
  </xsl:template>

	<!-- ====================================================================== -->
	<!-- Paragraphs                                                             -->
	<!-- ====================================================================== -->

	<xsl:template match="p">
		<xsl:choose>
			<xsl:when test="position()=1 and parent::note[@place='left' or @place='right']">
				<xsl:apply-templates/>
			</xsl:when>
      		<xsl:when test="@rend='right'">
    			<p class="tei_p tei_right">
    		  	  <xsl:apply-templates/>
    			</p>
    		</xsl:when>
			<xsl:otherwise>
				<p class="tei_p">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!--
	<xsl:template match="p[not(parent::note[@place='foot' or @place='end'])]">
		<xsl:choose>
			<xsl:when test="@rend='center'">
				<p class="center">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="name(preceding-sibling::node()[1])='pb'">
				<p class="noindent">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="parent::td">
				<p>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="contains(@rend, 'IndentHanging')">
				<p class="{@rend}">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="not(preceding-sibling::p)">
				<xsl:choose>
					<xsl:when test="@rend='hang'">
						<p class="hang">
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:when test="@rend='indent'">
						<p class="indent">
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:when test="@rend='noindent'">
						<p class="noindent">
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<p class="noindent">
							<xsl:apply-templates/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="not(following-sibling::p)">
				<xsl:choose>
					<xsl:when test="@rend='hang'">
						<p class="hang">
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:when test="@rend='indent'">
						<p class="indent">
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:when test="@rend='noindent'">
						<p class="noindent">
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<p class="padded">
							<xsl:apply-templates/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="@rend">
						<p class="{@rend}">
							<xsl:apply-templates/>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<p class="normal">
							<xsl:apply-templates/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	-->

	<!-- ====================================================================== -->
	<!-- Other Text Blocks                                                      -->
	<!-- ====================================================================== -->

	<xsl:template match="argument|closer|dateline|opener|salute|signed|trailer">
		<div>
			<xsl:attribute name="class">
				<xsl:value-of select="concat('tei_', local-name())"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
	<xsl:template match="address">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="addrLine">
		<xsl:apply-templates/>
		<br/>
	</xsl:template>
	
	<xsl:template match="byline">
		<p class="right">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="cit">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="cit/bibl">
		<p class="right">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="epigraph">
		<div class="tei_blockquote">
			<xsl:apply-templates/>
		</div>
		<br/>
	</xsl:template>
	
	<xsl:template match="epigraph/bibl">
		<p class="right">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<xsl:template match="q">
		<div class="tei_blockquote">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	
  <!-- Greg Murray (gpm2a@virginia.edu): 2010-06-07: Refactored <gap/> handling:
    * Handle uva-dl-tei @altRend
    * Use HTML @title to indicate description of, and reason for, the gap
  -->
  <xsl:template match="gap">
    <xsl:choose>
      <xsl:when test="@altRend"><xsl:value-of select="@altRend"/></xsl:when>
      <xsl:otherwise>
        <span class="tei_gap">
          <xsl:attribute name="title">
            <xsl:if test="@desc">
              <xsl:text>Description: </xsl:text>
              <xsl:choose>
                <xsl:when test="@desc='chi'">Chinese characters</xsl:when>
                <xsl:otherwise><xsl:value-of select="@desc"/></xsl:otherwise>
              </xsl:choose>
              <xsl:text>. </xsl:text>
            </xsl:if>
            <xsl:if test="@reason">
              <xsl:choose>
                <xsl:when test="@reason='other' and not(@other)"/>
                <xsl:when test="@reason='unknown'"/>
                <xsl:otherwise>
                  <xsl:text>Reason: </xsl:text>
                  <xsl:choose>
                    <xsl:when test="@reason='editorial'">Deliberately omitted from the digital text</xsl:when>
                    <xsl:when test="@reason='damage'">Damage to physical object</xsl:when>
                    <xsl:when test="@reason='missing'">Missing from physical object</xsl:when>
                    <xsl:when test="@reason='obscured'">Obscured</xsl:when>
                    <xsl:when test="@reason='other'"><xsl:value-of select="@other"/></xsl:when>
                  </xsl:choose>
                  <xsl:text>. </xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:if>
            <xsl:if test="@extent">
              <xsl:text>Extent: </xsl:text>
              <xsl:value-of select="@extent"/>
              <xsl:text>. </xsl:text>
            </xsl:if>
          </xsl:attribute>
          <xsl:text>[OMITTED]</xsl:text>
        </span>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates/>
  </xsl:template>
  
	<!-- ====================================================================== -->
	<!-- Bibliographies                                                         -->
	<!-- ====================================================================== -->

	<xsl:template match="listBibl">
		<xsl:if test="$anchor.id=@*[local-name()='id']">
			<a name="X"/>
		</xsl:if>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="bibl">
		<xsl:choose>
			<xsl:when test="parent::listBibl">
				<xsl:choose>
					<xsl:when test="$anchor.id=@*[local-name()='id']">
						<a name="X"/>
						<div class="bibl-hi">
							<p class="hang">
								<xsl:apply-templates/>
							</p>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<p class="hang">
							<xsl:apply-templates/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Because of order in the following, "rend" takes precedence over "level" -->

	<xsl:template match="*[local-name()='title']">
		<xsl:choose>
			<xsl:when test="@rend='italic'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:when test="@level='m'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:when test="@level='a'"> &#x201C;<xsl:apply-templates/>&#x201D; </xsl:when>
			<xsl:when test="@level='j'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:when test="@level='s'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:when test="@level='u'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="author">
		<xsl:choose>
			<xsl:when test="@rend='hide'">
				<xsl:text>&#x2014;&#x2014;&#x2014;</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- ====================================================================== -->
	<!-- Formatting                                                             -->
	<!-- ====================================================================== -->

	<xsl:template match="date">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="hi">
		<xsl:choose>
			<!-- for note references and note symbols, avoid applying CSS superscript twice (which elevates the content excessively) -->
			<xsl:when test="ancestor::ref and @rend='super'">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="ancestor::seg[@type='note-symbol'] and @rend='super'">
				<xsl:apply-templates/>
			</xsl:when>
			<!-- italic is by far the most common @rend value; just use HTML <i> -->
			<xsl:when test="@rend='italic'">
				<i>
					<xsl:apply-templates/>
				</i>
			</xsl:when>
			<!-- for everything else, use <span class="tei_..."> -->
			<xsl:otherwise>
				<span>
					<xsl:attribute name="class">
						<xsl:value-of select="concat('tei_', @rend)"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="foreign">
		<i>
			<xsl:apply-templates/>
		</i>
	</xsl:template>
	
	<xsl:template match="lb">
		<xsl:choose>
			<xsl:when test="ancestor::l">
				<!-- ignore line break within a line of verse (since such a line break
					is typically merely incidental to the limits of the physical page) -->
			</xsl:when>
			<xsl:otherwise>
				<br/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- tz [Tony Zanella, tony.zanella@gmail.com] added a name template for formatting names in bov on 04/10/2009 -->
	<!-- Greg Murray (gpm2a@virginia.edu): 2010-05-17: Only format names in bov (Board of Visitors minutes) -->
  <xsl:template match="name">
    <xsl:choose>
      <xsl:when test="contains($docId, 'bov')">
        <b>
          <xsl:apply-templates/>
        </b>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

	<!-- ====================================================================== -->
	<!-- References                                                             -->
	<!-- ====================================================================== -->

	<xsl:template match="ref">

		<!-- variables -->
		<!--
		<xsl:variable name="target" select="@target"/>
		<xsl:variable name="chunk">
			<xsl:choose>
				<xsl:when test="@type='secref'">
					<xsl:value-of select="$target"/>
				</xsl:when>
				<xsl:when test="@type='noteref' or @type='endnote'">
					<xsl:value-of
						select="key('endnote-id', $target)/ancestor::*[matches(local-name(), '^div[1-6]$')][1]/@*[local-name()='id']"
					/>
				</xsl:when>
				<xsl:when test="@type='fnoteref'">
					<xsl:value-of
						select="key('fnote-id', $target)/ancestor::*[matches(local-name(), '^div[1-6]$')][1]/@*[local-name()='id']"
					/>
				</xsl:when>
				<xsl:when test="@type='pageref'">
					<xsl:choose>
						<xsl:when test="$target='endnotes'">
							<xsl:value-of select="'endnotes'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of
								select="key('pb-id', $target)/ancestor::*[matches(local-name(), '^div[1-6]$')][1]/@*[local-name()='id']"
							/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="key('generic-id', $target)/ancestor::*[matches(local-name(), '^div[1-6]$')][1]/@*[local-name()='id']"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="toc" select="key('div-id', $chunk)/parent::*/@*[local-name()='id']"/>
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="$anchor.id=@*[local-name()='id']">ref-hi</xsl:when>
				<xsl:otherwise>ref</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		-->

		<!-- back link scrolling -->
		<!--
		<xsl:if test="$anchor.id=@*[local-name()='id']">
			<a name="X"/>
		</xsl:if>
		-->

		<!-- process refs -->
		<!--
		<xsl:choose>
		-->
			<!-- end note refs -->
			<!--
			<xsl:when test="@type='noteref' or @type='endnote'">
				<sup>
					<xsl:attribute name="class">
						<xsl:value-of select="$class"/>
					</xsl:attribute>
					<xsl:text>[</xsl:text>
					<a>
						<xsl:attribute name="href"><xsl:value-of select="$doc.path"
								/>&#038;chunk.id=<xsl:value-of select="$chunk"
								/>&#038;toc.id=<xsl:value-of select="$toc"
								/>&#038;toc.depth=<xsl:value-of select="$toc.depth"
								/>&#038;brand=<xsl:value-of select="$brand"/><xsl:value-of
								select="$search"/>&#038;anchor.id=<xsl:value-of select="$target"
							/>#X</xsl:attribute>
						<xsl:attribute name="target">_top</xsl:attribute>
						<xsl:apply-templates/>
					</a>
					<xsl:text>]</xsl:text>
				</sup>
			</xsl:when>
			-->
			<!-- footnote refs -->
			<!--
			<xsl:when test="@type='fnoteref'">
				<sup>
					<xsl:attribute name="class">
						<xsl:value-of select="$class"/>
					</xsl:attribute>
					<xsl:text>[</xsl:text>
					<a>
						<xsl:attribute name="href">javascript://</xsl:attribute>
						<xsl:attribute name="onclick">
							<xsl:text>javascript:window.open('</xsl:text><xsl:value-of
								select="$doc.path"
								/>&#038;doc.view=popup&#038;chunk.id=<xsl:value-of
								select="$target"
							/><xsl:text>','popup','width=300,height=300,resizable=yes,scrollbars=yes')</xsl:text>
						</xsl:attribute>
						<xsl:apply-templates/>
					</a>
					<xsl:text>]</xsl:text>
				</sup>
			</xsl:when>
			-->
			<!-- page refs -->
			<!--
			<xsl:when test="@type='pageref'">
				<a>
					<xsl:attribute name="href"><xsl:value-of select="$doc.path"
							/>&#038;chunk.id=<xsl:value-of select="$chunk"
							/>&#038;toc.id=<xsl:value-of select="$toc"
							/>&#038;toc.depth=<xsl:value-of select="$toc.depth"
							/>&#038;brand=<xsl:value-of select="$brand"
							/>&#038;anchor.id=<xsl:value-of select="$target"/>#X</xsl:attribute>
					<xsl:attribute name="target">_top</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:when>
			-->
			<!-- all others -->
			<!--
			<xsl:otherwise>
			-->
				<xsl:element name="a">
					<xsl:if test="not(@rend) or @rend != 'normal'" >
						<xsl:attribute name="class">tei_ref</xsl:attribute>
					</xsl:if>
					<!--
					<xsl:attribute name="href"><xsl:value-of select="$doc.path"
							/>&#038;chunk.id=<xsl:value-of select="$chunk"
							/>&#038;toc.id=<xsl:value-of select="$toc"
							/>&#038;toc.depth=<xsl:value-of select="$toc.depth"
							/>&#038;brand=<xsl:value-of select="$brand"
							/>&#038;anchor.id=<xsl:value-of select="$target"/>#X</xsl:attribute>
					<xsl:attribute name="target">_top</xsl:attribute>
					-->
					<xsl:attribute name="href">#<xsl:value-of select="@target"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="@n">
							<xsl:text>[</xsl:text>
							<xsl:value-of select="@n"/>
							<xsl:text>]</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			<!--
			</xsl:otherwise>
		</xsl:choose>
		-->

	</xsl:template>

	<!--
	<xsl:template match="xref">
		<xsl:choose>
			<xsl:when test="@type='pdf'">
				<a class="ref">
					<xsl:attribute name="href">
						<xsl:value-of select="$pdf.path"/>
						<xsl:value-of select="@doc"/>
					</xsl:attribute>
					<sup class="down1">[PDF]</sup>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="@to"/>
					</xsl:attribute>
					<xsl:attribute name="target">_top</xsl:attribute>
					<xsl:apply-templates/>
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	-->

	<!-- ====================================================================== -->
	<!-- Figures                                                                -->
	<!-- ====================================================================== -->

  <!-- Greg Murray (gpm2a@virginia.edu): 2010-06-11: Getting <figure> images to
    display (not displayed at all prior to this fix; broken image icon in browser) -->
  <!-- Matthew Stephens (ms3uf@virginia.edu): 2010-07-28: adding test to ensure @entity
     exists before calling as the function argument in select clause -->
  <xsl:template match="*[local-name()='figure']">
    <xsl:variable name="pid">
      <xsl:choose>
        <xsl:when test="@pid">
          <xsl:value-of select="@pid"/>
        </xsl:when>
        <xsl:when test="@entity">
          <xsl:value-of select="@entity"/>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="img_src">
      <xsl:choose>
        <xsl:when test='matches($pid, "uva-lib:\d+") and contains(upper-case($doc.title), "STUDIES IN BIBLIOGRAPHY")'>
          <xsl:text>http://fedora-prod02.lib.virginia.edu:8080/fedora/objects/</xsl:text>
          <xsl:value-of select="$pid"/>
          <xsl:text>/methods/djatoka%3AStaticSDef/getStaticImage?</xsl:text>
        </xsl:when>
        <xsl:when test='matches($pid, "uva-lib:\d+") and contains(upper-case($doc.title), "BIBLIOGRAPHICAL SOCIETY")'>
          <xsl:text>http://fedora-prod02.lib.virginia.edu:8080/fedora/objects/</xsl:text>
          <xsl:value-of select="$pid"/>
          <xsl:text>/methods/djatoka%3AStaticSDef/getStaticImage?</xsl:text>
        </xsl:when>
        <xsl:when test='matches($pid, "uva-lib:\d+") and contains(upper-case($doc.title), "SOUTHERN COLLECTING")'>
          <xsl:text>http://fedora-prod02.lib.virginia.edu:8080/fedora/objects/</xsl:text>
          <xsl:value-of select="$pid"/>
          <xsl:text>/methods/djatoka%3AStaticSDef/getStaticImage?</xsl:text>
        </xsl:when>
        <xsl:when test='matches($pid, "uva-lib:\d+")'>
          <xsl:text>http://fedora-prod01.lib.virginia.edu:8080/fedora/get/</xsl:text>
          <xsl:value-of select="$pid"/>
          <xsl:text>/uva-lib-bdef:102/getScreen</xsl:text>
        </xsl:when>
      	<xsl:when test="graphic/@url">
      		<!-- <xsl:value-of select="concat('http://static.lib.virginia.edu/legacy/', string(graphic/@url))"/> -->
      	</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('http://static.lib.virginia.edu', '/legacy/',  upper-case(substring($pid,1,1)), '/', $pid, '.jpg')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="image_or_placeholder">
    	<xsl:if test="not(graphic/@url)">
      <xsl:choose>
        <xsl:when test="not($img_src) or $pid = preceding::pb[1]/@pid">
          <!-- no image associated with this <figure>, or <figure> just points to page image -->
          <xsl:element name="span">
            <xsl:attribute name="class">tei_figure_placeholder</xsl:attribute>
            <xsl:text>[ILLUSTRATION]</xsl:text>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="img">
            <xsl:attribute name="src" select="$img_src"/>
            <xsl:attribute name="class">illustration</xsl:attribute>
            <xsl:attribute name="alt">illustration</xsl:attribute>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    	</xsl:if>
    </xsl:variable>

	<xsl:element name="a">
  	<xsl:if test="@id">
  		<xsl:attribute name="name" select="@id" />  		
  	</xsl:if>
    <xsl:choose>
      <xsl:when test="@rend='none'"/>
      <xsl:when test="@rend='inline'">
        <xsl:copy-of select="$image_or_placeholder"/>
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <div class="tei_figure">
          <xsl:copy-of select="$image_or_placeholder"/>
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
	</xsl:element>
  </xsl:template>

<!--
	<xsl:template match="figure">
		<xsl:variable name="img_src">
			<xsl:choose>
				<xsl:when test="contains($docId, 'preview')">
					<xsl:value-of select="unparsed-entity-uri(@entity)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($figure.path, @entity)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="fullsize">
			<xsl:choose>
				<xsl:when test="contains($docId, 'preview')">
					<xsl:value-of
						select="unparsed-entity-uri(substring-before(substring-after(@rend, 'popup('), ')'))"
					/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of
						select="concat($figure.path, substring-before(substring-after(@rend,'('),')'))"
					/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="height">
			<xsl:choose>
				<xsl:when test="contains(@rend,'X')">
					<xsl:value-of select="number(substring-before(@rend,'X'))"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="contains(@rend,'X')">
					<xsl:value-of select="number(substring-after(@rend,'X'))"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$anchor.id=@*[local-name()='id']">
			<a name="X"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="@rend='hide'">
				<div class="illgrp">
					<p>Image Withheld</p>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
			<xsl:when test="@rend='inline'">
				<img src="{$img_src}" alt="inline image"/>
			</xsl:when>
			<xsl:when test="@rend='block'">
				<div class="illgrp">
					<img src="{$img_src}" width="400" alt="block image"/>
					<xsl:apply-templates/>
					<br/>
					<xsl:text>[</xsl:text>
					<a>
						<xsl:attribute name="href">javascript://</xsl:attribute>
						<xsl:attribute name="onclick">
							<xsl:text>javascript:window.open('</xsl:text>
							<xsl:value-of select="$doc.path"/>
							<xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text>
							<xsl:value-of select="$img_src"/>
							<xsl:text>','popup','width=600,height=600,resizable=yes,scrollbars=yes')</xsl:text>
						</xsl:attribute>
						<xsl:text>Full Size</xsl:text>
					</a>
					<xsl:text>]</xsl:text>
				</div>
			</xsl:when>
			<xsl:when test="contains(@rend, 'popup(')">
				<div class="illgrp">
					<img src="{$img_src}" alt="figure"/>
					<xsl:apply-templates/>
					<br/>
					<xsl:text>[</xsl:text>
					<a>
						<xsl:attribute name="href">javascript://</xsl:attribute>
						<xsl:attribute name="onclick">
							<xsl:text>javascript:window.open('</xsl:text>
							<xsl:value-of select="$doc.path"/>
							<xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text>
							<xsl:value-of select="$fullsize"/>
							<xsl:text>','popup','width=400,height=400,resizable=yes,scrollbars=yes')</xsl:text>
						</xsl:attribute>
						<xsl:text>Full Size</xsl:text>
					</a>
					<xsl:text>]</xsl:text>
				</div>
			</xsl:when>
			<xsl:when test="($height != '0') and ($height &lt; 50)">
				<xsl:text>&#160;</xsl:text>
				<img src="{$img_src}" width="{$width}" height="{$height}" alt="image"/>
			</xsl:when>
			<xsl:when test="($height != '0') and ($height &gt; 50) and ($width &lt; 400)">
				<div class="illgrp">
					<img src="{$img_src}" width="{$width}" height="{$height}" alt="image"/>
					<xsl:apply-templates/>
					<br/>
					<xsl:text>[</xsl:text>
					<a>
						<xsl:attribute name="href">javascript://</xsl:attribute>
						<xsl:attribute name="onclick">
							<xsl:text>javascript:window.open('</xsl:text>
							<xsl:value-of select="$doc.path"/>
							<xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text>
							<xsl:value-of select="$img_src"/>
							<xsl:text>','popup','width=</xsl:text>
							<xsl:value-of select="$width + 50"/>
							<xsl:text>,height=</xsl:text>
							<xsl:value-of select="$height + 50"/>
							<xsl:text>,resizable=yes,scrollbars=yes')</xsl:text>
						</xsl:attribute>
						<xsl:text>Full Size</xsl:text>
					</a>
					<xsl:text>]</xsl:text>
				</div>
			</xsl:when>
			<xsl:when test="($height != '0') and ($height &gt; 50) and ($width &gt; 400)">
				<div class="illgrp">
					<img src="{$img_src}" width="400" alt="image"/>
					<xsl:apply-templates/>
					<br/>
					<xsl:text>[</xsl:text>
					<a>
						<xsl:attribute name="href">javascript://</xsl:attribute>
						<xsl:attribute name="onclick">
							<xsl:text>javascript:window.open('</xsl:text>
							<xsl:value-of select="$doc.path"/>
							<xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text>
							<xsl:value-of select="$img_src"/>
							<xsl:text>','popup','width=</xsl:text>
							<xsl:value-of select="$width + 50"/>
							<xsl:text>,height=</xsl:text>
							<xsl:value-of select="$height + 50"/>
							<xsl:text>,resizable=yes,scrollbars=yes')</xsl:text>
						</xsl:attribute>
						<xsl:text>Full Size</xsl:text>
					</a>
					<xsl:text>]</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="illgrp">
					<img src="{$img_src}" width="400" alt="image"/>
					<xsl:apply-templates/>
					<br/>
					<xsl:text>[</xsl:text>
					<a>
						<xsl:attribute name="href">javascript://</xsl:attribute>
						<xsl:attribute name="onclick">
							<xsl:text>javascript:window.open('</xsl:text>
							<xsl:value-of select="$doc.path"/>
							<xsl:text>&#038;doc.view=popup&#038;fig.ent=</xsl:text>
							<xsl:value-of select="$img_src"/>
							<xsl:text>','popup','width=400,height=400,resizable=yes,scrollbars=yes')</xsl:text>
						</xsl:attribute>
						<xsl:text>Full Size</xsl:text>
					</a>
					<xsl:text>]</xsl:text>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
-->

  <xsl:template match="graphic[@url]">
  	<div class="tei_figure">
  	<xsl:element name="img">
  		<xsl:attribute name="src" select="concat('http://static.lib.virginia.edu/legacy/',@url)" />
  		<xsl:attribute name="class">illustration</xsl:attribute>
  	</xsl:element>
  	</div>
  </xsl:template>

  <xsl:template match="*[local-name()='figDesc']">
    <span class="tei_figDesc">
      <xsl:text>[Description: </xsl:text>
      <xsl:if test="@n"><xsl:value-of select="@n"/>. </xsl:if>
      <xsl:apply-templates/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>

	<!-- ====================================================================== -->
	<!-- Milestones                                                             -->
	<!-- ====================================================================== -->

	<xsl:template match="pb">
		<xsl:variable name="pid" select="@pid"/>
		<xsl:variable name="cleaned-page-number">
			<xsl:choose>
				<xsl:when test="string(number(@n))='NaN'">
					<xsl:call-template name="math:roman-to-number">
						<xsl:with-param name="roman">
							<xsl:value-of select="@n"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="number(@n)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="fedoraurl">http://fedora-prod02.lib.virginia.edu:8080/fedora/objects/</xsl:variable>
		<xsl:variable name="fedorathumb">/methods/djatoka%3AStaticSDef/getThumbnail?</xsl:variable>
		<xsl:variable name="iiifurl">https://iiif.lib.virginia.edu/iiif/</xsl:variable>
		<xsl:variable name="iiifthumb">/full/256,/0/default.jpg</xsl:variable>
		<!-- whitespace matters in this variable (below), do not break lines -->
		<xsl:variable name="repo-location">
			<xsl:if test="false()" >
          <xsl:choose>
            <xsl:when test="$pid and contains(upper-case($doc.title), 'STUDIES IN BIBLIOGRAPHY')"><xsl:value-of select="$fedoraurl"/><xsl:value-of select="$pid"/><xsl:value-of select="$fedorathumb"/></xsl:when>
          	<xsl:when test="$pid and contains(upper-case($doc.title), 'BIBLIOGRAPHICAL SOCIETY')"><xsl:value-of select="$fedoraurl"/><xsl:value-of select="$pid"/><xsl:value-of select="$fedorathumb"/></xsl:when>
          	<xsl:when test="$pid and contains(upper-case($doc.title), 'SOUTHERN COLLECTING')"><xsl:value-of select="$fedoraurl"/><xsl:value-of select="$pid"/><xsl:value-of select="$fedorathumb"/></xsl:when>
            <xsl:when test="$pid">http://fedora-prod01.lib.virginia.edu:8080/fedora/get/<xsl:value-of select="$pid"/>/uva-lib-bdef:102/getPreview</xsl:when>
            <xsl:otherwise><xsl:value-of select="false()"/></xsl:otherwise>
          </xsl:choose>
			</xsl:if>
			<xsl:if test="true()">
				<xsl:choose>
					<xsl:when test="$pid and contains(upper-case($doc.title), 'STUDIES IN BIBLIOGRAPHY')"><xsl:value-of select="$iiifurl"/><xsl:value-of select="$pid"/><xsl:value-of select="$iiifthumb"/></xsl:when>
					<xsl:when test="$pid and contains(upper-case($doc.title), 'BIBLIOGRAPHICAL SOCIETY')"><xsl:value-of select="$iiifurl"/><xsl:value-of select="$pid"/><xsl:value-of select="$iiifthumb"/></xsl:when>
					<xsl:when test="$pid and contains(upper-case($doc.title), 'SOUTHERN COLLECTING')"><xsl:value-of select="$iiifurl"/><xsl:value-of select="$pid"/><xsl:value-of select="$iiifthumb"/></xsl:when>
					<xsl:when test="$pid">http://fedora-prod01.lib.virginia.edu:8080/fedora/get/<xsl:value-of select="$pid"/>/uva-lib-bdef:102/getPreview</xsl:when>
					<xsl:otherwise><xsl:value-of select="false()"/></xsl:otherwise>
				</xsl:choose>				
			</xsl:if>
		</xsl:variable>


		<xsl:variable name="odd">
			<xsl:value-of select="($cleaned-page-number mod 2)"/>
		</xsl:variable>

		<!-- xsl:when test="not(following-sibling::*)"/ -->
		<!--<xsl:when test="$anchor.id=@id">
				<a name="X"/>
				<div class="run-head">
					<hr class="run-head"/>
					<div class="run-head-pagenum_{$odd}">
						<xsl:value-of select="@n"/>
					</div>
					<div class="run-head-title">
						<xsl:value-of
							select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='main']"
						/>
					</div>
				</div>
				<xsl:if test="$pid">
					<div class="page-image">
						<a
							href="http://fedora-prod01.lib.virginia.edu:8080/fedora/get/{$pid}/uva-lib-bdef:102/getScreen">
							<img
								src="http://fedora-prod01.lib.virginia.edu:8080/fedora/get/{$pid}/uva-lib-bdef:102/getPreview"
							/>
						</a>
					</div>
				</xsl:if>
			</xsl:when>-->

		<div class="run-head">
			<hr class="run-head"/>
			<xsl:if test="@n">
				<div class="run-head-pagenum_{$odd}">
					<xsl:value-of select="@n"/>
				</div>
			</xsl:if>

			<!--<div class="run-head-title">
				<xsl:value-of
					select="/TEI.2/teiHeader/fileDesc/sourceDesc/biblFull/titleStmt/title[@type='main']"
				/>
			</div>-->
        <!-- add a class value specifying a repo for 'showpage.js' to build proper URLs in Ajax -->
        <xsl:choose>
          <xsl:when test="$pid and (
          	contains(upper-case($doc.title), 'STUDIES IN BIBLIOGRAPHY') or 
          	contains(upper-case($doc.title), 'BIBLIOGRAPHICAL SOCIETY') or 
          	contains(upper-case($doc.title), 'SOUTHERN COLLECTING')   )" >
			<div class="screen-image fedora-prod02" style="display:none;" id="{$pid}_container">
				<img class="page_screen" title="Click to Shrink"/>
			</div>
			<br/>
          </xsl:when> 
          <xsl:otherwise>
			<div class="screen-image" style="display:none;" id="{$pid}_container">
				<img class="page_screen" title="Click to Shrink"/>
			</div>
			<br/>
          </xsl:otherwise>
        </xsl:choose>
		</div>
      <!-- if $pid, there will be a $repo-location, defaults to 
           http://fedora-prod01.lib.virginia.edu:8080/fedora/get/{$pid}/uva-lib-bdef:102/getPreview  
      -->
      <xsl:choose>
        <xsl:when test="$pid">
  	      <div class="page-image">
  	        <img title="Click to Enlarge" class="page_thumbnail"  id="{$pid}_link" alt="{if (string(@n)) then concat('Page ', @n) else 'No Page Number'}"
  	             src="{$repo-location}"/>
  	      </div>
        </xsl:when>
	  </xsl:choose>
	</xsl:template>

	<xsl:template match="milestone">

		<xsl:if test="$anchor.id=@*[local-name()='id']">
			<a name="X"/>
		</xsl:if>

		<xsl:if test="@rend='ornament' or @rend='ornamental_break'">
			<div align="center">
				<table border="0" width="40%">
					<tr align="center">
						<td>&#x2022;</td>
						<td>&#x2022;</td>
						<td>&#x2022;</td>
					</tr>
				</table>
			</div>
		</xsl:if>

	</xsl:template>

</xsl:stylesheet>
