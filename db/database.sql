-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2023 at 11:21 AM
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
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `PkCartId` int(11) UNSIGNED NOT NULL,
  `FkCustomerId` int(11) UNSIGNED NOT NULL,
  `FkProductId` int(11) UNSIGNED NOT NULL,
  `FkCouponId` varchar(50) NOT NULL DEFAULT '0',
  `quantity` varchar(255) DEFAULT NULL,
  `price` float NOT NULL,
  `discountValue` float NOT NULL DEFAULT 0,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(82, 0, 'ryrty', 'oreo_jrbfoqkg9rd6.jpeg', b'1', b'1', '2023-09-21 10:29:21', 1, '2023-09-21 10:30:24', NULL),
(83, 0, 'Home & Furniture', '46b798_0412c5d3a7c7497c883a2dfdc7aed925_mv2_500x.webp', b'1', b'1', '2023-11-16 17:47:51', 1, '2023-11-16 17:55:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `PkCouponId` int(11) UNSIGNED NOT NULL,
  `FkProductId` int(11) UNSIGNED NOT NULL,
  `couponName` varchar(100) DEFAULT NULL,
  `couponCode` varchar(50) NOT NULL,
  `discountValue` float NOT NULL,
  `discountType` int(1) UNSIGNED NOT NULL,
  `couponStartDate` date NOT NULL,
  `couponExpDate` date NOT NULL,
  `repeatRestriction` int(1) UNSIGNED NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) UNSIGNED NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`PkCouponId`, `FkProductId`, `couponName`, `couponCode`, `discountValue`, `discountType`, `couponStartDate`, `couponExpDate`, `repeatRestriction`, `description`, `isActive`, `isDeleted`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(2, 0, '15 OFF DEP', '15OFFDEP', 15, 1, '2023-11-13', '2023-11-17', 1, 'Diwali festival: 15% off of all products', b'1', b'0', '2023-10-25 12:19:53', 1, '2023-11-15 15:29:41', 1),
(3, 9, '20 Off Tea', '20OFFTEA', 20, 1, '2023-10-25', '2023-11-15', 1, '20% off tea products', b'1', b'0', '2023-10-25 12:37:54', 1, '2023-11-15 16:07:13', 1),
(4, 0, 'test', 'APPFIRST', 200, 2, '2023-10-25', '2023-11-14', 1, 'For only test purpose\r\n', b'1', b'0', '2023-10-25 13:08:50', 1, '2023-11-15 17:54:35', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `PkCustomerId` int(10) UNSIGNED NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(12) DEFAULT NULL,
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

INSERT INTO `customer` (`PkCustomerId`, `firstName`, `token`, `lastName`, `email`, `mobile`, `password`, `dob`, `gender`, `profile`, `isBlcoked`, `isActive`, `isDeleted`, `createdBy`, `createdDate`, `updatedBy`, `updatedDate`) VALUES
(1, 'Mamta', NULL, 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', '$2a$10$EIMyk7EYrrx8WxTBnbROn.0pJ89u/lEZWSqSisWSgV7GjzY.Tzw4u', '2001-07-16', b'0', NULL, b'0', b'1', b'0', 0, '2023-08-11 08:05:50', 1, '2023-11-02 11:04:31'),
(2, 'test', NULL, 'test', 'mamta@yahoo.in', NULL, '$2a$10$qvrxiNNJUOrAY7s2pPLKcemxkZo85eZ0V2eC0ARMXLU0oAZtIho9K', '1996-03-04', b'1', '', b'0', b'1', b'1', 1, '2023-08-14 06:13:06', NULL, '2023-08-16 04:47:11'),
(3, 'test', NULL, 'test', 'ravi@gmail.com', NULL, '$2a$10$A7SBFgAOmO8DAQVc8lFoAuFSRq5zctd5GzcNRo.XE8ZHIbF3NMzfC', '1996-03-04', b'1', '', b'1', b'1', b'0', 1, '2023-08-14 06:16:56', NULL, '2023-11-02 12:17:23'),
(4, 'arfwseert', NULL, 'wqew', 'werwerwe@gmail.com', NULL, '$2a$10$pLmaV/d27yvvSvgiIMixoOGBMF3Nrns/CrxK9BwBTALx/01/wpt.q', '1997-04-05', b'0', NULL, b'1', b'1', b'0', 1, '2023-08-14 06:17:58', NULL, '2023-08-14 12:31:07'),
(5, 'sftstfg', NULL, 'ftggdrtfe', 'ravina@gmail.com', NULL, '$2a$10$2EwyauSjj5zYC9mDbCBA1OJhJd33TtaBd9B8HkX6Vd.mbHBCHRm4e', '2000-07-07', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:46:11', NULL, NULL),
(6, 'adsf', NULL, 'fwef', 'mamta123@lucidsolutions.in', NULL, '$2a$10$i.QZccW7zvDCZFFz5HQYMujS0DnEbYJ9N10RXQZNUjGZP8HyUCwTy', '1998-07-07', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:47:31', NULL, '2023-08-16 04:47:33'),
(7, '646485', NULL, 'wewe', 'ravina@gmail.com', NULL, '$2a$10$P5c5FgQXAyUrz0QNR3HigejG/jwkqT5LEJAc4oVoLaQaULlQvX2je', '2008-06-13', b'1', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:49:09', 1, '2023-08-14 10:57:55'),
(8, 'thyrtf', NULL, 'erty', 'yogesh.m@gmail.com', NULL, '$2a$10$Odo3.yQIaGKiixWQNMN0Ie/sEKJ81hAf6TYVXcMNe1qREuanDhzZC', '2001-03-08', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:53:33', NULL, NULL),
(9, 'thyrtf', NULL, 'erty', 'yogesh.m@gmail.com', NULL, '$2a$10$Nvroj5URmsNzMxLmUGz3Ru0jwI1o6RR9v0pAsEpdpd9TWd6bXGQ9C', '2001-03-08', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:54:49', NULL, NULL),
(10, 'tyrty', NULL, 'tyrty', 'yogesh.m@gmail.com', NULL, '$2a$10$dHnyMAEyGhgYEJRCdiDpsut8iAzWco/17W0QTzDPfFjVTXx2VbVue', '2010-05-15', b'1', '', b'0', b'1', b'1', 1, '2023-08-14 06:59:29', 1, '2023-08-14 12:19:47'),
(11, 'Vishal', NULL, 'Kumar Khatri', 'vishal.k@lucidsolutions.in', '8385079333', '$2a$10$EwOyXFxUEHfyoIp1.I5Ht./yX1tcpCyq094MI5ctIgTfYL9lIi0U6', '1995-08-20', b'1', NULL, b'0', b'1', b'0', 0, '2023-09-22 05:57:59', 11, '2023-11-02 06:12:39'),
(12, 'te', NULL, 'Soni', 'test@lucidsolutions.in', '895656321', '$2a$10$LZ3Px7UOUmo0eBYFZvTAguE733T7zGh66fN2tv2PGMhV5kYrLSgVu', '2003-06-13', b'1', NULL, b'0', b'1', b'0', 1, '2023-11-01 12:20:35', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `PkNotificationId` int(11) UNSIGNED NOT NULL,
  `FkOrderId` int(11) UNSIGNED NOT NULL,
  `subject` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `createdBy` int(10) UNSIGNED NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`PkNotificationId`, `FkOrderId`, `subject`, `message`, `createdBy`, `createdDate`) VALUES
(3, 43, 'New Order Placed 43', ' \'Vishal Kumar Khatri\' has placed a new order which is pending.', 11, '2023-11-17 10:08:09'),
(4, 44, 'New Order Placed 44', ' \'Vishal Kumar Khatri\' has placed a new order which is pending.', 11, '2023-11-17 10:34:11'),
(5, 45, 'New Order Placed 45', ' \'Mamta Soni\' has placed a new order which is pending.', 1, '2023-11-17 10:43:37');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `PkOrderId` int(10) UNSIGNED NOT NULL,
  `FkCustomerId` int(10) UNSIGNED NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `state` varchar(100) NOT NULL,
  `zipCode` int(6) NOT NULL,
  `billingFirstName` varchar(100) DEFAULT NULL,
  `billingLastName` varchar(100) DEFAULT NULL,
  `billingMobile` varchar(50) DEFAULT NULL,
  `billingAddress` text DEFAULT NULL,
  `billingState` varchar(100) DEFAULT NULL,
  `billingZipCode` int(6) DEFAULT NULL,
  `shipping` varchar(10) DEFAULT NULL,
  `finalAmount` float NOT NULL,
  `discountValue` float NOT NULL DEFAULT 0,
  `FkCouponId` varchar(50) NOT NULL DEFAULT '0',
  `paymentMethod` varchar(50) DEFAULT NULL,
  `UPIID` varchar(50) DEFAULT NULL,
  `creditCardName` varchar(100) DEFAULT NULL,
  `creditCardNumber` varchar(50) DEFAULT NULL,
  `cardExpieryDate` date DEFAULT NULL,
  `cvv` int(3) DEFAULT NULL,
  `status` int(1) UNSIGNED NOT NULL DEFAULT 0,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `createdBy` int(10) UNSIGNED NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedBy` int(10) DEFAULT NULL,
  `updatedDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`PkOrderId`, `FkCustomerId`, `firstName`, `lastName`, `email`, `mobile`, `address`, `state`, `zipCode`, `billingFirstName`, `billingLastName`, `billingMobile`, `billingAddress`, `billingState`, `billingZipCode`, `shipping`, `finalAmount`, `discountValue`, `FkCouponId`, `paymentMethod`, `UPIID`, `creditCardName`, `creditCardNumber`, `cardExpieryDate`, `cvv`, `status`, `isActive`, `isDeleted`, `createdBy`, `createdDate`, `updatedBy`, `updatedDate`) VALUES
(4, 11, 'Mamta', 'Soni', 'vishal.k@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 789650, 'Mamta', 'Soni', '8122891132', 'Chennai', 'TN', 789650, 'courier', 2850, 427.5, '0', 'cod', '', '', NULL, NULL, NULL, 1, b'1', b'0', 11, '2023-10-31 07:45:25', NULL, '2023-11-09 08:36:40'),
(5, 11, 'Vishal', 'Kumar Khatri', 'vishal.k@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 342008, 'Vishal', 'Kumar Khatri', '8122891132', 'Chennai', 'TN', 342008, 'free', 2060, 200, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 11, '2023-10-31 09:01:19', NULL, NULL),
(6, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'courier', 1340, 201, '0', 'upi', '8385079333@paytm', '', NULL, '2023-11-24', NULL, 0, b'1', b'0', 1, '2023-11-03 05:24:09', NULL, NULL),
(7, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 1142, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:28:33', NULL, NULL),
(8, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 55000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:29:54', NULL, NULL),
(9, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 55000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:29:59', NULL, NULL),
(10, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 55000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:30:05', NULL, NULL),
(11, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 55000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:30:11', NULL, NULL),
(12, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 55000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:30:12', NULL, NULL),
(13, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 55000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:30:23', NULL, NULL),
(14, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 55000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:30:24', NULL, NULL),
(15, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 56500, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:30:36', NULL, NULL),
(16, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 56500, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:30:37', NULL, NULL),
(17, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 56500, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:30:37', NULL, NULL),
(18, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 56500, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 05:31:07', NULL, NULL),
(19, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 264872000000000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 08:20:54', NULL, NULL),
(20, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 264872000000000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 08:21:03', NULL, NULL),
(21, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 150, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 08:21:31', NULL, NULL),
(22, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 150, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-07 08:23:42', NULL, NULL),
(23, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 1000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-08 06:16:08', NULL, NULL),
(24, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 1000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-08 06:16:16', NULL, NULL),
(25, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 1000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-08 06:22:07', NULL, NULL),
(26, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 1000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-08 06:22:26', NULL, NULL),
(27, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 1000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-08 06:22:43', NULL, NULL),
(28, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 1200, 0, '0', 'cod', '', '', NULL, NULL, NULL, 1, b'1', b'0', 1, '2023-11-08 06:32:46', NULL, '2023-11-09 05:33:45'),
(29, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'courier', 2200, 200, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-09 08:06:23', NULL, NULL),
(30, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'courier', 0, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-09 08:07:39', NULL, NULL),
(31, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 2000, 300, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 1, '2023-11-09 08:11:42', NULL, NULL),
(33, 11, 'Mamta', 'Soni', 'vishal.k@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 789650, 'Mamta', 'Soni', '8122891132', 'Chennai', 'TN', 789650, 'free', 1030, 154.5, '0', 'cod', '', '', NULL, NULL, NULL, 1, b'1', b'0', 11, '2023-11-09 08:29:50', NULL, '2023-11-17 08:00:25'),
(34, 11, 'Mamta', 'Soni', 'vishal.k@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 789650, 'Mamta', 'Soni', '8122891132', 'Chennai', 'TN', 789650, 'courier', 3000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 4, b'1', b'0', 11, '2023-11-09 12:07:00', NULL, '2023-11-17 08:15:17'),
(40, 11, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 789650, 'Mamta', 'Soni', '8122891132', 'Chennai', 'TN', 789650, 'free', 30, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 11, '2023-11-17 10:02:51', NULL, NULL),
(41, 11, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 789650, 'Mamta', 'Soni', '8122891132', 'Chennai', 'TN', 789650, 'free', 30, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 11, '2023-11-17 10:03:43', NULL, NULL),
(42, 11, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 789650, 'Mamta', 'Soni', '8122891132', 'Chennai', 'TN', 789650, 'free', 30, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 11, '2023-11-17 10:05:19', NULL, NULL),
(43, 11, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 789650, 'Mamta', 'Soni', '8122891132', 'Chennai', 'TN', 789650, 'free', 30, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 11, '2023-11-17 10:08:09', NULL, NULL),
(44, 11, 'Vishal ', 'Kumar Khatri', 'vishal.k@lucidsolutions.in', '8122891132', 'Chennai', 'TN', 789650, 'Vishal ', 'Kumar Khatri', '8122891132', 'Chennai', 'TN', 789650, 'nextDay', 1000, 0, '0', 'cod', '', '', NULL, NULL, NULL, 0, b'1', b'0', 11, '2023-11-17 10:34:11', NULL, NULL),
(45, 1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'Mamta', 'Soni', '8385079333', 'Mane Street Barber Shop Station Road', 'RJ', 342001, 'free', 1560, 234, '0', 'cod', '', '', NULL, NULL, NULL, 1, b'1', b'0', 1, '2023-11-17 10:43:37', NULL, '2023-11-17 11:59:47');

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `PkItemId` int(11) UNSIGNED NOT NULL,
  `FkCustomerId` int(11) UNSIGNED NOT NULL,
  `FkOrderId` int(11) UNSIGNED NOT NULL,
  `FkProductId` int(11) UNSIGNED NOT NULL,
  `FkCouponId` varchar(50) NOT NULL DEFAULT '0',
  `totalQuantity` int(50) NOT NULL,
  `totalCost` double NOT NULL,
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`PkItemId`, `FkCustomerId`, `FkOrderId`, `FkProductId`, `FkCouponId`, `totalQuantity`, `totalCost`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(8, 11, 4, 6, '2', 2, 2000, '2023-10-31 13:15:25', 11, NULL, NULL),
(9, 11, 4, 18, '2', 1, 850, '2023-10-31 13:15:25', 11, NULL, NULL),
(10, 11, 5, 12, '4', 2, 60, '2023-10-31 14:31:19', 11, NULL, NULL),
(11, 11, 5, 6, '4', 2, 2000, '2023-10-31 14:31:19', 11, NULL, NULL),
(12, 1, 6, 15, '2', 2, 60, '2023-11-03 10:54:09', 1, NULL, NULL),
(13, 1, 6, 1, '2', 5, 280, '2023-11-03 10:54:09', 1, NULL, NULL),
(14, 1, 6, 13, '2', 2, 1000, '2023-11-03 10:54:09', 1, NULL, NULL),
(15, 1, 7, 6, '0', 1, 1000, '2023-11-07 10:58:33', 1, NULL, NULL),
(16, 1, 7, 12, '0', 1, 30, '2023-11-07 10:58:33', 1, NULL, NULL),
(17, 1, 7, 1, '0', 2, 112, '2023-11-07 10:58:33', 1, NULL, NULL),
(18, 1, 22, 19, '0', 1, 150, '2023-11-07 13:53:42', 1, NULL, NULL),
(19, 1, 25, 20, '0', 1, 1000, '2023-11-08 11:52:07', 1, NULL, NULL),
(20, 1, 28, 9, '0', 2, 200, '2023-11-08 12:02:46', 1, NULL, NULL),
(21, 1, 28, 20, '0', 1, 1000, '2023-11-08 12:02:46', 1, NULL, NULL),
(22, 1, 29, 9, '4', 2, 200, '2023-11-09 13:36:23', 1, NULL, NULL),
(23, 1, 29, 20, '4', 2, 2000, '2023-11-09 13:36:23', 1, NULL, NULL),
(24, 1, 31, 20, '0', 2, 2000, '2023-11-09 13:41:42', 1, NULL, NULL),
(29, 11, 43, 15, '0', 1, 30, '2023-11-17 15:38:09', 11, NULL, NULL),
(30, 11, 44, 20, '0', 1, 1000, '2023-11-17 16:04:11', 11, NULL, NULL),
(31, 1, 45, 15, '2', 2, 60, '2023-11-17 16:13:37', 1, NULL, NULL),
(32, 1, 45, 6, '2', 1, 1000, '2023-11-17 16:13:37', 1, NULL, NULL),
(33, 1, 45, 13, '2', 1, 500, '2023-11-17 16:13:37', 1, NULL, NULL);

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
  `productQty` int(11) UNSIGNED NOT NULL,
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
(1, 18, 'PARLE G Original Gluco Biscuits Plain', '1', 56, 0, 'Filled with the goodness of milk and wheat, parle-g has been a source of all round nourishment for the nation since 1939.As its unique taste expanded over the globe, parle-g was declared the worlds largest selling biscuit brand by nielsen in 2003. Best paired with tea across India, dip this biscuit in your chai and relish the delicious taste like nothing in the world exists. Parle g gold is bigger, richer and tastier glucose biscuit.', b'1', b'0', '2023-09-13 15:36:01', 1, '2023-11-07 10:58:33', 1),
(2, 19, 'Anand Namkeen Thika Meetha mix', '4', 800, 10, 'testy', b'1', b'0', '2023-09-13 16:03:30', 1, '2023-10-03 10:40:06', 1),
(3, 28, 'Puma Snikers', '1,2', 55000, 20, 'edfwe', b'1', b'0', '2023-09-13 18:01:45', 1, '2023-10-09 14:56:23', 1),
(4, 41, 'T-SHIRT', '5', 850, 25, 'test', b'1', b'0', '2023-09-14 14:12:42', 1, '2023-10-11 12:37:30', 1),
(5, 7, 'Samsung Z-fold ', '1,5', 1500000, 5, 'folding phone', b'1', b'0', '2023-09-14 14:35:24', 1, '2023-09-18 14:40:58', 1),
(6, 18, 'Cookie', '9', 1000, 3, 'dased', b'1', b'0', '2023-09-14 14:59:19', 1, '2023-11-17 16:13:37', 1),
(7, 21, 'Meggie', '10', 500, 20, 'meggie', b'1', b'0', '2023-09-15 15:14:31', 1, '2023-10-03 10:38:20', 1),
(8, 19, 'Sona Namkeen', '4', 1500, 10, 'mixer', b'1', b'0', '2023-09-15 18:30:40', 1, '2023-10-11 16:45:21', 1),
(9, 20, 'Taj Mahal Tea 855', '8', 100, 21, 'tea', b'1', b'1', '2023-09-18 11:23:48', 1, '2023-11-16 18:48:11', 1),
(10, 18, 'crack jack', '1', 30, 22, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-10-23 17:02:04', NULL),
(11, 18, 'Hide & seek', '1', 30, 25, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-09-18 16:54:04', 1),
(12, 18, 'Oreo', '1', 30, 22, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-11-07 10:58:33', 1),
(13, 18, 'test', '1,9', 500, 45, 'ertert', b'1', b'0', '2023-09-18 16:55:11', 1, '2023-11-17 16:13:37', 1),
(14, 18, 'Monaco', '1', 30, 25, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-10-05 14:15:39', 1),
(15, 18, 'Britannia Good Day', '1', 30, 16, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-11-17 16:13:37', 1),
(16, 18, 'Oreo Pink Cream', '1,9', 30, 23, 'gretgf', b'1', b'0', '2023-09-18 16:51:22', 1, '2023-10-23 17:16:06', 1),
(17, 18, 'Sunfest', '1', 500, 50, 'ertert', b'1', b'0', '2023-09-18 16:55:11', 1, '2023-09-21 16:55:29', 1),
(18, 18, 'Choco Lava Cake', '9', 850, 19, 'Choco Lava Cake', b'1', b'0', '2023-09-29 11:19:48', 1, '2023-10-31 13:15:26', 1),
(19, 19, 'Bhujia Sev', '4,11', 150, 9, 'Haldiram\'s Bhujia is an authentic rendition of the classic, textured namkeen. Reach for a pack at teatime or top it on a steaming bowl of upma, poha or chaats.', b'1', b'0', '2023-10-01 22:45:57', 7, '2023-11-07 13:53:42', 7),
(20, 20, 'Wagh bakri Chai', '8', 1000, 18, 'Waagbakri Chai', b'1', b'0', '2023-10-03 10:45:41', 1, '2023-11-17 16:04:11', 1),
(21, 19, '5555555555', NULL, 55000, 20, 'ewe', b'1', b'0', '2023-10-03 12:43:57', 1, '2023-10-03 14:14:04', 1),
(22, 20, 'werwer', NULL, 25, 15, 'werfwe', b'1', b'1', '2023-11-14 16:20:18', 1, '2023-11-14 16:20:31', NULL),
(23, 20, 'Taj Mahal Tea', NULL, 100, 15, 'cf', b'1', b'0', '2023-11-16 15:49:57', 1, NULL, NULL),
(24, 21, 'Meggie Pasta', '10', 100, 20, 'ewew', b'1', b'0', '2023-11-16 16:28:20', 1, '2023-11-16 17:46:17', 1),
(25, 19, 'Taj Mahal Tea', NULL, 25, 15, 'y6rty7', b'1', b'1', '2023-11-16 16:30:57', 1, '2023-11-16 17:46:45', NULL),
(26, 19, 'Taj Mahal Tea', NULL, 25, 25, '7657', b'1', b'1', '2023-11-16 16:32:08', 1, '2023-11-16 17:46:33', NULL),
(27, 19, 'Taj Mahal Tea', NULL, 500, 20, 'sfsdf', b'1', b'1', '2023-11-16 16:32:45', 1, '2023-11-16 17:46:31', NULL),
(28, 18, 'Taj Mahal Tea566', NULL, 100, 20, 'wqeqw', b'1', b'1', '2023-11-16 17:32:29', 1, '2023-11-16 18:48:40', NULL);

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
(6, 2, 'anand-nmkieen_1nvr14ueh50bq.png', b'1', b'1', '2023-09-13 16:03:30', 1),
(11, 4, 'motorcycle-with-helmet.jpg', b'1', b'1', '2023-09-14 14:26:46', 1),
(12, 5, '22fddf3c7da4c4f4.webp', b'1', b'1', '2023-09-14 14:35:24', 1),
(15, 7, 'anand-nmkieen_1gfgiz2rj7f68.png', b'1', b'1', '2023-09-15 15:14:31', 1),
(18, 8, '360_F_228074132_GXAkRxpdhNIUd7E6Sv3XEwybixD8Z1yf.jpg', b'1', b'1', '2023-09-15 18:30:40', 1),
(24, 8, 'png-transparent-vegetarian-cuisine-dal-french-fries-ramoji-wafer-and-namkeen-pvt-ltd-food-junk-food-food-recipe-wafer.png', b'0', b'1', '2023-09-15 18:40:02', 1),
(27, 6, 'istockphoto-178716575-612x612.jpg', b'1', b'1', '2023-09-18 11:54:00', 1),
(30, 6, '-original-imagpa5fbvqzk2xn.webp', b'0', b'1', '2023-09-18 12:09:15', 1),
(32, 10, 'download_erhh4bljuzrf.jpg', b'1', b'1', '2023-09-18 16:51:22', 1),
(33, 11, 'b7ade9.webp', b'1', b'1', '2023-09-18 16:52:51', 1),
(34, 12, 'download_qkjz9swh03c0.jpg', b'1', b'1', '2023-09-18 16:53:58', 1),
(35, 13, 'canon-eos-eos-3000d-dslr-original-imaf3t5h9yuyc5zu.webp', b'1', b'1', '2023-09-18 16:55:11', 1),
(38, 15, 'png-transparent-vegetarian-cuisine-dal-french-fries-ramoji-wafer-and-namkeen-pvt-ltd-food-junk-food-food-recipe-wafer_zy613kygnovy.png', b'1', b'1', '2023-09-18 17:09:03', 1),
(39, 16, 'oreo.jpeg', b'1', b'1', '2023-09-18 17:10:44', 1),
(40, 17, 'oreo_6wpihl66wp5r.jpeg', b'1', b'1', '2023-09-18 17:11:04', 1),
(41, 14, '360_F_228074132_GXAkRxpdhNIUd7E6Sv3XEwybixD8Z1yf_18c5p6s3pjp5.jpg', b'1', b'1', '2023-09-18 17:11:38', 1),
(42, 9, 'funny-portrait-pretty-woman-playing-with-big-fluffy-teddy-bear-sweet-pastel-colors-holding-her-present-sending-kiss-making-funny-face-holidays-joy-childhood.jpg', b'1', b'1', '2023-09-21 10:50:37', 1),
(43, 9, 'marketing-creative-collage-with-phone.jpg', b'0', b'1', '2023-09-25 12:48:13', 1),
(45, 18, 'electric-blender-mixer-juicer-set.jpg', b'1', b'1', '2023-09-29 11:21:44', 1),
(46, 19, 'Bhujia_Sev.jpg', b'1', b'1', '2023-10-01 22:45:57', 7),
(47, 19, 'bhujiya_sev_1.webp', b'0', b'1', '2023-10-01 22:45:57', 7),
(48, 20, 'wagh-bakri-tea.jpg', b'1', b'1', '2023-10-03 10:45:41', 1),
(49, 20, '070417TeaShops01.jpg', b'0', b'1', '2023-10-03 10:46:25', 1),
(50, 21, '070417TeaShops01_1d31cbb8hepx1.jpg', b'1', b'1', '2023-10-03 12:43:57', 1),
(54, 1, 'b5c22e_3f0bf41ae1c84a9e8fe6f505f80580d5_mv2_500x.webp', b'1', b'1', '2023-10-05 11:50:05', 1),
(55, 1, '46b798_0412c5d3a7c7497c883a2dfdc7aed925_mv2_500x.webp', b'0', b'1', '2023-10-05 11:50:05', 1),
(57, 1, '925036427-3444501-1.jpg', b'0', b'1', '2023-10-05 12:05:04', 1),
(58, 14, '070417TeaShops01_ey82bknl49ky.jpg', b'0', b'1', '2023-10-05 14:15:39', 1),
(61, 3, 'portrait-smiling-beautiful-girl-her-handsome-boyfriend-laughing-happy-cheerful-couple-sunglasses_ilkqjj831sgv.jpg', b'1', b'1', '2023-10-09 14:56:08', 1),
(62, 15, 'anand-nmkieen.png', b'0', b'1', '2023-11-08 14:38:07', 1),
(63, 22, '925036427-3444501-1_1xiyqqiuya1nb.jpg', b'0', b'1', '2023-11-14 16:20:18', 1),
(64, 23, 'wagh-bakri-tea_1sxi62wl7m48z.jpg', b'0', b'1', '2023-11-16 15:49:57', 1),
(65, 24, '925036427-3444501-1_j8v4cwm3y99z.jpg', b'0', b'1', '2023-11-16 16:28:20', 1),
(66, 25, 'wagh-bakri-tea_1p66r6ugube1a.jpg', b'0', b'1', '2023-11-16 16:30:57', 1),
(67, 26, '925036427-3444501-1_mh4l04q4ll5b.jpg', b'0', b'1', '2023-11-16 16:32:08', 1),
(68, 27, '070417TeaShops01_10fc9fsfugk59.jpg', b'0', b'1', '2023-11-16 16:32:45', 1),
(69, 28, '925036427-3444501-1_1b72566j8pjko.jpg', b'0', b'1', '2023-11-16 17:32:30', 1);

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
(8, 20, 'Green tea', b'1', b'0', '2023-09-14 17:09:32', 1, '2023-11-16 18:00:15', 1),
(9, 18, 'butter buiscuit', b'1', b'0', '2023-09-14 18:11:51', 1, NULL, NULL),
(10, 21, 'Noodles', b'1', b'0', '2023-09-15 15:14:51', 1, NULL, NULL),
(11, 19, 'Sev', b'1', b'0', '2023-10-02 00:09:42', 7, '2023-10-11 12:43:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_wishlist`
--

CREATE TABLE `product_wishlist` (
  `PkWishListId` int(11) UNSIGNED NOT NULL,
  `FkProductId` int(11) UNSIGNED NOT NULL,
  `FkCustomerId` int(11) UNSIGNED NOT NULL,
  `isLike` bit(1) NOT NULL DEFAULT b'0',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_wishlist`
--

INSERT INTO `product_wishlist` (`PkWishListId`, `FkProductId`, `FkCustomerId`, `isLike`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(1, 15, 1, b'0', '2023-11-03 14:53:47', 1, '2023-11-09 10:18:02', 1),
(2, 1, 1, b'0', '2023-11-03 15:34:23', 1, '2023-11-06 16:37:34', 1),
(3, 6, 1, b'0', '2023-11-03 15:55:59', 1, '2023-11-06 13:54:02', 1),
(4, 10, 1, b'0', '2023-11-08 11:56:14', 1, '2023-11-09 13:48:26', 1),
(5, 20, 1, b'0', '2023-11-08 12:28:48', 1, '2023-11-09 13:52:21', 1),
(6, 15, 11, b'0', '2023-11-09 13:53:45', 11, '2023-11-09 13:53:53', 11),
(7, 13, 11, b'1', '2023-11-09 14:50:42', 11, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `send_notification`
--

CREATE TABLE `send_notification` (
  `PkSendNotificationId` int(11) UNSIGNED NOT NULL,
  `FkNotificationId` int(11) UNSIGNED NOT NULL,
  `receiver_id` int(11) UNSIGNED NOT NULL,
  `isRead` bit(1) NOT NULL DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `send_notification`
--

INSERT INTO `send_notification` (`PkSendNotificationId`, `FkNotificationId`, `receiver_id`, `isRead`) VALUES
(4, 3, 1, b'1'),
(5, 3, 7, b'0'),
(6, 4, 1, b'0'),
(7, 4, 7, b'0'),
(8, 5, 1, b'1'),
(9, 5, 7, b'0');

-- --------------------------------------------------------

--
-- Table structure for table `status_history`
--

CREATE TABLE `status_history` (
  `PkHistoryId` int(11) UNSIGNED NOT NULL,
  `FkOrderId` int(11) UNSIGNED NOT NULL,
  `status` int(1) NOT NULL,
  `comment` text DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status_history`
--

INSERT INTO `status_history` (`PkHistoryId`, `FkOrderId`, `status`, `comment`, `createdBy`, `dateCreated`) VALUES
(9, 4, 0, NULL, 11, '2023-10-31 13:15:25'),
(10, 5, 0, NULL, 11, '2023-10-31 14:31:19'),
(11, 6, 0, NULL, 1, '2023-11-03 10:54:09'),
(12, 7, 0, NULL, 1, '2023-11-07 10:58:33'),
(13, 8, 0, NULL, 1, '2023-11-07 10:59:54'),
(14, 9, 0, NULL, 1, '2023-11-07 10:59:59'),
(15, 10, 0, NULL, 1, '2023-11-07 11:00:05'),
(16, 11, 0, NULL, 1, '2023-11-07 11:00:11'),
(17, 12, 0, NULL, 1, '2023-11-07 11:00:12'),
(18, 13, 0, NULL, 1, '2023-11-07 11:00:23'),
(19, 14, 0, NULL, 1, '2023-11-07 11:00:24'),
(20, 15, 0, NULL, 1, '2023-11-07 11:00:36'),
(21, 16, 0, NULL, 1, '2023-11-07 11:00:37'),
(22, 17, 0, NULL, 1, '2023-11-07 11:00:37'),
(23, 18, 0, NULL, 1, '2023-11-07 11:01:07'),
(24, 19, 0, NULL, 1, '2023-11-07 13:50:54'),
(25, 20, 0, NULL, 1, '2023-11-07 13:51:03'),
(26, 21, 0, NULL, 1, '2023-11-07 13:51:31'),
(27, 22, 0, NULL, 1, '2023-11-07 13:53:42'),
(28, 23, 0, NULL, 1, '2023-11-08 11:46:08'),
(29, 24, 0, NULL, 1, '2023-11-08 11:46:16'),
(30, 25, 0, NULL, 1, '2023-11-08 11:52:07'),
(31, 26, 0, NULL, 1, '2023-11-08 11:52:26'),
(32, 27, 0, NULL, 1, '2023-11-08 11:52:43'),
(33, 28, 0, NULL, 1, '2023-11-08 12:02:46'),
(34, 28, 1, '', 1, '2023-11-09 10:55:28'),
(35, 28, 2, '', 1, '2023-11-09 11:03:08'),
(36, 28, 1, 'test', 1, '2023-11-09 11:03:45'),
(37, 29, 0, NULL, 1, '2023-11-09 13:36:23'),
(38, 30, 0, NULL, 1, '2023-11-09 13:37:39'),
(39, 31, 0, NULL, 1, '2023-11-09 13:41:42'),
(41, 33, 0, NULL, 11, '2023-11-09 13:59:50'),
(42, 4, 1, 'testing', 1, '2023-11-09 14:06:40'),
(43, 4, 1, 'testing', 1, '2023-11-09 14:07:14'),
(44, 34, 0, NULL, 11, '2023-11-09 17:37:00'),
(45, 34, 1, '', 1, '2023-11-17 12:02:27'),
(46, 33, 3, '', 1, '2023-11-17 13:29:55'),
(47, 33, 5, '', 1, '2023-11-17 13:30:17'),
(48, 33, 3, '', 1, '2023-11-17 13:30:22'),
(49, 33, 1, '', 1, '2023-11-17 13:30:25'),
(50, 34, 3, '', 1, '2023-11-17 13:42:41'),
(51, 34, 3, '', 1, '2023-11-17 13:43:05'),
(52, 34, 4, '', 1, '2023-11-17 13:45:17'),
(53, 35, 0, NULL, 11, '2023-11-17 15:29:25'),
(54, 36, 0, NULL, 11, '2023-11-17 15:29:29'),
(55, 37, 0, NULL, 11, '2023-11-17 15:29:33'),
(56, 38, 0, NULL, 11, '2023-11-17 15:30:24'),
(57, 39, 0, NULL, 11, '2023-11-17 15:30:26'),
(58, 40, 0, NULL, 11, '2023-11-17 15:32:51'),
(59, 41, 0, NULL, 11, '2023-11-17 15:33:43'),
(60, 42, 0, NULL, 11, '2023-11-17 15:35:19'),
(61, 43, 0, NULL, 11, '2023-11-17 15:38:09'),
(62, 44, 0, NULL, 11, '2023-11-17 16:04:11'),
(63, 45, 0, NULL, 1, '2023-11-17 16:13:37'),
(64, 45, 1, '', 1, '2023-11-17 17:29:47');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `PkUserId` int(11) UNSIGNED NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` varchar(12) DEFAULT NULL,
  `dob` date NOT NULL,
  `gender` bit(1) NOT NULL DEFAULT b'1',
  `password` varchar(100) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `createdBy` int(10) UNSIGNED NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedBy` int(10) DEFAULT NULL,
  `updatedDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`PkUserId`, `firstName`, `token`, `lastName`, `email`, `mobile`, `dob`, `gender`, `password`, `image`, `isActive`, `isDeleted`, `createdBy`, `createdDate`, `updatedBy`, `updatedDate`) VALUES
(1, 'Mamta', NULL, 'Soni', 'mamta.s@lucidsolutions.in', '8385079333', '1995-08-20', b'0', '$2a$10$NCjOVZ4f9CPrTLH5oXWa0ODhx63orLLmJsHo.pwaim3xNRo/IdfnK', 'funny-portrait-pretty-woman-playing-with-big-fluffy-teddy-bear-sweet-pastel-colors-holding-her-present-sending-kiss-making-funny-face-holidays-joy-childhood.jpg', b'1', b'0', 0, '2023-11-02 11:08:46', 1, '2023-11-15 05:32:46'),
(2, 'Nanu', NULL, 'Soni', 'nanu@gmail.com', '8385079333', '2002-07-19', b'0', '$2a$10$WdZ3G3tt5EMuP609CM.QC.n1jhre89/ci52EocGlyuFelh4ZCjHKy', NULL, b'1', b'0', 0, '2023-11-02 11:08:46', 1, '2023-11-14 12:48:11'),
(3, 'gvedrfg', NULL, 'dftgd', 'admin@gmail.com', NULL, '1999-05-05', b'1', '$2a$10$93SlasObMG8s9J4NxYZHTOY34VzuCmuKxuTglyfM.EMjOA9L2ZvxO', '', b'1', b'1', 0, '2023-11-02 11:08:46', NULL, '2023-11-02 12:22:55'),
(4, 'test', NULL, 'test', 'mamta@gmail.com', NULL, '1997-03-04', b'1', '$2a$10$SzIln4DQUbKx6pCW6iwEw.QlL6GQOievpKVlWjHHqOqSJQbV021vy', NULL, b'1', b'0', 0, '2023-11-02 11:08:46', NULL, NULL),
(5, 'Mamta', NULL, 'soni', '', NULL, '2006-04-11', b'0', '$2a$10$v3izpn/ocmrASfYmYtHp1uVb4fHokoD944y26vToQM9hbq/dDzBMa', '', b'1', b'1', 0, '2023-11-02 11:08:46', NULL, '2023-11-06 09:24:44'),
(6, 'fgujhg', NULL, 'gjg', 'ravina@gmail.com', NULL, '2007-08-15', b'0', '$2a$10$TUDPhJfaJHKxx3hNiHOy6.wWbD6ROhZFXd7mSBaN0qD4mOU.nXyQi', '', b'1', b'1', 0, '2023-11-02 11:08:46', NULL, '2023-11-02 12:23:06'),
(7, 'Vishal Kumar', NULL, 'Khatri', 'vishal.k@lucidsolutions.in', NULL, '1995-08-20', b'1', '$2a$10$vOKOnWE1xfkbLT0YuXRVtuCXH09oSE7WWnDJ50gUSrXtGNCefhVte', NULL, b'1', b'0', 0, '2023-11-02 11:08:46', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`PkCartId`),
  ADD KEY `FkCustomerId` (`FkCustomerId`),
  ADD KEY `FkProductId` (`FkProductId`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`PkCategoryId`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`PkCouponId`),
  ADD KEY `FkProductId` (`FkProductId`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`PkCustomerId`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`PkNotificationId`),
  ADD KEY `FkOrderId` (`FkOrderId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`PkOrderId`),
  ADD KEY `FkCustomerId` (`FkCustomerId`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`PkItemId`),
  ADD KEY `FkCustomerId` (`FkCustomerId`),
  ADD KEY `FkProductId` (`FkProductId`),
  ADD KEY `FkOrderId` (`FkOrderId`);

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
-- Indexes for table `product_wishlist`
--
ALTER TABLE `product_wishlist`
  ADD PRIMARY KEY (`PkWishListId`),
  ADD KEY `FkProductId` (`FkProductId`),
  ADD KEY `FkCustomerId` (`FkCustomerId`);

--
-- Indexes for table `send_notification`
--
ALTER TABLE `send_notification`
  ADD PRIMARY KEY (`PkSendNotificationId`),
  ADD KEY `FkNotificationId` (`FkNotificationId`);

--
-- Indexes for table `status_history`
--
ALTER TABLE `status_history`
  ADD PRIMARY KEY (`PkHistoryId`),
  ADD KEY `FkOrderId` (`FkOrderId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`PkUserId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `PkCartId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=458;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `PkCategoryId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `PkCouponId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `PkCustomerId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `PkNotificationId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `PkOrderId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `PkItemId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `PkProductId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `PkImageId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `product_tags`
--
ALTER TABLE `product_tags`
  MODIFY `PkTagId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `product_wishlist`
--
ALTER TABLE `product_wishlist`
  MODIFY `PkWishListId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `send_notification`
--
ALTER TABLE `send_notification`
  MODIFY `PkSendNotificationId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `status_history`
--
ALTER TABLE `status_history`
  MODIFY `PkHistoryId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `PkUserId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`FkCustomerId`) REFERENCES `customer` (`PkCustomerId`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`FkProductId`) REFERENCES `product` (`PkProductId`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`FkOrderId`) REFERENCES `orders` (`PkOrderId`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`FkCustomerId`) REFERENCES `customer` (`PkCustomerId`);

--
-- Constraints for table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`FkCustomerId`) REFERENCES `customer` (`PkCustomerId`),
  ADD CONSTRAINT `order_item_ibfk_3` FOREIGN KEY (`FkProductId`) REFERENCES `product` (`PkProductId`),
  ADD CONSTRAINT `order_item_ibfk_4` FOREIGN KEY (`FkOrderId`) REFERENCES `orders` (`PkOrderId`);

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

--
-- Constraints for table `product_wishlist`
--
ALTER TABLE `product_wishlist`
  ADD CONSTRAINT `product_wishlist_ibfk_1` FOREIGN KEY (`FkProductId`) REFERENCES `product` (`PkProductId`),
  ADD CONSTRAINT `product_wishlist_ibfk_2` FOREIGN KEY (`FkCustomerId`) REFERENCES `customer` (`PkCustomerId`);

--
-- Constraints for table `send_notification`
--
ALTER TABLE `send_notification`
  ADD CONSTRAINT `send_notification_ibfk_1` FOREIGN KEY (`FkNotificationId`) REFERENCES `notifications` (`PkNotificationId`);

--
-- Constraints for table `status_history`
--
ALTER TABLE `status_history`
  ADD CONSTRAINT `status_history_ibfk_1` FOREIGN KEY (`FkOrderId`) REFERENCES `orders` (`PkOrderId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
