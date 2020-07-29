<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ead="urn:isbn:1-931666-22-9" xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"  indent="no"/>

<xsl:template match="/list/inst" >
<xsl:if test="@orgcode">
<xsl:variable name="include" select="concat(@dirname,'_address.xi.xml')" />
<xsl:variable name="xi" select="document(resolve-uri($include, base-uri(.)))"/>
<xsl:text>&#x0a;</xsl:text><xsl:value-of select="@dirname"/><xsl:text>:</xsl:text>
<!--<xsl:text>&#x0a; orgcode: '</xsl:text><xsl:value-of select="@orgcode"/><xsl:text>'</xsl:text>-->
<xsl:text>&#x0a;  name: '</xsl:text><xsl:value-of select="normalize-space()"/><xsl:text>'
  building: '</xsl:text><xsl:value-of select="concat( $xi/ead:address/ead:addressline[1], ' ', $xi/ead:address/ead:addressline[2])"/>
<xsl:text>'&#x0a;  address1: '</xsl:text><xsl:value-of select="string($xi/ead:address/ead:addressline[3])"/>
<xsl:text>'&#x0a;  address2: '</xsl:text><xsl:value-of select="string($xi/ead:address/ead:addressline[4])"/>
<xsl:text>'&#x0a;  state: 'VA' &#x0a;  country: 'USA'</xsl:text>
<!--<xsl:if test="$xi/ead:address/ead:addressline[contains(.,'URL:')]">
    thumbnail_url: '<xsl:value-of select="string($xi/ead:address/ead:addressline[contains(.,'URL:')]/ead:extptr/@*:href)"/>
<xsl:text>'</xsl:text>
</xsl:if>-->
<xsl:text>&#x0a;  thumbnail_url: '</xsl:text><xsl:value-of select="./@logo"/><xsl:text>'</xsl:text>
<xsl:if test="$xi/ead:address/ead:addressline[contains(., 'Email:')]">
<xsl:text>&#x0a;  contact: '</xsl:text><xsl:value-of select="string($xi/ead:address/ead:addressline[contains(.,'Email:')]/ead:extptr/@*:href)" />
<xsl:text>'</xsl:text>    
</xsl:if>
<!--<xsl:text>&#x0a;#-\-\-\-\-</xsl:text>-->
</xsl:if>
</xsl:template>
    
</xsl:stylesheet>