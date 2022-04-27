#!/bin/bash

source $(dirname $0)/site_config.sh

#Enable modules
"$drush" -y pm:enable responsive_image syslog devel admin_toolbar pdf matomo restui controlled_access_terms_defaults jsonld field_group field_permissions features file_entity view_mode_switch replaywebpage islandora_defaults islandora_marc_countries fico fico_taxonomy_condition openseadragon ableplayer csvfile_formatter archive_list_contents islandora_iiif islandora_display advanced_search media_thumbnails media_thumbnails_pdf media_thumbnails_video media_library_edit migrate_source_csv migrate_tools basic_auth islandora_lite_solr_search islandora_mirador term_condition filemime

"$drush" -y pm:enable media_thumbnails_tiff

"$drush" -y migrate:import --group=islandora

