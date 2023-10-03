-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 03, 2023 at 03:30 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vishal_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `PkCategoryId` int(11) UNSIGNED NOT NULL,
  `parentCategoryId` int(11) NOT NULL DEFAULT 0,
  `categoryName` varchar(100) NOT NULL,
  `categoryImage` varchar(255) DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`PkCategoryId`, `parentCategoryId`, `categoryName`, `categoryImage`, `isActive`, `isDeleted`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(1, 0, 'Grocery', 'all-grocery-items-500x500.webp', b'1', b'0', '2023-09-08 10:53:57', 1, '2023-09-08 11:43:49', 1),
(2, 0, 'Fashion', 'portrait-smiling-beautiful-girl-her-handsome-boyfriend-laughing-happy-cheerful-couple-sunglasses.jpg', b'1', b'0', '2023-09-08 10:54:38', 1, '2023-09-08 11:57:08', 1),
(3, 0, 'Electronics', 'istockphoto-178716575-612x612.jpg', b'1', b'0', '2023-09-08 10:55:13', 1, '2023-09-08 12:12:40', 1),
(4, 0, 'Home & Furniture', 'scandinavian-living-room-interior-design-zoom-background.jpg', b'1', b'0', '2023-09-08 10:55:37', 1, '2023-09-08 12:18:42', 1),
(5, 3, 'Appliances', 'electric-blender-mixer-juicer-set.jpg', b'1', b'0', '2023-09-08 10:56:04', 1, '2023-09-15 15:35:28', 1),
(6, 2, 'Beauty, Toys & More', 'cute-cheerful-little-girl-with-teddy-bear-blue-wall.jpg', b'1', b'0', '2023-09-08 10:56:26', 1, '2023-09-15 15:35:43', 1),
(7, 3, 'Mobiles', 'marketing-creative-collage-with-phone.jpg', b'1', b'0', '2023-09-08 10:56:55', 1, '2023-09-15 15:36:32', 1),
(8, 44, 'Two Wheelers', 'motorcycle-with-helmet.jpg', b'1', b'0', '2023-09-08 10:57:22', 1, '2023-09-21 10:27:03', 1),
(9, 1, 'Snacks & Beverages', '9fbd36.webp', b'1', b'0', '2023-09-08 10:58:30', 1, '2023-09-08 10:58:28', NULL),
(10, 1, 'Packaged Food', 'ac8550.webp', b'1', b'0', '2023-09-08 10:58:53', 1, '2023-09-08 10:58:51', NULL),
(11, 1, 'Staples', '50474c.webp', b'1', b'0', '2023-09-08 10:59:16', 1, '2023-09-08 10:59:15', NULL),
(12, 1, 'Household Care', 'b7ade9.webp', b'1', b'0', '2023-09-08 10:59:49', 1, '2023-09-08 10:59:48', NULL),
(13, 2, 'Men\'s Wear', '-original-imagnbzq8acbnh3m.webp', b'1', b'0', '2023-09-08 11:01:20', 1, '2023-09-08 11:01:18', NULL),
(14, 0, 'Women\'s Wear', 'l-mf19kr414g-mon-original-imagsszy6fqxxueq_1gqgqcxufamrk.webp', b'1', b'0', '2023-09-08 11:02:52', 1, '2023-09-21 10:29:03', 1),
(15, 2, 'Kid\'s Wear', '12-18-months-black-velvet-crazylife-fashion-original-imagsj4cpvngzx4a.webp', b'1', b'0', '2023-09-08 11:03:42', 1, '2023-09-08 11:03:40', NULL),
(16, 3, 'Computer Peripherals', '-original-imagpa5fbvqzk2xn.webp', b'1', b'0', '2023-09-08 11:05:37', 1, '2023-09-08 11:05:36', NULL),
(17, 3, 'Cameras & Accessories', 'canon-eos-eos-3000d-dslr-original-imaf3t5h9yuyc5zu.webp', b'1', b'0', '2023-09-08 11:07:39', 1, '2023-09-08 11:07:37', NULL),
(18, 9, 'Biscuits', NULL, b'1', b'0', '2023-09-08 11:28:21', 1, NULL, NULL),
(19, 9, 'Namkin', NULL, b'1', b'0', '2023-09-08 11:28:31', 1, NULL, NULL),
(20, 9, 'Tea ', '', b'1', b'0', '2023-09-08 11:28:46', 1, '2023-09-21 10:30:04', 1),
(21, 10, 'Noodles & Pasta', NULL, b'1', b'0', '2023-09-08 11:29:06', 1, NULL, NULL),
(22, 10, 'Jam & Honey', NULL, b'1', b'0', '2023-09-08 11:29:25', 1, NULL, NULL),
(23, 11, 'Dal & Pulses', NULL, b'1', b'0', '2023-09-08 11:29:50', 1, NULL, NULL),
(24, 11, 'Ghee & Oils', NULL, b'1', b'0', '2023-09-08 11:30:06', 1, NULL, NULL),
(25, 11, 'Atta & Flours', NULL, b'1', b'0', '2023-09-08 11:30:37', 1, NULL, NULL),
(26, 11, 'Masala & Spices', NULL, b'1', b'0', '2023-09-08 11:30:57', 1, NULL, NULL),
(27, 13, 'T-Shirt', NULL, b'1', b'0', '2023-09-08 11:58:40', 1, NULL, NULL),
(28, 13, 'Footwear', NULL, b'1', b'0', '2023-09-08 11:59:01', 1, NULL, NULL),
(29, 13, 'Jeans', NULL, b'1', b'0', '2023-09-08 11:59:19', 1, NULL, NULL),
(30, 14, 'Suits', NULL, b'1', b'0', '2023-09-08 11:59:42', 1, NULL, NULL),
(31, 14, 'Western wear', 'portrait-smiling-beautiful-girl-her-handsome-boyfriend-laughing-happy-cheerful-couple-sunglasses_1q9j9jy3hw4ce.jpg', b'1', b'0', '2023-09-08 12:00:02', 1, '2023-09-21 10:20:25', 1),
(32, 14, 'Sarees', NULL, b'1', b'0', '2023-09-08 12:00:11', 1, NULL, NULL),
(33, 14, 'Antalkali ', NULL, b'1', b'0', '2023-09-08 12:00:30', 1, NULL, NULL),
(34, 15, 'Boy\'s Fashion', NULL, b'1', b'0', '2023-09-08 12:00:55', 1, NULL, NULL),
(35, 15, 'Girl\'s Fashion', NULL, b'1', b'0', '2023-09-08 12:01:18', 1, NULL, NULL),
(36, 16, 'Printers', NULL, b'1', b'0', '2023-09-08 12:02:26', 1, NULL, NULL),
(37, 16, 'Moniters', NULL, b'1', b'0', '2023-09-08 12:05:51', 1, NULL, NULL),
(38, 16, 'Toners', 'istockphoto-178716575-612x612_15h1ibzha0hh7.jpg', b'1', b'0', '2023-09-08 12:06:06', 1, '2023-09-21 10:28:13', 1),
(39, 17, 'DSLR & Mirrorless', NULL, b'1', b'0', '2023-09-08 12:13:32', 1, NULL, NULL),
(40, 17, 'Compact & Bridge Cameras', NULL, b'1', b'0', '2023-09-08 12:14:22', 1, NULL, NULL),
(41, 17, 'Sports & Action', NULL, b'1', b'0', '2023-09-08 12:15:00', 1, NULL, NULL),
(42, 4, 'Kitchen & dining', NULL, b'1', b'0', '2023-09-08 12:16:11', 1, NULL, NULL),
(43, 4, 'Home Decor', NULL, b'1', b'0', '2023-09-08 12:16:41', 1, NULL, NULL),
(44, 0, 'Wheelers', 'motorcycle-with-helmet_12e6u0n0fs2yp.jpg', b'1', b'0', '2023-09-15 15:37:07', 1, '2023-09-20 17:40:32', 1),
(45, 12, 'Cleaning products', NULL, b'1', b'0', '2023-09-15 15:48:00', 1, NULL, NULL),
(46, 12, ' Laundry products ', 'ratlami-sev_1omqdw9y0suja.png', b'1', b'0', '2023-09-15 15:48:37', 1, '2023-09-20 11:09:10', 1),
(47, 6, 'Beauty & Personal Care', NULL, b'1', b'0', '2023-09-15 15:50:27', 1, NULL, NULL),
(48, 6, 'Toys & School Supplies', NULL, b'1', b'0', '2023-09-15 16:37:35', 1, NULL, NULL),
(49, 5, 'Air Conditioners', NULL, b'1', b'0', '2023-09-15 16:43:22', 1, NULL, NULL),
(50, 5, 'TV', '-original-imagpa5fbvqzk2xn_1l2fw7e76bopa.webp', b'1', b'0', '2023-09-15 16:43:45', 1, '2023-09-21 10:27:35', 1),
(51, 5, 'Watching Machine', NULL, b'1', b'0', '2023-09-15 16:44:25', 1, '2023-09-20 15:16:56', 1),
(52, 7, 'Samsung', NULL, b'1', b'0', '2023-09-15 16:45:10', 1, NULL, NULL),
(53, 7, 'Vivo', '', b'1', b'1', '2023-09-15 16:45:24', 1, '2023-09-20 11:05:48', NULL),
(54, 7, 'Apple', NULL, b'1', b'0', '2023-09-15 16:45:42', 1, NULL, NULL),
(55, 42, 'Cookware', NULL, b'1', b'0', '2023-09-15 16:47:25', 1, NULL, NULL),
(56, 42, 'Kitchen Tools', NULL, b'1', b'0', '2023-09-15 16:48:58', 1, NULL, NULL),
(57, 42, 'Table & Dinnerware', NULL, b'1', b'0', '2023-09-15 16:49:29', 1, NULL, NULL),
(58, 43, 'Painting & Posters', NULL, b'1', b'0', '2023-09-15 16:50:18', 1, NULL, NULL),
(59, 43, 'Clocks', NULL, b'1', b'0', '2023-09-15 16:50:32', 1, NULL, NULL),
(60, 43, 'Wall Decore', 'oreo.jpeg', b'1', b'0', '2023-09-15 16:50:54', 1, '2023-09-21 10:29:07', 1),
(61, 8, 'Petrol Vehicle', NULL, b'1', b'0', '2023-09-15 16:51:20', 1, NULL, NULL),
(62, 8, 'Electronic Vehicle', NULL, b'1', b'0', '2023-09-15 16:51:34', 1, NULL, NULL),
(67, 0, 'Home', NULL, b'1', b'1', '2023-09-20 12:40:43', 1, '2023-09-20 12:42:34', NULL),
(73, 0, 'erfwe', NULL, b'1', b'1', '2023-09-20 12:48:51', 1, '2023-09-20 12:49:29', 1),
(74, 0, 'qwedw', NULL, b'1', b'1', '2023-09-20 12:49:41', 1, '2023-09-21 10:32:10', NULL),
(75, 0, 'gd', NULL, b'1', b'1', '2023-09-20 13:19:37', 1, '2023-09-21 10:30:55', NULL),
(76, 0, 'rtyr', NULL, b'1', b'1', '2023-09-20 13:19:59', 1, '2023-09-21 10:30:59', 1),
(77, 0, 'sfs', '1_nkxt2l2uvkao.jpg', b'1', b'1', '2023-09-20 13:42:22', 1, '2023-09-21 10:30:32', 1),
(78, 0, 'erwert', '1_1mguhzdhyoe0d.png', b'1', b'1', '2023-09-20 13:44:13', 1, '2023-09-21 10:31:59', 1),
(79, 0, 'rtry', '1_aheksy692kfn.jpg', b'1', b'1', '2023-09-20 13:59:29', 1, '2023-09-21 10:32:02', NULL),
(80, 0, 't6t54', '1.png', b'1', b'1', '2023-09-20 14:06:55', 1, '2023-09-21 10:32:04', NULL),
(81, 0, 'fytr', '1_au8yxbmxivn1.png', b'1', b'1', '2023-09-20 14:43:50', 1, '2023-09-21 10:32:07', 1),
(82, 0, 'ryrty', 'oreo_jrbfoqkg9rd6.jpeg', b'1', b'1', '2023-09-21 10:29:21', 1, '2023-09-21 10:30:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `PkCustomerId` int(10) UNSIGNED NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `gender` bit(1) NOT NULL,
  `profile` varchar(255) DEFAULT NULL,
  `isBlcoked` bit(1) NOT NULL DEFAULT b'0',
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `createdBy` int(10) UNSIGNED NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedBy` int(10) DEFAULT NULL,
  `updatedDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`PkCustomerId`, `token`, `firstName`, `lastName`, `email`, `password`, `dob`, `gender`, `profile`, `isBlcoked`, `isActive`, `isDeleted`, `createdBy`, `createdDate`, `updatedBy`, `updatedDate`) VALUES
(1, '7F9C4237-1606-47C0-A96CAEEAC7311144', 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '$2a$10$EIMyk7EYrrx8WxTBnbROn.0pJ89u/lEZWSqSisWSgV7GjzY.Tzw4u', '2001-07-16', b'0', NULL, b'0', b'1', b'0', 0, '2023-08-11 08:05:50', 1, '2023-09-22 08:50:02'),
(2, NULL, 'test', 'test', 'mamta@yahoo.in', '$2a$10$qvrxiNNJUOrAY7s2pPLKcemxkZo85eZ0V2eC0ARMXLU0oAZtIho9K', '1996-03-04', b'1', '', b'0', b'1', b'1', 1, '2023-08-14 06:13:06', NULL, '2023-08-16 04:47:11'),
(3, NULL, 'test', 'test', 'ravi@gmail.com', '$2a$10$A7SBFgAOmO8DAQVc8lFoAuFSRq5zctd5GzcNRo.XE8ZHIbF3NMzfC', '1996-03-04', b'1', NULL, b'1', b'1', b'0', 1, '2023-08-14 06:16:56', NULL, '2023-08-16 04:47:26'),
(4, NULL, 'arfwseert', 'wqew', 'werwerwe@gmail.com', '$2a$10$pLmaV/d27yvvSvgiIMixoOGBMF3Nrns/CrxK9BwBTALx/01/wpt.q', '1997-04-05', b'0', NULL, b'1', b'1', b'0', 1, '2023-08-14 06:17:58', NULL, '2023-08-14 12:31:07'),
(5, NULL, 'sftstfg', 'ftggdrtfe', 'ravina@gmail.com', '$2a$10$2EwyauSjj5zYC9mDbCBA1OJhJd33TtaBd9B8HkX6Vd.mbHBCHRm4e', '2000-07-07', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:46:11', NULL, NULL),
(6, NULL, 'adsf', 'fwef', 'mamta123@lucidsolutions.in', '$2a$10$i.QZccW7zvDCZFFz5HQYMujS0DnEbYJ9N10RXQZNUjGZP8HyUCwTy', '1998-07-07', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:47:31', NULL, '2023-08-16 04:47:33'),
(7, NULL, '646485', 'wewe', 'ravina@gmail.com', '$2a$10$P5c5FgQXAyUrz0QNR3HigejG/jwkqT5LEJAc4oVoLaQaULlQvX2je', '2008-06-13', b'1', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:49:09', 1, '2023-08-14 10:57:55'),
(8, NULL, 'thyrtf', 'erty', 'yogesh.m@gmail.com', '$2a$10$Odo3.yQIaGKiixWQNMN0Ie/sEKJ81hAf6TYVXcMNe1qREuanDhzZC', '2001-03-08', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:53:33', NULL, NULL),
(9, NULL, 'thyrtf', 'erty', 'yogesh.m@gmail.com', '$2a$10$Nvroj5URmsNzMxLmUGz3Ru0jwI1o6RR9v0pAsEpdpd9TWd6bXGQ9C', '2001-03-08', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:54:49', NULL, NULL),
(10, NULL, 'tyrty', 'tyrty', 'yogesh.m@gmail.com', '$2a$10$dHnyMAEyGhgYEJRCdiDpsut8iAzWco/17W0QTzDPfFjVTXx2VbVue', '2010-05-15', b'1', '', b'0', b'1', b'1', 1, '2023-08-14 06:59:29', 1, '2023-08-14 12:19:47'),
(11, NULL, 'Vishal', 'Kumar Khatri', 'vishal.k@lucidsolutions.in', '$2a$10$EfdmrcOB8W5uHX/oGIIl8uJZxzpEQSFRNOGXkkqfHdDEW4qfJpQ5a', '1995-08-20', b'1', NULL, b'0', b'1', b'0', 0, '2023-09-22 05:57:59', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `PkProductId` int(11) UNSIGNED NOT NULL,
  `FkCategoryId` int(11) UNSIGNED NOT NULL,
  `productName` varchar(100) NOT NULL,
  `product_tags` mediumtext DEFAULT NULL,
  `productPrice` float NOT NULL,
  `productQty` int(11) NOT NULL,
  `productDescription` text DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`PkProductId`, `FkCategoryId`, `productName`, `product_tags`, `productPrice`, `productQty`, `productDescription`, `isActive`, `isDeleted`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(1, 18, 'PARLE G Original Gluco Biscuits Plain', '1', 56, 15, 'fwerfwe', b'1', b'0', '2023-09-13 15:36:01', 1, '2023-09-18 12:07:09', 1),
(2, 19, 'Anand Namkeen Thika Meetha mix', '4', 800, 10, 'testy', b'1', b'0', '2023-09-13 16:03:30', 1, '2023-10-03 10:40:06', 1),
(3, 28, 'Puma Snikers', '1,2', 55000, 20, 'edfwe', b'1', b'0', '2023-09-13 18:01:45', 1, '2023-09-15 11:40:41', 1),
(4, 41, 'T-SHIRT', '5', 850, 25, 'test', b'1', b'1', '2023-09-14 14:12:42', 1, '2023-09-20 11:31:49', 1),
(5, 7, 'Samsung Z-fold ', '1,5', 1500000, 5, 'folding phone', b'1', b'0', '2023-09-14 14:35:24', 1, '2023-09-18 14:40:58', 1),
(6, 18, 'Biscuits', '9', 1000, 20, 'dased', b'1', b'0', '2023-09-14 14:59:19', 1, '2023-09-21 16:46:16', 1),
(7, 21, 'Meggie', '10', 500, 20, 'meggie', b'1', b'0', '2023-09-15 15:14:31', 1, '2023-10-03 10:38:20', 1),
(8, 19, 'Sona Namkeen', '4', 1500, 10, 'mixer', b'1', b'0', '2023-09-15 18:30:40', 1, '2023-10-03 10:40:30', 1),
(9, 20, 'Taj Mahal Tea', '8', 100, 25, 'tea', b'1', b'0', '2023-09-18 11:23:48', 1, '2023-10-03 14:12:05', 1),
(10, 18, 'crack jack', '1', 30, 25, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-09-18 17:06:16', NULL),
(11, 18, 'Hide & seek', '1', 30, 25, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-09-18 16:54:04', 1),
(12, 18, 'Oreo', '1', 30, 25, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-09-21 18:25:06', 1),
(13, 18, 'test', '1,9', 500, 50, 'ertert', b'1', b'0', '2023-09-18 16:55:11', 1, '2023-09-21 18:25:36', 1),
(14, 18, 'Monaco', '1', 30, 25, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-09-18 17:11:38', 1),
(15, 18, 'Britannia Good Day', '1', 30, 25, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-09-21 16:45:26', 1),
(16, 18, 'Oreo Pink Cream', '1,9', 30, 25, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-09-18 17:10:44', 1),
(17, 18, 'Sunfest', '1', 500, 50, 'ertert', b'1', b'0', '2023-09-18 16:55:11', 1, '2023-09-21 16:55:29', 1),
(18, 18, 'Choco Lava Cake', '9', 850, 20, 'Choco Lava Cake', b'1', b'0', '2023-09-29 11:19:48', 1, '2023-10-03 14:08:12', 1),
(19, 19, 'Bhujia Sev', '4,11', 150, 10, 'Haldiram\'s Bhujia is an authentic rendition of the classic, textured namkeen. Reach for a pack at teatime or top it on a steaming bowl of upma, poha or chaats.', b'1', b'0', '2023-10-01 22:45:57', 7, '2023-10-02 18:21:02', 7),
(20, 20, 'Wagh bakri Chai', '8', 1000, 25, 'Waagbakri Chai', b'1', b'0', '2023-10-03 10:45:41', 1, '2023-10-03 14:13:56', 1),
(21, 19, '5555555555', NULL, 55000, 20, 'ewe', b'1', b'0', '2023-10-03 12:43:57', 1, '2023-10-03 14:14:04', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_image`
--

CREATE TABLE `product_image` (
  `PkImageId` int(11) UNSIGNED NOT NULL,
  `FkProductId` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `image` text DEFAULT NULL,
  `isDefault` bit(1) NOT NULL DEFAULT b'0',
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_image`
--

INSERT INTO `product_image` (`PkImageId`, `FkProductId`, `image`, `isDefault`, `isActive`, `dateCreated`, `createdBy`) VALUES
(3, 1, 'ratlami-sev.png', b'0', b'1', '2023-09-13 15:51:58', 1),
(4, 1, 'anand-nmkieen.png', b'1', b'1', '2023-09-13 15:51:58', 1),
(6, 2, 'anand-nmkieen_1nvr14ueh50bq.png', b'1', b'1', '2023-09-13 16:03:30', 1),
(7, 2, '50474c.webp', b'0', b'1', '2023-09-13 16:03:30', 1),
(9, 3, '69c6589653afdb9a.webp', b'1', b'1', '2023-09-13 18:01:45', 1),
(11, 4, 'motorcycle-with-helmet.jpg', b'1', b'1', '2023-09-14 14:26:46', 1),
(12, 5, '22fddf3c7da4c4f4.webp', b'1', b'1', '2023-09-14 14:35:24', 1),
(15, 7, 'anand-nmkieen_1gfgiz2rj7f68.png', b'1', b'1', '2023-09-15 15:14:31', 1),
(17, 6, '0ff199d1bd27eb98.webp', b'0', b'1', '2023-09-15 16:59:13', 1),
(18, 8, '360_F_228074132_GXAkRxpdhNIUd7E6Sv3XEwybixD8Z1yf.jpg', b'1', b'1', '2023-09-15 18:30:40', 1),
(24, 8, 'png-transparent-vegetarian-cuisine-dal-french-fries-ramoji-wafer-and-namkeen-pvt-ltd-food-junk-food-food-recipe-wafer.png', b'0', b'1', '2023-09-15 18:40:02', 1),
(27, 6, 'istockphoto-178716575-612x612.jpg', b'1', b'1', '2023-09-18 11:54:00', 1),
(29, 1, 'download.jpg', b'0', b'1', '2023-09-18 12:07:09', 1),
(30, 6, '-original-imagpa5fbvqzk2xn.webp', b'0', b'1', '2023-09-18 12:09:15', 1),
(32, 10, 'download_erhh4bljuzrf.jpg', b'1', b'1', '2023-09-18 16:51:22', 1),
(33, 11, 'b7ade9.webp', b'1', b'1', '2023-09-18 16:52:51', 1),
(34, 12, 'download_qkjz9swh03c0.jpg', b'1', b'1', '2023-09-18 16:53:58', 1),
(35, 13, 'canon-eos-eos-3000d-dslr-original-imaf3t5h9yuyc5zu.webp', b'1', b'1', '2023-09-18 16:55:11', 1),
(38, 15, 'png-transparent-vegetarian-cuisine-dal-french-fries-ramoji-wafer-and-namkeen-pvt-ltd-food-junk-food-food-recipe-wafer_zy613kygnovy.png', b'1', b'1', '2023-09-18 17:09:03', 1),
(39, 16, 'oreo.jpeg', b'1', b'1', '2023-09-18 17:10:44', 1),
(40, 17, 'oreo_6wpihl66wp5r.jpeg', b'1', b'1', '2023-09-18 17:11:04', 1),
(41, 14, '360_F_228074132_GXAkRxpdhNIUd7E6Sv3XEwybixD8Z1yf_18c5p6s3pjp5.jpg', b'1', b'1', '2023-09-18 17:11:38', 1),
(42, 9, 'funny-portrait-pretty-woman-playing-with-big-fluffy-teddy-bear-sweet-pastel-colors-holding-her-present-sending-kiss-making-funny-face-holidays-joy-childhood.jpg', b'0', b'1', '2023-09-21 10:50:37', 1),
(43, 9, 'marketing-creative-collage-with-phone.jpg', b'1', b'1', '2023-09-25 12:48:13', 1),
(44, 18, '4c7dd5.webp', b'0', b'1', '2023-09-29 11:19:48', 1),
(45, 18, 'electric-blender-mixer-juicer-set.jpg', b'1', b'1', '2023-09-29 11:21:44', 1),
(46, 19, 'Bhujia_Sev.jpg', b'0', b'1', '2023-10-01 22:45:57', 7),
(47, 19, 'bhujiya_sev_1.webp', b'1', b'1', '2023-10-01 22:45:57', 7),
(48, 20, 'wagh-bakri-tea.jpg', b'1', b'1', '2023-10-03 10:45:41', 1),
(49, 20, '070417TeaShops01.jpg', b'0', b'1', '2023-10-03 10:46:25', 1),
(50, 21, '070417TeaShops01_1d31cbb8hepx1.jpg', b'1', b'1', '2023-10-03 12:43:57', 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_tags`
--

CREATE TABLE `product_tags` (
  `PkTagId` int(11) UNSIGNED NOT NULL,
  `FkCategoryId` int(11) UNSIGNED NOT NULL,
  `tagName` varchar(100) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_tags`
--

INSERT INTO `product_tags` (`PkTagId`, `FkCategoryId`, `tagName`, `isActive`, `isDeleted`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(1, 18, 'biscuits', b'1', b'0', '2023-09-11 10:57:18', 1, '2023-09-11 10:58:46', NULL),
(2, 36, 'printers', b'1', b'0', '2023-09-11 10:57:45', 1, NULL, NULL),
(3, 10, 'food', b'1', b'0', '2023-09-11 10:58:38', 1, '2023-09-14 16:36:40', 1),
(4, 19, 'Namkin', b'1', b'0', '2023-09-14 11:23:59', 1, '2023-10-01 22:44:26', 7),
(5, 41, 'sports', b'1', b'0', '2023-09-14 14:10:34', 1, NULL, NULL),
(6, 17, 'camera', b'1', b'0', '2023-09-14 14:10:43', 1, '2023-09-14 16:36:31', 1),
(7, 19, 'mixer', b'1', b'0', '2023-09-14 17:09:22', 1, NULL, NULL),
(8, 20, 'Green tea', b'1', b'0', '2023-09-14 17:09:32', 1, '2023-09-14 18:11:30', 1),
(9, 18, 'butter buiscuit', b'1', b'0', '2023-09-14 18:11:51', 1, NULL, NULL),
(10, 21, 'Noodles', b'1', b'0', '2023-09-15 15:14:51', 1, NULL, NULL),
(11, 19, 'Sev', b'1', b'0', '2023-10-02 00:09:42', 7, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `PkUserId` int(11) UNSIGNED NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `gender` bit(1) NOT NULL DEFAULT b'1',
  `password` varchar(100) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`PkUserId`, `token`, `firstName`, `lastName`, `email`, `dob`, `gender`, `password`, `image`) VALUES
(1, '18DDB337-AF2F-42EC-A056207956B2B437', 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '1995-08-20', b'0', '$2a$10$NCjOVZ4f9CPrTLH5oXWa0ODhx63orLLmJsHo.pwaim3xNRo/IdfnK', '3.jpg'),
(2, NULL, 'Nanu', 'Soni', 'nanu@gmail.com', '2002-07-19', b'0', '$2a$10$WdZ3G3tt5EMuP609CM.QC.n1jhre89/ci52EocGlyuFelh4ZCjHKy', NULL),
(3, NULL, 'gvedrfg', 'dftgd', 'admin@gmail.com', '1999-05-05', b'1', '$2a$10$93SlasObMG8s9J4NxYZHTOY34VzuCmuKxuTglyfM.EMjOA9L2ZvxO', NULL),
(4, NULL, 'test', 'test', 'mamta@gmail.com', '1997-03-04', b'1', '$2a$10$SzIln4DQUbKx6pCW6iwEw.QlL6GQOievpKVlWjHHqOqSJQbV021vy', NULL),
(5, NULL, 'Mamta', 'soni', '', '2006-04-11', b'0', '$2a$10$v3izpn/ocmrASfYmYtHp1uVb4fHokoD944y26vToQM9hbq/dDzBMa', NULL),
(6, NULL, 'fgujhg', 'gjg', 'ravina@gmail.com', '2007-08-15', b'0', '$2a$10$TUDPhJfaJHKxx3hNiHOy6.wWbD6ROhZFXd7mSBaN0qD4mOU.nXyQi', NULL),
(7, NULL, 'Vishal Kumar', 'Khatri', 'vishal.k@lucidsolutions.in', '1995-08-20', b'1', '$2a$10$vOKOnWE1xfkbLT0YuXRVtuCXH09oSE7WWnDJ50gUSrXtGNCefhVte', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`PkCategoryId`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`PkCustomerId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`PkProductId`),
  ADD KEY `FkCategoryId` (`FkCategoryId`);

--
-- Indexes for table `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`PkImageId`),
  ADD KEY `FkProductId` (`FkProductId`);

--
-- Indexes for table `product_tags`
--
ALTER TABLE `product_tags`
  ADD PRIMARY KEY (`PkTagId`),
  ADD KEY `FkCategoryId` (`FkCategoryId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`PkUserId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `PkCategoryId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `PkCustomerId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `PkProductId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `PkImageId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `product_tags`
--
ALTER TABLE `product_tags`
  MODIFY `PkTagId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `PkUserId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`FkCategoryId`) REFERENCES `category` (`PkCategoryId`);

--
-- Constraints for table `product_image`
--
ALTER TABLE `product_image`
  ADD CONSTRAINT `product_image_ibfk_1` FOREIGN KEY (`FkProductId`) REFERENCES `product` (`PkProductId`);

--
-- Constraints for table `product_tags`
--
ALTER TABLE `product_tags`
  ADD CONSTRAINT `product_tags_ibfk_1` FOREIGN KEY (`FkCategoryId`) REFERENCES `category` (`PkCategoryId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
