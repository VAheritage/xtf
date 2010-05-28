If you look at style/dynaXML/docReqParser.xsl, you'll see that the stylesheets
under this "uvaGenText" directory don't actually get used. I'm leaving them here
on the off chance that they're needed in future, but currently there's no point
in making any changes to them.

For uvaGenText-specific output, instead of copying all the formatting stylesheets
wholesale and tweaking them, it is far easier to add a conditional based on the
ID (which includes the path and filename) of the file being processed:

<xsl:choose>
  <xsl:when test="contains($docId, 'uvaGenText')">
    ...
  </xsl:when>
  <xsl:otherwise>
    ...
  </xsl:otherwise>
</xsl:choose>

Greg Murray (gpm2a@virginia.edu), 2010-05-17
