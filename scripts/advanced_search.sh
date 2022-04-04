#!/bin/bash

#inital_path
inital_path=$PWD

#current site
site_path=/var/www/drupal

# import advanced search configs
drush -y config-import --partial --source="${site_path}"/islandora_lite_installation/configs/advanced_search
