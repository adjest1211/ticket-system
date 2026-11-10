-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2026 at 08:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `recipe_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `dish`
--

CREATE TABLE `dish` (
  `dishID` int(11) NOT NULL,
  `dishName` varchar(100) NOT NULL,
  `dcategoryID` int(100) NOT NULL,
  `dishImage` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dish`
--

INSERT INTO `dish` (`dishID`, `dishName`, `dcategoryID`, `dishImage`) VALUES
(1, 'Chicken Adobo', 1, ''),
(2, 'Pork Adobo', 1, ''),
(3, 'Kare-kare', 1, ''),
(4, 'Kaldereta', 1, ''),
(5, 'Mechado', 1, ''),
(6, 'Afritada', 1, ''),
(7, 'Bicol Express', 1, ''),
(8, 'Laing', 1, ''),
(9, 'Humba', 1, ''),
(10, 'Igado', 1, ''),
(11, 'Sinigang', 2, ''),
(12, 'Nilaga', 2, ''),
(13, 'Tinola', 2, ''),
(14, 'Bulalo', 2, ''),
(15, 'Sinampalukang Manok', 2, ''),
(16, 'Papaitan', 2, ''),
(17, 'Spaghetti', 3, ''),
(18, 'Carbonara', 3, ''),
(19, 'Baked Macaroni', 3, ''),
(20, 'Palabok', 3, ''),
(21, 'Malabon', 3, ''),
(22, 'Sotanghon Guisado', 3, ''),
(23, 'Pancit Bihon', 3, ''),
(24, 'Pancit Canton', 3, ''),
(25, 'Pancit Lomi', 3, ''),
(26, 'Inihaw na Liempo', 4, ''),
(27, 'Chicken Inasal', 4, ''),
(28, 'Lechon', 4, ''),
(29, 'Pork Barbeque', 4, ''),
(30, 'Lechon Kawali', 6, ''),
(31, 'Fried Chicken', 6, ''),
(32, 'Tokwa\'t Baboy', 6, ''),
(33, 'Crispy Pata', 6, ''),
(34, 'Daing na Bangus', 6, ''),
(35, 'Sisig', 1, ''),
(36, 'Lumpiang Shanghai', 5, ''),
(37, 'Lumpiang Sariwa', 5, ''),
(38, 'Kinilaw', 1, ''),
(39, 'Kwek-kwek', 5, ''),
(40, 'Calamares', 5, ''),
(41, 'Bibingka', 5, ''),
(42, 'Puto', 5, ''),
(43, 'Biko', 5, ''),
(44, 'Suman', 5, ''),
(45, 'Sapin-sapin', 5, ''),
(46, 'Pichi-pichi', 5, ''),
(47, 'Kutsinta', 5, ''),
(48, 'Maja Blanca', 5, ''),
(49, 'Halo-halo', 5, ''),
(50, 'Lechec Flan', 5, ''),
(51, 'Ube Halaya', 5, ''),
(52, 'Turon', 5, ''),
(53, 'Buko Pandan', 5, ''),
(54, 'Mango Float', 5, ''),
(55, 'Coffee Jelly', 5, ''),
(56, 'Fruit Salad', 5, ''),
(57, 'Menudo', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `dishcategory`
--

CREATE TABLE `dishcategory` (
  `dcategoryID` int(11) NOT NULL,
  `dcategoryName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dishcategory`
--

INSERT INTO `dishcategory` (`dcategoryID`, `dcategoryName`) VALUES
(1, 'Main Dish'),
(2, 'Soup'),
(3, 'Pasta/Noodles'),
(4, 'Grilled/Roasted'),
(5, 'Snacks/Dessert'),
(6, 'Fried');

-- --------------------------------------------------------

--
-- Table structure for table `icategory`
--

CREATE TABLE `icategory` (
  `icategoryID` int(11) NOT NULL,
  `icategoryName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `icategory`
--

INSERT INTO `icategory` (`icategoryID`, `icategoryName`) VALUES
(1, 'Meat & Offal\r\n'),
(2, 'Poultry\r\n'),
(3, 'Fish\r\n'),
(4, 'Seafood & Shellfish\r\n'),
(5, 'Vegetables\r\n'),
(6, 'Fruits\r\n'),
(7, 'Herbs & Spices\r\n'),
(8, 'Aromatics\r\n'),
(9, 'Grains & Rice\r\n'),
(10, 'Noodles & Pasta\r\n'),
(11, 'Flour & Baking\r\n'),
(12, 'Dairy & Cream\r\n'),
(13, 'Eggs'),
(14, 'Beans & Legumes'),
(15, 'Nuts & Seeds'),
(16, 'Oils & Fats'),
(17, 'Sauces & Condiments'),
(18, 'Sweeteners'),
(19, 'Preserved & Prepared'),
(20, 'Liquids, Bases & Flavorings');

-- --------------------------------------------------------

--
-- Table structure for table `ingredientneeds`
--

CREATE TABLE `ingredientneeds` (
  `dishID` int(11) NOT NULL,
  `ingredientID` int(11) NOT NULL,
  `quantity` varchar(100) NOT NULL,
  `unit` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredientneeds`
--

INSERT INTO `ingredientneeds` (`dishID`, `ingredientID`, `quantity`, `unit`) VALUES
(1, 20, '1', 'kg'),
(1, 202, '1/2', 'cup'),
(1, 235, '1', 'cup'),
(1, 203, '1/2', 'cup'),
(1, 107, '1', 'bulb'),
(1, 109, '1', 'bulb'),
(1, 97, '3', 'pcs'),
(1, 98, '1', 'tsp'),
(1, 200, '1', 'tbsp'),
(1, 215, '1', 'tsp'),
(2, 9, '1', 'kg'),
(2, 202, '1/2', 'cup'),
(2, 203, '1/2', 'cup'),
(2, 235, '1', 'cup'),
(2, 107, '1', 'bulb'),
(2, 109, '1', 'bulb'),
(2, 97, '3', 'pcs'),
(2, 98, '1', 'tsp'),
(2, 200, '1', 'tbsp'),
(3, 4, '1', 'kg'),
(3, 196, '1/2', 'cup'),
(3, 195, '1/2', 'cup'),
(3, 59, '1', 'kg'),
(3, 56, '1', 'bunch'),
(3, 73, '1', 'bunch'),
(3, 58, '2', 'pcs'),
(3, 117, '1/2', 'cup'),
(3, 109, '1', 'bulb'),
(3, 107, '4', 'cloves'),
(3, 235, '6', 'cups'),
(3, 101, 'Add according to your preference.', 'null'),
(3, 103, '1/2', 'tsp'),
(3, 100, '1/4', 'tsp'),
(3, 204, '2', 'tbsp'),
(4, 1, '1', 'kg'),
(4, 208, '1', 'cup'),
(4, 60, '2', 'pcs'),
(4, 61, '2', 'pcs'),
(4, 62, '1', 'pc'),
(4, 100, '1', 'pc'),
(4, 109, '1', 'bulb'),
(4, 107, '5', 'cloves'),
(4, 210, '1/2', 'cup'),
(4, 235, '3', 'cups'),
(4, 200, '2', 'tbsp'),
(4, 103, '2', 'tsp'),
(5, 1, '1', 'kg'),
(5, 208, '1', 'cup'),
(5, 202, '1/4', 'cup'),
(5, 84, '1/4', 'cup'),
(5, 60, '2', 'pcs'),
(5, 61, '2', 'pcs'),
(5, 109, '1', 'bulb'),
(5, 107, '5', 'cloves'),
(5, 235, '3', 'cups'),
(5, 97, '2', 'pcs'),
(5, 200, '2', 'tbsp'),
(5, 103, '2', 'tsp'),
(5, 100, '2', 'tsp'),
(6, 20, '1', 'kg'),
(6, 208, '1', 'cup'),
(6, 60, '2', 'pcs'),
(6, 61, '2', 'pcs'),
(6, 62, '1', 'pc'),
(6, 109, '1', 'pc'),
(6, 107, '5', 'cloves'),
(6, 235, '2', 'cups'),
(6, 200, '2', 'tbsp'),
(6, 103, '1', 'tsp'),
(6, 100, '1/2', 'tsp'),
(7, 9, '1', 'kg'),
(7, 240, '2', 'cups'),
(7, 241, '1', 'cup'),
(7, 104, '1', 'cup'),
(7, 205, '1/4', 'cup'),
(7, 109, '1', 'bulb'),
(7, 107, '5', 'gloves'),
(7, 111, '1', 'tbsp'),
(7, 200, '2', 'tbsp'),
(7, 103, '1', 'tsp'),
(7, 100, '1/2', 'tsp'),
(8, 64, '100', 'grams'),
(8, 240, '2', 'cups'),
(8, 241, '1', 'cup'),
(8, 8, '1/2', 'cup (optional)'),
(8, 109, '1', 'bulb'),
(8, 107, '5', 'gloves'),
(8, 111, '1 ', 'tbsp'),
(8, 205, '2', 'tbsp'),
(8, 105, '3-5', 'pcs'),
(8, 103, '1/2', 'tsp'),
(9, 9, '1', 'kg'),
(9, 202, '1/2', 'cup'),
(9, 203, '1/2', 'cup'),
(9, 216, '1/2', 'cup'),
(9, 235, '1', 'cup'),
(9, 85, '1/2', 'cup'),
(9, 191, '1/4', 'cup'),
(9, 109, '1', 'bulb'),
(9, 107, '5', 'gloves'),
(9, 97, '3', 'pcs'),
(9, 98, '1', 'tsp'),
(9, 59, '1/2', 'cup'),
(10, 253, '1/2', 'kg'),
(10, 15, '1/2', 'kg'),
(10, 202, '1/4', 'cup'),
(10, 203, '1/4', 'cup'),
(10, 235, '1', 'cup'),
(10, 109, '1', 'bulb'),
(10, 107, '5', 'gloves'),
(10, 62, '1', 'pc'),
(10, 63, '1/2', 'cup'),
(10, 97, '2', 'pcs'),
(10, 200, '2', 'tbsp'),
(10, 103, '1/2', 'tsp'),
(10, 99, '1/2', 'tsp'),
(11, 19, '1', 'kg'),
(11, 213, '1', 'pack'),
(11, 65, '1', 'pc'),
(11, 77, '2', 'pcs'),
(11, 109, '1', 'bulb'),
(11, 58, '1', 'pc'),
(11, 66, '1', 'bunch'),
(11, 235, '8', 'cups'),
(11, 67, '5', 'pcs'),
(11, 104, '2', 'pcs'),
(11, 207, '2', 'tbsp'),
(12, 10, '1', 'kg'),
(12, 60, '3', 'pcs'),
(12, 68, '1', 'pc'),
(12, 75, '2', 'pcs'),
(12, 109, '1', 'bulb'),
(12, 98, '1', 'tsp'),
(12, 235, '8', 'cups'),
(12, 207, '2', 'tbsp'),
(12, 56, '2', 'bunches'),
(13, 41, '1', 'kg'),
(13, 69, '1', 'pc'),
(13, 70, '2', 'cups'),
(13, 109, '1', 'bulb'),
(13, 107, '5', 'cloves'),
(13, 111, '2', 'tbsp'),
(13, 235, '6', 'cups'),
(13, 207, '2', 'tbsp'),
(13, 200, '2', 'tbsp'),
(13, 99, '1', 'tbsp'),
(14, 3, '1', 'kg'),
(14, 75, '2', 'pcs'),
(14, 60, '2', 'pcs'),
(14, 68, '1', 'pc'),
(14, 56, '2', 'bunches'),
(14, 109, '1', 'bulb'),
(14, 98, '1', 'tbsp'),
(14, 235, '9', 'cups'),
(14, 207, '2', 'tbsp'),
(15, 20, '1', 'kg'),
(15, 242, '1', 'cup'),
(15, 213, '1', 'pack'),
(15, 109, '1', 'bulb'),
(15, 107, '5', 'cloves'),
(15, 111, '1', 'tbsp'),
(15, 77, '2', 'pcs'),
(15, 235, '6', 'cups'),
(15, 207, '2', 'tbsp'),
(15, 200, '2', 'tbsp'),
(16, 6, '1/2', 'kg'),
(16, 254, '1/2', 'kg'),
(16, 1, '1/2', 'kg'),
(16, 109, '1', 'bulb'),
(16, 107, '5', 'cloves'),
(16, 111, '2', 'tbsp'),
(16, 207, '3', 'tbsp'),
(16, 200, '2', 'tbsp'),
(16, 18, '2', 'tbsp'),
(16, 235, '6', 'cups'),
(16, 104, '3', 'pcs'),
(16, 103, '2', 'tsp'),
(16, 100, '2', 'tsp'),
(17, 120, '1', 'kg'),
(17, 12, '500', 'grams'),
(17, 218, '7', 'pcs'),
(17, 255, '1', 'kg'),
(17, 208, '1', 'cup'),
(17, 109, '1', ' bulb'),
(17, 107, '5', 'cloves'),
(17, 180, '1', 'cup'),
(17, 200, '2', 'tbsp'),
(17, 215, '1', 'tbsp'),
(17, 103, '1', 'tsp'),
(17, 100, '2', 'tsp'),
(18, 121, '500', 'grams'),
(18, 219, '250', 'grams'),
(18, 183, '1', 'pack'),
(18, 178, '1', 'cup'),
(18, 180, '1', 'cup'),
(18, 109, '1', 'bulb'),
(18, 107, '4', 'cloves'),
(18, 182, '2', 'tbsp'),
(18, 103, '1', 'tsp'),
(18, 100, '2', 'tsp'),
(18, 256, '1', 'cup');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `ingredientID` int(11) NOT NULL,
  `ingredientName` varchar(100) NOT NULL,
  `icategoryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`ingredientID`, `ingredientName`, `icategoryID`) VALUES
(1, 'Beef\r\n', 1),
(2, 'Beef shank\r\n', 1),
(3, 'Beef shank with bone marrow\r\n', 1),
(4, 'Oxtail\r\n', 1),
(5, 'Ground beef\r\n', 1),
(6, 'Beef tripe\r\n', 1),
(7, 'Beef liver\r\n', 1),
(8, 'Pork\r\n', 1),
(9, 'Pork belly\r\n', 1),
(10, 'Pork belly slices\r\n', 1),
(11, 'Pork loin\r\n', 1),
(12, 'Ground pork\r\n', 1),
(13, 'Pork leg\r\n', 1),
(14, 'Pork maskara\r\n', 1),
(15, 'Pork liver\r\n', 1),
(16, 'Whole dressed pig\r\n', 1),
(17, 'Chicken or pork intestines\r\n', 1),
(18, 'Bile\r\n', 1),
(19, 'Pork ribs\r\n', 1),
(20, 'Chicken\r\n', 2),
(41, 'Chicken pieces\r\n', 2),
(42, 'Chicken leg quarters\r\n', 2),
(43, 'Chicken liver\r\n', 2),
(44, 'Duck\r\n', 2),
(45, 'Bangus\r\n', 3),
(46, 'Tuna\r\n', 3),
(47, 'Tanigue\r\n', 3),
(48, 'Smoked fish flakes\r\n', 3),
(49, 'Tilapia\r\n', 3),
(50, 'Galunggong\r\n', 3),
(51, 'Shrimp\r\n', 4),
(52, 'Squid\r\n', 4),
(53, 'Squid rings\r\n', 4),
(54, 'Crab\r\n', 4),
(55, 'Mussels\r\n', 4),
(56, 'Pechay\r\n', 5),
(57, 'Sitaw\r\n', 5),
(58, 'Eggplant\r\n', 5),
(59, 'Banana heart\r\n', 5),
(60, 'Potato\r\n', 5),
(61, 'Carrot\r\n', 5),
(62, 'Red bell pepper\r\n', 5),
(63, 'Green peas\r\n', 5),
(64, 'Dried taro leaves\r\n', 5),
(65, 'Radish\r\n', 5),
(66, 'Kangkong\r\n', 5),
(67, 'Okra\r\n', 5),
(68, 'Cabbage\r\n', 5),
(69, 'Green papaya\r\n', 5),
(70, 'Malunggay leaves\r\n', 5),
(71, 'Celery\r\n', 5),
(72, 'Sweet potato\r\n', 5),
(73, 'Green beans\r\n', 5),
(74, 'Cucumber\r\n', 5),
(75, 'Corn cobs\r\n', 5),
(76, 'Corn kernels\r\n', 5),
(77, 'Tomato\r\n', 5),
(78, 'Cassava\r\n', 5),
(79, 'Purple yam (ube)\r\n', 5),
(80, 'Sayote\r\n', 5),
(81, 'Ampalaya\r\n', 5),
(82, 'Squash\r\n', 5),
(83, 'Calamansi\r\n', 6),
(84, 'Calamansi juice\r\n', 6),
(85, 'Pineapple juice\r\n', 6),
(86, 'Raisins\r\n', 6),
(87, 'Green mango\r\n', 6),
(88, 'Langka strips\r\n', 6),
(89, 'Jackfruit strips\r\n', 6),
(90, 'Sweetened jackfruit\r\n', 6),
(91, 'Saba banana\r\n', 6),
(92, 'Sweetened banana\r\n', 6),
(93, 'Ripe mango slices\r\n', 6),
(94, 'Young coconut strips\r\n', 6),
(95, 'Grated coconut\r\n', 6),
(96, 'Lemon\r\n', 6),
(97, 'Bay leaves\r\n', 7),
(98, 'Peppercorns\r\n', 7),
(99, 'Black pepper\r\n', 7),
(100, 'Pepper\r\n', 7),
(101, 'Annatto powder\r\n', 7),
(102, 'Garlic powder\r\n', 7),
(103, 'Salt\r\n', 7),
(104, 'Green chilies\r\n', 7),
(105, 'Red chilies\r\n', 7),
(106, 'Cinnamon\r\n', 7),
(107, 'Garlic\r\n', 8),
(108, 'Toasted garlic\r\n', 8),
(109, 'Onion\r\n', 8),
(110, 'Red onion\r\n', 8),
(111, 'Ginger\r\n', 8),
(112, 'Lemongrass\r\n', 8),
(113, 'Spring onion\r\n', 8),
(114, 'Rice\r\n', 9),
(115, 'Cooked rice\r\n', 9),
(116, 'Glutinous rice\r\n', 9),
(117, 'Ground toasted rice\r\n', 9),
(118, 'Pinipig\r\n', 9),
(119, 'Brown rice\r\n', 9),
(120, 'Spaghetti pasta\r\n', 10),
(121, 'Pasta\r\n', 10),
(122, 'Elbow macaroni\r\n', 10),
(123, 'Palabok noodles\r\n', 10),
(124, 'Thick rice noodles\r\n', 10),
(125, 'Sotanghon noodles\r\n', 10),
(126, 'Bihon noodles\r\n', 10),
(167, 'Pancit canton noodles\r\n', 10),
(168, 'Thick lomi noodles\r\n', 10),
(169, 'Misua noodles\r\n', 10),
(170, 'Flour\r\n', 11),
(171, 'All-purpose flour\r\n', 11),
(172, 'Rice flour\r\n', 11),
(173, 'Glutinous rice flour\r\n', 11),
(174, 'Cornstarch\r\n', 11),
(175, 'Baking powder\r\n', 11),
(176, 'Yeast\r\n', 11),
(177, 'Milk\r\n', 12),
(178, 'Evaporated milk\r\n', 12),
(179, 'Condensed milk\r\n', 12),
(180, 'Grated cheese\r\n', 12),
(181, 'Cheese cubes\r\n', 12),
(182, 'Butter\r\n', 12),
(183, 'All-purpose cream\r\n', 12),
(184, 'Ube ice cream\r\n', 12),
(185, 'Fresh cream\r\n', 12),
(186, 'Egg\r\n', 13),
(187, 'Boiled egg\r\n', 13),
(188, 'Quail eggs\r\n', 13),
(189, 'Salted egg\r\n', 13),
(190, 'Egg yolks\r\n', 13),
(191, 'Fermented black beans\r\n', 14),
(192, 'Red beans\r\n', 14),
(193, 'Monggo beans\r\n', 14),
(194, 'Chickpeas\r\n', 14),
(195, 'Peanuts\r\n', 15),
(196, 'Peanut butter\r\n', 15),
(197, 'Sesame seeds\r\n', 15),
(198, 'Oil\r\n', 16),
(199, 'Annatto oil\r\n', 16),
(200, 'Cooking oil\r\n', 16),
(201, 'Coconut oil\r\n', 16),
(202, 'Soy sauce\r\n', 17),
(203, 'Vinegar\r\n', 17),
(204, 'Bagoong\r\n', 17),
(205, 'Shrimp paste\r\n', 17),
(206, 'Bagoong alamang\r\n', 17),
(207, 'Fish sauce\r\n', 17),
(208, 'Tomato sauce\r\n', 17),
(209, 'Banana ketchup\r\n', 17),
(210, 'Liver spread\r\n', 17),
(211, 'Green olives\r\n', 17),
(212, 'Mayonnaise\r\n', 17),
(213, 'Tamarind soup mix\r\n', 17),
(214, 'Oyster sauce\r\n', 17),
(215, 'Sugar\r\n', 18),
(216, 'Brown sugar\r\n', 18),
(217, 'Honey\r\n', 18),
(218, 'Hotdogs\r\n', 19),
(219, 'Bacon\r\n', 19),
(220, 'Chicharon\r\n', 19),
(221, 'Tofu\r\n', 19),
(222, 'Lumpia wrappers\r\n', 19),
(223, 'Fresh lumpia wrappers\r\n', 19),
(224, 'Ube halaya\r\n', 19),
(225, 'Latik\r\n', 19),
(226, 'Nata de coco\r\n', 19),
(227, 'Kaong\r\n', 19),
(228, 'Leche flan\r\n', 19),
(229, 'Graham crackers\r\n', 19),
(230, 'Crushed graham\r\n', 19),
(231, 'Fruit cocktail\r\n', 19),
(232, 'Pandan-flavored gulaman\r\n', 19),
(233, 'Unflavored gulaman\r\n', 19),
(234, 'Canned sardines\r\n', 19),
(235, 'Water\r\n', 20),
(236, 'Broth\r\n', 20),
(237, 'Chicken broth\r\n', 20),
(238, 'Shrimp broth\r\n', 20),
(239, 'Seafood broth\r\n', 20),
(240, 'Coconut milk\r\n', 20),
(241, 'Coconut cream\r\n', 20),
(242, 'Young tamarind leaves\r\n', 20),
(243, 'Banana leaves\r\n', 20),
(244, 'Cocoa powder\r\n', 20),
(245, 'Lye water\r\n', 20),
(246, 'Ube flavoring\r\n', 20),
(247, 'Pandan flavoring\r\n', 20),
(248, 'Pandan extract\r\n', 20),
(249, 'Vanilla\r\n', 20),
(250, 'Instant coffee\r\n', 20),
(251, 'Shaved ice\r\n', 20),
(252, 'Tamarind\r\n', 20),
(253, 'Pork tenderloin', 1),
(254, 'Beef intestine', 1),
(255, 'Spaghetti sauce', 17),
(256, 'Mushroom', 5);

-- --------------------------------------------------------

--
-- Table structure for table `instruction`
--

CREATE TABLE `instruction` (
  `instructionID` int(11) NOT NULL,
  `dishID` int(11) NOT NULL,
  `stepNumber` int(11) NOT NULL,
  `instruction` varchar(512) NOT NULL,
  `stepPicture` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instruction`
--

INSERT INTO `instruction` (`instructionID`, `dishID`, `stepNumber`, `instruction`, `stepPicture`) VALUES
(1, 1, 1, 'Combine chicken, soy sauce, garlic, and peppercorns in a bowl. Marinate for 30 minutes.', ''),
(2, 1, 2, 'Heat oil in a pot and sauté the onion.\r\n', ''),
(3, 1, 3, 'Add the marinated chicken and cook until lightly browned.', ''),
(4, 1, 4, 'Pour in the marinade, water, and bay leaves.', ''),
(5, 1, 5, 'Simmer for 25–30 minutes until the chicken is tender.', ''),
(6, 1, 6, 'Add vinegar and let it simmer without stirring for a few minutes.', ''),
(7, 1, 7, 'Stir gently and cook until the sauce reaches your preferred consistency.', ''),
(8, 1, 8, 'Serve hot with rice.', ''),
(9, 2, 1, 'Marinate the pork in soy sauce, garlic, and peppercorns for 30 minutes.', ''),
(10, 2, 2, 'Heat oil in a pot and sauté the onion.', ''),
(11, 2, 3, 'Add the pork and cook until lightly browned.', ''),
(12, 2, 4, 'Pour in the marinade and water.', ''),
(13, 2, 5, 'Add bay leaves and simmer for 40–50 minutes or until tender.', ''),
(14, 2, 6, 'Add vinegar and allow it to simmer for a few minutes before stirring.', ''),
(15, 2, 7, 'Continue cooking until the sauce thickens.', ''),
(16, 2, 8, 'Serve with steamed rice.', ''),
(17, 3, 1, 'Boil the oxtail in water until tender. Reserve the broth.', ''),
(18, 3, 2, 'Sauté garlic and onion in a pot.', ''),
(19, 3, 3, 'Add the cooked meat and stir.', ''),
(20, 3, 4, 'Pour in the reserved broth.', ''),
(21, 3, 5, 'Add peanut butter, ground peanuts, and annatto.', ''),
(22, 3, 6, 'Add toasted ground rice to thicken the sauce.', ''),
(23, 3, 7, 'Add the banana blossom, eggplant, and string beans.', ''),
(24, 3, 8, 'Cook until the vegetables are tender.', ''),
(25, 3, 9, 'Add pechay and cook for another 2 minutes.', ''),
(26, 3, 10, 'Season with salt and pepper. Serve with bagoong.', ''),
(27, 4, 1, 'Heat oil in a pot and sauté garlic and onion.', ''),
(28, 4, 2, 'Add beef and cook until browned.', ''),
(29, 4, 3, 'Pour in tomato sauce and water.', ''),
(30, 4, 4, 'Cover and simmer until the beef becomes tender.', ''),
(31, 4, 5, 'Add liver spread and mix well.\r\n', ''),
(32, 4, 6, 'Add potatoes and carrots.', ''),
(33, 4, 7, 'Cook until the vegetables are tender.', ''),
(34, 4, 8, 'Add bell peppers and season with salt and pepper.', ''),
(35, 4, 9, 'Simmer for another 3–5 minutes and serve.', ''),
(36, 5, 1, 'Marinate the beef in soy sauce and calamansi juice for 30 minutes.', ''),
(37, 5, 2, 'Heat oil in a pot and sauté garlic and onion.', ''),
(38, 5, 3, 'Add the beef and cook until browned.', ''),
(39, 5, 4, 'Pour in the tomato sauce and beef broth.', ''),
(40, 5, 5, 'Add bay leaves and simmer until the beef is tender.', ''),
(41, 5, 6, 'Add potatoes and carrots.', ''),
(42, 5, 7, 'Cook until the vegetables are soft.', ''),
(43, 5, 8, 'Season with salt and pepper.', ''),
(44, 5, 9, 'Simmer until the sauce thickens, then serve.', ''),
(45, 6, 1, 'Heat oil in a pot.', ''),
(46, 6, 2, 'Sauté garlic and onion.', ''),
(47, 6, 3, 'Add chicken and cook until lightly browned.', ''),
(48, 6, 4, 'Pour in tomato sauce and water.', ''),
(49, 6, 5, 'Cover and simmer for 20 minutes.', ''),
(50, 6, 6, 'Add potatoes and carrots.', ''),
(51, 6, 7, 'Cook until the chicken and vegetables are tender.', ''),
(52, 6, 8, 'Add bell peppers.', ''),
(53, 6, 9, 'Season with salt and pepper.', ''),
(54, 6, 10, 'Simmer for another 3 minutes before serving.', ''),
(55, 7, 1, 'Heat oil in a pan.', ''),
(56, 7, 2, 'Sauté garlic, onion, and ginger.', ''),
(57, 7, 3, 'Add pork and cook until lightly browned.', ''),
(58, 7, 4, 'Add shrimp paste and mix.', ''),
(59, 7, 5, 'Pour in coconut milk.', ''),
(60, 7, 6, 'Simmer until the pork becomes tender.', ''),
(61, 7, 7, 'Add green chili peppers.', ''),
(62, 7, 8, 'Pour in coconut cream.', ''),
(63, 7, 9, 'Cook until the sauce thickens.', ''),
(64, 7, 10, 'Adjust the seasoning and serve.', ''),
(65, 8, 1, 'Prepare the dried taro leaves. ', ''),
(66, 8, 2, 'Do not wash or stir them excessively.\r\n', ''),
(67, 8, 3, 'In a pot, combine coconut milk, garlic, onion, ginger, and shrimp paste.', ''),
(68, 8, 4, 'Add dried fish or pork if desired.', ''),
(69, 8, 5, 'Bring the mixture to a gentle simmer.', ''),
(70, 8, 6, 'Add the dried taro leaves on top.', ''),
(71, 8, 7, 'Cover and cook over low heat until the leaves soften.\r\n', ''),
(72, 8, 8, 'Add coconut cream and chili peppers.', ''),
(73, 8, 9, 'Continue simmering until the sauce thickens and the leaves are fully cooked.\r\n', ''),
(74, 8, 10, 'Season to taste and serve.', ''),
(75, 9, 1, 'Marinate pork in soy sauce, garlic, and peppercorns for 30 minutes.', ''),
(76, 9, 2, 'Heat a pot and brown the pork.', ''),
(77, 9, 3, 'Add onion and sauté.', ''),
(78, 9, 4, 'Pour in the marinade, water, pineapple juice, and brown sugar.', ''),
(79, 9, 5, 'Add bay leaves and black beans.', ''),
(80, 9, 6, 'Simmer until the pork becomes tender.', ''),
(81, 9, 7, 'Add vinegar and allow it to simmer before stirring.', ''),
(82, 9, 8, 'Add dried banana blossoms.', ''),
(83, 9, 9, 'Continue cooking until the sauce becomes thick and flavorful.', ''),
(84, 9, 10, 'Serve with rice.', ''),
(85, 10, 1, 'Marinate the pork in soy sauce, garlic, and pepper for 20 minutes.', ''),
(86, 10, 2, 'Heat oil in a pan and sauté garlic and onion.', ''),
(87, 10, 3, 'Add the marinated pork and cook until browned.', ''),
(88, 10, 4, 'Pour in water and add bay leaves.', ''),
(89, 10, 5, 'Simmer until the pork becomes tender.', ''),
(90, 10, 6, 'Add vinegar and allow it to simmer before stirring.', ''),
(91, 10, 7, 'Add pork liver and cook thoroughly.', ''),
(92, 10, 8, 'Add green peas and bell pepper.', ''),
(93, 10, 9, 'Season with salt and pepper.', ''),
(94, 10, 10, 'Simmer until the sauce is reduced, then serve.', ''),
(95, 11, 1, 'Boil pork in water until tender.', ''),
(96, 11, 2, 'Add onion and tomatoes.', ''),
(97, 11, 3, 'Add the sinigang mix and stir.', ''),
(98, 11, 4, 'Add radish and cook for 5 minutes.', ''),
(99, 11, 5, 'Add eggplant, okra, and green chili peppers.', ''),
(100, 11, 6, 'Cook until the vegetables are tender.', ''),
(101, 11, 7, 'Add kangkong and cook for 2 minutes.', ''),
(102, 11, 8, 'Season with fish sauce and serve hot.', ''),
(103, 12, 1, 'Boil pork in water and remove any foam that forms.', ''),
(104, 12, 2, 'Add onion and peppercorns.', ''),
(105, 12, 3, 'Simmer until the pork becomes tender.', ''),
(106, 12, 4, 'Add corn and potatoes.', ''),
(107, 12, 5, 'Cook until the potatoes are soft.', ''),
(108, 12, 6, 'Add cabbage and pechay.', ''),
(109, 12, 7, 'Season with fish sauce.', ''),
(110, 12, 8, 'Simmer for another 2–3 minutes and serve.', ''),
(111, 13, 1, 'Heat oil in a pot.', ''),
(112, 13, 2, 'Sauté garlic, onion, and ginger.', ''),
(113, 13, 3, 'Add chicken and cook until lightly browned.', ''),
(114, 13, 4, 'Add fish sauce and stir.', ''),
(115, 13, 5, 'Pour in water and bring to a boil.', ''),
(116, 13, 6, 'Simmer until the chicken is tender.', ''),
(117, 13, 7, 'Add green papaya and cook until soft.', ''),
(118, 13, 8, 'Add malunggay leaves.', ''),
(119, 13, 9, 'Season with pepper and serve hot.', ''),
(120, 14, 1, 'Place beef shank in a large pot with water.', ''),
(121, 14, 2, 'Bring to a boil and remove the foam.', ''),
(122, 14, 3, 'Add onion and peppercorns.', ''),
(123, 14, 4, 'Simmer until the beef is very tender.', ''),
(124, 14, 5, 'Add corn and potatoes.', ''),
(125, 14, 6, 'Cook until the vegetables are soft.', ''),
(126, 14, 7, 'Add cabbage and pechay.', ''),
(127, 14, 8, 'Season with fish sauce.', ''),
(128, 14, 9, 'Simmer for a few more minutes and serve hot.', ''),
(129, 15, 1, 'Heat oil in a pot.', ''),
(130, 15, 2, 'Sauté garlic, onion, ginger, and tomatoes.', ''),
(131, 15, 3, 'Add chicken and cook until lightly browned.', ''),
(132, 15, 4, 'Pour in water and bring to a boil.', ''),
(133, 15, 5, 'Simmer until the chicken is tender.', ''),
(134, 15, 6, 'Add tamarind or sinigang mix.', ''),
(135, 15, 7, 'Add young tamarind leaves.', ''),
(136, 15, 8, 'Season with fish sauce.', ''),
(137, 15, 9, 'Simmer for another 2 minutes and serve.', ''),
(138, 16, 1, 'Clean the beef innards thoroughly and boil until tender.', ''),
(139, 16, 2, 'Drain and cut into bite-sized pieces.', ''),
(140, 16, 3, 'Heat oil in a pot and sauté garlic, onion, and ginger.', ''),
(141, 16, 4, 'Add the beef meat and innards.', ''),
(142, 16, 5, 'Stir and cook for several minutes.', ''),
(143, 16, 6, 'Pour in water and simmer.', ''),
(144, 16, 7, 'Gradually add a small amount of prepared bile to achieve the desired bitterness.', ''),
(145, 16, 8, 'Add green chili peppers.', ''),
(146, 16, 9, 'Season with fish sauce, salt, and pepper.', ''),
(147, 16, 10, 'Simmer until the flavors are combined and serve hot.', ''),
(148, 17, 1, 'Boil water in a pot and cook spaghetti noodles according to package instructions.', ''),
(149, 17, 2, 'Drain the noodles and set aside.', ''),
(150, 17, 3, 'Heat oil in a pan.', ''),
(151, 17, 4, 'Sauté garlic and onion.', ''),
(152, 17, 5, 'Add ground meat and cook thoroughly.', ''),
(153, 17, 6, 'Add sliced hotdogs.', ''),
(154, 17, 7, 'Pour in spaghetti sauce and tomato sauce.', ''),
(155, 17, 8, 'Add sugar if desired and simmer for 10–15 minutes.', ''),
(156, 17, 9, 'Season with salt and pepper.', ''),
(157, 17, 10, 'Pour sauce over the noodles and top with grated cheese.', ''),
(158, 18, 1, 'Cook carbonara pasta in boiling water according to package instructions.', ''),
(159, 18, 2, 'Drain and set aside.', ''),
(160, 18, 3, 'Melt butter in a pan.', ''),
(161, 18, 4, 'Fry bacon until cooked.', ''),
(162, 18, 5, 'Add garlic and onion and sauté.', ''),
(163, 18, 6, 'Add mushrooms if desired.', ''),
(164, 18, 7, 'Pour in all-purpose cream and evaporated milk.', ''),
(165, 18, 8, 'Add grated cheese and stir until creamy.', ''),
(166, 18, 9, 'Season with salt and pepper.', ''),
(167, 18, 10, 'Add cooked spaghetti and mix well before serving.', '');

-- --------------------------------------------------------

--
-- Table structure for table `plan`
--

CREATE TABLE `plan` (
  `planID` int(11) NOT NULL,
  `dishID` int(11) NOT NULL,
  `cookingDateTime` datetime NOT NULL,
  `status` enum('pending','completed','cancelled') NOT NULL,
  `createdAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plan`
--

INSERT INTO `plan` (`planID`, `dishID`, `cookingDateTime`, `status`, `createdAt`) VALUES
(1, 1, '2026-11-10 13:03:21', 'pending', '2026-11-08 06:03:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dish`
--
ALTER TABLE `dish`
  ADD PRIMARY KEY (`dishID`),
  ADD KEY `dcategoryID` (`dcategoryID`);

--
-- Indexes for table `dishcategory`
--
ALTER TABLE `dishcategory`
  ADD PRIMARY KEY (`dcategoryID`);

--
-- Indexes for table `icategory`
--
ALTER TABLE `icategory`
  ADD PRIMARY KEY (`icategoryID`);

--
-- Indexes for table `ingredientneeds`
--
ALTER TABLE `ingredientneeds`
  ADD KEY `dishID` (`dishID`),
  ADD KEY `ingredientID` (`ingredientID`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ingredientID`),
  ADD KEY `icategoryID` (`icategoryID`);

--
-- Indexes for table `instruction`
--
ALTER TABLE `instruction`
  ADD PRIMARY KEY (`instructionID`),
  ADD KEY `dishID` (`dishID`);

--
-- Indexes for table `plan`
--
ALTER TABLE `plan`
  ADD PRIMARY KEY (`planID`),
  ADD KEY `dishID` (`dishID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dish`
--
ALTER TABLE `dish`
  MODIFY `dishID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `dishcategory`
--
ALTER TABLE `dishcategory`
  MODIFY `dcategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `icategory`
--
ALTER TABLE `icategory`
  MODIFY `icategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `ingredientID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=257;

--
-- AUTO_INCREMENT for table `instruction`
--
ALTER TABLE `instruction`
  MODIFY `instructionID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `plan`
--
ALTER TABLE `plan`
  MODIFY `planID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dish`
--
ALTER TABLE `dish`
  ADD CONSTRAINT `dish_ibfk_1` FOREIGN KEY (`dcategoryID`) REFERENCES `dishcategory` (`dcategoryID`);

--
-- Constraints for table `ingredientneeds`
--
ALTER TABLE `ingredientneeds`
  ADD CONSTRAINT `ingredientneeds_ibfk_1` FOREIGN KEY (`dishID`) REFERENCES `dish` (`dishID`),
  ADD CONSTRAINT `ingredientneeds_ibfk_2` FOREIGN KEY (`ingredientID`) REFERENCES `ingredients` (`ingredientID`);

--
-- Constraints for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD CONSTRAINT `ingredients_ibfk_1` FOREIGN KEY (`icategoryID`) REFERENCES `icategory` (`icategoryID`);

--
-- Constraints for table `instruction`
--
ALTER TABLE `instruction`
  ADD CONSTRAINT `instruction_ibfk_1` FOREIGN KEY (`dishID`) REFERENCES `dish` (`dishID`);

--
-- Constraints for table `plan`
--
ALTER TABLE `plan`
  ADD CONSTRAINT `plan_ibfk_1` FOREIGN KEY (`dishID`) REFERENCES `dish` (`dishID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
