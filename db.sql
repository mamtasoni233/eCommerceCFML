CREATE TABLE `users` (
    `PkUserId` int(11) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `firstName` VARCHAR(100) NOT NULL,
    `lastName` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `dob` date NOT NULL,
    `gender`bit(1) NOT NULL DEFAULT 1,
    `password` varchar(100) NOT NULL
);