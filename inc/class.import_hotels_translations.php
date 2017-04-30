<?php

use \JsonCollectionParser\Parser as Parser;
use Unirest\Request as Request;

/**
 * ImportHotelsTranslations
 */
class ImportHotelsTranslations extends ImportHotels
{

  protected static function parserProcess($file = "") {

    if (empty($file))
      return;

      //$parser = new Parser();

      //$parser->parse($file, [get_called_class(), 'importToDB']);

      $file = json_decode(file_get_contents($file));

      $file = $file->results;

      $count = count($file);

      for ($i = 0; $i < $count; $i++)
        static::importToDB($file[$i]);

      return;

  }


  public static function importToDB($json = "") {


       $temp_data = (object) $json;

       $temp_data->code = (int) $temp_data->code;

         $db = DB::Connect();


         $code = $db->real_escape_string($temp_data->code);
         $master = $db->real_escape_string($temp_data->master);
         $name = $db->real_escape_string($temp_data->name);
         $country = $db->real_escape_string($temp_data->country);
         $zipcode = $db->real_escape_string($temp_data->zipcode);
         $regions = $db->real_escape_string($temp_data->regions[0]);
         $address = $db->real_escape_string($temp_data->address);
         $destination = $db->real_escape_string($temp_data->destination);
         $latitude = $db->real_escape_string($temp_data->latitude);
         $longitude = $db->real_escape_string($temp_data->longitude);
         $countrycode = $db->real_escape_string($temp_data->currencycode);
         $checkin_from = $db->real_escape_string($temp_data->checkin_from);
         $checkout_to = $db->real_escape_string($temp_data->checkout_to);
         $nr_rooms = $db->real_escape_string($temp_data->nr_rooms);
         $stars = $db->real_escape_string($temp_data->stars);
         $hotel_type = $db->real_escape_string($temp_data->hotel_type);

         $hotel_information = $db->real_escape_string($temp_data->descriptions['hotel_information']);
         $hotel_amenity = $db->real_escape_string($temp_data->descriptions['hotel_amenity']);
         $room_amenity = $db->real_escape_string($temp_data->descriptions['room_amenity']);
         $location_information = $db->real_escape_string($temp_data->descriptions['location_information']);
         $hotel_introduction = ( empty($temp_data->descriptions['hotel_introduction'] ? "none" : $db->real_escape_string($temp_data->descriptions['hotel_introduction']) ));

         $hotel_availability_score = ( empty($temp_data->availability_score) ? 0 : $db->real_escape_string($temp_data->availability_score) );

         $attraction_information = $db->real_escape_string($temp_data->descriptions['attraction_information']);

         $year_built = $db->real_escape_string($temp_data->year_built);
         $nr_restaurants = $db->real_escape_string($temp_data->nr_restaurants);
         $nr_bars = $db->real_escape_string($temp_data->nr_bars);
         $nr_halls = $db->real_escape_string($temp_data->nr_halls);
         $updated_at = $db->real_escape_string($temp_data->updated_at);

         $hotel_information = str_replace("'","&apos;",$hotel_information);
       	$hotel_amenity = str_replace("'","&apos;",$hotel_amenity);
       	$room_amenity = str_replace("'","&apos;",$room_amenity);
       	$location_information = str_replace("'","&apos;",$location_information);
       	$hotel_introduction = str_replace("'","&apos;",$hotel_introduction);
       	$attraction_information = str_replace("'","&apos;",$attraction_information);

         $sql = "INSERT INTO hotels VALUES('$code', '$master', '$destination', '$zipcode', '$latitude', '$longitude', '$countrycode', '$hotel_type', '$stars', '$hotel_availability_score', '$nr_rooms', '$nr_restaurants', '$nr_bars', '$nr_halls', '$year_built','$checkin_from','$checkout_to','','$updated_at')";
         //$result = $db->query($sql);
         $db->close();
         d($result);
         return;


  }


}


 ?>
