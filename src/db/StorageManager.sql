-- phpMyAdmin SQL Dump
-- version 4.5.0.2
-- http://www.phpmyadmin.net
--
-- Gép: localhost
-- Létrehozás ideje: 2015. Nov 27. 14:46
-- Kiszolgáló verziója: 10.0.17-MariaDB
-- PHP verzió: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `StorageManager`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Events`
--

CREATE TABLE `Events` (
  `event_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `notification_text` varchar(3000) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ItemTypes`
--

CREATE TABLE `ItemTypes` (
  `item_type_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `quantity_unit` varchar(25) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Storages`
--

CREATE TABLE `Storages` (
  `storage_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `template_id` int(10) UNSIGNED NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `StorageTemplateItems`
--

CREATE TABLE `StorageTemplateItems` (
  `id` int(10) UNSIGNED NOT NULL,
  `template_id` int(10) UNSIGNED NOT NULL,
  `item_type_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(11) DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `StorageTemplates`
--

CREATE TABLE `StorageTemplates` (
  `template_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `StoredItems`
--

CREATE TABLE `StoredItems` (
  `id` int(10) UNSIGNED NOT NULL,
  `storage_id` int(10) UNSIGNED NOT NULL,
  `item_type_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(11) DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `Users`
--

CREATE TABLE `Users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `login_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('admin','owner','manager','field_worker') DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `Users`
--

INSERT INTO `Users` (`user_id`, `login_name`, `password`, `user_type`, `timestamp`) VALUES
(1, 'admin', 'admin', 'admin', '2015-11-26 00:24:52'),
(2, 'owner1', 'owner1', 'owner', '2015-11-26 00:25:09'),
(3, 'owner2', 'owner2', 'owner', '2015-11-26 00:25:16'),
(4, 'manager1', 'manager1', 'manager', '2015-11-26 00:25:30'),
(5, 'manager2', 'manager2', 'manager', '2015-11-26 00:25:38'),
(6, 'employee1', 'employee1', 'field_worker', '2015-11-26 00:27:59'),
(7, 'employee2', 'employee2', 'field_worker', '2015-11-26 00:28:07'),
(8, 'employee3', 'employee3', 'field_worker', '2015-11-26 00:28:16');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `Events`
--
ALTER TABLE `Events`
  ADD PRIMARY KEY (`event_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- A tábla indexei `ItemTypes`
--
ALTER TABLE `ItemTypes`
  ADD PRIMARY KEY (`item_type_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- A tábla indexei `Storages`
--
ALTER TABLE `Storages`
  ADD PRIMARY KEY (`storage_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `template_id` (`template_id`);

--
-- A tábla indexei `StorageTemplateItems`
--
ALTER TABLE `StorageTemplateItems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_template_record` (`template_id`,`item_type_id`),
  ADD KEY `item_type_id` (`item_type_id`);

--
-- A tábla indexei `StorageTemplates`
--
ALTER TABLE `StorageTemplates`
  ADD PRIMARY KEY (`template_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- A tábla indexei `StoredItems`
--
ALTER TABLE `StoredItems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_item_type` (`storage_id`,`item_type_id`),
  ADD KEY `item_type_id` (`item_type_id`);

--
-- A tábla indexei `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `login_name` (`login_name`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `Events`
--
ALTER TABLE `Events`
  MODIFY `event_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT a táblához `ItemTypes`
--
ALTER TABLE `ItemTypes`
  MODIFY `item_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT a táblához `Storages`
--
ALTER TABLE `Storages`
  MODIFY `storage_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT a táblához `StorageTemplateItems`
--
ALTER TABLE `StorageTemplateItems`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT a táblához `StorageTemplates`
--
ALTER TABLE `StorageTemplates`
  MODIFY `template_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT a táblához `StoredItems`
--
ALTER TABLE `StoredItems`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT a táblához `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `Storages`
--
ALTER TABLE `Storages`
  ADD CONSTRAINT `Storages_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `StorageTemplates` (`template_id`);

--
-- Megkötések a táblához `StorageTemplateItems`
--
ALTER TABLE `StorageTemplateItems`
  ADD CONSTRAINT `StorageTemplateItems_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `StorageTemplates` (`template_id`),
  ADD CONSTRAINT `StorageTemplateItems_ibfk_2` FOREIGN KEY (`item_type_id`) REFERENCES `ItemTypes` (`item_type_id`);

--
-- Megkötések a táblához `StoredItems`
--
ALTER TABLE `StoredItems`
  ADD CONSTRAINT `StoredItems_ibfk_1` FOREIGN KEY (`storage_id`) REFERENCES `Storages` (`storage_id`),
  ADD CONSTRAINT `StoredItems_ibfk_2` FOREIGN KEY (`item_type_id`) REFERENCES `ItemTypes` (`item_type_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
