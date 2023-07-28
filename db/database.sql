-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2023 at 03:02 PM
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
(1, 0, 'Home', '', b'1', b'0', '2023-07-24 12:14:41', 1, '2023-07-28 17:58:14', 1),
(2, 9, 'TV', '', b'1', b'0', '2023-07-24 15:47:11', 1, '2023-07-28 17:30:05', 1),
(3, 8, 'Beauty product', '', b'0', b'0', '2023-07-24 16:04:14', 1, '2023-07-28 17:14:44', 1),
(4, 1, 'Furniture', 'avatar-4_1tigshcerrzl8.jpg', b'1', b'0', '2023-07-24 18:05:26', 1, '2023-07-28 17:30:46', 1),
(5, 1, 'abcd', '1.png', b'1', b'0', '2023-07-24 18:11:42', 1, '2023-07-28 17:28:42', 1),
(6, 0, 'School', '', b'1', b'0', '2023-07-24 18:27:35', 1, '2023-07-28 17:31:41', 1),
(7, 9, 'Mobile', 'avatar-3_1sojrdx0fndgj.jpg', b'1', b'0', '2023-07-24 18:32:19', 1, '2023-07-28 17:30:29', 1),
(8, 0, 'Beauty & Health', '1_1ey1danqrstgp.jpg', b'1', b'0', '2023-07-27 15:30:15', 1, '2023-07-27 18:10:59', 1),
(9, 0, 'Electronics', NULL, b'1', b'0', '2023-07-27 16:13:37', 1, '2023-07-28 17:29:50', 1),
(10, 6, 'school bag', NULL, b'0', b'0', '2023-07-27 16:13:42', 1, '2023-07-28 17:35:16', 1),
(11, 8, 'Face Cream', NULL, b'1', b'0', '2023-07-27 16:13:47', 1, '2023-07-28 17:31:24', 1),
(12, 8, 'Home Decore12', NULL, b'0', b'0', '2023-07-28 15:03:24', 1, '2023-07-28 17:39:57', 1);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `PkCourseId` int(11) UNSIGNED NOT NULL,
  `FkTireId` int(10) UNSIGNED NOT NULL,
  `duration` int(11) NOT NULL,
  `minCourse` int(20) NOT NULL,
  `maxCourse` int(20) NOT NULL,
  `minExpenditure` float NOT NULL,
  `maxExpenditure` float NOT NULL,
  `maxCredits` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`PkCourseId`, `FkTireId`, `duration`, `minCourse`, `maxCourse`, `minExpenditure`, `maxExpenditure`, `maxCredits`) VALUES
(20, 1, 150, 2, 5, 500, 1000, 1000),
(28, 1, 300, 2, 3, 450, 750, 580),
(29, 2, 300, 3, 6, 1200, 1500, 1200),
(30, 2, 150, 1, 5, 200, 500, 500),
(31, 3, 150, 6, 7, 560, 780, 780),
(35, 4, 300, 2, 10, 400, 500, 6000);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `PkProductId` int(11) UNSIGNED NOT NULL,
  `FkCategoryId` int(11) UNSIGNED NOT NULL,
  `productName` varchar(100) NOT NULL,
  `productQty` int(11) NOT NULL,
  `productImage` varchar(255) DEFAULT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
  `createdBy` int(11) NOT NULL,
  `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updatedBy` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `PkPublishId` int(11) UNSIGNED NOT NULL,
  `publisherId` int(10) UNSIGNED NOT NULL,
  `publisherName` varchar(255) NOT NULL,
  `status` bit(1) NOT NULL DEFAULT b'1',
  `iconImage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`PkPublishId`, `publisherId`, `publisherName`, `status`, `iconImage`) VALUES
(1, 22, 'fr', b'1', ''),
(2, 102, 'Mamta', b'1', ''),
(6, 7498, 'sgdsegd', b'1', 'unsplash-2.jpg'),
(32, 42, 'Vinay133', b'1', ''),
(33, 42, 'Vinay14', b'1', 'avatar-4.jpg'),
(41, 42, 'Vinay22', b'1', 'avatar-4.jpg'),
(49, 42, 'Vinay30', b'1', 'avatar-4.jpg'),
(56, 42, 'Vinay37', b'1', 'avatar-4.jpg'),
(57, 42, 'Vinay333', b'1', ''),
(90, 651, 'qwewr', b'1', ''),
(92, 1651, 'GDSDFYH4564565', b'1', ''),
(96, 2562, 'wewertwer', b'1', ''),
(97, 626, 'tetg', b'1', ''),
(101, 3, 'Mamta Soni3', b'1', ''),
(102, 4, 'Mamta Soni4', b'1', ''),
(103, 5, 'Mamta Soni5', b'1', ''),
(104, 6, 'Mamta Soni6', b'1', ''),
(105, 7, 'Mamta Soni7', b'1', ''),
(106, 8, 'Mamta Soni8', b'1', ''),
(107, 9, 'Mamta Soni9', b'1', ''),
(108, 10, 'Mamta Soni101', b'1', ''),
(109, 1, 'Mamta Soni1222', b'1', ''),
(110, 45, 'Mamta Soni2', b'1', ''),
(111, 3, 'Mamta Soni3', b'1', ''),
(112, 4, 'Mamta Soni4', b'1', ''),
(113, 5, 'Mamta Soni5555', b'1', ''),
(114, 6, 'Mamta Soni67', b'1', ''),
(115, 7, 'Mamta Soni7', b'1', ''),
(116, 8, 'Mamta Soni8', b'1', ''),
(117, 9, 'Mamta Soni9', b'1', ''),
(118, 11, 'Mamta Soni10', b'1', '');

-- --------------------------------------------------------

--
-- Table structure for table `tier`
--

CREATE TABLE `tier` (
  `PkTierId` int(11) UNSIGNED NOT NULL,
  `titleTier` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tier`
--

INSERT INTO `tier` (`PkTierId`, `titleTier`) VALUES
(1, 'Homeschool Accreditation'),
(2, 'Homeschool Academy'),
(3, 'Homeschool Live'),
(4, 'PVC');

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
(1, NULL, 'Mamta', 'Soni', 'mamta.s@lucidsolutions.in', '1995-08-20', b'0', '$2a$10$NCjOVZ4f9CPrTLH5oXWa0ODhx63orLLmJsHo.pwaim3xNRo/IdfnK', 'avatar-3_vjbvmmcfk63l.jpg'),
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
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`PkCourseId`),
  ADD KEY `FkTireId` (`FkTireId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`PkProductId`),
  ADD KEY `FkCategoryId` (`FkCategoryId`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`PkPublishId`);

--
-- Indexes for table `tier`
--
ALTER TABLE `tier`
  ADD PRIMARY KEY (`PkTierId`);

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
  MODIFY `PkCategoryId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `PkCourseId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `PkProductId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publisher`
--
ALTER TABLE `publisher`
  MODIFY `PkPublishId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `tier`
--
ALTER TABLE `tier`
  MODIFY `PkTierId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `PkUserId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`FkTireId`) REFERENCES `tier` (`PkTierId`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`FkCategoryId`) REFERENCES `category` (`PkCategoryId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
