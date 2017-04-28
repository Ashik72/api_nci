<?php
require __DIR__ . '/vendor/autoload.php';
//ini_set('memory_limit', '8M');

require_once 'config.php';
require_once 'inc/class.import_hotels.php';

//d(ImportHotels::getLastIndex());
d(ImportHotels::processData($_GET['type']));
//d(ImportHotels::keyExists('10008'));

 ?>
