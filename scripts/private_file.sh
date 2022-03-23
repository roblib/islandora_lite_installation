# register path of private file directroy
sed -i "/file_private_path/c\$settings['file_private_path'] = 'sites/default/private_files';" /var/www/drupal/web/sites/default/settings.php 
