-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 25, 2024 at 02:35 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `grape_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `dht`
--

CREATE TABLE `dht` (
  `id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `temperature` float NOT NULL,
  `humidity` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `dht`
--

INSERT INTO `dht` (`id`, `log_id`, `temperature`, `humidity`, `created_at`) VALUES
(1, 1, 22.84, 55.17, '2024-10-18 13:33:22'),
(2, 2, 29.36, 61.55, '2024-10-18 13:33:27'),
(3, 3, 29.66, 51.25, '2024-10-18 13:33:32'),
(4, 4, 20.63, 71.03, '2024-10-18 13:33:37'),
(5, 5, 24.4, 60.8, '2024-10-18 13:33:42');

-- --------------------------------------------------------

--
-- Table structure for table `ina`
--

CREATE TABLE `ina` (
  `id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `current` float NOT NULL,
  `voltage` float NOT NULL,
  `power` float NOT NULL,
  `power_consumption` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ina`
--

INSERT INTO `ina` (`id`, `log_id`, `current`, `voltage`, `power`, `power_consumption`, `created_at`) VALUES
(1, 1, 2.3, 228.21, 884.63, 86.66, '2024-10-18 13:33:22'),
(2, 2, 3.41, 221.76, 721.95, 311.5, '2024-10-18 13:33:27'),
(3, 3, 1.96, 227.28, 165.5, 128.01, '2024-10-18 13:33:32'),
(4, 4, 0.96, 223.89, 776.25, 51.48, '2024-10-18 13:33:37'),
(5, 5, 2.69, 223.76, 229.6, 6.55, '2024-10-18 13:33:42'),
(6, 6, 1.41, 223.49, 340.69, 185.49, '2024-10-18 13:36:06'),
(7, 7, 1.51, 221.49, 750.97, 425.84, '2024-10-18 13:36:09'),
(8, 8, 2.7, 222.26, 570.1, 341.54, '2024-10-18 13:39:51'),
(9, 9, 0.71, 227.85, 894.2, 405.69, '2024-10-18 13:52:47'),
(10, 9, 4.43, 226.67, 291.04, 265.95, '2024-10-18 13:54:31'),
(11, 10, 0.55, 223.4, 764.39, 122.32, '2024-10-18 13:54:36'),
(12, 8, 1.34, 229.98, 333.7, 122.74, '2024-10-18 13:58:20'),
(13, 12, 4.31, 228.43, 687.28, 164.14, '2024-10-18 14:01:15'),
(14, 13, 3.46, 226.82, 623.97, 493.65, '2024-10-18 14:06:24'),
(15, 15, 0.21, 228.09, 724.24, 268.77, '2024-10-18 14:19:09'),
(16, 16, 3.68, 229.79, 433.58, 408.86, '2024-10-18 14:20:01'),
(17, 17, 4.23, 229.53, 670.89, 302.63, '2024-10-18 14:27:50'),
(18, 18, 2.93, 224.3, 948.66, 422.25, '2024-10-18 14:27:55'),
(19, 19, 1.76, 223.39, 959.45, 228.88, '2024-10-18 14:29:07'),
(20, 20, 4.42, 227, 122.52, 412.25, '2024-10-18 14:29:12'),
(21, 21, 4.14, 229.24, 123.33, 282.7, '2024-10-18 14:29:17'),
(22, 22, 4.51, 228.41, 984.18, 80.58, '2024-10-18 14:30:23'),
(23, 23, 3.31, 227.77, 469.33, 18.81, '2024-10-18 14:31:51'),
(24, 24, 2.14, 229.55, 14.08, 56.77, '2024-11-16 05:28:01'),
(25, 25, 0.53, 229.38, 837.76, 76.7, '2024-11-16 05:30:48'),
(26, 26, 0.3, 221.46, 980.34, 60.65, '2024-11-16 05:30:56');

-- --------------------------------------------------------

--
-- Table structure for table `node_send_logs`
--

CREATE TABLE `node_send_logs` (
  `id` int(11) NOT NULL,
  `node_id` int(11) NOT NULL,
  `delay` int(11) DEFAULT NULL,
  `payload_size` int(11) DEFAULT NULL,
  `throughput` float DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `node_send_logs`
--

INSERT INTO `node_send_logs` (`id`, `node_id`, `delay`, `payload_size`, `throughput`, `created_at`) VALUES
(1, 1, 20, 256, 403, '2024-10-18 13:33:22'),
(2, 1, 35, 256, 790, '2024-10-18 13:33:27'),
(3, 1, 69, 256, 381, '2024-10-18 13:33:32'),
(4, 1, 91, 256, 418, '2024-10-18 13:33:37'),
(5, 1, 78, 256, 651, '2024-10-18 13:33:42'),
(6, 2, 26, 256, 437, '2024-10-18 13:36:06'),
(7, 2, 4, 256, 293, '2024-10-18 13:36:09'),
(8, 3, NULL, NULL, NULL, '2024-10-18 13:39:51'),
(9, 4, 17, 256, 596, '2024-10-18 13:52:47'),
(10, 4, 40, 256, 476, '2024-10-18 13:54:36'),
(11, 3, NULL, NULL, NULL, '2024-10-18 13:58:20'),
(12, 4, 89, 256, 620, '2024-10-18 14:01:15'),
(13, 4, NULL, NULL, NULL, '2024-10-18 14:06:24'),
(14, 4, NULL, NULL, NULL, '2024-10-18 14:06:24'),
(15, 4, 76, 256, 820, '2024-10-18 14:19:09'),
(16, 4, 36, 256, 887, '2024-10-18 14:20:01'),
(17, 3, NULL, NULL, NULL, '2024-10-18 14:27:50'),
(18, 3, 98, 256, 833, '2024-10-18 14:27:55'),
(19, 4, 38, 256, 841, '2024-10-18 14:29:07'),
(20, 4, 28, 256, 935, '2024-10-18 14:29:12'),
(21, 4, 21, 256, 735, '2024-10-18 14:29:17'),
(22, 3, NULL, NULL, NULL, '2024-10-18 14:30:23'),
(23, 4, 14, 256, 59, '2024-10-18 14:31:51'),
(24, 4, 52, 256, 504, '2024-11-16 05:28:01'),
(25, 4, 19, 256, 100, '2024-11-16 05:30:48'),
(26, 4, NULL, NULL, NULL, '2024-11-16 05:30:56');

-- --------------------------------------------------------

--
-- Table structure for table `soil_moisture`
--

CREATE TABLE `soil_moisture` (
  `id` int(11) NOT NULL,
  `log_id` int(11) NOT NULL,
  `sensor_order` int(11) DEFAULT NULL,
  `moisture` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `soil_moisture`
--

INSERT INTO `soil_moisture` (`id`, `log_id`, `sensor_order`, `moisture`, `created_at`) VALUES
(1, 6, 1, 20, '2024-10-18 13:36:06'),
(2, 6, 2, 5, '2024-10-18 13:36:06'),
(3, 7, 1, 83, '2024-10-18 13:36:09'),
(4, 7, 2, 38, '2024-10-18 13:36:09'),
(5, 8, 1, 45, '2024-10-18 13:39:51'),
(6, 8, 2, 18, '2024-10-18 13:39:51'),
(7, 9, 1, 4, '2024-10-18 13:52:47'),
(8, 9, 2, 79, '2024-10-18 13:52:47'),
(9, 9, 1, 43, '2024-10-18 13:54:31'),
(10, 9, 2, 71, '2024-10-18 13:54:31'),
(11, 10, 1, 64, '2024-10-18 13:54:36'),
(12, 10, 2, 84, '2024-10-18 13:54:36'),
(13, 8, 14, 13, '2024-10-18 13:58:20'),
(14, 8, 12, 38, '2024-10-18 13:58:20'),
(15, 12, 1, 25, '2024-10-18 14:01:15'),
(16, 12, 2, 83, '2024-10-18 14:01:15'),
(17, 13, 1, 41, '2024-10-18 14:06:24'),
(18, 13, 2, 36, '2024-10-18 14:06:24'),
(19, 15, 1, 30, '2024-10-18 14:19:09'),
(20, 15, 2, 71, '2024-10-18 14:19:09'),
(21, 16, 1, 56, '2024-10-18 14:20:01'),
(22, 16, 2, 85, '2024-10-18 14:20:01'),
(23, 17, 1, 26, '2024-10-18 14:27:50'),
(24, 17, 2, 26, '2024-10-18 14:27:50'),
(25, 18, 1, 6, '2024-10-18 14:27:56'),
(26, 18, 1, 43, '2024-10-18 14:27:55'),
(27, 19, 2, 65, '2024-10-18 14:29:07'),
(28, 19, 3, 65, '2024-10-18 14:29:07'),
(29, 20, 4, 59, '2024-10-18 14:29:12'),
(30, 20, 5, 90, '2024-10-18 14:29:12'),
(31, 21, 6, 57, '2024-10-18 14:29:17'),
(32, 21, 10, 27, '2024-10-18 14:29:17'),
(33, 22, 7, 94, '2024-10-18 14:30:23'),
(34, 22, 8, 22, '2024-10-18 14:30:23'),
(35, 23, 9, 29, '2024-10-18 14:31:51'),
(36, 23, 15, 61, '2024-10-18 14:31:51'),
(37, 24, 1, 37, '2024-11-16 05:28:01'),
(38, 24, 2, 96, '2024-11-16 05:28:01'),
(39, 25, 1, 26, '2024-11-16 05:30:48'),
(40, 25, 2, 79, '2024-11-16 05:30:48'),
(41, 26, 1, 51, '2024-11-16 05:30:56'),
(42, 26, 2, 6, '2024-11-16 05:30:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dht`
--
ALTER TABLE `dht`
  ADD PRIMARY KEY (`id`),
  ADD KEY `log_id` (`log_id`);

--
-- Indexes for table `ina`
--
ALTER TABLE `ina`
  ADD PRIMARY KEY (`id`),
  ADD KEY `log_id` (`log_id`);

--
-- Indexes for table `node_send_logs`
--
ALTER TABLE `node_send_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `soil_moisture`
--
ALTER TABLE `soil_moisture`
  ADD PRIMARY KEY (`id`),
  ADD KEY `log_id` (`log_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dht`
--
ALTER TABLE `dht`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `ina`
--
ALTER TABLE `ina`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `node_send_logs`
--
ALTER TABLE `node_send_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `soil_moisture`
--
ALTER TABLE `soil_moisture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dht`
--
ALTER TABLE `dht`
  ADD CONSTRAINT `dht_ibfk_1` FOREIGN KEY (`log_id`) REFERENCES `node_send_logs` (`id`);

--
-- Constraints for table `ina`
--
ALTER TABLE `ina`
  ADD CONSTRAINT `ina_ibfk_1` FOREIGN KEY (`log_id`) REFERENCES `node_send_logs` (`id`);

--
-- Constraints for table `soil_moisture`
--
ALTER TABLE `soil_moisture`
  ADD CONSTRAINT `soil_moisture_ibfk_1` FOREIGN KEY (`log_id`) REFERENCES `node_send_logs` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
