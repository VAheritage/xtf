<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      exclude-result-prefixes="xs"
      version="2.0">

<!-- reads a text file of contact info and writes out 
      *_address.xml and *_contact.xml  
      input file must be a parameter.
      Since it reads that file with unparsed-text(), the required command line
      input file doesn't matter - it can be the stylesheet itself. 
      ( If you try to use a text file as input, the parser complains about 
        content before the prologue. ) 

    format of java command to generate xml files:
    java -jar saxon9he.jar -s:parse-text.xsl -xsl:parse-text.xsl inputfile=input.txt  
    
    url and email links and other items may have to be manually edited afterwards. 
-->

<xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />    
<xsl:param name="inputfile"></xsl:param>
<xsl:param name="basename"><xsl:value-of select="substring-before($inputfile, '.')" /></xsl:param>


<xsl:template match="/">
        
    <xsl:param  name="inputlines" select="tokenize( unparsed-text($inputfile), '\r?\n')" />

    <xsl:if test="not($inputfile)">
        <xsl:message terminate="yes">No inputfile param!</xsl:message>
    </xsl:if>
    

    <xsl:message>Output: <xsl:value-of select="concat($basename,'_address.xml')" /> </xsl:message>
    <xsl:result-document href="{concat($basename,'_address.xml')}" >    
    <xsl:call-template name="address" >
        <xsl:with-param name="lines"  select="$inputlines" />
    </xsl:call-template>
    </xsl:result-document>

    <xsl:message>Output: <xsl:value-of select="concat($basename,'_contact.xml')" /> </xsl:message>
    <xsl:result-document href="{concat($basename,'_contact.xml')}" >
    <xsl:call-template name="contact">
        <xsl:with-param name="lines" select="$inputlines" />
    </xsl:call-template>
    </xsl:result-document>
    
</xsl:template>

    <xsl:template name="address" >
        <xsl:param name="lines" />
        <address> 
        <xsl:for-each select="$lines">
            <xsl:if test="normalize-space(.)">
            <addressline>
                <xsl:value-of select="normalize-space(.)" /> 
            </addressline>
            </xsl:if>
        </xsl:for-each>
        </address>   
    </xsl:template>


<xsl:template name="contact">
    <xsl:param name="lines" />
    
    <list type="simple" >
        <head>Contact information:</head>
        <xsl:for-each select="$lines">
                <xsl:if test="normalize-space(.)" >
                    <xsl:element name="item">
                    <xsl:choose>
                        <xsl:when test="contains(.,'http:')">URL: <xsl:element name="extref">
                            <xsl:attribute name="href" select="normalize-space(.)"/>
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:element>
                        </xsl:when>
                        <xsl:when test="contains(.,'@')">
                            <xsl:attribute name="id">email</xsl:attribute>Email: <xsl:element name="extref">
                                <xsl:attribute name="href" select="normalize-space(.)" />
                                <xsl:value-of select="normalize-space(.)"/>
                            </xsl:element>
                        </xsl:when>
                        <xsl:otherwise><xsl:value-of select="normalize-space(.)" /></xsl:otherwise>
                    </xsl:choose>
                        
                    </xsl:element>  
                </xsl:if>
        </xsl:for-each>
   </list>
</xsl:template>

</xsl:stylesheet>
