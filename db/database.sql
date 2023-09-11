-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 11, 2023 at 03:12 PM
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
(5, 0, 'Appliances', 'electric-blender-mixer-juicer-set.jpg', b'1', b'0', '2023-09-08 10:56:04', 1, '2023-09-08 12:10:17', 1),
(6, 0, 'Beauty, Toys & More', 'cute-cheerful-little-girl-with-teddy-bear-blue-wall.jpg', b'1', b'0', '2023-09-08 10:56:26', 1, '2023-09-08 14:32:10', 1),
(7, 0, 'Mobiles', 'marketing-creative-collage-with-phone.jpg', b'1', b'0', '2023-09-08 10:56:55', 1, '2023-09-08 14:35:03', 1),
(8, 0, 'Two Wheelers', 'motorcycle-with-helmet.jpg', b'1', b'0', '2023-09-08 10:57:22', 1, '2023-09-08 14:38:24', 1),
(9, 1, 'Snacks & Beverages', '9fbd36.webp', b'1', b'0', '2023-09-08 10:58:30', 1, '2023-09-08 10:58:28', NULL),
(10, 1, 'Packaged Food', 'ac8550.webp', b'1', b'0', '2023-09-08 10:58:53', 1, '2023-09-08 10:58:51', NULL),
(11, 1, 'Staples', '50474c.webp', b'1', b'0', '2023-09-08 10:59:16', 1, '2023-09-08 10:59:15', NULL),
(12, 1, 'Household Care', 'b7ade9.webp', b'1', b'0', '2023-09-08 10:59:49', 1, '2023-09-08 10:59:48', NULL),
(13, 2, 'Men\'s Wear', '-original-imagnbzq8acbnh3m.webp', b'1', b'0', '2023-09-08 11:01:20', 1, '2023-09-08 11:01:18', NULL),
(14, 2, 'Women\'s Wear', 'l-mf19kr414g-mon-original-imagsszy6fqxxueq.webp', b'1', b'0', '2023-09-08 11:02:52', 1, '2023-09-08 11:02:51', NULL),
(15, 2, 'Kid\'s Wear', '12-18-months-black-velvet-crazylife-fashion-original-imagsj4cpvngzx4a.webp', b'1', b'0', '2023-09-08 11:03:42', 1, '2023-09-08 11:03:40', NULL),
(16, 3, 'Computer Peripherals', '-original-imagpa5fbvqzk2xn.webp', b'1', b'0', '2023-09-08 11:05:37', 1, '2023-09-08 11:05:36', NULL),
(17, 3, 'Cameras & Accessories', 'canon-eos-eos-3000d-dslr-original-imaf3t5h9yuyc5zu.webp', b'1', b'0', '2023-09-08 11:07:39', 1, '2023-09-08 11:07:37', NULL),
(18, 9, 'Biscuits', NULL, b'1', b'0', '2023-09-08 11:28:21', 1, NULL, NULL),
(19, 9, 'Namkin', NULL, b'1', b'0', '2023-09-08 11:28:31', 1, NULL, NULL),
(20, 9, 'Tea ', NULL, b'1', b'0', '2023-09-08 11:28:46', 1, NULL, NULL),
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
(31, 14, 'Western wear', NULL, b'1', b'0', '2023-09-08 12:00:02', 1, NULL, NULL),
(32, 14, 'Sarees', NULL, b'1', b'0', '2023-09-08 12:00:11', 1, NULL, NULL),
(33, 14, 'Antalkali ', NULL, b'1', b'0', '2023-09-08 12:00:30', 1, NULL, NULL),
(34, 15, 'Boy\'s Fashion', NULL, b'1', b'0', '2023-09-08 12:00:55', 1, NULL, NULL),
(35, 15, 'Girl\'s Fashion', NULL, b'1', b'0', '2023-09-08 12:01:18', 1, NULL, NULL),
(36, 16, 'Printers', NULL, b'1', b'0', '2023-09-08 12:02:26', 1, NULL, NULL),
(37, 16, 'Moniters', NULL, b'1', b'0', '2023-09-08 12:05:51', 1, NULL, NULL),
(38, 16, 'Toners', NULL, b'1', b'0', '2023-09-08 12:06:06', 1, NULL, NULL),
(39, 17, 'DSLR & Mirrorless', NULL, b'1', b'0', '2023-09-08 12:13:32', 1, NULL, NULL),
(40, 17, 'Compact & Bridge Cameras', NULL, b'1', b'0', '2023-09-08 12:14:22', 1, NULL, NULL),
(41, 17, 'Sports & Action', NULL, b'1', b'0', '2023-09-08 12:15:00', 1, NULL, NULL),
(42, 4, 'Kitchen & dining', NULL, b'1', b'0', '2023-09-08 12:16:11', 1, NULL, NULL),
(43, 4, 'Home Decor', NULL, b'1', b'0', '2023-09-08 12:16:41', 1, NULL, NULL);

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
(1, NULL, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '$2a$10$y0k8/Sap/WLAHSclo/Uex.ejyzRFfKPmHyOS2Zy/0W.Jqbm1T1hZG', '2001-07-16', b'0', NULL, b'0', b'0', b'0', 0, '2023-08-11 08:05:50', NULL, '2023-08-14 12:28:46'),
(2, NULL, 'test', 'test', 'mamta@yahoo.in', '$2a$10$qvrxiNNJUOrAY7s2pPLKcemxkZo85eZ0V2eC0ARMXLU0oAZtIho9K', '1996-03-04', b'1', '', b'0', b'1', b'1', 1, '2023-08-14 06:13:06', NULL, '2023-08-16 04:47:11'),
(3, NULL, 'test', 'test', 'ravi@gmail.com', '$2a$10$A7SBFgAOmO8DAQVc8lFoAuFSRq5zctd5GzcNRo.XE8ZHIbF3NMzfC', '1996-03-04', b'1', NULL, b'1', b'1', b'0', 1, '2023-08-14 06:16:56', NULL, '2023-08-16 04:47:26'),
(4, NULL, 'arfwseert', 'wqew', 'werwerwe@gmail.com', '$2a$10$pLmaV/d27yvvSvgiIMixoOGBMF3Nrns/CrxK9BwBTALx/01/wpt.q', '1997-04-05', b'0', NULL, b'1', b'1', b'0', 1, '2023-08-14 06:17:58', NULL, '2023-08-14 12:31:07'),
(5, NULL, 'sftstfg', 'ftggdrtfe', 'ravina@gmail.com', '$2a$10$2EwyauSjj5zYC9mDbCBA1OJhJd33TtaBd9B8HkX6Vd.mbHBCHRm4e', '2000-07-07', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:46:11', NULL, NULL),
(6, NULL, 'adsf', 'fwef', 'mamta123@lucidsolutions.in', '$2a$10$i.QZccW7zvDCZFFz5HQYMujS0DnEbYJ9N10RXQZNUjGZP8HyUCwTy', '1998-07-07', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:47:31', NULL, '2023-08-16 04:47:33'),
(7, NULL, '646485', 'wewe', 'ravina@gmail.com', '$2a$10$P5c5FgQXAyUrz0QNR3HigejG/jwkqT5LEJAc4oVoLaQaULlQvX2je', '2008-06-13', b'1', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:49:09', 1, '2023-08-14 10:57:55'),
(8, NULL, 'thyrtf', 'erty', 'yogesh.m@gmail.com', '$2a$10$Odo3.yQIaGKiixWQNMN0Ie/sEKJ81hAf6TYVXcMNe1qREuanDhzZC', '2001-03-08', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:53:33', NULL, NULL),
(9, NULL, 'thyrtf', 'erty', 'yogesh.m@gmail.com', '$2a$10$Nvroj5URmsNzMxLmUGz3Ru0jwI1o6RR9v0pAsEpdpd9TWd6bXGQ9C', '2001-03-08', b'0', NULL, b'0', b'1', b'0', 1, '2023-08-14 06:54:49', NULL, NULL),
(10, NULL, 'tyrty', 'tyrty', 'yogesh.m@gmail.com', '$2a$10$dHnyMAEyGhgYEJRCdiDpsut8iAzWco/17W0QTzDPfFjVTXx2VbVue', '2010-05-15', b'1', '', b'0', b'1', b'1', 1, '2023-08-14 06:59:29', 1, '2023-08-14 12:19:47');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `PkProductId` int(11) UNSIGNED NOT NULL,
  `FkCategoryId` int(11) UNSIGNED NOT NULL,
  `productName` varchar(100) NOT NULL,
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

INSERT INTO `product` (`PkProductId`, `FkCategoryId`, `productName`, `productPrice`, `productQty`, `productDescription`, `isActive`, `isDeleted`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(1, 18, 'PARLE G Original Gluco Biscuits Plain', 100, 5, '', b'1', b'0', '2023-09-08 14:47:51', 1, '2023-09-11 17:40:28', 1),
(2, 18, 'UNIBIC Rich Chocolate Wafers', 25, 5, '', b'1', b'0', '2023-09-08 14:51:28', 1, '2023-09-11 17:51:51', 1),
(3, 19, 'Anand Namkeen ', 500, 1, 'Thika Meetha mix', b'1', b'0', '2023-09-11 12:13:42', 1, '2023-09-11 17:05:00', 1),
(4, 19, 'Gopal Namkeen', 850, 10, 'Ratlami Sev', b'1', b'0', '2023-09-11 13:31:49', 1, '2023-09-11 17:05:32', 1),
(5, 21, 'pasta', 850, 13, 'test', b'1', b'0', '2023-09-11 15:47:16', 1, '2023-09-11 17:37:23', 1),
(6, 26, 'testy', 500, 25, 'test', b'1', b'0', '2023-09-11 15:49:42', 1, '2023-09-11 17:52:55', 1),
(7, 26, 'MDH Sambhar Masala', 500, 25, 'test', b'1', b'0', '2023-09-11 15:52:59', 1, '2023-09-11 16:58:22', 1),
(8, 26, 'Catch Pavbhaji Masala', 500, 25, 'test', b'1', b'0', '2023-09-11 15:53:53', 1, '2023-09-11 17:39:54', 1),
(11, 27, 'T-SHIRT', 850, 10, 'gdg', b'1', b'0', '2023-09-11 16:10:51', 1, '2023-09-11 17:07:59', 1),
(16, 37, 'Sony 4K Smart TV', 500, 15, 'NBCBMCBN ', b'1', b'0', '2023-09-11 16:35:48', 1, '2023-09-11 17:52:37', 1),
(21, 43, 'Wooden Frame', 850, 15, 'rwerw', b'1', b'0', '2023-09-11 16:49:58', 1, '2023-09-11 18:33:41', 1),
(27, 15, 'hello', 25, 20, 'eter', b'1', b'0', '2023-09-11 17:30:15', 1, NULL, NULL),
(28, 19, 'Red Color School Beg', 55000, 20, 'weqw', b'1', b'0', '2023-09-11 17:31:47', 1, '2023-09-11 17:35:30', 1);

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
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_image`
--

INSERT INTO `product_image` (`PkImageId`, `FkProductId`, `image`, `isDefault`, `isActive`, `isDeleted`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(1, 3, 'ratlami-sev_1xp2xmc313ng4.png', b'0', b'1', b'0', '2023-09-11 17:05:00', 1, NULL, NULL),
(2, 3, 'anand-nmkieen_1mkf0z2h032iy.png', b'0', b'1', b'0', '2023-09-11 17:05:00', 1, NULL, NULL),
(3, 3, '31-315722_product-image-parle-g-biscuit-25-gm_1rmduislgdbgq.png', b'0', b'1', b'0', '2023-09-11 17:05:00', 1, NULL, NULL),
(4, 4, 'ratlami-sev_94608lkau4d.png', b'0', b'1', b'0', '2023-09-11 17:05:32', 1, NULL, NULL),
(5, 4, '31-315722_product-image-parle-g-biscuit-25-gm_1pbsqauebaww8.png', b'0', b'1', b'0', '2023-09-11 17:05:32', 1, NULL, NULL),
(6, 4, 'images (2)_12kxjeok77cfv.jpg', b'0', b'1', b'0', '2023-09-11 17:05:32', 1, NULL, NULL),
(7, 11, 'portrait-smiling-beautiful-girl-her-handsome-boyfriend-laughing-happy-cheerful-couple-sunglasses.jpg', b'0', b'1', b'0', '2023-09-11 17:07:00', 1, NULL, NULL),
(8, 11, 'fashion_xwo46843rbuh.jpg', b'0', b'1', b'0', '2023-09-11 17:07:00', 1, NULL, NULL),
(9, 11, 'images (1).jfif', b'0', b'1', b'0', '2023-09-11 17:07:00', 1, NULL, NULL),
(10, 11, 'cute-cheerful-little-girl-with-teddy-bear-blue-wall.jpg', b'0', b'1', b'0', '2023-09-11 17:07:59', 1, NULL, NULL),
(11, 11, 'funny-portrait-pretty-woman-playing-with-big-fluffy-teddy-bear-sweet-pastel-colors-holding-her-present-sending-kiss-making-funny-face-holidays-joy-childhood (1).jpg', b'0', b'1', b'0', '2023-09-11 17:07:59', 1, NULL, NULL),
(12, 1, '31-315722_product-image-parle-g-biscuit-25-gm - Copy.png', b'0', b'1', b'0', '2023-09-11 17:08:43', 1, NULL, NULL),
(13, 1, '31-315722_product-image-parle-g-biscuit-25-gm_8jlzu7cuotdf.png', b'0', b'1', b'0', '2023-09-11 17:08:43', 1, NULL, NULL),
(14, 1, 'images (2)_wh71boydmiou.jpg', b'0', b'1', b'0', '2023-09-11 17:08:43', 1, NULL, NULL),
(15, 1, 'download_14hrcyv2yyp6w.jpg', b'0', b'1', b'0', '2023-09-11 17:08:43', 1, NULL, NULL),
(16, 1, '1523530788-Parle-Parle G Original Gluco Biscuits-Front.jpg', b'0', b'1', b'0', '2023-09-11 17:08:43', 1, NULL, NULL),
(17, 6, 'download_aixxlz64be66.jpg', b'0', b'1', b'0', '2023-09-11 17:11:02', 1, NULL, NULL),
(18, 6, '1523530788-Parle-Parle G Original Gluco Biscuits-Front_axbfmj3iennm.jpg', b'0', b'1', b'0', '2023-09-11 17:11:02', 1, NULL, NULL),
(19, 6, 'marketing-creative-collage-with-phone.jpg', b'0', b'1', b'0', '2023-09-11 17:11:02', 1, NULL, NULL),
(20, 2, 'ratlami-sev_1v6gduyf3o701.png', b'0', b'1', b'0', '2023-09-11 17:21:38', 1, NULL, NULL),
(21, 2, 'anand-nmkieen_o8vozzug7p4w.png', b'0', b'1', b'0', '2023-09-11 17:21:38', 1, NULL, NULL),
(22, 2, '31-315722_product-image-parle-g-biscuit-25-gm - Copy - Copy.png', b'0', b'1', b'0', '2023-09-11 17:21:38', 1, NULL, NULL),
(23, 27, 'portrait-smiling-beautiful-girl-her-handsome-boyfriend-laughing-happy-cheerful-couple-sunglasses_tr2e8dr9sv62.jpg', b'0', b'1', b'0', '2023-09-11 17:30:15', 1, NULL, NULL),
(24, 27, 'portrait-smiling-beautiful-girl-her-handsome-boyfriend-laughing-happy-cheerful-couple-sunglasses_1qvqtzozcm6hk.jpg', b'0', b'1', b'0', '2023-09-11 17:30:15', 1, NULL, NULL),
(25, 27, 'portrait-smiling-beautiful-girl-her-handsome-boyfriend-laughing-happy-cheerful-couple-sunglasses_yp8qzpt8prt7.jpg', b'0', b'1', b'0', '2023-09-11 17:30:15', 1, NULL, NULL),
(26, 28, 'ratlami-sev_t9p0pdeh9x0n.png', b'0', b'1', b'0', '2023-09-11 17:31:47', 1, NULL, NULL),
(27, 28, '31-315722_product-image-parle-g-biscuit-25-gm - Copy - Copy (2).png', b'0', b'1', b'0', '2023-09-11 17:31:47', 1, NULL, NULL),
(28, 5, 'ratlami-sev_1x7vwwbe41zx6.png', b'0', b'1', b'0', '2023-09-11 17:37:23', 1, NULL, NULL),
(29, 5, 'anand-nmkieen_1wpad8qieho8u.png', b'0', b'1', b'0', '2023-09-11 17:37:23', 1, NULL, NULL),
(30, 5, '31-315722_product-image-parle-g-biscuit-25-gm - Copy - Copy (2)_pajfzqg7u04j.png', b'0', b'1', b'0', '2023-09-11 17:37:23', 1, NULL, NULL),
(31, 8, 'ratlami-sev_1i1c79cfz4kxs.png', b'0', b'1', b'0', '2023-09-11 17:39:54', 1, NULL, NULL),
(32, 8, 'anand-nmkieen_4ckz8lzcxp0p.png', b'0', b'1', b'0', '2023-09-11 17:39:54', 1, NULL, NULL),
(33, 6, 'ratlami-sev_19lnuhptgvo7c.png', b'0', b'1', b'0', '2023-09-11 17:40:54', 1, NULL, NULL),
(34, 6, 'anand-nmkieen_1i0nxhlypa0d7.png', b'0', b'1', b'0', '2023-09-11 17:40:54', 1, NULL, NULL),
(35, 16, 'download_mfjhvrn7hedr.jpg', b'0', b'1', b'0', '2023-09-11 17:41:34', 1, NULL, NULL),
(36, 16, 'images (2)_14say7zxyk639.jpg', b'0', b'1', b'0', '2023-09-11 17:41:34', 1, NULL, NULL),
(37, 2, 'ratlami-sev_kq4uvk3u7og0.png', b'0', b'1', b'0', '2023-09-11 17:44:28', 1, NULL, NULL),
(38, 2, 'anand-nmkieen_1jvmcyi0za7l4.png', b'0', b'1', b'0', '2023-09-11 17:44:28', 1, NULL, NULL),
(39, 16, '31-315722_product-image-parle-g-biscuit-25-gm - Copy - Copy (2)_10v0pif2wwj2w.png', b'0', b'1', b'0', '2023-09-11 17:52:37', 1, NULL, NULL),
(40, 16, '31-315722_product-image-parle-g-biscuit-25-gm_11v1kbgeiykq.png', b'0', b'1', b'0', '2023-09-11 17:52:37', 1, NULL, NULL),
(41, 16, 'images (2)_1tgkodqmm34ir.jpg', b'0', b'1', b'0', '2023-09-11 17:52:37', 1, NULL, NULL),
(42, 16, 'download_1mwxgiwax0870.jpg', b'0', b'1', b'0', '2023-09-11 17:52:37', 1, NULL, NULL);

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
(3, 21, 'sfrsfe', b'1', b'1', '2023-09-11 10:58:38', 1, '2023-09-11 10:58:53', NULL);

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
(1, '18DDB337-AF2F-42EC-A056207956B2B437', 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '1995-08-20', b'0', '$2a$10$NCjOVZ4f9CPrTLH5oXWa0ODhx63orLLmJsHo.pwaim3xNRo/IdfnK', 'avatar-3_vjbvmmcfk63l.jpg'),
(2, NULL, 'Nanu', 'Soni', 'nanu@gmail.com', '2002-07-19', b'0', '$2a$10$WdZ3G3tt5EMuP609CM.QC.n1jhre89/ci52EocGlyuFelh4ZCjHKy', NULL),
(3, NULL, 'gvedrfg', 'dftgd', 'admin@gmail.com', '1999-05-05', b'1', '$2a$10$93SlasObMG8s9J4NxYZHTOY34VzuCmuKxuTglyfM.EMjOA9L2ZvxO', NULL),
(4, NULL, 'test', 'test', 'mamta@gmail.com', '1997-03-04', b'1', '$2a$10$SzIln4DQUbKx6pCW6iwEw.QlL6GQOievpKVlWjHHqOqSJQbV021vy', NULL),
(5, NULL, 'Mamta', 'soni', '', '2006-04-11', b'0', '$2a$10$v3izpn/ocmrASfYmYtHp1uVb4fHokoD944y26vToQM9hbq/dDzBMa', NULL),
(6, NULL, 'fgujhg', 'gjg', 'ravina@gmail.com', '2007-08-15', b'0', '$2a$10$TUDPhJfaJHKxx3hNiHOy6.wWbD6ROhZFXd7mSBaN0qD4mOU.nXyQi', NULL),
(7, NULL, 'Vishal Kumar', 'Khatri', 'vishal.k@lucidsolutions.in', '1995-08-20', b'1', '$2a$10$Yv3.NlUCfjCk0tk9dKBGe.uTdwnt.jeViWQlbYUJc5MTCqrhxrBwy', NULL);

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
  MODIFY `PkCategoryId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `PkCustomerId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `PkProductId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `product_image`
--
ALTER TABLE `product_image`
  MODIFY `PkImageId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `product_tags`
--
ALTER TABLE `product_tags`
  MODIFY `PkTagId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
