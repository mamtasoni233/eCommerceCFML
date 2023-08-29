-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 29, 2023 at 03:06 PM
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
(1, 0, 'Home', 'avatar-3.jpg', b'1', b'0', '2023-07-24 12:14:41', 1, '2023-08-29 18:22:59', 1),
(2, 9, 'TV', '7_dw8jkchbrsrx.png', b'1', b'0', '2023-07-24 15:47:11', 1, '2023-08-21 15:15:03', 1),
(3, 8, 'Beauty product', '', b'0', b'0', '2023-07-24 16:04:14', 1, '2023-08-03 10:25:25', 1),
(4, 1, 'Furniture', '', b'1', b'0', '2023-07-24 18:05:26', 1, '2023-08-07 15:19:46', 1),
(5, 6, 'abcd', '1_13xj8yr44fkjb.jpg', b'1', b'0', '2023-07-24 18:11:42', 1, '2023-08-29 18:35:56', 1),
(6, 8, 'School', '', b'1', b'0', '2023-07-24 18:27:35', 1, '2023-08-28 15:56:32', 1),
(7, 9, 'Mobile', '11.jpg', b'1', b'1', '2023-07-24 18:32:19', 1, '2023-08-08 17:20:14', 1),
(8, 0, 'Beauty & Health', '6.png', b'1', b'0', '2023-07-27 15:30:15', 1, '2023-08-29 18:23:12', 1),
(9, 0, 'Electronics', 'profile-img.jpg', b'1', b'0', '2023-07-27 16:13:37', 1, '2023-08-29 16:21:54', 1),
(10, 6, 'school bag', '', b'1', b'1', '2023-07-27 16:13:42', 1, '2023-08-03 10:31:15', 1),
(11, 8, 'Face Cream', '', b'0', b'0', '2023-07-27 16:13:47', 1, '2023-08-07 15:42:30', 1),
(12, 1, 'Home Decore12', '', b'1', b'0', '2023-07-28 15:03:24', 1, '2023-08-28 16:52:12', 1),
(13, 1, 'Photo Frame', '1.png', b'1', b'0', '2023-08-01 10:10:48', 1, '2023-08-29 18:36:07', 1),
(14, 0, 'XYZ', 'cellphone.jpg', b'1', b'1', '2023-08-01 10:56:25', 1, '2023-08-08 17:20:24', 1),
(15, 14, 'XYZ423453', '', b'1', b'1', '2023-08-02 14:53:01', 1, '2023-08-07 11:55:17', NULL),
(16, 14, 'hikuyio', '', b'1', b'1', '2023-08-02 14:53:10', 1, '2023-08-07 11:55:21', NULL),
(17, 0, 'ABC', 'avatar-3_8d0xw1lc0oi4.jpg', b'1', b'0', '2023-08-07 13:41:57', 1, '2023-08-29 18:34:44', 1),
(18, 6, 'TV12361', '1.jpg', b'1', b'0', '2023-08-16 10:51:39', 1, '2023-08-29 18:35:15', 1),
(19, 4, 'Kicthen Dining table', 'building.jpg', b'1', b'0', '2023-08-21 15:16:02', 1, '2023-08-21 16:04:20', 1),
(20, 4, 'Table', NULL, b'1', b'0', '2023-08-21 15:35:48', 1, NULL, NULL),
(21, 4, 'XYZ56656', NULL, b'1', b'0', '2023-08-28 15:29:36', 1, '2023-08-29 11:36:51', NULL),
(22, 0, 'hello', 'pic06_126ocg6gsdh5k.jpg', b'1', b'0', '2023-08-29 11:49:55', 1, '2023-08-29 18:33:16', 1);

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
  `productImage` varchar(255) DEFAULT NULL,
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

INSERT INTO `product` (`PkProductId`, `FkCategoryId`, `productName`, `productPrice`, `productQty`, `productImage`, `isActive`, `isDeleted`, `dateCreated`, `createdBy`, `dateUpdated`, `updatedBy`) VALUES
(1, 19, 'Wooden Frame', 500, 10, '5.png', b'1', b'0', '2023-08-01 12:27:41', 1, '2023-08-21 15:19:56', 1),
(2, 10, 'Red Color School Beg', 1000, 10, '1.png', b'1', b'1', '2023-08-01 12:43:49', 1, '2023-08-03 10:31:15', 1),
(3, 3, 'Foundation', 3500, 2, NULL, b'1', b'0', '2023-08-01 12:44:18', 1, '2023-08-01 14:28:50', 1),
(4, 2, 'Sony 4K Smart TV', 55000, 15, '1.png', b'1', b'0', '2023-08-01 12:45:31', 1, '2023-08-08 17:21:06', 1),
(5, 4, 'ytut', 46416, 2, '', b'1', b'1', '2023-08-07 10:57:58', 1, '2023-08-07 11:40:20', 1),
(6, 5, 'soap', 500, 20, NULL, b'1', b'0', '2023-08-28 15:40:16', 1, NULL, NULL),
(7, 2, 'Sony 4K Smart TV', 5, 2, '1.jpg', b'1', b'0', '2023-08-29 10:33:13', 1, '2023-08-29 10:33:14', NULL);

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
  MODIFY `PkCategoryId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `PkCustomerId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `PkProductId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
