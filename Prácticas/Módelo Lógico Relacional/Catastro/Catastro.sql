-- MySQL Script generated by MySQL Workbench
-- Thu Nov 12 20:11:26 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CATASTRO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CATASTRO
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CATASTRO` DEFAULT CHARACTER SET utf8 ;
USE `CATASTRO` ;

-- -----------------------------------------------------
-- Table `CATASTRO`.`BLOQUE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CATASTRO`.`BLOQUE` ;

CREATE TABLE IF NOT EXISTS `CATASTRO`.`BLOQUE` (
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(5) NOT NULL,
  `NumeroPersonas` INT NOT NULL,
  `NombreZona` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`calle`, `numero`),
  INDEX `NombreZona_idx` (`NombreZona` ASC) VISIBLE,
  CONSTRAINT `NombreZona`
    FOREIGN KEY (`NombreZona`)
    REFERENCES `CATASTRO`.`ZONA` (`nombre`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CATASTRO`.`FAMILIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CATASTRO`.`FAMILIA` ;

CREATE TABLE IF NOT EXISTS `CATASTRO`.`FAMILIA` (
  `DNIcabeza` VARCHAR(9) NOT NULL,
  `NumeroFamiliares` INT NOT NULL,
  PRIMARY KEY (`DNIcabeza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CATASTRO`.`PERSONA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CATASTRO`.`PERSONA` ;

CREATE TABLE IF NOT EXISTS `CATASTRO`.`PERSONA` (
  `DNI` VARCHAR(9) NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  `fecha_nacimiento` VARCHAR(20) NOT NULL,
  `DNIcabeza` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`DNI`),
  UNIQUE INDEX `dni_UNIQUE` (`DNI` ASC) VISIBLE,
  INDEX `DNIcabeza_idx` (`DNIcabeza` ASC) VISIBLE,
  CONSTRAINT `DNIcabeza`
    FOREIGN KEY (`DNIcabeza`)
    REFERENCES `CATASTRO`.`FAMILIA` (`DNIcabeza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CATASTRO`.`PISO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CATASTRO`.`PISO` ;

CREATE TABLE IF NOT EXISTS `CATASTRO`.`PISO` (
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(5) NOT NULL,
  `planta` INT NOT NULL,
  `portal` INT NOT NULL,
  `letra` VARCHAR(2) NOT NULL,
  `DNIcabeza` VARCHAR(9) NULL,
  `NumeroPersonas` INT NULL,
  PRIMARY KEY (`calle`, `numero`, `planta`, `portal`, `letra`),
  INDEX `numero_idx` (`numero` ASC) VISIBLE,
  INDEX `DNIcabeza_idx` (`DNIcabeza` ASC) VISIBLE,
  CONSTRAINT `calle`
    FOREIGN KEY (`calle`)
    REFERENCES `CATASTRO`.`BLOQUE` (`calle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `numero`
    FOREIGN KEY (`numero`)
    REFERENCES `CATASTRO`.`BLOQUE` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DNIcabeza`
    FOREIGN KEY (`DNIcabeza`)
    REFERENCES `CATASTRO`.`FAMILIA` (`DNIcabeza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CATASTRO`.`VIVIENDA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CATASTRO`.`VIVIENDA` ;

CREATE TABLE IF NOT EXISTS `CATASTRO`.`VIVIENDA` (
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(5) NOT NULL,
  `NumeroPersonas` INT NOT NULL,
  `DNIcabeza` VARCHAR(9) NOT NULL,
  `NombreZona` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`calle`, `numero`),
  INDEX `DNIcabeza_idx` (`DNIcabeza` ASC) VISIBLE,
  INDEX `NombreZona_idx` (`NombreZona` ASC) VISIBLE,
  CONSTRAINT `DNIcabeza`
    FOREIGN KEY (`DNIcabeza`)
    REFERENCES `CATASTRO`.`FAMILIA` (`DNIcabeza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `NombreZona`
    FOREIGN KEY (`NombreZona`)
    REFERENCES `CATASTRO`.`ZONA` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CATASTRO`.`ZONA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CATASTRO`.`ZONA` ;

CREATE TABLE IF NOT EXISTS `CATASTRO`.`ZONA` (
  `nombre` VARCHAR(45) NOT NULL,
  `area` VARCHAR(45) NOT NULL,
  `concejal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
