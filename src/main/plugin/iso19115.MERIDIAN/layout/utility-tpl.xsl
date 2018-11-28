<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gn="http://www.fao.org/geonetwork"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:gmi="http://www.isotc211.org/2005/gmi"
  exclude-result-prefixes="#all">
<!-- TODO - **check how many prefixes we need to include in stylesheet here -->
  <xsl:include href="utility-tpl-multilingual.xsl"/>

	<xsl:template name="get-iso19139.MERIDIAN-is-service">
		<xsl:call-template name="get-iso19139-is-service"/>
	</xsl:template>

  <xsl:template name="get-iso19139.MERIDIAN-title">
    <xsl:call-template name="get-iso19139-title"/>
  </xsl:template>

	<xsl:template name="get-iso19139.MERIDIAN-extents-as-json">
		<xsl:call-template name="get-iso19139-extents-as-json"/>
	</xsl:template>

  <xsl:template name="get-iso19139.MERIDIAN-online-source-config">
    <xsl:param name="pattern"/>
    <xsl:call-template name="get-iso19139-online-source-config">
        <xsl:with-param name="pattern" select="$pattern"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>