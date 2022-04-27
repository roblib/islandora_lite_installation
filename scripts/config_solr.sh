#!/bin/bash

source $(dirname $0)/site_config.sh

"$drush" -y pm:enable search_api_solr
"$drush" -y pm:uninstall search
"$drush" -y pm:enable search_api_solr_defaults

"$drush" -y config-set search_api.server.default_solr_server backend_config.connector_config.scheme https
"$drush" -y config-set search_api.server.default_solr_server backend_config.connector_config.host ${solr_host}
"$drush" -y config-set search_api.server.default_solr_server backend_config.connector_config.core ${solr_core}
