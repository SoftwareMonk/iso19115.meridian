<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet   
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gmi="http://standards.iso.org/iso/19115/-2/gmi/1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gco="http://www.isotc211.org/2005/gco" 
xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gss="http://www.isotc211.org/2005/gss" 
xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gml="http://www.opengis.net/gml/3.2" 
xmlns:srv="http://www.isotc211.org/2005/srv" version="1.0">
	<xsl:template match="gmi:MI_Metadata">
		 <uuid><xsl:value-of select="gmd:fileIdentifier/gco:CharacterString"/></uuid>
	</xsl:template>

</xsl:stylesheet>
