#!/bin/bash
DOMAIN=$1
DRUPAL_DEFAULT_ACCOUNT_PASSWORD=$2
URL="https://${DOMAIN}/term_from_uri?_format=json&uri=https%3A%2F%2Fschema.org%2FBook"

BOOK_TERM_ID=$(curl -u admin:$DRUPAL_DEFAULT_ACCOUNT_PASSWORD -X GET $URL | jq .[].tid[].value)

drush -y --input-format=yaml config:set block.block.miradorblock visibility.term "
id: term
tid:
  -
    target_id: '$BOOK_TERM_ID'
negate: false
context_mapping: {  }"

