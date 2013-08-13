<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    

    <xsl:template match="@*|node()" >
        <xsl:copy>
            <xsl:apply-templates  select="@*"/>
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>
    

    <!-- unparsed-entities are not resolvable within a multi-stage XSLT pipeline.
        preFilter is the first stage, so we translate them here to hrefs while 
        we can still resolve the entities. 
     -->
    <xsl:template match="node()[@entityref and not (@href)]"  > 
        <!--  for every element with an entityref but not href,
         add an href using the resolved value of the entity  -->        
        <xsl:copy>
            <xsl:attribute name="href"><xsl:value-of select="unparsed-entity-uri(@entityref)"/></xsl:attribute>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@entityref"  >
        <!--  null transform:  no output  -->
    </xsl:template>
    
    
</xsl:stylesheet>