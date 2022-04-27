#!/bin/bash

source $(dirname $0)/site_config.sh

current_path="$PWD"

wget https://www.drupal.org/files/issues/2022-02-10/deprecated-3084136-3.patch -P "$site_path"/web/modules/contrib/fico
cd "$site_path"/web/modules/contrib/fico && patch --forward -p1 < deprecated-3084136-3.patch
cd "$current_path"

cp "$islandora_lite_installation_path"/patches/workbench_integration.patch "$site_path"/web/modules/contrib/islandora_workbench_integration/
cd "$site_path"/web/modules/contrib/islandora_workbench_integration && patch --forward -p1 < workbench_integration.patch
cd "$current_path"

"$drush" pm:enable islandora_workbench_integration
