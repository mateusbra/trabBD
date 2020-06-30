-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estado` (
  `ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cidade` (
  `ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Estado` INT(11) UNSIGNED NOT NULL,
  `Nome` VARCHAR(255) NULL,
  PRIMARY KEY (`ID`, `ID_Estado`),
  INDEX `fk_Cidade_Estado1_idx` (`ID_Estado` ASC) VISIBLE,
  CONSTRAINT `fk_Cidade_Estado1`
    FOREIGN KEY (`ID_Estado`)
    REFERENCES `mydb`.`Estado` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bairro` (
  `ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Cidade` INT(11) UNSIGNED NOT NULL,
  `Nome` VARCHAR(255) NULL,
  PRIMARY KEY (`ID`, `ID_Cidade`),
  INDEX `fk_Bairro_Cidade1_idx` (`ID_Cidade` ASC) VISIBLE,
  CONSTRAINT `fk_Bairro_Cidade1`
    FOREIGN KEY (`ID_Cidade`)
    REFERENCES `mydb`.`Cidade` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ID_Bairro` INT(11) UNSIGNED NOT NULL,
  `Logradouro` VARCHAR(255) NULL,
  `Numero` INT(11) NULL,
  PRIMARY KEY (`ID`, `ID_Bairro`),
  INDEX `fk_Endereco_Bairro1_idx` (`ID_Bairro` ASC) VISIBLE,
  CONSTRAINT `fk_Endereco_Bairro1`
    FOREIGN KEY (`ID_Bairro`)
    REFERENCES `mydb`.`Bairro` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(255) NULL,
  `Email` VARCHAR(255) NULL,
  `ID_Endereco` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`, `ID_Endereco`),
  UNIQUE INDEX `idCliente_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_Cliente_Endereco1_idx` (`ID_Endereco` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Endereco1`
    FOREIGN KEY (`ID_Endereco`)
    REFERENCES `mydb`.`Endereco` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Status` (
  `ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Status` VARCHAR(30) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pacote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pacote` (
  `ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Data_Entrega` DATE NULL,
  `Data_Prevista` DATE NULL,
  `Peso` INT(11) NULL,
  `Largura` INT(11) NULL,
  `Altura` INT(11) NULL,
  `Profundidade` INT(11) NULL,
  `ID_Status` INT(11) UNSIGNED NOT NULL,
  `ID_Cliente` INT(11) UNSIGNED NOT NULL,
  `ID_Endereco` INT(11) UNSIGNED NOT NULL,
  `ID_Endereco_Bairro` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`, `ID_Status`, `ID_Cliente`, `ID_Endereco`, `ID_Endereco_Bairro`),
  INDEX `fk_Pacote_Status_idx` (`ID_Status` ASC) VISIBLE,
  INDEX `fk_Pacote_Cliente1_idx` (`ID_Cliente` ASC) VISIBLE,
  INDEX `fk_Pacote_Endereco1_idx` (`ID_Endereco` ASC, `ID_Endereco_Bairro` ASC) VISIBLE,
  CONSTRAINT `fk_Pacote_Status`
    FOREIGN KEY (`ID_Status`)
    REFERENCES `mydb`.`Status` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pacote_Cliente1`
    FOREIGN KEY (`ID_Cliente`)
    REFERENCES `mydb`.`Cliente` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pacote_Endereco1`
    FOREIGN KEY (`ID_Endereco` , `ID_Endereco_Bairro`)
    REFERENCES `mydb`.`Endereco` (`ID` , `ID_Bairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;