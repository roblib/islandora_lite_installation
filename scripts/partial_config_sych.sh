#!/bin/bash

source $(dirname $0)/site_config.sh

# import advanced search configs
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/advanced_search

# rest config
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/rest

# media config
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/media_form_display



