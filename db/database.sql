-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 10, 2023 at 03:49 PM
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
(1, 0, 'Home', '6_6afh051ialta.png', b'1', b'0', '2023-07-24 12:14:41', 1, '2023-08-08 17:35:34', 1),
(2, 9, 'TV', '7_dw8jkchbrsrx.png', b'1', b'0', '2023-07-24 15:47:11', 1, '2023-08-09 10:31:55', 1),
(3, 8, 'Beauty product', '', b'0', b'0', '2023-07-24 16:04:14', 1, '2023-08-03 10:25:25', 1),
(4, 1, 'Furniture', '', b'1', b'0', '2023-07-24 18:05:26', 1, '2023-08-07 15:19:46', 1),
(5, 6, 'abcd', 'avatar-6_tk7ojkq0nvwc.jpg', b'1', b'0', '2023-07-24 18:11:42', 1, '2023-08-09 10:32:06', 1),
(6, 0, 'School', '', b'1', b'0', '2023-07-24 18:27:35', 1, '2023-08-02 12:49:42', 1),
(7, 9, 'Mobile', '11.jpg', b'1', b'1', '2023-07-24 18:32:19', 1, '2023-08-08 17:20:14', 1),
(8, 0, 'Beauty & Health', '', b'1', b'0', '2023-07-27 15:30:15', 1, '2023-08-08 12:11:24', 1),
(9, 0, 'Electronics', '7_14jpleral6q13.png', b'1', b'0', '2023-07-27 16:13:37', 1, '2023-08-08 17:35:42', 1),
(10, 6, 'school bag', '', b'1', b'1', '2023-07-27 16:13:42', 1, '2023-08-03 10:31:15', 1),
(11, 8, 'Face Cream', '', b'0', b'0', '2023-07-27 16:13:47', 1, '2023-08-07 15:42:30', 1),
(12, 8, 'Home Decore12', '', b'1', b'0', '2023-07-28 15:03:24', 1, '2023-08-07 11:42:46', 1),
(13, 1, 'Photo Frame', '1.png', b'1', b'0', '2023-08-01 10:10:48', 1, '2023-08-08 17:18:49', 1),
(14, 0, 'XYZ', 'cellphone.jpg', b'1', b'1', '2023-08-01 10:56:25', 1, '2023-08-08 17:20:24', 1),
(15, 14, 'XYZ423453', '', b'1', b'1', '2023-08-02 14:53:01', 1, '2023-08-07 11:55:17', NULL),
(16, 14, 'hikuyio', '', b'1', b'1', '2023-08-02 14:53:10', 1, '2023-08-07 11:55:21', NULL),
(17, 0, 'ABC', '3.jpg', b'1', b'0', '2023-08-07 13:41:57', 1, '2023-08-08 17:19:30', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `PkCustomerId` int(10) UNSIGNED NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `dob` date NOT NULL,
  `gender` bit(1) NOT NULL,
  `profile` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`PkCustomerId`, `firstName`, `lastName`, `email`, `password`, `dob`, `gender`, `profile`) VALUES
(1, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '$2a$10$7iuUsjZsF0DQevwRE9oT8eU7OmcsyUFkA0tGVxJvbyg50nWnQBwZS', '2001-07-16', b'0', NULL);

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
(1, 13, 'Wooden Frame', 500, 10, '5.png', b'1', b'0', '2023-08-01 12:27:41', 1, '2023-08-08 17:21:10', 1),
(2, 10, 'Red Color School Beg', 1000, 10, '1.png', b'1', b'1', '2023-08-01 12:43:49', 1, '2023-08-03 10:31:15', 1),
(3, 3, 'Foundation', 3500, 2, NULL, b'1', b'0', '2023-08-01 12:44:18', 1, '2023-08-01 14:28:50', 1),
(4, 2, 'Sony 4K Smart TV', 55000, 15, '1.png', b'1', b'0', '2023-08-01 12:45:31', 1, '2023-08-08 17:21:06', 1),
(5, 4, 'ytut', 46416, 2, '', b'1', b'1', '2023-08-07 10:57:58', 1, '2023-08-07 11:40:20', 1);

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
  MODIFY `PkCategoryId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `PkCustomerId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `PkProductId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
