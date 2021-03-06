<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:gmi="http://standards.iso.org/iso/19115/-2/gmi/1.0" xmlns:gmx="http://www.isotc211.org/2005/gmx"
xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gco="http://www.isotc211.org/2005/gco" 
xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gss="http://www.isotc211.org/2005/gss" 
xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gml="http://www.opengis.net/gml/3.2" 
xmlns:srv="http://www.isotc211.org/2005/srv" 
xmlns:geonet="http://www.fao.org/geonetwork" xmlns:ows="http://www.opengis.net/ows"
xmlns:csw="http://www.opengis.net/cat/csw/2.0.2"
>
	
	<xsl:param name="displayInfo"/>

	<!-- =================================================================== -->

	<xsl:template match="gmi:MI_Metadata">
		<xsl:variable name="info" select="geonet:info"/>
		<xsl:copy>
      <xsl:copy-of select="@*"/>
			<xsl:apply-templates select="gmd:fileIdentifier"/>
			<xsl:apply-templates select="gmd:hierarchyLevel"/>
			<xsl:apply-templates select="gmd:contact"/>
			<xsl:apply-templates select="gmd:identificationInfo"/>
			
			<!-- GeoNetwork elements added when resultType is equal to results_with_summary -->
			<xsl:if test="$displayInfo = 'true'">
				<xsl:copy-of select="$info"/>
			</xsl:if>
			
		</xsl:copy>
	</xsl:template>

	<!-- =================================================================== -->

	<xsl:template match="gmd:MD_DataIdentification">
		<xsl:copy>
      <xsl:copy-of select="@*"/>
			<xsl:apply-templates select="gmd:citation"/>
			<xsl:apply-templates select="gmd:graphicOverview"/>
			<xsl:apply-templates select="gmd:topicCategory"/>
			<xsl:apply-templates select="gmd:extent"/>
		</xsl:copy>
	</xsl:template>


	<!-- === copy template ================================================= -->

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- =================================================================== -->

</xsl:stylesheet>