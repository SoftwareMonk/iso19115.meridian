<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:gmi="http://standards.iso.org/iso/19115/-2/gmi/1.0" 
  exclude-result-prefixes="#all">
<!-- TODO - **check how many prefixes we need to include in stylesheet here -->

  <!-- Get the main metadata languages -->
  <xsl:template name="get-iso19115.MERIDIAN-language">
    <xsl:call-template name="get-iso19139-language"/>
  </xsl:template>

  <!-- Get the list of other languages in JSON -->
  <xsl:template name="get-iso19115.MERIDIAN-other-languages-as-json">
    <xsl:call-template name="get-iso19139-other-languages-as-json"/>
  </xsl:template>

  <!-- Get the list of other languages -->
  <xsl:template name="get-iso19115.MERIDIAN-other-languages">
    <xsl:call-template name="get-iso19139-other-languages"/>
  </xsl:template>
</xsl:stylesheet>
