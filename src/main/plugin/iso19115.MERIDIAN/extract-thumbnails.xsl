<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:gmi="http://standards.iso.org/iso/19115/-2/gmi/1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gco="http://www.isotc211.org/2005/gco" 
xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gss="http://www.isotc211.org/2005/gss" 
xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gml="http://www.opengis.net/gml/3.2" 
xmlns:srv="http://www.isotc211.org/2005/srv" >

	<xsl:template match="gmi:MI_Metadata">
		<thumbnail>
			<xsl:for-each select="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:graphicOverview/gmd:MD_BrowseGraphic">
				<xsl:choose>
					<xsl:when test="gmd:fileDescription/gco:CharacterString = 'large_thumbnail' and gmd:fileName/gco:CharacterString != ''">
						<large>
							<xsl:value-of select="gmd:fileName/gco:CharacterString" />
						</large>
					</xsl:when>
					<xsl:when test="gmd:fileDescription/gco:CharacterString = 'thumbnail' and gmd:fileName/gco:CharacterString != ''">
						<small>
							<xsl:value-of select="gmd:fileName/gco:CharacterString" />
						</small>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</thumbnail>
	</xsl:template>

</xsl:stylesheet>