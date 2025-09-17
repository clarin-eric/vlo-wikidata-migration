#!/usr/bin/env bash
set -e

echo -e "1. Converting CSV mapping file to XML...\n"
bash /app/script/csv2xml.bash

echo -e "\n\n2. Applying transformation to facet concept mapping file...\n"
bash /app/script/apply-xslt.bash
