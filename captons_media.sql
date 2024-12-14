-- -------------------------------------------------------------
-- TablePlus 6.2.0(576)
--
-- https://tableplus.com/
--
-- Database: captons_media
-- Generation Time: 2024-12-15 00:39:36.4670
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `_prisma_migrations`;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logs` text COLLATE utf8mb4_unicode_ci,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `applied_steps_count` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `Category`;
CREATE TABLE `Category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `Comment`;
CREATE TABLE `Comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `CommentImage`;
CREATE TABLE `CommentImage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `imageId` int NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `CommentImage_imageId_fkey` (`imageId`),
  CONSTRAINT `CommentImage_imageId_fkey` FOREIGN KEY (`imageId`) REFERENCES `Image` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `Image`;
CREATE TABLE `Image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `ownerId` int NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `Image_ownerId_fkey` (`ownerId`),
  CONSTRAINT `Image_ownerId_fkey` FOREIGN KEY (`ownerId`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `Post`;
CREATE TABLE `Post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `ownerId` int NOT NULL,
  `categoryId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Post_ownerId_fkey` (`ownerId`),
  KEY `Post_categoryId_fkey` (`categoryId`),
  CONSTRAINT `Post_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `Post_ownerId_fkey` FOREIGN KEY (`ownerId`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `SavedImage`;
CREATE TABLE `SavedImage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `imageId` int NOT NULL,
  `userId` int NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `SavedImage_imageId_userId_key` (`imageId`,`userId`),
  KEY `SavedImage_userId_fkey` (`userId`),
  CONSTRAINT `SavedImage_imageId_fkey` FOREIGN KEY (`imageId`) REFERENCES `Image` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `SavedImage_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `createdAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `User_email_key` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('15bbcc8c-4491-4c63-aec8-bad7af09e118', '8e285804fd5896b3ff768c185df8d28e4a9b5f330c7eb19561ef748ddc265431', '2024-12-14 17:08:30.510', '20241214162843_uploda_database', NULL, NULL, '2024-12-14 17:08:30.125', 1);

INSERT INTO `Category` (`id`, `name`, `description`, `createdAt`, `updatedAt`) VALUES
(1, 'anhtuan', 'toilenbak', '2024-12-14 17:26:32.232', '2024-12-14 17:26:32.232'),
(2, 'duaxe', 'traiphep', '2024-12-14 17:27:13.159', '2024-12-14 17:27:13.159');

INSERT INTO `Comment` (`id`, `message`) VALUES
(1, 'oktest'),
(2, 'okfen');

INSERT INTO `Image` (`id`, `title`, `url`, `status`, `ownerId`, `createdAt`, `updatedAt`) VALUES
(1, 'culy', 'haha.com', 1, 1, '2024-12-14 17:37:14.537', '2024-12-14 17:37:14.537'),
(2, 'hkt', 'hkt.com', 2, 2, '2024-12-14 17:10:45.491', '2024-12-14 17:10:45.491');

INSERT INTO `Post` (`id`, `title`, `summary`, `content`, `status`, `ownerId`, `categoryId`) VALUES
(1, 'hahahaha', 'sum hehehehe 01', 'ok', 1, 1, 1),
(2, 'anhtuan', 'hêhee', 'test', 2, 2, 2),
(4, 'post 01', 'sum post 01', 'content test 01', 1, 1, 1),
(5, 'post 01', 'sum post 01', 'content test 01', 1, 1, 1),
(6, 'post 0123', 'sum post 01', 'content test 01', 1, 1, 1);

INSERT INTO `SavedImage` (`id`, `imageId`, `userId`, `createdAt`, `updatedAt`) VALUES
(2, 2, 1, '2024-12-14 17:30:47.253', '2024-12-14 17:30:47.253'),
(3, 4, 3, '2024-12-14 17:30:58.379', '2024-12-14 17:30:58.379');

INSERT INTO `User` (`id`, `email`, `password`, `phone`, `name`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'user8@gmail.com', '$2b$10$4hlzLenpO58.KrNf0tPe0.H/We2CrdxAvCZ/YTzDclkL8bbAqQeMq', '0843453365', 'user3333', 2, '2024-12-14 17:12:23.203', '2024-12-14 17:29:30.477'),
(2, 'user9@gmail.com', '$2b$10$cvzulDXJoqHS9M2PI9qA..fIWLZDxT3gCkZVry0xIZEiT9lqPy7wK', '0843453365', 'user02331', 1, '2024-12-14 17:12:49.738', '2024-12-14 17:12:49.738'),
(3, 'user1@gmail.com', '$2b$10$MuCtezomtRsTT26T1X/M/uHwu3DDPNcllNczm8Ev5zbuu7Ogz1vxC', '0843453365', 'user202331', 1, '2024-12-14 17:12:55.474', '2024-12-14 17:12:55.474'),
(4, 'user01@gmail.com', '$2b$10$klKw9i6WCmjwfZGOPk5d9.H93MohPRU1RKWG1vwEVEkBBdUwFOmtG', '0843453365', 'user202331', 1, '2024-12-14 17:13:32.200', '2024-12-14 17:13:32.200'),
(5, 'user021@gmail.com', '$2b$10$im1jVL1I0sCdmhwnfPhIAOfAwMN8kl7JINLtXzHwLw0RzbfMtjcOa', '03456567678', 'user021', 1, '2024-12-14 17:14:03.295', '2024-12-14 17:14:03.295'),
(6, 'user0a21@gmail.com', '$2b$10$90ipZoDTOJ9jrckG5B4p4uO7ox/S3GjElY7rQ6uYjLqXEJgcHzVYO', '03456567678', 'user021', 1, '2024-12-14 17:15:14.524', '2024-12-14 17:15:14.524'),
(7, 'user0wa21@gmail.com', '$2b$10$vWL.V3CZsfNZJxaF.zkBRuUpCD72nStjQM3XE75mxhbV66XCB//P.', '03456567678', 'user021', 1, '2024-12-14 17:15:30.693', '2024-12-14 17:15:30.693');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;