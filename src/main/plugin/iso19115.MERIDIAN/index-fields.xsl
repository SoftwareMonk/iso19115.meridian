<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="2.0" xmlns:gmi="http://www.isotc211.org/2005/gmi"
xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:gsr="http://www.isotc211.org/2005/gsr" xmlns:gco="http://www.isotc211.org/2005/gco" 
xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:gss="http://www.isotc211.org/2005/gss" 
xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gml="http://www.opengis.net/gml" 
xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:dcterms="http://purl.org/dc/terms/" 
xmlns:dwc="http://rs.tdwg.org/dwc/terms/" xmlns:dwr="http://rs.tdwg.org/dwc/dwcrecord/"
xmlns:geonet="http://www.fao.org/geonetwork" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:gmx="http://www.isotc211.org/2005/gmx"
			exclude-result-prefixes="gmd gmx gco gml srv geonet gmi xlink xsl">


	<xsl:import href="../iso19139/index-fields/default.xsl"/>
	<xsl:include href="../iso19139/convert/functions.xsl"/>

	<!-- this for the MCP-custom DataParameter section.
	<xsl:template mode="index" match="mcp:dataParameters/mcp:DP_DataParameters/mcp:dataParameter">
		<xsl:for-each select="mcp:DP_DataParameter/mcp:parameterName/mcp:DP_Term">
			<xsl:variable name="term" select="mcp:term/*"/>
			<Field name="dataparam" string="{$term}" store="true" index="true"/>
			<xsl:if test="mcp:type/mcp:DP_TypeCode/@codeListValue='longName'">
				<Field name="longParamName" string="{$term}" store="true" index="true"/>
			</xsl:if>
			<xsl:for-each select="mcp:vocabularyRelationship/mcp:DP_VocabularyRelationship">
				<Field name="vocabTerm" string="{mcp:vocabularyTermURL/gmd:URL}" store="true" index="true"/>
				<Field name="vocabTermList" string="{mcp:vocabularyListURL/gmd:URL}" store="true" index="true"/>
			</xsl:for-each>
		</xsl:for-each>

		<xsl:apply-templates mode="index" select="*"/>
	</xsl:template>
-->	
	<!-- Commenting out - unclear if the basic index-fields handles this.		
	<xsl:template mode="index" match="gmd:dateStamp/gco:Date">

		<Field name="createDate" string="{string(.)}" store="true" index="true"/>

		<xsl:apply-templates mode="index" select="*"/>
	</xsl:template>
		-->
	<!-- again, may not be necessary. The basic index-fields might handle everything we need. Will have to test.
		
	<xsl:template mode="index" match="gmd:MD_Keywords">

		<xsl:variable name="thesaurusId" select="normalize-space(gmd:thesaurusName/*/gmd:identifier/*/gmd:code[starts-with(string(gmx:Anchor),'geonetwork.thesaurus')])"/>

		<xsl:if test="$thesaurusId!=''">
			<Field name="thesaurusName" string="{string($thesaurusId)}" store="true" index="true"/>
		</xsl:if>
-->
		<!-- index keyword codes under lucene index field with name same
				 as thesaurus that contains the keyword codes -->
	<!--
		<xsl:for-each select="gmd:keyword/*">
			<xsl:if test="name()='gmx:Anchor' and $thesaurusId!=''">
-->
				<!-- expecting something like 
							    	<gmx:Anchor 
									  	xlink:href="http://localhost:8080/geonetwork/srv/en/xml.keyword.get?thesaurus=register.theme.urn:marine.csiro.au:marlin:keywords:standardDataType&id=urn:marine.csiro.au:marlin:keywords:standardDataTypes:concept:3510">CMAR Vessel Data: ADCP</gmx:Anchor>
				-->
	<!--
				<xsl:variable name="keywordId">
					<xsl:for-each select="tokenize(@xlink:href,'&amp;')">
						<xsl:if test="starts-with(string(.),'id=')">
							<xsl:value-of select="substring-after(string(.),'id=')"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
	
				<xsl:if test="normalize-space($keywordId)!=''">
					<Field name="{$thesaurusId}" string="{replace($keywordId,'%23','#')}" store="true" index="true"/>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>

		<xsl:apply-templates mode="index" select="*"/>
	</xsl:template>
	-->
</xsl:stylesheet>
