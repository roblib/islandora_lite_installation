#!/bin/bash

# enable the module
"$drush" -y pm:enable ajax_solr_search

source $(dirname $0)/site_config.sh

[ -d "${site_path}"/dsu_sites_config ] && git clone https://github.com/digitalutsc/dsu_sites_config "${site_path}"/dsu_sites_config

# import config from federated search
"$drush" -y config-import --partial --source="${site_path}"/dsu_sites_config/federated-search

# clear cache
"$drush" cr
