<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
This Schematron schema merges three sets of Schematron rules
1. Schematron rules embedded in the GML 3.2 schema
2. Schematron rules implementing the Additional Constraints described in 
 ISO 19139 Table A.1
3. INSPIRE IR on metadata for datasets and services.
This script was written by CSIRO for the Australia-New Zealand Land 
Information Council (ANZLIC) as part of a project to develop an XML 
implementation of the ANZLIC ISO Metadata Profile. 
December 2006, March 2007
Port back to good old Schematron-1.5 for use with schematron-report.xsl
and change titles for use as bare bones 19115/19139 schematron checker 
in GN 2.2 onwards.
Simon Pigot, 2007
Francois Prunayre, 2008
Etienne Taffoureau, 2008
Add MCP rules
Simon Pigot
February 8, 2011
Add more MCP rules for CI_Responsibility
Simon Pigot
February 8, 2011
Added MERIDIAN rules
Kim Mortimer
September 24, 2018
This work is licensed under the Creative Commons Attribution 2.5 License. 
To view a copy of this license, visit 
http://creativecommons.org/licenses/by/2.5/au/ 
or send a letter to:
Creative Commons, 
543 Howard Street, 5th Floor, 
San Francisco, California, 94105, 
USA.
-->

	<sch:title xmlns="http://www.w3.org/2001/XMLSchema">Schematron validation for MERIDIAN profile version 0.2 of ISO 19115-2(19139-2)</sch:title>
	<sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
	<sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
	<sch:ns prefix="srv" uri="http://www.isotc211.org/2005/srv"/>
	<sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
	<sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
	<sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
	<sch:ns prefix="gmi" uri="http://standards.iso.org/iso/19115/-2/gmi/1.0"/>
	<sch:ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
	<sch:ns prefix="gss" uri="http://www.isotc211.org/2005/gss"/>
	<sch:ns prefix="gsr" uri="http://www.isotc211.org/2005/gsr"/>
	<sch:ns prefix="gts" uri="http://www.isotc211.org/2005/gts"/>


	<!-- Test that every CharacterString element has content or it's parent has a
   		 valid nilReason attribute value - this is not necessary for geonetwork 
			 because update-fixed-info.xsl supplies a gco:nilReason of missing for 
			 all gco:CharacterString elements with no content and removes it if the
			 user fills in a value - this is the same for all gco:nilReason tests 
			 used below - the test for gco:nilReason in 'inapplicable....' etc is
			 "mickey mouse" for that reason. -->
	<sch:pattern>
		<sch:title>$loc/strings/M6</sch:title>
		<sch:rule context="*[gco:CharacterString]">
			<sch:report
				test="(normalize-space(gco:CharacterString) = '') and (not(@gco:nilReason) or not(contains('inapplicable missing template unknown withheld',@gco:nilReason)))"
				>$loc/strings/alert.M6.characterString</sch:report>
		</sch:rule>
	</sch:pattern>

	<sch:pattern>
		<sch:title>$loc/strings/M7</sch:title>
		<!-- **UNVERIFIED -->
		<sch:rule id="CRSLabelsPosType" context="//gml:DirectPositionType">
			<sch:report test="not(@srsDimension) or @srsName"
				>$loc/strings/alert.M7.directPosition</sch:report>
			<sch:report test="not(@axisLabels) or @srsName"
				>$loc/strings/alert.M7.axisAndSrs</sch:report>
			<sch:report test="not(@uomLabels) or @srsName"
				>$loc/strings/alert.M7.uomAndSrs</sch:report>
			<sch:report
				test="(not(@uomLabels) and not(@axisLabels)) or (@uomLabels and @axisLabels)"
				>$loc/strings/alert.M7.uomAndAxis</sch:report>
		</sch:rule>
	</sch:pattern>

	<!--anzlic/trunk/gml/3.2.0/gmd/citation.xsd-->
	<!-- TEST 21 FXCHECK -->
	<!-- checks for at least one name in each ResponsibleParty-->
	<sch:pattern>
		<sch:title>$loc/strings/M8</sch:title>
		<sch:rule context="//*[gmd:CI_ResponsibleParty]">
			<sch:let name="count" value="(count(gmd:CI_ResponsibleParty/gmd:individualName[@gco:nilReason!='missing' or not(@gco:nilReason)]) 
				+ count(gmd:CI_ResponsibleParty/gmd:organisationName[@gco:nilReason!='missing' or not(@gco:nilReason)])
				+ count(gmd:CI_ResponsibleParty/gmd:positionName[@gco:nilReason!='missing' or not(@gco:nilReason)]))"/>
			<sch:assert	test="$count > 0">$loc/strings/alert.M8</sch:assert>
			<sch:report	test="$count > 0">
				<sch:value-of select="$loc/strings/report.M8"/> 
				<sch:value-of select="gmd:CI_ResponsibleParty/gmd:organisationName"/>-
				<sch:value-of select="gmd:CI_ResponsibleParty/gmd:individualName"/>
			</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- anzlic/trunk/gml/3.2.0/gmd/constraints.xsd-->
	<!-- TEST  4 FXCHECK -->
	<!-- ensures that when OtherRestrictions is selected, they are provided -->
	<sch:pattern>
		<sch:title>$loc/strings/M9</sch:title>
		<sch:rule context="//gmd:MD_LegalConstraints[gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions']
			|//*[@gco:isoType='gmd:MD_LegalConstraints' and gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions']">
			<sch:let name="access" value="(not(gmd:otherConstraints) or gmd:otherConstraints/@gco:nilReason='missing')"/>
			<sch:assert
				test="$access = false()"
				>
				<sch:value-of select="$loc/strings/alert.M9.access"/>
			</sch:assert>
			<sch:report
				test="$access = false()"
				><sch:value-of select="$loc/strings/report.M9"/>
				<sch:value-of select="gmd:otherConstraints/gco:CharacterString"/>
			</sch:report>
		</sch:rule>
		<sch:rule context="//gmd:MD_LegalConstraints[gmd:useConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions']
			|//*[@gco:isoType='gmd:MD_LegalConstraints' and gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='otherRestrictions']">
			<sch:let name="use" value="(not(gmd:otherConstraints) or gmd:otherConstraints/@gco:nilReason='missing')"/>
			<sch:assert
				test="$use = false()"
				><sch:value-of select="$loc/strings/alert.M9.use"/>
			</sch:assert>
			<sch:report
				test="$use = false()"
				><sch:value-of select="$loc/strings/report.M9"/>
				<sch:value-of select="gmd:otherConstraints/gco:CharacterString"/>
			</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- anzlic/trunk/gml/3.2.0/gmd/content.xsd-->
	<!-- TEST 13 FXCHECK -->
	<sch:pattern>
		<sch:title>$loc/strings/M10</sch:title>
		<sch:rule context="//gmd:MD_Band[gmd:maxValue or gmd:minValue]">
			<sch:let name="values" value="(gmd:maxValue[@gco:nilReason!='missing' or not(@gco:nilReason)]
				or gmd:minValue[@gco:nilReason!='missing' or not(@gco:nilReason)]) 
				and not(gmd:units)"/>
			<sch:assert test="$values = false()"
				><sch:value-of select="$loc/strings/alert.M10"/>
			</sch:assert>
			<sch:report test="$values = false()"
				>
				<sch:value-of select="$loc/strings/report.M10.min"/>
				<sch:value-of select="gmd:minValue"/> / 
				<sch:value-of select="$loc/strings/report.M10.max"/>
				<sch:value-of select="gmd:maxValue"/> [
				<sch:value-of select="$loc/strings/report.M10.units"/>
				<sch:value-of select="gmd:units"/>]
			</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- repeat to MI_Band -->
	<sch:pattern>
		<sch:title>$loc/strings/M10</sch:title>
		<sch:rule context="//gmi:Mi_Band[gmd:maxValue or gmd:minValue]">
			<sch:let name="values" value="(gmd:maxValue[@gco:nilReason!='missing' or not(@gco:nilReason)]
				or gmd:minValue[@gco:nilReason!='missing' or not(@gco:nilReason)]) 
				and not(gmd:units)"/>
			<sch:assert test="$values = false()"
				><sch:value-of select="$loc/strings/alert.M10"/>
			</sch:assert>
			<sch:report test="$values = false()"
				>
				<sch:value-of select="$loc/strings/report.M10.min"/>
				<sch:value-of select="gmd:minValue"/> / 
				<sch:value-of select="$loc/strings/report.M10.max"/>
				<sch:value-of select="gmd:maxValue"/> [
				<sch:value-of select="$loc/strings/report.M10.units"/>
				<sch:value-of select="gmd:units"/>]
			</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- anzlic/trunk/gml/3.2.0/gmd/dataQuality.xsd -->
	<!-- TEST 10 FXCHECK -->
	<!-- should be ensuring that LI_Source has at least one of description, citation, or extent-->
	<sch:pattern>
		<sch:title>$loc/strings/M11</sch:title>
		<sch:rule context="//gmd:LI_Source">
			<sch:let name="extent" value="gmd:description[@gco:nilReason!='missing' or not(@gco:nilReason)] or gmd:sourceExtent"/>
			<sch:assert test="$extent"
				>$loc/strings/alert.M11</sch:assert>
			<sch:report test="$extent"
				>$loc/strings/report.M11</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- repeat for LE_Source-->
	<sch:pattern>
		<sch:title>$loc/strings/M11</sch:title>
		<sch:rule context="//gmd:LE_Source">
			<sch:let name="extent" value="gmd:description[@gco:nilReason!='missing' or not(@gco:nilReason)] or gmd:sourceExtent"/>
			<sch:assert test="$extent"
				>$loc/strings/alert.M11</sch:assert>
			<sch:report test="$extent"
				>$loc/strings/report.M11</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- TEST  7 FXCHECK -->
	<!-- this is checking that LI_Lineage is filled in correctly for the appropriate DQ_DataQuality, but we changed the obligation of that, so i'm commenting it out.
	<sch:pattern>
		<sch:title>$loc/strings/M13</sch:title>
		<sch:rule context="//gmd:DQ_DataQuality[gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue='dataset' 
			or gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue='series']">
			<sch:let name="emptyStatement" value="
				count(*/gmd:LI_Lineage/gmd:source) + count(*/gmd:LI_Lineage/gmd:processStep) = 0 
				and not(gmd:lineage/gmd:LI_Lineage/gmd:statement[@gco:nilReason!='missing' or not(@gco:nilReason)]) 
				"/>
			<sch:assert
				test="$emptyStatement = false()"
				>$loc/strings/alert.M13</sch:assert>
			<sch:report
				test="$emptyStatement = false()"
				>$loc/strings/report.M13</sch:report>
		</sch:rule>
	</sch:pattern>
	-->
	<!-- revised DQ_DataQuality check -->	
	<sch:pattern>
		<sch:title>DataQuality requires a scope and a lineage</sch:title>
		<sch:rule context="//gmd:DQ_DataQuality">
			<sch:assert test="count(gmd:scope) = 1">Must provide a single scope</sch:assert>
			<sch:assert test="count(gmd:lineage) =1">Must provide a single lineage</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!-- TEST  8 FXCHECK -->
	<!-- checks that LI_Lineage has at least one of the three values, but instead we just require statement
	<sch:pattern>
		<sch:title>$loc/strings/M14</sch:title>
		<sch:rule context="//gmd:LI_Lineage">
			<sch:let name="emptySource" value="not(gmd:source) 
				and not(gmd:statement[@gco:nilReason!='missing' or not(@gco:nilReason)]) 
				and not(gmd:processStep)"/>
			<sch:assert test="$emptySource = false()"
				>$loc/strings/alert.M14</sch:assert>
			<sch:report test="$emptySource = false()"
				>$loc/strings/report.M14</sch:report>

			<sch:let name="emptyProcessStep" value="not(gmd:processStep) 
				and not(gmd:statement[@gco:nilReason!='missing' or not(@gco:nilReason)])
				and not(gmd:source)"/>
			<sch:assert test="$emptyProcessStep = false()"
				>$loc/strings/alert.M15</sch:assert>
			<sch:report test="$emptyProcessStep = false()"
				>$loc/strings/report.M15</sch:report>
		</sch:rule>
	</sch:pattern>
	-->
	<sch:pattern>
		<sch:title>LI_Lineage requires a statement</sch:title>
		<sch:rule context="//gmd:LI_Lineage">
			<sch:assert test="count(gmd:statement)=1">Must provide a single statement</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!-- TEST 5 FXCHECK -->
	<!--checks that a dataset has either a report or a lineage. we require lineage above, so this is unnecessary
	<sch:pattern>
		<sch:title>$loc/strings/M16</sch:title>
		<sch:rule context="//gmd:DQ_DataQuality[gmd:scope/gmd:DQ_Scope/gmd:level/gmd:MD_ScopeCode/@codeListValue='dataset']">
			<sch:let name="noReportNorLineage" value="not(gmd:report) 
				and not(gmd:lineage)"/>
			<sch:assert
				test="$noReportNorLineage = false()"
				>$loc/strings/alert.M16</sch:assert>
			<sch:report
				test="$noReportNorLineage = false()"
				>$loc/strings/report.M16</sch:report>
		</sch:rule>
	</sch:pattern>
	-->
	<!-- TEST  6 FXCHECK -->
	<!-- requires a description for certain levels - we just required if the hierarchyLevel is not the same as the metadata level
	<sch:pattern>
		<sch:title>$loc/strings/M17</sch:title>
		<sch:rule context="//gmd:DQ_Scope">
			<sch:let name="levelDesc" value="gmd:level/gmd:MD_ScopeCode/@codeListValue='dataset' 
				or gmd:level/gmd:MD_ScopeCode/@codeListValue='series' 
				or (gmd:levelDescription and ((normalize-space(gmd:levelDescription) != '') 
				or (gmd:levelDescription/gmd:MD_ScopeDescription) 
				or (gmd:levelDescription/@gco:nilReason 
				and contains('inapplicable missing template unknown withheld',gmd:levelDescription/@gco:nilReason))))"/>
			<sch:assert
				test="$levelDesc"
				>$loc/strings/alert.M17</sch:assert>
			<sch:report
				test="$levelDesc"
				><sch:value-of select="$loc/strings/report.M17"/> <sch:value-of select="gmd:levelDescription"/></sch:report>
		</sch:rule>
	</sch:pattern>
	-->
	<!-- **looking at the pattern from above, it's doing some fancy stuff to try and catch empty classes? Unsure if it's correct code-->
	<sch:pattern>
		<sch:title>$loc/strings/M17</sch:title>
		<sch:rule context="gmi:MI_Metadata">
			<sch:let name="levelDesc" value="//gmd:hierarchyLevel/gmd:MD_MetadataScopeCode !=
			//gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:scope/gmd:DQ_Scope/gmd:MD_ScopeCode/@codeListValue
				and((gmd:levelDescription and ((normalize-space(gmd:levelDescription) != '') 
				or (gmd:levelDescription/gmd:MD_ScopeDescription) 
				or (gmd:levelDescription/@gco:nilReason 
				and contains('inapplicable missing template unknown withheld',gmd:levelDescription/@gco:nilReason)))))"/>
			<sch:assert
				test="$levelDesc"
				>$loc/strings/alert.M17</sch:assert>
			<sch:report
				test="$levelDesc"
				><sch:value-of select="$loc/strings/report.M17"/> <sch:value-of select="gmd:levelDescription"/></sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- anzlic/trunk/gml/3.2.0/gmd/distribution.xsd-->
	<!-- TEST 14 FXCHECK -->
	<!-- give a densityUnits when you have a density-->
	<sch:pattern>
		<sch:title>$loc/strings/M18</sch:title>
		<sch:rule context="//gmd:MD_Medium">
			<sch:let name="density" value="gmd:density and not(gmd:densityUnits[@gco:nilReason!='missing' or not(@gco:nilReason)])"/>
			<sch:assert test="$density = false()"
				>$loc/strings/alert.M18</sch:assert>
			<sch:report test="$density = false()"
				><sch:value-of select="$loc/strings/report.M18"/> <sch:value-of select="gmd:density"/> 
				<sch:value-of select="gmd:densityUnits/gco:CharacterString"/></sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- TEST15 FXCHECK -->
	<!-- distributionFormat and distributor are conditional-->
	<sch:pattern>
		<sch:title>$loc/strings/M19</sch:title>
		<sch:rule context="//gmd:MD_Distribution">
			<sch:let name="total" value="count(gmd:distributionFormat) +
				count(gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat)"/>
			<sch:let name="count" value="count(gmd:distributionFormat)>0 
				or count(gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat)>0"/>
			<sch:assert
				test="$count"
				>$loc/strings/alert.M19</sch:assert>
			<sch:report
				test="$count"
				><sch:value-of select="$total"/> <sch:value-of select="$loc/strings/report.M19"/></sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- anzlic/trunk/gml/3.2.0/gmd/extent.xsd-->
	<!-- TEST 20 FXCHECK -->
	<!--EX_Extent needs at least one value in it -->
	<sch:pattern>
		<sch:title>$loc/strings/M20</sch:title>
		<sch:rule context="//gmd:EX_Extent">
			<sch:let name="count" value="count(gmd:description[@gco:nilReason!='missing' or not(@gco:nilReason)])>0 
				or count(gmd:geographicElement)>0 
				or count(gmd:temporalElement)>0 
				or count(gmd:verticalElement)>0"/>
			<sch:assert
				test="$count"
				>$loc/strings/alert.M20</sch:assert>
			<sch:report
				test="$count"
				>$loc/strings/report.M20</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- TEST  1 -->
	<!-- this is checking if datasets have extents, but we do the conditionality a little differently, so I'm commenting it out
	<sch:pattern>
		<sch:title>$loc/strings/M21</sch:title>
		<sch:rule context="//gmd:MD_DataIdentification|//*[@gco:isoType='gmd:MD_DataIdentification']">
			<sch:let name="extent" value="(not(../../gmd:hierarchyLevel) 
				or ../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset' 
				or ../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='') 
				and (count(gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicBoundingBox) 
				+ count (gmd:extent/*/gmd:geographicElement/gmd:EX_GeographicDescription))=0"/>
			<sch:assert
				test="$extent = false()"
				>$loc/strings/alert.M21</sch:assert>
			<sch:report
				test="$extent = false()"
				>$loc/strings/report.M21</sch:report>
		</sch:rule>
	</sch:pattern>
	-->
	<!-- TEST  2 -->
	<!-- this checks for topic category for datasets, but we require it for all
	<sch:pattern>
		<sch:title>$loc/strings/M22</sch:title>
		<sch:rule context="//gmd:MD_DataIdentification|//*[@gco:isoType='gmd:MD_DataIdentification']">
			<sch:let name="topic" value="(not(../../gmd:hierarchyLevel) 
				or ../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='dataset' 
				or ../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='series'  
				or ../../gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue='' )
				and not(gmd:topicCategory)"/>
			<sch:assert
				test="$topic = false()"
				>$loc/strings/alert.M6</sch:assert>
			<sch:report
				test="$topic = false()"
				><sch:value-of select="$loc/strings/report.M6"/> "<sch:value-of select="gmd:topicCategory"/>"</sch:report>
		</sch:rule>
	</sch:pattern>
	-->
	<!-- TEST  3 -->
	<!-- ensures that aggregate information either has a name or identifier-->
	<sch:pattern>
		<sch:title>$loc/strings/M23</sch:title>
		<sch:rule context="//gmd:MD_AggregateInformation">
			<sch:assert test="gmd:aggregateDataSetName or gmd:aggregateDataSetIdentifier"
				>$loc/strings/alert.M23</sch:assert>
			<sch:report test="gmd:aggregateDataSetName or gmd:aggregateDataSetIdentifier"
				>$loc/strings/report.M23</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- ** I think this is trying to read the encoder from the file itself?-->
	<sch:pattern>
		<sch:title>$loc/strings/M25</sch:title>
		<!-- UNVERIFIED -->
		<sch:rule context="//gmi:MI_Metadata|//*[@gco:isoType='gmi:MI_Metadata']">
			<!-- characterSet: documented if ISO/IEC 10646 not used and not defined by
        the encoding standard. Can't tell if XML declaration has an encoding
        attribute. -->
		</sch:rule>
	</sch:pattern>

	<!-- anzlic/trunk/gml/3.2.0/gmd/metadataExtension.xsd-->
	<!-- TEST 16 -->
	<sch:pattern>
		<sch:title>$loc/strings/M26</sch:title>
		<sch:rule context="//gmd:MD_ExtendedElementInformation">
			<sch:assert
				test="(gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='codelist' 
				or gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='enumeration' 
				or gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='codelistElement') 
				or (gmd:obligation and ((normalize-space(gmd:obligation) != '')  
				or (gmd:obligation/gmd:MD_ObligationCode) 
				or (gmd:obligation/@gco:nilReason and contains('inapplicable missing template unknown withheld',gmd:obligation/@gco:nilReason))))"
				>$loc/strings/alert.M26.obligation</sch:assert>
			<sch:assert
				test="(gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='codelist' 
				or gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='enumeration' 
				or gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='codelistElement') 
				or (gmd:maximumOccurrence and ((normalize-space(gmd:maximumOccurrence) != '')  
				or (normalize-space(gmd:maximumOccurrence/gco:CharacterString) != '') 
				or (gmd:maximumOccurrence/@gco:nilReason and contains('inapplicable missing template unknown withheld',gmd:maximumOccurrence/@gco:nilReason))))"
				>$loc/strings/alert.M26.maximumOccurence</sch:assert>
			<sch:assert
				test="(gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='codelist' 
				or gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='enumeration' 
				or gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='codelistElement') 
				or (gmd:domainValue and ((normalize-space(gmd:domainValue) != '')  
				or (normalize-space(gmd:domainValue/gco:CharacterString) != '') 
				or (gmd:domainValue/@gco:nilReason and contains('inapplicable missing template unknown withheld',gmd:domainValue/@gco:nilReason))))"
				>$loc/strings/alert.M26.domainValue</sch:assert>
		</sch:rule>
	</sch:pattern>
	<!-- TEST 17 -->
	<sch:pattern>
		<sch:title>$loc/strings/M27</sch:title>
		<sch:rule context="//gmd:MD_ExtendedElementInformation">
			<sch:let name="condition" value="gmd:obligation/gmd:MD_ObligationCode='conditional'
				and (not(gmd:condition) or count(gmd:condition[@gco:nilReason='missing'])>0)"/>
			<sch:assert
				test="$condition = false()"
				>
				<sch:value-of select="$loc/strings/alert.M27"/>
			</sch:assert>
			<sch:report
				test="$condition = false()"
				>
				<sch:value-of select="$loc/strings/report.M27"/>
			</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- TEST 18 -->
	<sch:pattern>
		<sch:title>$loc/strings/M28</sch:title>
		<sch:rule context="//gmd:MD_ExtendedElementInformation">
			<sch:let name="domain" value="gmd:dataType/gmd:MD_DatatypeCode/@codeListValue='codelistElement' and not(gmd:domainCode)"/>
			<sch:assert
				test="$domain = false()"
				>$loc/strings/alert.M28</sch:assert>
			<sch:report
				test="$domain = false()"
				>$loc/strings/report.M28</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- TEST 19 -->
	<sch:pattern>
		<sch:title>$loc/strings/M29</sch:title>
		<sch:rule context="//gmd:MD_ExtendedElementInformation">
			<sch:let name="shortName" value="gmd:dataType/gmd:MD_DatatypeCode/@codeListValue!='codelistElement' and not(gmd:shortName)"/>
			<sch:assert
				test="$shortName = false()"
				>$loc/strings/alert.M29</sch:assert>
			<sch:report
				test="$shortName = false()"
				>$loc/strings/report.M29</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- anzlic/trunk/gml/3.2.0/gmd/spatialRepresentation.xsd-->
	<!-- TEST 12 -->
	<!-- ensures checkpoints have a description when they're available-->
	<sch:pattern>
		<sch:title>$loc/strings/M30</sch:title>
		<sch:rule context="//gmd:MD_Georectified">
			<sch:let name="cpd" value="(gmd:checkPointAvailability/gco:Boolean='1' or gmd:checkPointAvailability/gco:Boolean='true') and 
				(not(gmd:checkPointDescription) or count(gmd:checkPointDescription[@gco:nilReason='missing'])>0)"/>
			<sch:assert
				test="$cpd = false()"
				>$loc/strings/alert.M30</sch:assert>
			<sch:report
				test="$cpd = false()"
				>$loc/strings/report.M30</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- repeats for MI_Georectified-->
		<sch:pattern>
		<sch:title>$loc/strings/M30</sch:title>
		<sch:rule context="//gmi:MI_Georectified">
			<sch:let name="cpd" value="(gmd:checkPointAvailability/gco:Boolean='1' or gmd:checkPointAvailability/gco:Boolean='true') and 
				(not(gmd:checkPointDescription) or count(gmd:checkPointDescription[@gco:nilReason='missing'])>0)"/>
			<sch:assert
				test="$cpd = false()"
				>$loc/strings/alert.M30</sch:assert>
			<sch:report
				test="$cpd = false()"
				>$loc/strings/report.M30</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- Not sure what this one is doing... -->
	<sch:pattern>
		<sch:title>$loc/strings/M61</sch:title>
		<sch:rule context="//gmi:MI_Metadata/gmd:hierarchyLevel|//*[@gco:isoType='gmi:MI_Metadata']/gmd:hierarchyLevel">
			<sch:let name="hl" value="(gmd:MD_ScopeCode/@codeListValue!='' and gmd:MD_ScopeCode/@codeListValue!='dataset') and 
				(not(../gmd:hierarchyLevelName) or ../gmd:hierarchyLevelName/@gco:nilReason)"/>
			<sch:assert
				test="$hl = false()"
				>$loc/strings/alert.M61</sch:assert>
			<sch:report
				test="$hl = false()"
				><sch:value-of select=" $loc/strings/report.M61"/> "<sch:value-of select="../gmd:hierarchyLevelName"/>"</sch:report>
		</sch:rule>
	</sch:pattern>
	<!--**TODO or FIXME: Change text to localization strings to improve cross-language support -->

	<!-- MD_DataIdentification changes -->
	<sch:pattern>
		<sch:title>MD_DataIdentification requires citation, abstract, status, pointOfContact, characterSet, topicCategory, resourceMaintenance, resourceFormat, descriptiveKeywords and resourceConstraints</sch:title>
		<sch:rule context="//gmd:MD_DataIdentification">
			<sch:assert test="count(gmd:citation) = 1">MD_DataIdentification must have a single citation.</sch:assert>
			<sch:assert test="count(gmd:abstract) = 1">MD_DataIdentification must have a single abstract.</sch:assert>
			<sch:assert test="count(gmd:status) >= 1">MD_DataIdentification is missing its current status.</sch:assert>
			<sch:assert test="count(gmd:pointOfContact) >= 1">MD_DataIdentification is missing a point of contact.</sch:assert>
			<sch:assert test="count(gmd:characterSet) >=1">MD_DataIdentification is missing a defined character set.</sch:assert>
			<sch:assert test="count(gmd:topicCategory) >=1">MD_DataIdentification is missing topic category.</sch:assert>
			<sch:assert test="count(gmd:resourceMaintenance) >=1">MD_DataIdentification is missing maintenance information.</sch:assert>
			<sch:assert test="count(gmd:resourceFormat) >=1">MD_DataIdentification is missing format information.</sch:assert>
			<sch:assert test="count(gmd:descriptiveKeywords) >= 4">MD_DataIdentification is missing keywords. Provide one for each of the 4 provided thesauri.</sch:assert>
			<sch:assert test="count(gmd:resourceConstraints) >=1">MD_DataIdentification is missing resource constraints.</sch:assert>
		</sch:rule>
	</sch:pattern>

	<!-- Maintenance restriction -->
	<sch:pattern>
		<sch:title>if gmd:resourceMaintenance then must have gmd:maintenanceAndUpdateFrequency</sch:title>
		<sch:rule context="//gmd:resourceMaintenance">
			<sch:assert test="gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue!=''">maintenanceAndUpdateFrequency is mandatory if resourceMaintenance is documented.</sch:assert>
		</sch:rule>
	</sch:pattern>

	<!-- Extent information -->
	<sch:pattern>
		<sch:title>resource must have a physical and temporal extent</sch:title>
		<sch:rule context="//gmd:MD_DataIdentification">
			<sch:report test="count(gmd:extent//gmd:temporalElement/gmd:EX_TemporalExtent) >= 1">Provide at least one temporal extent when describing the extent of the resource in MD_DataIdentification</sch:report>
			<sch:report test="count(gmd:extent//gmd:geographicElement/gmd:EX_GeographicBoundingBox) >= 1">Provide at least one bounding box when describing the extent of the resource in MD_DataIdentification</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- Resolution check -->
	<sch:pattern>
		<sch:title>MD_Resolution requires at least one value</sch:title>
		<sch:rule context="//gmd:MD_Resolution">
			<sch:report test="count(gmd:equivalentScale) + count(gmd:distance) >= 1">provide at least one of equivalentScale and distance </sch:report>
			<sch:report test="count(gmd:equivalentScale[@gco:nilReason]) =0 or count(gmd:distance[@gco:nilReason])=0">fields cannot both be nil</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- CI_Series -->
	<sch:pattern>
		<sch:title>CI_Series requires one of name, issueIdentification</sch:title>
		<sch:rule context="//gmd:CI_Series">
			<sch:report test="count(gmd:name)+count(gmd:issueIdentification) >= 1 0">provide at least one of name, issueIdentification</sch:report>
			<sch:report test="count(gmd:name[@gco:nilReason]) =0 or count(gmd:issueIdentification[@gco:nilReason]) = 0">fields cannot both be nil</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- CI_Contact-->
	<sch:pattern>
		<sch:title>CI_Contact requires one of phone, address</sch:title>
		<sch:rule context="//gmd:CI_Series">
			<sch:report test="count(gmd:phone)+count(gmd:address) >= 1">provide at least one of phone, address (strongly recommended to provide email address)</sch:report>
			<sch:report test="count(gmd:phone[@gco:nilReason]) = 0 or count(gmd:address[@gco:nilReason])=0">fields cannot both be nil</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- CI_Telephone-->
	<sch:pattern>
		<sch:title>CI_Contact requires one of voice phone #, fax phone #</sch:title>
		<sch:rule context="//gmd:CI_Telephone">
			<sch:report test="count(gmd:voice)+count(gmd:facsimile) >= 1">provide at least one phone #</sch:report>
			<sch:report test="count(gmd:voice[@gco:nilReason]) =0 or count(gmd:facsimile[@gco:nilReason]) =0">fields cannot both be nil</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- Require a field named useLimitation that is not empty in an MD_*Constraints for  DataIdentification -->
	<sch:pattern>
		<sch:title>Require a free-text description of constraints whenever constraints are provided.</sch:title>
		<sch:rule context="//gmd:resourceConstraints">
			<sch:report test="count(gmd:MD_Constraints/useLimitation)>= 1 or count(gmd:MD_LegalConstraints/useLimitation)>= 1 or count(gmd:MD_SecurityConstraints/useLimitation)>= 1">provide at least one useLimitation in free text</sch:report>
			<sch:report test="count(gmd:MD_Constraints/useLimitation[@gco:nilReason])= 0 or count(gmd:MD_LegalConstraints/useLimitation[@gco:nilReason]) = 0 or count(gmd:MD_SecurityConstraints/useLimitation[@gco:nilreason]) = 0">At least one useLimitation must be provided</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!--LE_NominalResolution-->
	<sch:pattern>
		<sch:title>CI_Contact requires one of phone, address</sch:title>
		<sch:rule context="//gmi:LE_NominalResolution">
			<sch:report test="count(gmi:scanningResolution)+count(gmi:groundResolution) >= 1">provide at least one of scanning resolution, ground distance</sch:report>
			<sch:report test="count(gmi:scanningResolution[@gco:nilReason])=0 or count(gmi:groundResolution[@gco:nilReason])=0">fields cannot both be nil</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!--MD_StandardOrderProcess - do I need to provide this?-->
	<!--MD_Medium - do I need to provide this? -->
	<!-- MD_RangeDimension - do I need to provide this? -->
	<!-- MD_Band -->
	<sch:pattern>
		<sch:title>MD_Band requires either a sequenceIdentifier or a description.</sch:title>
		<sch:rule context="//gmi:MD_Band">
			<sch:report test="count(gmd:sequenceIdentifier)+count(gmd:descriptor)>=1">Provide at least one of sequenceIdentifier, descriptor</sch:report>
		</sch:rule>
	</sch:pattern>
	<!-- MI_Band -->
	<sch:pattern>
		<sch:title>MI_Band requires either a sequenceIdentifier or a description.</sch:title>
		<sch:rule context="//gmi:MI_Band">
			<sch:report test="count(gmd:sequenceIdentifier)+count(gmd:descriptor)>=1">Provide at least one of sequenceIdentifier, descriptor</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- acquisition information -->
	<!-- MI_Instrument-->
	<sch:pattern>
		<sch:title>MI_Instrument requires an identifier and a type.</sch:title>
		<sch:rule context="//gmi:MI_Instrument">
			<sch:report test="count(gmi:type) = 1">A single type is required for MI_Instrument.</sch:report>
			<sch:report test="count(gmi:identifier) = 1">A single identifier is required for MI_Instrument. </sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- MI_Operation -->
	<sch:pattern>
		<sch:title>MI_Operation requires a single citation, identifier, and status. </sch:title>
		<sch:rule context="//gmi:MI_Operation">
			<sch:report test="count(gmi:citation) = 1">A single citation is required for MI_Operation.</sch:report>
			<sch:report test="count(gmi:identifier) = 1">A single identifier is required for MI_Operation.</sch:report>
			<sch:report test="count(gmi:status)= 1">A single status is required for MI_Operation.</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- MI_event-->
	<sch:pattern>
		<sch:title>MI_Event requires a single: identifier, trigger, context, sequence, and time.</sch:title>
		<sch:rule context="//gmi:MI_Event">
			<sch:report test="count(gmi:identifier) = 1">A single identifier is required for MI_Event.</sch:report>
			<sch:report test="count(gmi:trigger) = 1">A single trigger type is required for MI_Event.</sch:report>
			<sch:report test="count(gmi:context) = 1">A single event context is required for MI_Event.</sch:report>
			<sch:report test="count(gmi:sequence) = 1">A single temporal event context is required for MI_Event.</sch:report>
			<sch:report test="count(gmi:time) = 1">A single time of occurrence is required for MI_Event.</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- MI_PlatformPass -->
	<sch:pattern>
		<sch:title>MI_PlatformPass requires an identifier.</sch:title>
		<sch:rule context="//gmi:MI_PlatformPass">
			<sch:report test="count(gmi:identifier) = 1">A single identifier is required for MI_PlatformPass.</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- MI_Platform -->
	<sch:pattern>
		<sch:title>MI_Platform requires a single identifier and description, and at least one instrument.</sch:title>
		<sch:rule context="//gmi:MI_Platform">
			<sch:report test="count(gmi:identifier) = 1">A single identifier is required for MI_Platform.</sch:report>
			<sch:report test="count(gmi:description) = 1">A single description is required for MI_Platform.</sch:report>
			<sch:report test="count(gmi:instrument) >= 1">At least one instrument is required for MI_Platform.</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- MI_Plan -->
	<sch:pattern>
		<sch:title>MI_Plan requires a single status and citation.</sch:title>
		<sch:rule context="//gmi:MI_Plan">
			<sch:report test="count(gmi:status)=1">A single status is required for MI_Plan.</sch:report>
			<sch:report test="count(gmi:citation)=1">A single citation is required for MI_Plan.</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- MI_Objective -->
	<sch:pattern>
		<sch:title>MI_Objective requires a single identifier and at least one ObjectiveOccurrence. </sch:title>
		<sch:rule context="//gmi:MI_Objective">
			<sch:report test="count(gmi:identifier)=1">A single identifier is required for MI_Objective.</sch:report>
			<sch:report test="count(gmi:objectiveOccurence)>=1">At least one objectiveOccurence is required for MI_Objective.</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- MI_Requirement -->
	<sch:pattern>
		<sch:title>MI_Requirement must have a single citation, identifier, priority, requested date, and expiry date. It must also have at least one requestor and recipient.</sch:title>
		<sch:rule context="//gmi:MI_Requirement">
			<sch:report test="count(gmi:citation)=1">A single citation is required for MI_Requirement.</sch:report>
			<sch:report test="count(gmi:identifier)=1">A single identifier is required for MI_Requirement.</sch:report>
			<sch:report test="count(gmi:priority)=1">A single priority is required for MI_Requirement.</sch:report>
			<sch:report test="count(gmi:requestedDate)=1">A single requestedDate is required for MI_Requirement.</sch:report>
			<sch:report test="count(gmi:expiryDate)=1">A single expiryDate is required for MI_Requirement.</sch:report>
			<sch:report test="count(gmi:requestor)>=1">At least one requestor is required for MI_Requirement.</sch:report>
			<sch:report test="count(gmi:recipient)>=1">At least one recipient is required for MI_Requirement.</sch:report>
		</sch:rule>
	</sch:pattern>
	
	<!-- MI_RequestedDate -->
	<sch:pattern>
		<sch:title>MI_RequiredDate requires a single requestedDateOfCollection and latestAcceptableDate.</sch:title>
		<sch:rule context="//gmi:MI_RequestedDate">
			<sch:report test="count(gmi:requestedDateOfCollection)=1">A single requestedDateOfCollection is required for MI_RequestedDate.</sch:report>
			<sch:report test="count(gmi:latestAcceptableDate)=1">A single latestAcceptableDate is required for MI_RequestedDate.</sch:report>
		</sch:rule>
	</sch:pattern>
	

</sch:schema>
