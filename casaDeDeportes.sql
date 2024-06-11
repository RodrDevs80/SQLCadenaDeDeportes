-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CadenaDeDeportes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CadenaDeDeportes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CadenaDeDeportes` DEFAULT CHARACTER SET utf8 ;
USE `CadenaDeDeportes` ;

-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Direccion` (
  `IdDireccion` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdDireccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Sucursal` (
  `IdSucursal` INT NOT NULL AUTO_INCREMENT,
  `numeroUnico` VARCHAR(45) NOT NULL,
  `IdDireccion` INT NOT NULL,
  PRIMARY KEY (`IdSucursal`, `IdDireccion`),
  INDEX `fk_sucursal_direccion_idx` (`IdDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_sucursal_direccion`
    FOREIGN KEY (`IdDireccion`)
    REFERENCES `CadenaDeDeportes`.`Direccion` (`IdDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Empleado` (
  `IdEmpleado` INT NOT NULL AUTO_INCREMENT,
  `legajo` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `DNI` VARCHAR(45) NULL,
  `IdDireccion` INT NOT NULL,
  PRIMARY KEY (`IdEmpleado`, `IdDireccion`),
  INDEX `fk_Empleado_Direccion1_idx` (`IdDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Direccion1`
    FOREIGN KEY (`IdDireccion`)
    REFERENCES `CadenaDeDeportes`.`Direccion` (`IdDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Telefono` (
  `IdTelefono` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `IdEmpleado` INT NOT NULL,
  PRIMARY KEY (`IdTelefono`, `IdEmpleado`),
  INDEX `fk_Telefono_Empleado1_idx` (`IdEmpleado` ASC) VISIBLE,
  CONSTRAINT `fk_Telefono_Empleado1`
    FOREIGN KEY (`IdEmpleado`)
    REFERENCES `CadenaDeDeportes`.`Empleado` (`IdEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`JornadaLaboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`JornadaLaboral` (
  `IdJornadaLaboral` INT NOT NULL AUTO_INCREMENT,
  `diaSemana` VARCHAR(45) NULL,
  `horarioEntrada` VARCHAR(45) NULL,
  `horaDeSalida` VARCHAR(45) NULL,
  `IdEmpleado` INT NOT NULL,
  `IdSucursal` INT NOT NULL,
  PRIMARY KEY (`IdJornadaLaboral`, `IdEmpleado`, `IdSucursal`),
  INDEX `fk_Trabajo_Empleado1_idx` (`IdEmpleado` ASC) VISIBLE,
  INDEX `fk_JornadaLaboral_Sucursal1_idx` (`IdSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_Trabajo_Empleado1`
    FOREIGN KEY (`IdEmpleado`)
    REFERENCES `CadenaDeDeportes`.`Empleado` (`IdEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JornadaLaboral_Sucursal1`
    FOREIGN KEY (`IdSucursal`)
    REFERENCES `CadenaDeDeportes`.`Sucursal` (`IdSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Fabrica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Fabrica` (
  `IdFabrica` INT NOT NULL AUTO_INCREMENT,
  `cuit` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `paisDeOrigen` VARCHAR(45) NULL,
  `cantidadDeEmpledos` VARCHAR(45) NULL,
  `nombreDelGerente` VARCHAR(45) NULL,
  PRIMARY KEY (`IdFabrica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Producto` (
  `IdProducto` INT NOT NULL AUTO_INCREMENT,
  `codigoDeProducto` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  `costoFijoDeFabricacion` DECIMAL NULL,
  `Productocol` VARCHAR(45) NULL,
  `IdFabrica` INT NOT NULL,
  PRIMARY KEY (`IdProducto`, `IdFabrica`),
  INDEX `fk_Producto_Fabrica1_idx` (`IdFabrica` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Fabrica1`
    FOREIGN KEY (`IdFabrica`)
    REFERENCES `CadenaDeDeportes`.`Fabrica` (`IdFabrica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Sucursal_x_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Sucursal_x_Producto` (
  `IdSucursal_x_Producto` INT NOT NULL AUTO_INCREMENT,
  `IdSucursal` INT NOT NULL,
  `IdProducto` INT NOT NULL,
  `costoUnitario` DECIMAL NULL,
  PRIMARY KEY (`IdSucursal_x_Producto`, `IdSucursal`, `IdProducto`),
  INDEX `fk_Sucursal_has_Producto_Producto1_idx` (`IdProducto` ASC) VISIBLE,
  INDEX `fk_Sucursal_has_Producto_Sucursal1_idx` (`IdSucursal` ASC) VISIBLE,
  CONSTRAINT `fk_Sucursal_has_Producto_Sucursal1`
    FOREIGN KEY (`IdSucursal`)
    REFERENCES `CadenaDeDeportes`.`Sucursal` (`IdSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sucursal_has_Producto_Producto1`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `CadenaDeDeportes`.`Producto` (`IdProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Venta` (
  `IdVenta` INT NOT NULL AUTO_INCREMENT,
  `precioVenta` DECIMAL NULL,
  `DescuentoFidelidad` DECIMAL NULL,
  `IdSucursal_x_Producto` INT NOT NULL,
  PRIMARY KEY (`IdVenta`, `IdSucursal_x_Producto`),
  INDEX `fk_Venta_Sucursal_x_Producto1_idx` (`IdSucursal_x_Producto` ASC) VISIBLE,
  CONSTRAINT `fk_Venta_Sucursal_x_Producto1`
    FOREIGN KEY (`IdSucursal_x_Producto`)
    REFERENCES `CadenaDeDeportes`.`Sucursal_x_Producto` (`IdSucursal_x_Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Cliente` (
  `IdCliente` INT NOT NULL AUTO_INCREMENT,
  `codigoDeCliente` VARCHAR(45) NULL,
  `DNI` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `fechaDeNacimiento` DATE NULL,
  `IdDireccion` INT NOT NULL,
  PRIMARY KEY (`IdCliente`, `IdDireccion`),
  INDEX `fk_Cliente_Direccion1_idx` (`IdDireccion` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Direccion1`
    FOREIGN KEY (`IdDireccion`)
    REFERENCES `CadenaDeDeportes`.`Direccion` (`IdDireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`TarjetaCredito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`TarjetaCredito` (
  `IdTarjetaCredito` INT NOT NULL AUTO_INCREMENT,
  `numeroTarjeta` VARCHAR(45) NULL,
  `nombreTarjeta` VARCHAR(45) NULL,
  `codigoDeSeguridad` VARCHAR(45) NULL,
  `fechaDeVencimiento` VARCHAR(45) NULL,
  `IdCliente` INT NOT NULL,
  PRIMARY KEY (`IdTarjetaCredito`, `IdCliente`),
  INDEX `fk_TarjetaCredito_Cliente1_idx` (`IdCliente` ASC) VISIBLE,
  CONSTRAINT `fk_TarjetaCredito_Cliente1`
    FOREIGN KEY (`IdCliente`)
    REFERENCES `CadenaDeDeportes`.`Cliente` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CadenaDeDeportes`.`Venta_x_Sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CadenaDeDeportes`.`Venta_x_Sucursal` (
  `IdVenta_x_Sucursal` INT NOT NULL AUTO_INCREMENT,
  `IdSucursal` INT NOT NULL,
  `fecha` DATE NULL,
  `precioTotal` DECIMAL NULL,
  `descuento` DECIMAL NULL,
  `IdCliente` INT NOT NULL,
  PRIMARY KEY (`IdVenta_x_Sucursal`, `IdSucursal`, `IdCliente`),
  INDEX `fk_Venta_has_Sucursal_Sucursal1_idx` (`IdSucursal` ASC) VISIBLE,
  INDEX `fk_Venta_x_Sucursal_Cliente1_idx` (`IdCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Venta_has_Sucursal_Sucursal1`
    FOREIGN KEY (`IdSucursal`)
    REFERENCES `CadenaDeDeportes`.`Sucursal` (`IdSucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_x_Sucursal_Cliente1`
    FOREIGN KEY (`IdCliente`)
    REFERENCES `CadenaDeDeportes`.`Cliente` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
