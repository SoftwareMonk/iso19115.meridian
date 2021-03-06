<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
						xmlns:gco="http://www.isotc211.org/2005/gco"
						xmlns:mcp="http://schemas.aodn.org.au/mcp-2.0"
						xmlns:gmi="http://standards.iso.org/iso/19115/-2/gmi/1.0"
						xmlns:gmd="http://www.isotc211.org/2005/gmd" exclude-result-prefixes="gmd">

	<!-- ================================================================= -->
	
	<xsl:template match="/root">
		 <xsl:apply-templates select="*[name() != 'env']"/>
	</xsl:template>

	<!-- ================================================================= -->
	
	<xsl:template match="gmi:MI_Metadata">
		 <xsl:copy>
		 		<xsl:copy-of select="@*"/>
	 			<gmd:fileIdentifier>
					<gco:CharacterString><xsl:value-of select="/root/env/uuid"/></gco:CharacterString>
				</gmd:fileIdentifier>
			  <xsl:apply-templates select="node()"/>
		 </xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->
	
	<xsl:template match="gmd:fileIdentifier"/>
	
	<!-- ================================================================= -->
	
	<xsl:template match="@*|node()">
		 <xsl:copy>
			  <xsl:apply-templates select="@*|node()"/>
		 </xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->

</xsl:stylesheet>