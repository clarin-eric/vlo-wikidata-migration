#!/usr/bin/env bash
(
	cd "$(dirname $0)/docker" \
	&& docker-compose run --rm 'vlo-config-wikidata'
)
