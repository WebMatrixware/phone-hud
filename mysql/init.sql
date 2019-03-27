/*!40000 DROP DATABASE IF EXISTS `phone-hud`*/;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ `phone-hud` /*40100 DECFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci*/;
USE `phone-hud`;

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `addressID` INT(11) NOT NULL AUTO_INCREMENT,
    `addressStreet` VARCHAR(100),
    `addressCity` VARCHAR(60),
    `addressState` VARCHAR(20),
    `addressZip` VARCHAR(10),
    PRIMARY KEY (`addressID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `backups`;
CREATE TABLE `backups` (
  `backupID` INT(11) NOT NULL AUTO_INCREMENT,
    `backupName` VARCHAR(100),
    `backupAddedDate` DATETIME DEFAULT NULL,
    `systemID` INT(11) NOT NULL,
    PRIMARY KEY (`backupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `clientID` INT(11) NOT NULL AUTO_INCREMENT,
    `clientName` VARCHAR(200) NOT NULL,
    `clientNumber` VARCHAR(16) NOT NULL,
    `clientDateAdded` DATETIME DEFAULT NULL,
    `clientDateJoined` DATETIME DEFAULT NULL,
    `addressID` INT(11),
    `primaryContactID` INT(11),
    `secondaryContactID` INT(11),
    PRIMARY KEY (`clientID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `contactID` INT(11) NOT NULL AUTO_INCREMENT,
    `contactFName` VARCHAR(25),
    `contactMI` CHAR(1),
    `contactLName` VARCHAR(40),
    `contactPhone` VARCHAR(10),
    `contactMobile` VARCHAR(10),
    `contactEmail` VARCHAR(100),
    PRIMARY KEY (`contactID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `servers`;
CREATE TABLE `servers` (
  `serverID` INT(11) NOT NULL AUTO_INCREMENT,
    `serverName` VARCHAR(100) NOT NULL,
    `serverMachineName` VARCHAR(40),
    `serverMAC` VARCHAR(12),
    `serverIP` INT(4) UNSIGNED,
    `serverOS` VARCHAR(60),
    `serverSTVersion` VARCHAR(40),
    `serverSTBuild` VARCHAR(20),
    `siteID` INT(11),
    PRIMARY KEY (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `siteID` INT(11) NOT NULL AUTO_INCREMENT,
    `siteName` VARCHAR(100) NOT NULL,
    `addressID` INT(11),
    `contactID` INT(11),
    `systemID` INT(11),
    PRIMARY KEY (`siteID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

DROP TABLE IF EXISTS `systems`;
CREATE TABLE `systems` (
  `systemID` INT(11) NOT NULL AUTO_INCREMENT,
    `systemName` VARCHAR(100),
    `mainAddressID` INT(11),
    `mainPhone` VARCHAR(10),
    `clientID` INT(11),
    PRIMARY KEY (`systemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


ALTER TABLE `backups` ADD CONSTRAINT `backupSystemID` FOREIGN KEY (`systemID`) REFERENCES `systems` (`systemID`) ON UPDATE CASCADE;
ALTER TABLE `clients` ADD CONSTRAINT `addressID` FOREIGN KEY (`addressID`) REFERENCES `addresses` (`addressID`) ON UPDATE CASCADE;
ALTER TABLE `clients` ADD CONSTRAINT `primaryContactID` FOREIGN KEY (`primaryContactID`) REFERENCES `contacts` (`contactID`) ON UPDATE CASCADE;
ALTER TABLE `clients` ADD CONSTRAINT `secondaryContactID` FOREIGN KEY (`secondaryContactID`) REFERENCES `contacts` (`contactID`) ON UPDATE CASCADE;
ALTER TABLE `servers` ADD CONSTRAINT `siteID` FOREIGN KEY (`siteID`) REFERENCES `sites` (`siteID`) ON UPDATE CASCADE;
ALTER TABLE `sites` ADD CONSTRAINT `siteSystemID` FOREIGN KEY (`systemID`) REFERENCES `systems` (`systemID`) ON UPDATE CASCADE;
ALTER TABLE `systems` ADD CONSTRAINT `clientID` FOREIGN KEY (`clientID`) REFERENCES `clients` (`clientID`) ON UPDATE CASCADE;

INSERT INTO `addresses` (`addressStreet`, `addressCity`, `addressState`, `addressZip`)
VALUES
('1725 Dryden Road', 'Freeville', 'New York', '13068'),
('702 Elm St', 'Groton', 'New York', '13073');

INSERT INTO `contacts` (`contactFName`, `contactMI`, `contactLName`, `contactPhone`, `contactMobile`, `contactEmail`)
VALUES
('Ben', NULL, 'Lanning', '6073476139', '6072272531', 'blanning@all-mode.com'),
('Mike', NULL, 'Almeida', '6073476138', '6073470580', 'malmeida@all-mode.com'),
('Rick', NULL, 'Beck', '6073476124', '6072270592', 'rbeck@all-mode.com'),
('Dale', NULL, 'Cotterill', '6073476134', '6073270876', 'dcotterill@all-mode.com');

INSERT INTO `clients` (`clientName`, `clientNumber`, `clientDateAdded`, `clientDateJoined`, `addressID`, `primaryContactID`, `secondaryContactID`)
VALUES
('Susquehanna Valley School', '11040', '2018-07-09', '2016-09-16', 1, 1, 2),
('CBORD Group, Inc, The', '10378', NULL, '2016-09-16', 2, 3, 4);

INSERT INTO `systems` (`systemName`, `mainAddressID`, `mainPhone`, `clientID`)
VALUES
('Main/Single', 1, '6077759143', 1),
('Main/Single', 2, '6072572410', 2);

INSERT INTO `backups` (`backupName`, `backupAddedDate`, `systemID`)
VALUES
('2019-01-01 Backup', '2019-01-01', 1),
('2019-01-08 Backup', '2019-01-08', 1),
('2019-01-08 Backup After patching', '2019-01-08', 1),
('2019-01-01 Backup', '2019-01-01', 2),
('2019-01-08 Backup', '2019-01-01', 2);

INSERT INTO `sites` (`siteName`, `addressID`, `contactID`, `systemID`)
VALUES
('Susquehanna Valley VSD HS', 1, 1, 1),
('CBOARD HQ - Ithaca', 2, 2, 2),
('CBOARD Downtown - Ithaca', 2, 2, 2);

INSERT INTO `servers` (`serverName`, `serverMachineName`, `serverMAC`, `serverIP`, `serverOS`, `serverSTVersion`, `serverSTBuild`, `siteID`)
VALUES
('Headquarters', 'SHORETEL', 'AAAAAAAAAAAA', INET_ATON('10.232.0.10'), 'Windows Server 2012 R2', 'ShoreTel 14.2', '19.47.4300.0', 1),
('Headquarters', 'CBORD_VOIP', 'BBBBBBBBBBBB', INET_ATON('10.15.0.5'), 'Windows Server 2012', 'ShoreTel 14.2', '19.45.2308.0', 2),
('ECC', 'CBORD_ECC', 'CCCCCCCCCCCC', INET_ATON('10.15.0.6'), 'Windows Server 2012', NULL, NULL, 2);
