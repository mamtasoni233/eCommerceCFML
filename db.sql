CREATE TABLE `users` (
    `PkUserId` int(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `firstName` VARCHAR(100) NOT NULL,
    `lastName` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `dob` date NOT NULL,
    `gender`bit(1) NOT NULL DEFAULT 1,
    `password` varchar(100) NOT NULL
);
ALTER TABLE `users` ADD `token` VARCHAR(255) NULL DEFAULT NULL AFTER `PkUserId`;
ALTER TABLE `users` ADD `image` VARCHAR(255) NULL DEFAULT NULL AFTER `password`;

CREATE TABLE `category` (
    `PkCategoryId` int(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `categoryName` VARCHAR(100) NOT NULL,
    `categoryImage` VARCHAR(255) NOT NULL,
    `isActive` bit(1) NOT NULL DEFAULT 1,
    `isDeleted` bit(1) NOT NULL DEFAULT 0,
    `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
    `createdBy` int(11) NOT NULL,
    `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
    `updatedBy` int(11) DEFAULT NULL
);

CREATE TABLE `product` (
    `PkProductId` int(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `FkCategoryId` int(11) UNSIGNED NOT NULL,
    `productName` VARCHAR(100) NOT NULL,
    `productQty` int(11) NOT NULL,
    `productImage` VARCHAR(255) NOT NULL,
    `isActive` bit(1) NOT NULL DEFAULT 1,
    `isDeleted` bit(1) NOT NULL DEFAULT 0,
    `dateCreated` datetime NOT NULL DEFAULT current_timestamp(),
    `createdBy` int(11) NOT NULL,
    `dateUpdated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
    `updatedBy` int(11) DEFAULT NULL,
    FOREIGN KEY (FkCategoryId) REFERENCES category(PkCategoryId)
);