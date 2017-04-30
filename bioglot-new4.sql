-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 01, 2017 at 02:03 AM
-- Server version: 10.1.9-MariaDB
-- PHP Version: 5.6.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bioglot-new4`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookinglog`
--

CREATE TABLE `bookinglog` (
  `logid` bigint(20) NOT NULL,
  `logtime` datetime NOT NULL,
  `cust_fname` varchar(50) NOT NULL,
  `cust_lname` varchar(50) NOT NULL,
  `cust_email` varchar(50) NOT NULL,
  `cust_Phone` varchar(30) NOT NULL,
  `realex_orderID` varchar(50) NOT NULL,
  `amount` varchar(20) NOT NULL,
  `paymentStatus` varchar(5) NOT NULL,
  `hpTrackingID` varchar(30) NOT NULL,
  `hpReservationStatus` varchar(100) NOT NULL,
  `hpConfirmationNo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `chains`
--

CREATE TABLE `chains` (
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `continents`
--

CREATE TABLE `continents` (
  `code` varchar(10) NOT NULL,
  `CName` varchar(30) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `continents_translation`
--

CREATE TABLE `continents_translation` (
  `code` varchar(10) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `code` varchar(10) NOT NULL,
  `continents` varchar(3) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `countries_translation`
--

CREATE TABLE `countries_translation` (
  `code` varchar(10) NOT NULL,
  `LanguageCode` varchar(3) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `Code` varchar(10) NOT NULL,
  `Country` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `deleted_hotels`
--

CREATE TABLE `deleted_hotels` (
  `code` varchar(10) NOT NULL,
  `master` varchar(10) DEFAULT NULL,
  `destination` varchar(20) NOT NULL,
  `zip_code` varchar(20) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `currency_code` varchar(10) NOT NULL,
  `hotel_type` varchar(10) NOT NULL,
  `stars` int(10) NOT NULL,
  `availability_score` int(10) NOT NULL,
  `nr_rooms` int(10) NOT NULL,
  `nr_restaurants` int(10) NOT NULL,
  `nr_bars` int(10) NOT NULL,
  `nr_halls` int(10) NOT NULL,
  `Year_built` int(10) NOT NULL,
  `checkin_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checkout_to` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Chains` varchar(20) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `description`
--

CREATE TABLE `description` (
  `HotelId` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `description_translation`
--

CREATE TABLE `description_translation` (
  `HotelId` varchar(10) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `Hotel_Information` varchar(2000) NOT NULL,
  `Hotel_Introduction` varchar(2000) NOT NULL,
  `Location_Information` varchar(2000) NOT NULL,
  `Attraction_Infromation` varchar(2000) NOT NULL,
  `Hotel_Amenity` varchar(2000) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `code` varchar(100) NOT NULL,
  `parent` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country` varchar(10) NOT NULL,
  `regions` varchar(10) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `destination_translation`
--

CREATE TABLE `destination_translation` (
  `code` varchar(10) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilities`
--

CREATE TABLE `facilities` (
  `code` varchar(10) NOT NULL,
  `facility_type` varchar(10) NOT NULL,
  `category` varchar(10) NOT NULL,
  `scope` varchar(20) NOT NULL,
  `charge_free` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) DEFAULT NULL,
  `themes` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilities_scopes`
--

CREATE TABLE `facilities_scopes` (
  `code` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilities_themes`
--

CREATE TABLE `facilities_themes` (
  `code` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilities_themes_list`
--

CREATE TABLE `facilities_themes_list` (
  `FacilityId` varchar(10) NOT NULL,
  `ThemesId` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilities_translation`
--

CREATE TABLE `facilities_translation` (
  `code` varchar(10) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilities_types`
--

CREATE TABLE `facilities_types` (
  `code` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facilities_types_translation`
--

CREATE TABLE `facilities_types_translation` (
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facility-categories-translations`
--

CREATE TABLE `facility-categories-translations` (
  `language-country` varchar(3) NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `facility_categories`
--

CREATE TABLE `facility_categories` (
  `code` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `code` varchar(10) NOT NULL,
  `master` varchar(10) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `country` varchar(30) NOT NULL,
  `destination` varchar(20) NOT NULL,
  `zipcode` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `currencycode` varchar(10) NOT NULL,
  `hotel_type` varchar(10) NOT NULL,
  `stars` int(10) NOT NULL,
  `availability_score` int(10) NOT NULL,
  `nr_rooms` int(10) NOT NULL,
  `nr_restaurants` int(10) NOT NULL,
  `nr_bars` int(10) NOT NULL,
  `nr_halls` int(10) NOT NULL,
  `year_built` int(10) NOT NULL,
  `checkin_from` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checkout_to` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Chains` varchar(20) DEFAULT NULL,
  `hotel_information` text NOT NULL,
  `hotel_introduction` text NOT NULL,
  `location_information` text NOT NULL,
  `attraction_information` text NOT NULL,
  `hotel_amenity` text NOT NULL,
  `room_amenity` text NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotels_translation`
--

CREATE TABLE `hotels_translation` (
  `code` varchar(10) NOT NULL,
  `LanguageCode` varchar(3) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_facilities_list`
--

CREATE TABLE `hotel_facilities_list` (
  `HotelId` varchar(10) NOT NULL,
  `FacilityId` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_region_list`
--

CREATE TABLE `hotel_region_list` (
  `HotelId` varchar(10) NOT NULL,
  `RegionCode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_themes`
--

CREATE TABLE `hotel_themes` (
  `code` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_themes_list`
--

CREATE TABLE `hotel_themes_list` (
  `HotelId` varchar(10) NOT NULL,
  `ThemesCode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_themes_translation`
--

CREATE TABLE `hotel_themes_translation` (
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_types`
--

CREATE TABLE `hotel_types` (
  `code` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hotel_types_translation`
--

CREATE TABLE `hotel_types_translation` (
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `image-categories-translations`
--

CREATE TABLE `image-categories-translations` (
  `language-country` varchar(3) NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `HotelId` varchar(10) NOT NULL,
  `ImageId` int(11) NOT NULL,
  `category` varchar(200) NOT NULL,
  `tag` varchar(200) NOT NULL,
  `original` varchar(200) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `image_categories`
--

CREATE TABLE `image_categories` (
  `code` varchar(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `language_tags`
--

CREATE TABLE `language_tags` (
  `Id` int(10) NOT NULL,
  `LanguageName` varchar(100) NOT NULL,
  `Code` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `masterhotels`
--

CREATE TABLE `masterhotels` (
  `code` varchar(10) NOT NULL,
  `master` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `meal_types`
--

CREATE TABLE `meal_types` (
  `code` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `score` varchar(3) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `meal_types_translation`
--

CREATE TABLE `meal_types_translation` (
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `code` varchar(10) NOT NULL,
  `country` varchar(10) NOT NULL,
  `kind` varchar(20) NOT NULL,
  `name` varchar(40) NOT NULL,
  `state_code` varchar(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `regions_translation`
--

CREATE TABLE `regions_translation` (
  `code` varchar(10) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `state_code` varchar(20) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `room_types`
--

CREATE TABLE `room_types` (
  `code` varchar(5) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quantity` varchar(2) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `room_types_translation`
--

CREATE TABLE `room_types_translation` (
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `LanguageCode` varchar(10) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `thumbnail_image`
--

CREATE TABLE `thumbnail_image` (
  `ImageId` int(10) NOT NULL,
  `large` varchar(200) NOT NULL,
  `small` varchar(200) NOT NULL,
  `mid` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookinglog`
--
ALTER TABLE `bookinglog`
  ADD PRIMARY KEY (`logid`);

--
-- Indexes for table `chains`
--
ALTER TABLE `chains`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `continents`
--
ALTER TABLE `continents`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `continents_translation`
--
ALTER TABLE `continents_translation`
  ADD KEY `code` (`code`),
  ADD KEY `LanguageCode` (`LanguageCode`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`code`),
  ADD KEY `continents` (`continents`);

--
-- Indexes for table `countries_translation`
--
ALTER TABLE `countries_translation`
  ADD KEY `code` (`code`),
  ADD KEY `LanguageCode` (`LanguageCode`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`Code`);

--
-- Indexes for table `deleted_hotels`
--
ALTER TABLE `deleted_hotels`
  ADD PRIMARY KEY (`code`),
  ADD KEY `destination` (`destination`),
  ADD KEY `hotel_type` (`hotel_type`);

--
-- Indexes for table `description`
--
ALTER TABLE `description`
  ADD KEY `HotelId` (`HotelId`);

--
-- Indexes for table `description_translation`
--
ALTER TABLE `description_translation`
  ADD KEY `HotelId` (`HotelId`),
  ADD KEY `LanguageCode` (`LanguageCode`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`code`),
  ADD KEY `country` (`country`),
  ADD KEY `regions` (`regions`),
  ADD KEY `parent` (`parent`);

--
-- Indexes for table `destination_translation`
--
ALTER TABLE `destination_translation`
  ADD KEY `qqqq` (`LanguageCode`) USING BTREE,
  ADD KEY `code` (`code`) USING BTREE,
  ADD KEY `code_3` (`code`) USING BTREE;

--
-- Indexes for table `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`code`),
  ADD KEY `facility_type` (`facility_type`),
  ADD KEY `category` (`category`),
  ADD KEY `scope` (`scope`);

--
-- Indexes for table `facilities_scopes`
--
ALTER TABLE `facilities_scopes`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `facilities_themes`
--
ALTER TABLE `facilities_themes`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `facilities_themes_list`
--
ALTER TABLE `facilities_themes_list`
  ADD KEY `FacilityId` (`FacilityId`),
  ADD KEY `ThemesId` (`ThemesId`);

--
-- Indexes for table `facilities_translation`
--
ALTER TABLE `facilities_translation`
  ADD KEY `code` (`code`),
  ADD KEY `wers` (`LanguageCode`) USING BTREE;

--
-- Indexes for table `facilities_types`
--
ALTER TABLE `facilities_types`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `facilities_types_translation`
--
ALTER TABLE `facilities_types_translation`
  ADD KEY `code` (`code`),
  ADD KEY `qqwa` (`LanguageCode`) USING BTREE;

--
-- Indexes for table `facility-categories-translations`
--
ALTER TABLE `facility-categories-translations`
  ADD KEY `code` (`code`);

--
-- Indexes for table `facility_categories`
--
ALTER TABLE `facility_categories`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`code`),
  ADD KEY `destination` (`destination`),
  ADD KEY `hotel_type` (`hotel_type`);

--
-- Indexes for table `hotels_translation`
--
ALTER TABLE `hotels_translation`
  ADD KEY `code` (`code`) USING BTREE,
  ADD KEY `ax` (`LanguageCode`) USING BTREE;

--
-- Indexes for table `hotel_facilities_list`
--
ALTER TABLE `hotel_facilities_list`
  ADD KEY `HotelId` (`HotelId`);

--
-- Indexes for table `hotel_region_list`
--
ALTER TABLE `hotel_region_list`
  ADD KEY `HotelId` (`HotelId`);

--
-- Indexes for table `hotel_themes`
--
ALTER TABLE `hotel_themes`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `hotel_themes_list`
--
ALTER TABLE `hotel_themes_list`
  ADD KEY `HotelId` (`HotelId`);

--
-- Indexes for table `hotel_themes_translation`
--
ALTER TABLE `hotel_themes_translation`
  ADD KEY `code` (`code`) USING BTREE,
  ADD KEY `fx` (`LanguageCode`) USING BTREE;

--
-- Indexes for table `hotel_types`
--
ALTER TABLE `hotel_types`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `hotel_types_translation`
--
ALTER TABLE `hotel_types_translation`
  ADD KEY `code` (`code`),
  ADD KEY `LanguageCode` (`LanguageCode`);

--
-- Indexes for table `image-categories-translations`
--
ALTER TABLE `image-categories-translations`
  ADD KEY `code` (`code`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`ImageId`),
  ADD KEY `HotelId` (`HotelId`);

--
-- Indexes for table `image_categories`
--
ALTER TABLE `image_categories`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `language_tags`
--
ALTER TABLE `language_tags`
  ADD PRIMARY KEY (`Code`);

--
-- Indexes for table `meal_types`
--
ALTER TABLE `meal_types`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `meal_types_translation`
--
ALTER TABLE `meal_types_translation`
  ADD KEY `code` (`code`),
  ADD KEY `LanguageCode` (`LanguageCode`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`code`),
  ADD KEY `country` (`country`);

--
-- Indexes for table `regions_translation`
--
ALTER TABLE `regions_translation`
  ADD KEY `code` (`code`),
  ADD KEY `LanguageCode` (`LanguageCode`);

--
-- Indexes for table `room_types`
--
ALTER TABLE `room_types`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `room_types_translation`
--
ALTER TABLE `room_types_translation`
  ADD KEY `code` (`code`),
  ADD KEY `LanguageCode` (`LanguageCode`);

--
-- Indexes for table `thumbnail_image`
--
ALTER TABLE `thumbnail_image`
  ADD KEY `ImageId` (`ImageId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookinglog`
--
ALTER TABLE `bookinglog`
  MODIFY `logid` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `ImageId` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `continents_translation`
--
ALTER TABLE `continents_translation`
  ADD CONSTRAINT `Code` FOREIGN KEY (`code`) REFERENCES `continents` (`code`),
  ADD CONSTRAINT `Language` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `countries`
--
ALTER TABLE `countries`
  ADD CONSTRAINT `Cont` FOREIGN KEY (`continents`) REFERENCES `continents` (`code`);

--
-- Constraints for table `countries_translation`
--
ALTER TABLE `countries_translation`
  ADD CONSTRAINT `ee` FOREIGN KEY (`code`) REFERENCES `countries` (`code`),
  ADD CONSTRAINT `fs` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `description`
--
ALTER TABLE `description`
  ADD CONSTRAINT `HotelId` FOREIGN KEY (`HotelId`) REFERENCES `hotels` (`code`);

--
-- Constraints for table `description_translation`
--
ALTER TABLE `description_translation`
  ADD CONSTRAINT `d` FOREIGN KEY (`HotelId`) REFERENCES `hotels_translation` (`code`),
  ADD CONSTRAINT `ds` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`);

--
-- Constraints for table `destinations`
--
ALTER TABLE `destinations`
  ADD CONSTRAINT `C` FOREIGN KEY (`country`) REFERENCES `countries` (`code`),
  ADD CONSTRAINT `Region` FOREIGN KEY (`regions`) REFERENCES `regions` (`code`);

--
-- Constraints for table `destination_translation`
--
ALTER TABLE `destination_translation`
  ADD CONSTRAINT `DCode` FOREIGN KEY (`code`) REFERENCES `destinations` (`code`),
  ADD CONSTRAINT `ww` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`);

--
-- Constraints for table `facilities`
--
ALTER TABLE `facilities`
  ADD CONSTRAINT `FacilitiesCategories` FOREIGN KEY (`category`) REFERENCES `facility_categories` (`code`),
  ADD CONSTRAINT `FacilitiesScope` FOREIGN KEY (`scope`) REFERENCES `facilities_scopes` (`code`),
  ADD CONSTRAINT `FacilitiesType` FOREIGN KEY (`facility_type`) REFERENCES `facilities_types` (`code`);

--
-- Constraints for table `facilities_themes_list`
--
ALTER TABLE `facilities_themes_list`
  ADD CONSTRAINT `eeew` FOREIGN KEY (`ThemesId`) REFERENCES `facilities_themes` (`code`),
  ADD CONSTRAINT `ffe` FOREIGN KEY (`FacilityId`) REFERENCES `facilities` (`code`);

--
-- Constraints for table `facilities_translation`
--
ALTER TABLE `facilities_translation`
  ADD CONSTRAINT `FCode` FOREIGN KEY (`code`) REFERENCES `facilities` (`code`);

--
-- Constraints for table `facilities_types_translation`
--
ALTER TABLE `facilities_types_translation`
  ADD CONSTRAINT `FCS` FOREIGN KEY (`code`) REFERENCES `facilities_types` (`code`);

--
-- Constraints for table `facility-categories-translations`
--
ALTER TABLE `facility-categories-translations`
  ADD CONSTRAINT `facility-categories-translations_ibfk_1` FOREIGN KEY (`code`) REFERENCES `facility_categories` (`code`);

--
-- Constraints for table `hotels_translation`
--
ALTER TABLE `hotels_translation`
  ADD CONSTRAINT `HLn` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`),
  ADD CONSTRAINT `HotelCode` FOREIGN KEY (`code`) REFERENCES `hotels` (`code`);

--
-- Constraints for table `hotel_facilities_list`
--
ALTER TABLE `hotel_facilities_list`
  ADD CONSTRAINT `e` FOREIGN KEY (`HotelId`) REFERENCES `hotels` (`code`);

--
-- Constraints for table `hotel_region_list`
--
ALTER TABLE `hotel_region_list`
  ADD CONSTRAINT `sss` FOREIGN KEY (`HotelId`) REFERENCES `hotels` (`code`);

--
-- Constraints for table `hotel_themes_list`
--
ALTER TABLE `hotel_themes_list`
  ADD CONSTRAINT `w` FOREIGN KEY (`HotelId`) REFERENCES `hotels` (`code`);

--
-- Constraints for table `hotel_themes_translation`
--
ALTER TABLE `hotel_themes_translation`
  ADD CONSTRAINT `HTCode` FOREIGN KEY (`code`) REFERENCES `hotel_themes` (`code`);

--
-- Constraints for table `hotel_types_translation`
--
ALTER TABLE `hotel_types_translation`
  ADD CONSTRAINT `fa` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`),
  ADD CONSTRAINT `ff` FOREIGN KEY (`code`) REFERENCES `hotel_types` (`code`);

--
-- Constraints for table `image-categories-translations`
--
ALTER TABLE `image-categories-translations`
  ADD CONSTRAINT `image-categories-translations_ibfk_1` FOREIGN KEY (`code`) REFERENCES `image_categories` (`code`);

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `H` FOREIGN KEY (`HotelId`) REFERENCES `hotels` (`code`);

--
-- Constraints for table `meal_types_translation`
--
ALTER TABLE `meal_types_translation`
  ADD CONSTRAINT `Meal` FOREIGN KEY (`code`) REFERENCES `meal_types` (`code`),
  ADD CONSTRAINT `MealLn` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`);

--
-- Constraints for table `regions`
--
ALTER TABLE `regions`
  ADD CONSTRAINT `Country` FOREIGN KEY (`country`) REFERENCES `countries` (`code`);

--
-- Constraints for table `regions_translation`
--
ALTER TABLE `regions_translation`
  ADD CONSTRAINT `RCode` FOREIGN KEY (`code`) REFERENCES `regions` (`code`),
  ADD CONSTRAINT `RLN` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`);

--
-- Constraints for table `room_types_translation`
--
ALTER TABLE `room_types_translation`
  ADD CONSTRAINT `RTCode` FOREIGN KEY (`code`) REFERENCES `room_types` (`code`),
  ADD CONSTRAINT `RTLn` FOREIGN KEY (`LanguageCode`) REFERENCES `language_tags` (`Code`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
