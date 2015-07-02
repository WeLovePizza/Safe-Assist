-- MySQL Script generated by MySQL Workbench
-- Thu Jul  2 15:17:30 2015
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema safeassist
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema safeassist
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `safeassist` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `safeassist` ;

-- -----------------------------------------------------
-- Table `safeassist`.`USER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `safeassist`.`USER` ;

CREATE TABLE IF NOT EXISTS `safeassist`.`USER` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(85) NULL,
  `password` VARCHAR(85) NULL,
  `email` MEDIUMTEXT NULL,
  `usertype` ENUM('AGENT', 'NORMAL', 'ADMIN') NOT NULL,
  `remember_token` CHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `safeassist`.`CONSUMER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `safeassist`.`CONSUMER` ;

CREATE TABLE IF NOT EXISTS `safeassist`.`CONSUMER` (
  `id` INT NOT NULL,
  `sponsor` INT NOT NULL,
  `description` TEXT NULL,
  `last_update` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_CONSUMER_USER1_idx` (`sponsor` ASC),
  INDEX `user_records` (`id` ASC, `sponsor` ASC),
  CONSTRAINT `fk_CONSUMER_USER1`
    FOREIGN KEY (`sponsor`)
    REFERENCES `safeassist`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `safeassist`.`AGENCY`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `safeassist`.`AGENCY` ;

CREATE TABLE IF NOT EXISTS `safeassist`.`AGENCY` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `safeassist`.`AGENT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `safeassist`.`AGENT` ;

CREATE TABLE IF NOT EXISTS `safeassist`.`AGENT` (
  `user` INT NULL,
  `agency` INT NOT NULL,
  PRIMARY KEY (`user`),
  INDEX `fk_AGENT_ENTERPRISE1_idx` (`agency` ASC),
  CONSTRAINT `fk_AGENT_USER1`
    FOREIGN KEY (`user`)
    REFERENCES `safeassist`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AGENT_ENTERPRISE1`
    FOREIGN KEY (`agency`)
    REFERENCES `safeassist`.`AGENCY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `safeassist`.`ENTERPRISE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `safeassist`.`ENTERPRISE` ;

CREATE TABLE IF NOT EXISTS `safeassist`.`ENTERPRISE` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL COMMENT 'represents a group which acts as advocates and caretakers for consumers',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `safeassist`.`USERS_IN_ENTERPRISE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `safeassist`.`USERS_IN_ENTERPRISE` ;

CREATE TABLE IF NOT EXISTS `safeassist`.`USERS_IN_ENTERPRISE` (
  `user` INT NOT NULL,
  `enterprise` INT NOT NULL,
  INDEX `fk_USERS_IN_ENTERPRISE_USER1_idx` (`user` ASC),
  INDEX `fk_USERS_IN_ENTERPRISE_ENTERPRISE1_idx` (`enterprise` ASC),
  CONSTRAINT `fk_USERS_IN_ENTERPRISE_USER1`
    FOREIGN KEY (`user`)
    REFERENCES `safeassist`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USERS_IN_ENTERPRISE_ENTERPRISE1`
    FOREIGN KEY (`enterprise`)
    REFERENCES `safeassist`.`ENTERPRISE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
