#!/bin/bash

#current site
site_path=/var/www/html/drupal
site_url="http://localhost:8080"
drush="$site_path"/vendor/drush/drush/drush
islandora_lite_installation_path="$site_path/islandora_lite_installation"
site_config_path="$site_path"/dsu_sites_config


#configure_search_api_solr_module
cantaloupe_url="$site_url"/cantaloupe/iiif/2

#blazegraph
blazegraph_sitename="$site_url"
blazegraph_url=http://localhost:8080/bigdata
blazegraph_namespace=islandora

#fits
fits_mode="remote"
fits_url=http://localhost:8080/fits/examine
fits_config_var="fits-server-url"

