#!/bin/bash

source $(dirname $0)/site_config.sh

# import advanced search configs
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/advanced_search

# rest config
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/rest

# media - overwrite default form display
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/media_form_display

# simple config for rest_oai_pmh, citation_select
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/simple


