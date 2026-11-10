-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2026 at 08:49 AM
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
-- Database: `event_ticketing`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_sessions`
--

CREATE TABLE `auth_sessions` (
  `sessionId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `role` enum('admin','customer') NOT NULL,
  `tokenHash` char(64) NOT NULL,
  `expiresAt` datetime NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_sessions`
--

INSERT INTO `auth_sessions` (`sessionId`, `userId`, `role`, `tokenHash`, `expiresAt`, `createdAt`, `token`) VALUES
(1, NULL, 'admin', '506bdd6a9da5c91c9d3ca0cb7c550e005427163dfe253fedb4ed3263aed58e9d', '2026-11-11 14:05:19', '2026-11-10 06:05:19', 'YDGT_CWFVKv_CdHq1-PkI0attoOSG7RstsM6QqjOf4g'),
(3, NULL, 'admin', 'af6f930e4ba4751f811f42560456c46ff3abc2b3894840f24116e2c752429c02', '2026-11-11 14:08:52', '2026-11-10 06:08:52', 'zYvzbbp0axDtOHI1gu3ocnq3hCpHGipvLDHEoI3vT4Y'),
(8, 2, 'customer', 'c8252d6fab33e64abdfb1b94cdd9ae30fde47c23ea0c5d2f22b4c06be70ca458', '2026-11-11 14:29:17', '2026-11-10 06:29:17', 'uYiKCrbDOBo3fpqtxFZ-fEg58ETcpYbpek79X47m9fQ'),
(10, 2, 'customer', 'bb2e8c3922cc78b2f29293b23cf3a2b674ffe93372a53082926c54b3f170aa1d', '2026-11-11 15:12:13', '2026-11-10 07:12:13', '0kaHnyEIyO4I0hu1YzWXJqWvdFFvct8CpSNxYYoojjc');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `bookingId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `eventId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `totalAmount` decimal(10,2) NOT NULL,
  `bookingDate` datetime DEFAULT current_timestamp(),
  `status` enum('Pending','Confirmed','Cancelled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`bookingId`, `userId`, `eventId`, `quantity`, `totalAmount`, `bookingDate`, `status`) VALUES
(1, 2, 2, 1, 350.00, '2026-11-10 14:35:05', 'Confirmed'),
(2, 2, 2, 3, 1050.00, '2026-11-10 14:47:09', 'Confirmed'),
(3, 2, 1, 50, 25000.00, '2026-11-10 15:04:07', 'Cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `eventId` int(11) NOT NULL,
  `eventName` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `venue` varchar(150) NOT NULL,
  `startDateTime` datetime NOT NULL,
  `endDateTime` datetime NOT NULL,
  `ticketPrice` decimal(10,2) NOT NULL,
  `availableTickets` int(11) NOT NULL,
  `status` enum('Upcoming','Ongoing','Completed','Cancelled') DEFAULT 'Upcoming'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`eventId`, `eventName`, `description`, `venue`, `startDateTime`, `endDateTime`, `ticketPrice`, `availableTickets`, `status`) VALUES
(1, 'Music Festival 2026', 'A live music festival.', 'Nueva Ecija Convention Center', '2026-12-15 09:00:00', '2026-12-15 21:00:00', 500.00, 100, 'Upcoming'),
(2, 'Technology Summit', 'A technology and innovation event.', 'Cabanatuan City', '2026-12-20 08:00:00', '2026-12-20 17:00:00', 350.00, 46, 'Upcoming'),
(3, 'Mariane Sing', 'Singing ladadidadodaadadududididadidode', 'dito lang', '2026-11-11 14:17:00', '2026-11-12 17:17:00', 200.00, 20, 'Completed');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userId`, `fullName`, `email`, `password`) VALUES
(1, 'John Alcantara', 'john@gmail.com', '123456'),
(2, 'Maria Santos', 'maria@gmail.com', '2817be59ebdd1a24c41649a0615cc85f$621ddbf763631ca762469b0f862375951207e593bdd027556a4229bb232b638a'),
(3, 'asdf', 'qweqwe@gmail.com', '1380901671e5ec1797644a8229376e3f$4cc4581865237635a2934f4bea12751d9547a06d88f55267effe7b36af6c5e21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_sessions`
--
ALTER TABLE `auth_sessions`
  ADD PRIMARY KEY (`sessionId`),
  ADD UNIQUE KEY `tokenHash` (`tokenHash`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`bookingId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `eventId` (`eventId`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`eventId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_sessions`
--
ALTER TABLE `auth_sessions`
  MODIFY `sessionId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `bookingId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `eventId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_sessions`
--
ALTER TABLE `auth_sessions`
  ADD CONSTRAINT `auth_sessions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE;

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`eventId`) REFERENCES `events` (`eventId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
