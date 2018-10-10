<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" 
xmlns:gmi="http://www.isotc211.org/2005/gmi"
xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gco="http://www.isotc211.org/2005/gco" 
xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gss="http://www.isotc211.org/2005/gss" 
xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gml="http://www.opengis.net/gml" 
xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:dcterms="http://purl.org/dc/terms/" 
xmlns:dwc="http://rs.tdwg.org/dwc/terms/" xmlns:dwr="http://rs.tdwg.org/dwc/dwcrecord/">


	<!-- ================================================================= -->
	
	<xsl:template match="/root">
		 <xsl:apply-templates select="gmi:MI_Metadata"/>
	</xsl:template>

	<!-- ================================================================= -->
	
	<xsl:template match="gmd:graphicOverview[gmd:MD_BrowseGraphic/gmd:fileDescription/gco:CharacterString = /root/env/type]"/>

	<!-- ================================================================= -->

	<xsl:template match="@*|node()">
		 <xsl:copy>
			  <xsl:apply-templates select="@*|node()"/>
		 </xsl:copy>
	</xsl:template>
	
	<!-- ================================================================= -->
	
</xsl:stylesheet>