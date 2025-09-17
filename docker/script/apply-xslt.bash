#!/usr/bin/env bash
set -e

SAXON_VERSION="${SAXON_VERSION:-12-9}"
SAXON_URL="https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE${SAXON_VERSION}/SaxonHE${SAXON_VERSION}J.zip"

if [ ! -d '/app/saxon' ]; then
(
	mkdir -p '/app/saxon' \
	&& curl -sL -o '/app/saxon/saxon.zip' "${SAXON_URL}" \
	&& cd '/app/saxon' && unzip -q 'saxon.zip' \
	&& ln -s /app/saxon/saxon-he-??.?.jar '/app/saxon.jar'
)
fi

echo "Transforming ${FACET_MAPPING_SOURCE} to ${FACET_MAPPING_TARGET} using ${MAPPING_XML}"
(
	java -jar '/app/saxon.jar' \
		"-xsl:/app/xslt/updateFacetConcepts.xsl" \
		"-s:${FACET_MAPPING_SOURCE}" \
		"-o:${FACET_MAPPING_TARGET}" \
		"mapFile=${MAPPING_XML}"
)

echo "Done"
