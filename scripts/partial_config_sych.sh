#!/bin/bash

source $(dirname $0)/site_config.sh

# rest config
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/rest

# media - overwrite default form display
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/media_form_display

# media - overwrite default view display
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/media_view_display

# simple config for rest_oai_pmh, citation_select
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/simple

# simple config for blocks
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/blocks_olivero
