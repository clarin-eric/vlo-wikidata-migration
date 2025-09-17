<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:output method="xml" />
    <xsl:param name="mapFile" select="'../test/test.xml'"/>
    <xsl:param name="map" select="document($mapFile)/data/row"/>

    <xsl:template match="facetConcept/concept | acceptableContext/concept | rejectableContext/concept">
        <concept>
            <xsl:apply-templates select="@* | node()"/>
        </concept>        
        <xsl:variable name="uri" select="normalize-space(text())"/>
        <xsl:for-each select="$map[normalize-space(oldUri)=$uri]">
            <xsl:text>&#xa;&#xa;</xsl:text>
            <xsl:comment>Wikidata mapping from <xsl:value-of select="./oldUri"/></xsl:comment>
            <xsl:text>&#xa;</xsl:text>
            <concept><xsl:value-of select="./newUri"/></concept>
            <xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="/ | @* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
