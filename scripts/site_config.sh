#!/bin/bash

#current site
site_path=/var/www/drupal
drush="$site_path"/vendor/drush/drush/drush
islandora_lite_installation_path="/var/www/drupal/islandora_lite_installation"
site_config_path="/var/www/drupal/dsu_sites_config"


#configure_search_api_solr_module
solr_host=http://islandora.traefik.me:8983/solr
solr_core=ISLANDORA
cantaloupe_url=https://islandora.traefik.me/cantaloupe/iiif/2

#blazegraph
blazegraph_url=https://islandora.traefik.me:8082/bigdata
blazegraph_namespace=islandora

#fits
fits_mode="local"
fits_url=/opt/fits-1.4.1/fits.sh
fits_config_var="fits-path"

