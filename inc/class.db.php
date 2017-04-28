<?php

/**
 * DB
 */
class DB
{

  function __construct()
  {
    # code...
  }

  public static function Connect() {


    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

    if ($conn->connect_error)
      return;

    return $conn;

  }



}


 ?>
