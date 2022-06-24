#!/bin/bash

#current site
site_path=/var/www/drupal
site_url="https://islandora.traefik.me"
drush="$site_path"/vendor/drush/drush/drush
islandora_lite_installation_path="$site_path/islandora_lite_installation"
site_config_path="/var/www/drupal/dsu_sites_config"


#configure_search_api_solr_module
solr_host="$site_url":8983/solr
solr_core=ISLANDORA
cantaloupe_url="$site_url"/cantaloupe/iiif/2

#blazegraph
blazegraph_sitename=`echo $site_url |sed 's/https\?:\/\///'`
blazegraph_url="http://$blazegraph_sitename":8082/bigdata
blazegraph_namespace=islandora

#fits
fits_mode="local"
fits_url=/opt/fits-1.4.1/fits.sh
fits_config_var="fits-path"

