
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
xmlns:gmi="http://www.isotc211.org/2005/gmi" xmlns:gmd="http://www.isotc211.org/2005/gmd"
xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:xlink="http://www.w3.org/1999/xlink"
xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:srv="http://www.isotc211.org/2005/srv"
xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:gss="http://www.isotc211.org/2005/gss" 
xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gts="http://www.isotc211.org/2005/gts"
xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dwc="http://rs.tdwg.org/dwc/terms/"
xmlns:dwr="http://rs.tdwg.org/dwc/dwcrecord/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	 <!-- hide - not sure if this needs to be GMI or GMD exclude-result-prefixes="gmd"-->>

	<!-- ================================================================= -->
	<!-- copy everything as is -->
	
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>