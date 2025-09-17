#!/usr/bin/env bash
set -e

BASEDIR="$(cd "$(dirname $0)" && pwd)"

FACET_CONFIG_FILE="${BASEDIR}/test/facetConcepts.xml"
MAPPING_CSV="${BASEDIR}/test/test.csv"
OUT_DIR="${BASEDIR}/output"
OUT_FILE="facetConcepts.xml"

while [[ $# -gt 0 ]]; do
  case $1 in
    -i)
    	FACET_CONFIG_FILE="$(realpath "$2")"
    	shift
    	shift
    	;;
    -m)
    	MAPPING_CSV="$(realpath "$2")"
    	shift
    	shift
    	;;
    -o)
    	OUT_DIR="$(realpath "$(dirname $2)")"
    	OUT_FILE="$(basename $2)"
    	shift
    	shift
    	;;
  esac
done

if ! [ -e "${FACET_CONFIG_FILE}" ]; then
	echo "Error - no such file: ${FACET_CONFIG_FILE} "
	exit 1
fi

if ! [ -e "${MAPPING_CSV}" ]; then
	echo "Error - no such file: ${MAPPING_CSV} "
	exit 1
fi

if ! [ -d "${OUT_DIR}" ]; then
	echo "Creating output directory: ${OUT_DIR}"
	mkdir -p "${OUT_DIR}"
fi


export MAPPING_INFILE="${MAPPING_CSV}"
export FACET_MAPPING_INFILE="${FACET_CONFIG_FILE}"
export OUTPUT_DIR="${OUT_DIR}"
export OUTPUT_FILE="${OUT_FILE}"

echo "Concepts wikidata mapping CSV: ${MAPPING_INFILE}"
echo "Facet concept mapping configuration input file: ${FACET_MAPPING_INFILE}"
echo "Output will be written to ${OUTPUT_DIR}/${OUTPUT_FILE}"


( cd "${BASEDIR}/docker" && docker-compose run --rm 'vlo-config-wikidata' )

