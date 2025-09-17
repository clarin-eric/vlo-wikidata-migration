#!/usr/bin/env bash
set -e

cd /app/python

# Set up environment
echo "Setting up..."
apk add -q --no-cache py-pip
python3 -m venv /app/docker-venv
source /app/docker-venv/bin/activate
echo "Installing libraries"
python3 -m pip install -r requirements.txt > /dev/null

# Run conversion
python3 /app/python/csv2xml.py "${MAPPING_CSV}" "${MAPPING_XML}"

# Clean up
python3 -m venv ../docker-venv --clear
