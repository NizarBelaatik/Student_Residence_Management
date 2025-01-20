-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 21, 2025 at 12:06 AM
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
-- Database: `srm_db`
--

CREATE Database srm_db;
use srm_db;

-- --------------------------------------------------------

--
-- Table structure for table `email_verification`
--

CREATE TABLE `email_verification` (
  `verification_id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `verification_token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `email_verification`
--

INSERT INTO `email_verification` (`verification_id`, `email`, `verification_token`, `created_at`, `expires_at`, `verified_at`) VALUES
(1, 'lazariatik@gmail.com', 'c3p4oq4m5ub64feqrtl1', '2025-01-09 19:29:02', '2025-01-09 19:34:02', '2025-01-09 19:29:22'),
(2, 'lazariatik@gmail.com', 's5r55ic7bevprn28m5ji', '2025-01-11 12:05:30', '2025-01-11 21:10:30', '2025-01-11 21:05:44'),
(3, 'lazariatik@gmail.com', 't3ks47gf5n3ihmhgr7it', '2025-01-14 12:14:41', '2025-01-14 12:19:41', NULL),
(4, 'lazariatik@gmail.com', 'fmo42pcbqkol8i8aeehu', '2025-01-14 12:17:11', '2025-01-14 12:22:11', NULL),
(5, 'belaatiknizar@gmail.com', 'b91648kil9nk340c06audsto03e40b', '2025-01-18 19:25:34', '2025-01-18 19:30:34', '2025-01-18 19:25:50'),
(6, 'belaatiknizar@gmail.com', 'ij87m3htlttfrk02o550piil9ql6t9q9ajnisa0131iuja64d3', '2025-01-19 20:14:10', '2025-01-19 20:19:10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `maintenance_requests`
--

CREATE TABLE `maintenance_requests` (
  `id` int(11) NOT NULL,
  `resident_email` varchar(100) NOT NULL,
  `roomId` varchar(100) NOT NULL,
  `issue_type` varchar(100) DEFAULT NULL,
  `issue_description` text NOT NULL,
  `status` enum('pending','in_progress','resolved') DEFAULT 'pending',
  `technician_name` varchar(50) DEFAULT NULL,
  `resolved_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `maintenance_requests`
--

INSERT INTO `maintenance_requests` (`id`, `resident_email`, `roomId`, `issue_type`, `issue_description`, `status`, `technician_name`, `resolved_date`, `created_at`, `updated_at`) VALUES
(1, 'lazariatik@gmail.com', '13d54', 'Water', 'water leakage', 'pending', 'n@gmail.com', NULL, '2025-01-01 15:47:21', '2025-01-15 20:09:03'),
(2, 'lazariatik@gmail.com', '13d54', 'Elec', 'elec problem', 'resolved', 'n@gmail.com', '2025-01-15', '2025-01-13 15:59:48', '2025-01-15 20:10:22'),
(3, 'lazariatik@gmail.com', '823k8f', 'Water Leak', 'sdf', 'in_progress', NULL, NULL, '2025-01-15 09:02:00', '2025-01-15 20:37:19'),
(4, 'lazariatik@gmail.com', '823k8f', 'Electrical Issue', 'asdf', 'resolved', 'belaatiknizar@gmail.com', '2025-01-20', '2025-01-15 20:02:45', '2025-01-20 22:55:58'),
(5, 'lazariatik@gmail.com', '823k8f', 'Water Leak', 'sadf', 'pending', NULL, NULL, '2025-01-15 20:03:29', '2025-01-15 20:03:29'),
(6, 'lazariatik@gmail.com', '823k8f', 'Water Leak', 'water leaking', 'in_progress', 'belaatiknizar@gmail.com', NULL, '2025-01-15 20:06:40', '2025-01-20 20:39:53');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `sender` varchar(250) NOT NULL,
  `receiver` varchar(250) NOT NULL,
  `subject` varchar(250) NOT NULL,
  `msg` varchar(500) NOT NULL,
  `status` tinyint(1) DEFAULT 0,
  `type` varchar(20) DEFAULT NULL,
  `sendDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `checkedDate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `sender`, `receiver`, `subject`, `msg`, `status`, `type`, `sendDate`, `checkedDate`) VALUES
(1, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-04 11:18:56', NULL),
(2, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-04 11:23:16', NULL),
(3, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-04 20:16:11', NULL),
(4, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-05 12:33:52', NULL),
(5, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-05 15:54:40', NULL),
(6, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-05 15:55:04', NULL),
(7, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-05 16:00:20', NULL),
(8, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-05 16:13:27', NULL),
(9, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-05 21:03:00', NULL),
(10, 'ADMIN', 'lazariatik@gmail.com', 'Payment processed successfully!', 'Your payment of 0.0 has been successfully processed. Payment ID: 9NPSKB34KD2. Thank you!', 1, 'success', '2025-01-05 21:35:04', NULL),
(11, 'ADMIN', 'lazariatik@gmail.com', 'Payment processed successfully!', 'Your payment of 0.0 has been successfully processed. Payment ID: AJOB4W32QZ. Thank you!', 1, 'success', '2025-01-05 21:37:21', NULL),
(12, 'ADMIN', 'lazariatik@gmail.com', 'Payment Due: 500.0', 'Reminder: Pay your due fees of 500.0 before 2025-01-31 00:00:00.0. Check your email for more details.', 1, 'reminder', '2025-01-07 14:17:01', NULL),
(13, 'ADMIN', 'lazariatik@gmail.com', 'Payment processed successfully!', 'Your payment of 500.0 has been successfully processed. Payment ID: IKYM2ZYD1E. Thank you!', 1, 'success', '2025-01-07 14:19:10', NULL),
(14, 'ADMIN', 'lazariatik@gmail.com', 'Payment processed successfully!', 'Your payment of 500.0 has been successfully processed. Payment ID: AJOB4W32QZ. Thank you!', 1, 'success', '2025-01-07 16:26:36', '2025-01-19 19:42:26'),
(15, 'ADMIN', 'lazariatik@gmail.com', 'Payment processed successfully!', 'Your payment of 500.0 has been successfully processed. Payment ID: AJOB4W32QZ. Thank you!', 0, 'success', '2025-01-15 18:33:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `paymentId` varchar(12) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `roomId` varchar(255) NOT NULL,
  `amount_due` decimal(10,2) NOT NULL,
  `amount_paid` decimal(10,2) DEFAULT 0.00,
  `due_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `payment_date` timestamp NULL DEFAULT NULL,
  `status` enum('pending','paid','overdue') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`paymentId`, `fullname`, `email`, `roomId`, `amount_due`, `amount_paid`, `due_date`, `payment_date`, `status`) VALUES
('94GF4534K52', 'Night Code', 'lazariatik@gmail.com', '823k8f', 500.00, 500.00, '2024-12-31 23:00:00', '2025-01-04 23:00:00', 'paid'),
('9NPlG34478', 'Night Code', 'lazariatik@gmail.com', '823k8f', 500.00, 500.00, '2024-12-31 23:00:00', '2025-01-04 23:00:00', 'paid'),
('9NPlGGL3478', 'Night Code', 'lazariatik@gmail.com', '823k8f', 500.00, 500.00, '2024-12-19 23:00:00', '2025-01-04 23:00:00', 'paid'),
('9NPlGhj478', 'Night Code', 'lazariatik@gmail.com', '823k8f', 500.00, 500.00, '2025-01-20 19:00:23', NULL, 'pending'),
('9NPSKB34KD2', 'Night Code', 'lazariatik@gmail.com', '823k8f', 500.00, 0.00, '2024-12-31 23:00:00', NULL, 'overdue'),
('AJOB4W32QZ', 'Night Code', 'lazariatik@gmail.com', '823k8f', 500.00, 500.00, '2025-01-15 18:33:41', '2025-01-15 18:33:41', 'paid'),
('HQPUR7X8KL', 'Night Code', 'lazariatik@gmail.com', '13d54', 200.00, 0.00, '2025-01-30 23:00:00', NULL, 'pending'),
('IKYM2ZYD1E', 'Night Code', 'lazariatik@gmail.com', '823k8f', 500.00, 0.00, '2024-12-30 23:00:00', NULL, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `payment_data`
--

CREATE TABLE `payment_data` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `cardholder_name` varchar(255) NOT NULL,
  `card_number` varchar(20) NOT NULL,
  `expiry_date` varchar(5) NOT NULL,
  `cvc` varchar(4) NOT NULL,
  `payed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment_data`
--

INSERT INTO `payment_data` (`id`, `email`, `payment_id`, `cardholder_name`, `card_number`, `expiry_date`, `cvc`, `payed_at`) VALUES
(4, 'lazariatik@gmail.com', 'AJOB4W32QZ', 'night', '234', '234', '234', '2025-01-15 18:33:41');

-- --------------------------------------------------------

--
-- Table structure for table `payment_generation_status`
--

CREATE TABLE `payment_generation_status` (
  `id` int(11) NOT NULL,
  `month_year` varchar(7) NOT NULL,
  `status` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `payment_generation_status`
--

INSERT INTO `payment_generation_status` (`id`, `month_year`, `status`, `created_at`, `updated_at`) VALUES
(1, '2025-01', 'Generated', '2025-01-09 19:41:11', '2025-01-09 19:41:11');

-- --------------------------------------------------------

--
-- Table structure for table `residents`
--

CREATE TABLE `residents` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `roomId` varchar(10) DEFAULT NULL,
  `c_start_date` date NOT NULL,
  `c_end_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `residents`
--

INSERT INTO `residents` (`id`, `email`, `firstname`, `lastname`, `gender`, `phone`, `address`, `roomId`, `c_start_date`, `c_end_date`) VALUES
(1, 'lazariatik@gmail.com', 'Night', 'code', 'male', '9234 2345jfg fdgsdg', 'asdfa asdf45345 asdff', '823k8f', '2024-04-01', '2025-06-30');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `roomId` varchar(100) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `size` varchar(100) DEFAULT NULL,
  `equipment` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `state` enum('Available','Occupied','Maintenance') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`roomId`, `name`, `size`, `equipment`, `price`, `state`) VALUES
('13d54', '2', 'Medium', 'Suite', 200.00, 'Occupied'),
('13df4', '4', 'Small', 'Ocean View', 100.00, 'Available'),
('823k8f', '10', 'Large', NULL, 500.00, 'Occupied');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','resident','tech') NOT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password_hash`, `role`, `active`, `created_at`, `updated_at`) VALUES
(1, 'night@gmail.com', '$2a$12$wFdji4M7qo1ldyTwl0QqT.OvcRO99lfr43D17/TpP/q1.n2bXqrtq', 'admin', 1, '2025-01-09 19:26:54', '2025-01-19 12:51:07'),
(2, 'resident@example.com', 'hashedPasswordHere', 'resident', 1, '2025-01-09 19:26:54', '2025-01-09 19:26:54'),
(3, 'lazariatik@gmail.com', '$2a$12$Bs.g4KmN0Z8cG6qUU69ZGuIhZYJGwuMMhyNXbEi4o90BjzfDwaH0a', 'resident', 1, '2025-01-09 20:29:59', '2025-01-11 12:06:29'),
(4, 'belaatiknizar@gmail.com', '$2a$12$Ow8utRHWdCENNCKwtVE3cOh4bxfoAW036FRqnVl.C0uOsKMXUArUq', 'tech', 1, '2025-01-10 12:18:53', '2025-01-18 19:25:50'),
(5, 'n@gmail.com', '$2a$12$4xaAXHMqSXrrTWCL.CPypuoDxHq3kh06kw.wTMVXQ.I2rjL0xpJ2a', 'tech', 1, '2025-01-14 14:59:41', '2025-01-14 15:00:01');

-- --------------------------------------------------------

--
-- Table structure for table `user_admin_tech_info`
--

CREATE TABLE `user_admin_tech_info` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user_admin_tech_info`
--

INSERT INTO `user_admin_tech_info` (`id`, `email`, `firstname`, `lastname`, `phone`) VALUES
(1, 'night@gmail.com', 'Night12', 'Code1', '101010101010'),
(2, 'belaatiknizar@gmail.com', 'NIZ', 'BE', '123455'),
(3, 'n@gmail.com', 'Nii', 'Bee', '0123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `email_verification`
--
ALTER TABLE `email_verification`
  ADD PRIMARY KEY (`verification_id`),
  ADD UNIQUE KEY `verification_token` (`verification_token`);

--
-- Indexes for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `resident_email` (`resident_email`),
  ADD KEY `roomId` (`roomId`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`paymentId`);

--
-- Indexes for table `payment_data`
--
ALTER TABLE `payment_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_generation_status`
--
ALTER TABLE `payment_generation_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `residents`
--
ALTER TABLE `residents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `roomId` (`roomId`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`roomId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_admin_tech_info`
--
ALTER TABLE `user_admin_tech_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `email_verification`
--
ALTER TABLE `email_verification`
  MODIFY `verification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `payment_data`
--
ALTER TABLE `payment_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_generation_status`
--
ALTER TABLE `payment_generation_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `residents`
--
ALTER TABLE `residents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_admin_tech_info`
--
ALTER TABLE `user_admin_tech_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `maintenance_requests`
--
ALTER TABLE `maintenance_requests`
  ADD CONSTRAINT `maintenance_requests_ibfk_1` FOREIGN KEY (`resident_email`) REFERENCES `residents` (`email`) ON DELETE CASCADE,
  ADD CONSTRAINT `maintenance_requests_ibfk_2` FOREIGN KEY (`roomId`) REFERENCES `rooms` (`roomId`) ON DELETE CASCADE;

--
-- Constraints for table `residents`
--
ALTER TABLE `residents`
  ADD CONSTRAINT `residents_ibfk_1` FOREIGN KEY (`roomId`) REFERENCES `rooms` (`roomId`);

--
-- Constraints for table `user_admin_tech_info`
--
ALTER TABLE `user_admin_tech_info`
  ADD CONSTRAINT `user_admin_tech_info_ibfk_1` FOREIGN KEY (`email`) REFERENCES `users` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
