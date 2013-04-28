SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `FotoKommentare` ;
CREATE SCHEMA IF NOT EXISTS `FotoKommentare` DEFAULT CHARACTER SET utf8 ;
USE `FotoKommentare` ;

-- -----------------------------------------------------
-- Table `FotoKommentare`.`FK_CategoryAndTag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FotoKommentare`.`FK_CategoryAndTag` ;

CREATE  TABLE IF NOT EXISTS `FotoKommentare`.`FK_CategoryAndTag` (
  `Id` INT(11) NOT NULL ,
  `Name` VARCHAR(45) NOT NULL ,
  `Comment` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) ,
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Enthaellt Angaben zu Kategorien oder Tags, die an einem Foto vergeben werden';


-- -----------------------------------------------------
-- Table `FotoKommentare`.`FK_User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FotoKommentare`.`FK_User` ;

CREATE  TABLE IF NOT EXISTS `FotoKommentare`.`FK_User` (
  `Id` INT(11) NOT NULL ,
  `UserName` VARCHAR(16) NOT NULL ,
  `EMailAdress` VARCHAR(64) NOT NULL ,
  `NamePart1` VARCHAR(45) NOT NULL ,
  `NamePart2` VARCHAR(45) NOT NULL ,
  `UserState` SMALLINT NOT NULL ,
  `Passwd` VARCHAR(128) NOT NULL ,
  `Street` VARCHAR(128) NOT NULL ,
  `City` VARCHAR(128) NOT NULL ,
  `ZipNumber` VARCHAR(36) NOT NULL ,
  `Phone` VARCHAR(36) NOT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) ,
  UNIQUE INDEX `UserName_UNIQUE` (`UserName` ASC) ,
  UNIQUE INDEX `EMailAdress_UNIQUE` (`EMailAdress` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Enthaellt Angaben zum registrierten Benutzer';


-- -----------------------------------------------------
-- Table `FotoKommentare`.`FK_Picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FotoKommentare`.`FK_Picture` ;

CREATE  TABLE IF NOT EXISTS `FotoKommentare`.`FK_Picture` (
  `Id` INT(11) NOT NULL ,
  `Format` VARCHAR(32) NOT NULL ,
  `CreaDateTime` DATETIME NOT NULL ,
  `LocationFS` VARCHAR(255) NOT NULL ,
  `PictureState` SMALLINT NOT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Enthaellt Angaben zu hochgeladenen Bildern inklusiver Speicherort im FileSystem';


-- -----------------------------------------------------
-- Table `FotoKommentare`.`FK_Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FotoKommentare`.`FK_Comments` ;

CREATE  TABLE IF NOT EXISTS `FotoKommentare`.`FK_Comments` (
  `Id` INT(11) NOT NULL ,
  `PictureId` INT(11) NOT NULL ,
  `UserId` INT(11) NOT NULL ,
  `Comment` TEXT NOT NULL ,
  `RelatedId` INT(11) NULL DEFAULT NULL ,
  `CommentState` SMALLINT(6) NOT NULL ,
  `CreaDateTime` DATETIME NOT NULL ,
  `ModDateTime` DATETIME NULL DEFAULT NULL ,
  PRIMARY KEY (`Id`) ,
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC) ,
  INDEX `User_idx` (`UserId` ASC) ,
  INDEX `Related_idx` (`RelatedId` ASC) ,
  INDEX `fk_FK_Comments_Picture` (`PictureId` ASC) ,
  INDEX `fk_FK_Comments_User` (`UserId` ASC) ,
  INDEX `fk_FK_Comments_1` (`UserId` ASC) ,
  INDEX `fk_FK_Comments_2` (`PictureId` ASC) ,
  INDEX `fk_FK_Comments_3` (`RelatedId` ASC) ,
  CONSTRAINT `fk_FK_Comments_1`
    FOREIGN KEY (`UserId` )
    REFERENCES `FotoKommentare`.`FK_User` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FK_Comments_2`
    FOREIGN KEY (`PictureId` )
    REFERENCES `FotoKommentare`.`FK_Picture` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FK_Comments_3`
    FOREIGN KEY (`RelatedId` )
    REFERENCES `FotoKommentare`.`FK_Comments` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Enthaellt die getaetigten Kommentare';


-- -----------------------------------------------------
-- Table `FotoKommentare`.`FK_Picture_Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FotoKommentare`.`FK_Picture_Category` ;

CREATE  TABLE IF NOT EXISTS `FotoKommentare`.`FK_Picture_Category` (
  `PictureId` INT(11) NOT NULL ,
  `CategoryId` INT(11) NOT NULL ,
  INDEX `picture_category_UNIQUE` (`PictureId` ASC, `CategoryId` ASC) ,
  INDEX `fk_FK_Picture_Category_1` (`PictureId` ASC) ,
  INDEX `fk_FK_Picture_Category_2` (`CategoryId` ASC) ,
  CONSTRAINT `fk_FK_Picture_Category_1`
    FOREIGN KEY (`PictureId` )
    REFERENCES `FotoKommentare`.`FK_Picture` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FK_Picture_Category_2`
    FOREIGN KEY (`CategoryId` )
    REFERENCES `FotoKommentare`.`FK_CategoryAndTag` (`Id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Verlinkungstabelle zwischen Foto und Kategorie/Tag';



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
