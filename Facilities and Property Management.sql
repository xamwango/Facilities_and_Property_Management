-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Facilities_and_Property_Management
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Facilities_and_Property_Management
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Facilities_and_Property_Management` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `Facilities_and_Property_Management` ;

-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`units`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`units` (
  `unit_code` INT NOT NULL,
  `unit_name` VARCHAR(45) NULL,
  `unit_type` VARCHAR(30) NULL DEFAULT NULL,
  `Number_of_houses` INT NULL DEFAULT NULL,
  `city` VARCHAR(30) NULL DEFAULT NULL,
  `location` VARCHAR(30) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`unit_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`house_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`house_statuses` (
  `status_id` INT NOT NULL,
  `occupancy` VARCHAR(30) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`houses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`houses` (
  `unit_code` INT NULL DEFAULT NULL,
  `house_number` INT NOT NULL AUTO_INCREMENT,
  `house_status` INT NULL DEFAULT NULL,
  `house_category` VARCHAR(30) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`house_number`),
  INDEX `unit_code` (`unit_code` ASC) VISIBLE,
  INDEX `house_status` (`house_status` ASC) VISIBLE,
  CONSTRAINT `houses_ibfk_1`
    FOREIGN KEY (`unit_code`)
    REFERENCES `Facilities_and_Property_Management`.`units` (`unit_code`),
  CONSTRAINT `houses_ibfk_2`
    FOREIGN KEY (`house_status`)
    REFERENCES `Facilities_and_Property_Management`.`house_statuses` (`status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`tenants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`tenants` (
  `house_number` INT NULL DEFAULT NULL,
  `tenant_Id` INT NOT NULL,
  `full_name` VARCHAR(30) NULL DEFAULT NULL,
  `entry_date` DATE NULL DEFAULT NULL,
  `DEPOSIT` DOUBLE NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`tenant_Id`),
  INDEX `house_number` (`house_number` ASC) VISIBLE,
  CONSTRAINT `tenants_ibfk_1`
    FOREIGN KEY (`house_number`)
    REFERENCES `Facilities_and_Property_Management`.`houses` (`house_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`arrears`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`arrears` (
  `for_month` VARCHAR(30) NULL DEFAULT NULL,
  `arrears_amount` DOUBLE NULL DEFAULT NULL,
  `tenant_Id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  INDEX `fk_arrears_tenants1_idx` (`tenant_Id` ASC) VISIBLE,
  CONSTRAINT `fk_arrears_tenants1`
    FOREIGN KEY (`tenant_Id`)
    REFERENCES `Facilities_and_Property_Management`.`tenants` (`tenant_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`contract_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`contract_statuses` (
  `contract_status` INT NOT NULL,
  `status_name` VARCHAR(30) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`contract_status`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`contractual_agreements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`contractual_agreements` (
  `contract_status` INT NULL DEFAULT NULL,
  `tenant_Id` INT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `tenants_tenant_Id` INT NOT NULL,
  INDEX `contract_status` (`contract_status` ASC) VISIBLE,
  INDEX `fk_contractual_agreements_tenants1_idx` (`tenants_tenant_Id` ASC) VISIBLE,
  CONSTRAINT `contractual_agreement_ibfk_2`
    FOREIGN KEY (`contract_status`)
    REFERENCES `Facilities_and_Property_Management`.`contract_statuses` (`contract_status`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_contractual_agreements_tenants1`
    FOREIGN KEY (`tenants_tenant_Id`)
    REFERENCES `Facilities_and_Property_Management`.`tenants` (`tenant_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`maintenances`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`maintenances` (
  `house_number` INT NULL DEFAULT NULL,
  `maintenance` VARCHAR(30) NULL DEFAULT NULL,
  `date_repaired` DATE NULL DEFAULT NULL,
  `cost_incurred` DOUBLE NULL DEFAULT NULL,
  `serviced_by` VARCHAR(30) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  INDEX `house_number` (`house_number` ASC) VISIBLE,
  CONSTRAINT `maintenance_ibfk_1`
    FOREIGN KEY (`house_number`)
    REFERENCES `Facilities_and_Property_Management`.`houses` (`house_number`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`notices_to_vacate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`notices_to_vacate` (
  `date_issued` DATE NULL DEFAULT NULL,
  `date_to_vacate` DATE NULL DEFAULT NULL,
  `tenant_Id` INT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  INDEX `fk_notices_to_vacate_tenants1_idx` (`tenant_Id` ASC) VISIBLE,
  CONSTRAINT `fk_notices_to_vacate_tenants1`
    FOREIGN KEY (`tenant_Id`)
    REFERENCES `Facilities_and_Property_Management`.`tenants` (`tenant_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`payment_methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`payment_methods` (
  `payment_mode` INT NOT NULL,
  `payment_method` VARCHAR(30) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`payment_mode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`rent_garbbage_payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`rent_garbbage_payments` (
  `reference_transaction_code` INT NOT NULL,
  `month_paid` VARCHAR(30) NULL DEFAULT NULL,
  `for_year` VARCHAR(30) NULL DEFAULT NULL,
  `rent` DOUBLE NULL DEFAULT NULL,
  `garbbage_fee` DOUBLE NULL DEFAULT NULL,
  `date_paid` DATE NULL DEFAULT NULL,
  `payment_mode` INT NULL DEFAULT NULL,
  `tenant_Id` INT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`reference_transaction_code`),
  INDEX `payment_mode` (`payment_mode` ASC) VISIBLE,
  INDEX `fk_rent_garbbage_payments_tenants1_idx` (`tenant_Id` ASC) VISIBLE,
  CONSTRAINT `rent_garbbage_payment_ibfk_2`
    FOREIGN KEY (`payment_mode`)
    REFERENCES `Facilities_and_Property_Management`.`payment_methods` (`payment_mode`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_rent_garbbage_payments_tenants1`
    FOREIGN KEY (`tenant_Id`)
    REFERENCES `Facilities_and_Property_Management`.`tenants` (`tenant_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `Facilities_and_Property_Management`.`unit_securities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Facilities_and_Property_Management`.`unit_securities` (
  `unit_code` INT NULL DEFAULT NULL,
  `company_Id` INT NULL DEFAULT NULL,
  `company_name` VARCHAR(30) NULL DEFAULT NULL,
  `company_contact` VARCHAR(30) NULL DEFAULT NULL,
  `officer_name` VARCHAR(30) NULL DEFAULT NULL,
  `officer_contact` VARCHAR(30) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  INDEX `unit_code` (`unit_code` ASC) VISIBLE,
  CONSTRAINT `unit_security_ibfk_1`
    FOREIGN KEY (`unit_code`)
    REFERENCES `Facilities_and_Property_Management`.`units` (`unit_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
