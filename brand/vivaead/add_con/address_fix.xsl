<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

    <!--  stylesheet to fix *_address.xml entity include files to make
          email and URLs into <extptr> elements with @href & @title attributes. -->
    

    <xsl:template match="/address">
        <address xmlns="urn:isbn:1-931666-22-9">
            <xsl:apply-templates  select="addressline" />
        </address>
    </xsl:template>
    
    <xsl:template match="addressline[contains(.,'URL:') or contains(.,'Email:')]">
        <xsl:variable name="rest" select="normalize-space(substring-after(.,':'))" />
        <xsl:variable name="prefix"  select="substring-before(.,':')"/>
        <xsl:variable name="href">
            <xsl:choose>
                <xsl:when test="(normalize-space($prefix)='Email') and ( substring-before($rest,':') != 'http')">
                    <xsl:value-of select="concat('mailto:',$rest)"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="$rest"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
    <xsl:copy>
        <xsl:value-of select="concat($prefix,': ')"/>
        <xsl:element name="extptr">
            <xsl:attribute name="href"><xsl:value-of select="$href"/></xsl:attribute>
            <xsl:attribute name="title"><xsl:value-of select="$rest"/></xsl:attribute>
        </xsl:element>
    </xsl:copy>
    </xsl:template>
    
    <xsl:template match="addressline">
        <xsl:copy>
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>