<?php

require_once 'class.db.php';

use \JsonCollectionParser\Parser as Parser;
use Unirest\Request as Request;
/**
 * ImportHotels
 */
class ImportHotels
{

  function __construct()
  {
    # code...
  }

  public static function getLastIndex() {

    $db = DB::Connect();

    $index = 0;

    $sql = "SELECT code FROM hotels ORDER BY code DESC LIMIT 1";

    $result = $db->query($sql);


    if ($result->num_rows > 0)
      while($row = $result->fetch_assoc())
        $index = (int) $row['code'];

    $result->close();


    $db->close();

    return $index;

  }

  public static function keyExists($key = "") {

    if (empty($key))
      return;

    $db = DB::Connect();
    $sql = "SELECT code FROM `hotels` WHERE `code` = '{$key}' LIMIT 1";

    $result = $db->query($sql);

    $db->close();

    if ($result->num_rows > 0) {
      $result->close();
      return 1;
    } else {
      $result->close();
      return 0;
    }


  }

  public static function processData($type = "") {

    if (strcmp($type, "file") === 0)
      static::processFile($_GET['file']);
    elseif (strcmp($type, "link") === 0)
      static::processLink($_GET['link']);

  }



  protected static function processFile($file = "") {

    $file = dirname(__DIR__).DIRECTORY_SEPARATOR."file".DIRECTORY_SEPARATOR.$file;

    if (!file_exists($file))
      return;

    static::parserProcess($file);

    return;

  }

  public static function process($item) {
    d($item);
}

  protected static function parserProcess($file = "") {

    if (empty($file))
      return;

      $parser = new Parser();

      $parser->parse($file, [get_called_class(), 'importToDB']);
      //$parser->parse($file, [get_class(), 'process']);

      return;

  }




  protected static function processLink($link = "") {

    $headers = array('Accept' => 'application/json');

    $query = array();

    $link_query = $_GET;
    $link_query = array_slice($link_query, 2);
    $query = $link_query;

    try {
      $response = Request::post($link, $headers, $query);
    } catch (Exception $e) {
      return;
    }

    if ($response->code !== 200)
      return;

    $response = $response->body;

    $tmpfname = tempnam("/tmp", "hotels");

    $handle = fopen($tmpfname, "w");
    fwrite($handle, $response);
    fclose($handle);
    if (!file_exists($tmpfname))
      return;

    static::parserProcess($tmpfname);
    unlink($tmpfname);


    return;

  }

  public static function isJSON($string) {
   return is_string($string) && is_array(json_decode($string, true)) && (json_last_error() == JSON_ERROR_NONE) ? true : false;
 }

 public static function importToDB($json = "") {


      $temp_data = (object) $json;

      $temp_data->code = (int) $temp_data->code;
      if (static::keyExists($temp_data->code))
        $temp_data->code = ( (int) static::getLastIndex() ) + 1;
        $db = DB::Connect();
//        $code = ( empty($db->real_escape_string($temp_data->code)) ? "" : $db->real_escape_string($temp_data->code );

        $code = ( empty( $db->real_escape_string($temp_data->code) ) ? "" : $db->real_escape_string($temp_data->code) );
        $master = ( empty( $db->real_escape_string($temp_data->master) ) ? "" : $db->real_escape_string($temp_data->master) );
        $name = ( empty( $db->real_escape_string($temp_data->name) ) ? "" : $db->real_escape_string($temp_data->name) );
        $country = ( empty( $db->real_escape_string($temp_data->country) ) ? "" : $db->real_escape_string($temp_data->country) );
        $zipcode = ( empty( $db->real_escape_string($temp_data->zipcode) ) ? "" : $db->real_escape_string($temp_data->zipcode) );
        $regions = ( empty( $db->real_escape_string($temp_data->regions[0]) ) ? "" : $db->real_escape_string($temp_data->regions[0]) );
        $address = ( empty( $db->real_escape_string($temp_data->address) ) ? "" : $db->real_escape_string($temp_data->address) );
        $destination = ( empty( $db->real_escape_string($temp_data->destination) ) ? "" : $db->real_escape_string($temp_data->destination) );
        $latitude = ( empty( $db->real_escape_string($temp_data->latitude) ) ? "" : $db->real_escape_string($temp_data->latitude) );
        $longitude = ( empty( $db->real_escape_string($temp_data->longitude) ) ? "" : $db->real_escape_string($temp_data->longitude) );
        $countrycode = ( empty( $db->real_escape_string($temp_data->currencycode) ) ? "" : $db->real_escape_string($temp_data->currencycode) );
        $checkin_from = ( empty( $db->real_escape_string($temp_data->checkin_from) ) ? "" : $db->real_escape_string($temp_data->checkin_from) );
        $checkout_to = ( empty( $db->real_escape_string($temp_data->checkout_to) ) ? "" : $db->real_escape_string($temp_data->checkout_to) );
        $nr_rooms = ( empty( $db->real_escape_string($temp_data->nr_rooms) ) ? "" : $db->real_escape_string($temp_data->nr_rooms) );
        $stars = ( empty( $db->real_escape_string($temp_data->stars) ) ? "" : $db->real_escape_string($temp_data->stars) );
        $hotel_type = ( empty( $db->real_escape_string($temp_data->hotel_type) ) ? "" : $db->real_escape_string($temp_data->hotel_type) );

        $hotel_information = ( empty( $db->real_escape_string($temp_data->descriptions['hotel_information']) ) ? "" : $db->real_escape_string($temp_data->descriptions['hotel_information']) );
        $hotel_amenity = ( empty( $db->real_escape_string($temp_data->descriptions['hotel_amenity']) ) ? "" : $db->real_escape_string($temp_data->descriptions['hotel_amenity']) );
        $room_amenity = ( empty( $db->real_escape_string($temp_data->descriptions['room_amenity']) ) ? "" : $db->real_escape_string($temp_data->descriptions['room_amenity']) );
        $location_information = ( empty( $db->real_escape_string($temp_data->descriptions['location_information']) ) ? "" : $db->real_escape_string($temp_data->descriptions['location_information']) );
        $hotel_introduction = ( empty($temp_data->descriptions['hotel_introduction']) ? "none" : $db->real_escape_string($temp_data->descriptions['hotel_introduction']) );

        $hotel_availability_score = ( empty($temp_data->availability_score) ? 0 : $db->real_escape_string($temp_data->availability_score) );

        $attraction_information = ( empty( $db->real_escape_string($temp_data->descriptions['attraction_information']) ) ? "" : $db->real_escape_string($temp_data->descriptions['attraction_information']) );

        $year_built = ( empty( $db->real_escape_string($temp_data->year_built) ) ? "" : $db->real_escape_string($temp_data->year_built) );
        $nr_restaurants = ( empty( $db->real_escape_string($temp_data->nr_restaurants) ) ? "" : $db->real_escape_string($temp_data->nr_restaurants) );
        $nr_bars = ( empty( $db->real_escape_string($temp_data->nr_bars) ) ? "" : $db->real_escape_string($temp_data->nr_bars) );
        $nr_halls = ( empty( $db->real_escape_string($temp_data->nr_halls) ) ? "" : $db->real_escape_string($temp_data->nr_halls) );
        $updated_at = ( empty( $db->real_escape_string($temp_data->updated_at) ) ? "" : $db->real_escape_string($temp_data->updated_at) );

        $hotel_information = str_replace("'","&apos;",$hotel_information);
      	$hotel_amenity = str_replace("'","&apos;",$hotel_amenity);
      	$room_amenity = str_replace("'","&apos;",$room_amenity);
      	$location_information = str_replace("'","&apos;",$location_information);
      	$hotel_introduction = str_replace("'","&apos;",$hotel_introduction);
      	$attraction_information = str_replace("'","&apos;",$attraction_information);

        $sql = "INSERT INTO hotels VALUES('$code', '$master', '$name', '$country', '$destination', '$zipcode', '$address', '$latitude', '$longitude', '$countrycode', '$hotel_type', '$stars', '$hotel_availability_score', '$nr_rooms', '$nr_restaurants', '$nr_bars', '$nr_halls', '$year_built', '$checkin_from','$checkout_to','','$hotel_information', '$hotel_introduction', '$location_information', '$attraction_information', '$hotel_amenity', '$room_amenity','$updated_at')";

        $result = $db->query($sql);
        $error = ( empty($db->error) ? "" : $db->error );
        $db->close();

        $passed = 0;
        $failed = 0;

        if ($result == 1)
          $passed++;
        else
          $failed++;

        d([
          'sql' => $sql,
          'result' => $result,
          'error' => $error
        ]);

        return ['passed' => $passed, 'failed' => $failed];
 }



}


 ?>
