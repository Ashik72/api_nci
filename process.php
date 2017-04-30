<?php

require __DIR__ . '/vendor/autoload.php';
//ini_set('memory_limit', '30M');

require_once 'config.php';
require_once 'inc/class.import_hotels.php';
require_once 'inc/class.import_hotels_translations.php';

d(ImportHotels::processData($_GET['type']));
//d(ImportHotelsTranslations::processData($_GET['type']));


 ?>
