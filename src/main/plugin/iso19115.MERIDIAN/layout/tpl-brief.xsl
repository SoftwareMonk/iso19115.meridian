<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:gmd="http://www.isotc211.org/2005/gmd"
  xmlns:gco="http://www.isotc211.org/2005/gco"
  xmlns:srv="http://www.isotc211.org/2005/srv"
  xmlns:gmx="http://www.isotc211.org/2005/gmx"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:gml="http://www.opengis.net/gml/3.2"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:gn="http://www.fao.org/geonetwork"
  xmlns:gn-fn-core="http://geonetwork-opensource.org/xsl/functions/core"
  xmlns:gn-fn-iso19139="http://geonetwork-opensource.org/xsl/functions/profiles/iso19139"
  xmlns:gmi="http://standards.iso.org/iso/19115/-2/gmi/1.0"
  xmlns:dcterms="http://purl.org/dc/terms/" 
  xmlns:dwc="http://rs.tdwg.org/dwc/terms/"
  xmlns:dwr="http://rs.tdwg.org/dwc/dwcrecord/" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
<!-- TODO** KDM - check if more namespaces need to be added -->
	<xsl:include href="utility-tpl.xsl"/>

  <!-- ===================================================================== -->
  <!-- === iso19139.mcp-2.0 brief formatting === -->
  <!-- Edited to become MERIDIAN in 2018 -->
  <!-- ===================================================================== -->
  <xsl:template name="iso19115.MERIDIANBrief">
    <metadata>
      <xsl:call-template name="iso19139-brief"/>
      <!--<xsl:call-template name="ISO19115.MERIDIAN-brief"/>-->
    </metadata>
  </xsl:template>

<!-- TODO** KDM - any extensions in MI_Metadata need to be added to brief template -->

    <xsl:template name="iso19115.MERIDIAN-brief">


    </xsl:template>


</xsl:stylesheet>
