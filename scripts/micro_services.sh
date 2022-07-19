#!/bin/bash

source $(dirname $0)/site_config.sh

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 0
fi

if [ $1 == "playbook" ]; then 
    #blazegraph
    blazegraph_url=http://localhost:8080/bigdata
    blazegraph_namespace=islandora
    
    #fits
    fits_mode="remote"
    fits_url=http://localhost:8080/fits/examine
    fits_config_var="fits-server-url"
        
elif [ $1 == "docker" ]; then
    #blazegraph
    blazegraph_url=http://islandora.traefik.me:8082/bigdata
    blazegraph_namespace=islandora

    # install Fits commented because won't work, need install from buildkits
    #mkdir -p /opt/fits
    #wget https://github.com/harvard-lts/fits/releases/download/1.4.0/fits-latest.zip -P /opt/fits
    #unzip /opt/fits/fits-latest.zip -d /opt/fits
    #chmod +x /opt/fits/fits.sh
    
    #fits
    fits_mode="local"
    fits_url=/opt/fits-1.4.1/fits.sh
    fits_config_var="fits-path"
elif [ $1 == "production" ]; then
    echo "Vars set in site_config.sh"
else
  echo "Please enter which environment you running this script on"
  exit 0
fi


#Enable microservice modules
"$drush" -y pm:enable advancedqueue_runner triplestore_indexer fits

#Import fits field for File type
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/file_type.file

# configure Advanced Queue
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/advanced_queue

# configure advanced queue runner
"$drush" -y config-set --input-format=yaml advancedqueue_runner.settings drush_path "${site_path}"/vendor/drush/drush/drush
"$drush" -y config-set --input-format=yaml advancedqueue_runner.settings root_path "${site_path}"
"$drush" -y config-set --input-format=yaml advancedqueue_runner.settings auto-restart-in-cron 1
"$drush" -y config-set --input-format=yaml advancedqueue_runner.settings queues "
- default
- triplestore
- fits
- ocr_extract_text
"
"$drush" -y config-set --input-format=yaml advancedqueue_runner.settings interval '5'
"$drush" -y config-set --input-format=yaml advancedqueue_runner.settings mode limit
"$drush" -y config-set --input-format=yaml advancedqueue_runner.settings started_at $(date +%s)
"$drush" cron

# Configure Rest Services (enable jsonld endpoint)
"$drush" -y config-import --partial --source="$islandora_lite_installation_path"/configs/rest

#configure triplestore_indexer
"$drush" -y config-set --input-format=yaml triplestore_indexer.triplestoreindexerconfig server-url "${blazegraph_url}"
"$drush" -y config-set --input-format=yaml triplestore_indexer.triplestoreindexerconfig namespace "${blazegraph_namespace}"
"$drush" -y config-set --input-format=yaml triplestore_indexer.triplestoreindexerconfig method-of-op advanced_queue
"$drush" -y config-set --input-format=yaml triplestore_indexer.triplestoreindexerconfig aqj-max-retries 5
"$drush" -y config-set --input-format=yaml triplestore_indexer.triplestoreindexerconfig aqj-retry_delay 120
"$drush" -y config-set --input-format=yaml triplestore_indexer.triplestoreindexerconfig select-auth-method
"$drush" -y config-set --input-format=yaml triplestore_indexer.triplestoreindexerconfig advancedqueue-id triplestore
"$drush" -y config-set --input-format=yaml triplestore_indexer.triplestoreindexerconfig content-type-to-index "islandora_object: islandora_object"

# configure fits
"$drush" -y config-set --input-format=yaml fits.fitsconfig fits-method "${fits_mode}"
"$drush" -y config-set --input-format=yaml fits.fitsconfig "${fits_config_var}" "${fits_url}"
"$drush" -y config-set --input-format=yaml fits.fitsconfig fits-advancedqueue_id fits
"$drush" -y config-set --input-format=yaml fits.fitsconfig fits-extract-ingesting 1
"$drush" -y config-set --input-format=yaml fits.fitsconfig aqj-max-retries  5
"$drush" -y config-set --input-format=yaml fits.fitsconfig aqj-retry_delay 120
"$drush" -y config-set --input-format=yaml fits.fitsconfig fits-default-fields "
- field_fits_checksum
- field_fits_file_format
- field_fits
"
