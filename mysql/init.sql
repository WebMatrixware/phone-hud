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
    `backupAdded` DATETIME DEFAULT NULL,
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
    `serverIP` INT UNSIGNED,
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
    `systemName` VARCHAR(100) NOT NULL UNIQUE,
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
