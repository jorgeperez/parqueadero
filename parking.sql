SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`estados` (
  `id_estado` INT NOT NULL,
  `nombre_estado` VARCHAR(12) NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tipos_vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipos_vehiculos` (
  `id_tipo_vehiculo` INT NOT NULL,
  `nombre_tipo_vehiculo` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_tipo_vehiculo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_tarifas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_tarifas` (
  `id_tipo_tarifa` INT NOT NULL,
  `nombre_tipo_tarifa` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id_tipo_tarifa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tarifas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tarifas` (
  `id_tarifa` INT NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `valor_tarifa` DECIMAL(10,2) NOT NULL,
  `iva_tarifa` INT NOT NULL COMMENT 'No sé si es la manera correcta de guardar valores de moneda',
  `valor_tarifa_iva` DECIMAL(10,2) NOT NULL,
  `tipo_tarifas_id_tipo_tarifa` INT NOT NULL,
  PRIMARY KEY (`id_tarifa`),
  INDEX `fk_tarifas_tipo_tarifas1_idx` (`tipo_tarifas_id_tipo_tarifa` ASC),
  CONSTRAINT `fk_tarifas_tipo_tarifas1`
    FOREIGN KEY (`tipo_tarifas_id_tipo_tarifa`)
    REFERENCES `mydb`.`tipo_tarifas` (`id_tipo_tarifa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `id_rol` INT NOT NULL,
  `nombre_rol` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombres_usuario` VARCHAR(45) NOT NULL,
  `telefono_usuario` VARCHAR(45) NULL,
  `apellidos_usuario` VARCHAR(45) NOT NULL,
  `email_usuario` VARCHAR(45) NULL,
  `contraseña_usuario` VARCHAR(12) NOT NULL,
  `opciones_usuario` VARCHAR(45) NOT NULL,
  `roles_id_rol` INT NOT NULL,
  `cedula` VARCHAR(30) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `estado` INT NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_usuarios_roles1_idx` (`roles_id_rol` ASC),
  CONSTRAINT `fk_usuarios_roles1`
    FOREIGN KEY (`roles_id_rol`)
    REFERENCES `mydb`.`roles` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`aperturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aperturas` (
  `id_apertura` INT NOT NULL,
  `fecha_apertura` DATE NOT NULL,
  `hora_apertura` DATETIME NOT NULL,
  `valor_base` DECIMAL(10,2) NULL,
  `usuarios_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_apertura`),
  INDEX `fk_aperturas_usuarios1_idx` (`usuarios_id_usuario` ASC),
  CONSTRAINT `fk_aperturas_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `mydb`.`eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`eventos` (
  `id_evento` INT NOT NULL,
  `nombre_evento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_evento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`log_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`log_usuarios` (
  `id_log` INT NOT NULL,
  `fecha_log` DATE NOT NULL,
  `hora_log` DATETIME NOT NULL,
  `usuarios_id_usuario` INT NOT NULL,
  `eventos_id_evento` INT NOT NULL,
  PRIMARY KEY (`id_log`),
  INDEX `fk_log_usuarios_usuarios1_idx` (`usuarios_id_usuario` ASC),
  INDEX `fk_log_usuarios_eventos1_idx` (`eventos_id_evento` ASC),
  CONSTRAINT `fk_log_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_usuarios_eventos1`
    FOREIGN KEY (`eventos_id_evento`)
    REFERENCES `mydb`.`eventos` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`arqueo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`arqueo` (
  `id_arqueo` INT NOT NULL,
  `valor_ingresado` DECIMAL(10,2) NOT NULL,
  `valor_calculado` DECIMAL(10,2) NOT NULL,
  `diferencia` DECIMAL NULL,
  `gastos` FLOAT NULL,
  `fecha_arqueo` DATE NOT NULL,
  `usuarios_id_usuario` INT NOT NULL,
  `tipos_vehiculos_id_tipo_vehiculo` INT NOT NULL,
  PRIMARY KEY (`id_arqueo`),
  INDEX `fk_arqueo_usuarios1_idx` (`usuarios_id_usuario` ASC),
  INDEX `fk_arqueo_tipos_vehiculos1_idx` (`tipos_vehiculos_id_tipo_vehiculo` ASC),
  CONSTRAINT `fk_arqueo_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_arqueo_tipos_vehiculos1`
    FOREIGN KEY (`tipos_vehiculos_id_tipo_vehiculo`)
    REFERENCES `mydb`.`tipos_vehiculos` (`id_tipo_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`resolucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`resolucion` (
  `id_resolucion` INT NOT NULL,
  `nombre_resolucion` VARCHAR(45) NOT NULL,
  `consecutivo_inicial` VARCHAR(45) NOT NULL,
  `consecutivo final` VARCHAR(45) NOT NULL,
  `fecha_inicial` DATE NOT NULL,
  `fecha_final` DATE NOT NULL,
  `fecha_registro` DATE NULL,
  `usuarios_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_resolucion`),
  INDEX `fk_resolucion_usuarios1_idx` (`usuarios_id_usuario` ASC),
  CONSTRAINT `fk_resolucion_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`tirillas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tirillas` (
  `id_tirilla` INT NOT NULL,
  `fecha_tirilla` DATE NOT NULL,
  `placa` VARCHAR(10) NOT NULL,
  `tirillascol` VARCHAR(45) NOT NULL,
  `estados_id_estado` INT NOT NULL,
  `usuarios_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_tirilla`),
  INDEX `fk_tirillas_estados1_idx` (`estados_id_estado` ASC),
  INDEX `fk_tirillas_usuarios1_idx` (`usuarios_id_usuario` ASC),
  CONSTRAINT `fk_tirillas_estados1`
    FOREIGN KEY (`estados_id_estado`)
    REFERENCES `mydb`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tirillas_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`facturas` (
  `id_factura` INT NOT NULL,
  `subtotal` DECIMAL NOT NULL,
  `total` DECIMAL NOT NULL,
  `iva` INT NOT NULL,
  `duracion_parqueo` DECIMAL NOT NULL,
  `fecha_salida` DATE NOT NULL,
  `usuarios_id_usuario` INT NOT NULL,
  `estados_id_estado` INT NOT NULL,
  `tirillas_id_tirilla` INT NOT NULL,
  `resolucion_id_resolucion` INT NOT NULL,
  PRIMARY KEY (`id_factura`),
  INDEX `fk_facturas_usuarios1_idx` (`usuarios_id_usuario` ASC),
  INDEX `fk_facturas_estados1_idx` (`estados_id_estado` ASC),
  INDEX `fk_facturas_tirillas1_idx` (`tirillas_id_tirilla` ASC),
  INDEX `fk_facturas_resolucion1_idx` (`resolucion_id_resolucion` ASC),
  CONSTRAINT `fk_facturas_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_estados1`
    FOREIGN KEY (`estados_id_estado`)
    REFERENCES `mydb`.`estados` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_tirillas1`
    FOREIGN KEY (`tirillas_id_tirilla`)
    REFERENCES `mydb`.`tirillas` (`id_tirilla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_resolucion1`
    FOREIGN KEY (`resolucion_id_resolucion`)
    REFERENCES `mydb`.`resolucion` (`id_resolucion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`nota_contable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`nota_contable` (
  `id_notacontable` INT NOT NULL,
  `concepto_servicio` VARCHAR(45) NOT NULL,
  `valor_nota` DECIMAL NOT NULL,
  `fecha_nota` DATE NOT NULL,
  `nit_empresa` INT NOT NULL,
  `usuarios_id_usuario` INT NOT NULL,
  `facturas_id_factura` INT NOT NULL,
  PRIMARY KEY (`id_notacontable`),
  INDEX `fk_nota_contable_usuarios1_idx` (`usuarios_id_usuario` ASC),
  INDEX `fk_nota_contable_facturas1_idx` (`facturas_id_factura` ASC),
  CONSTRAINT `fk_nota_contable_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_contable_facturas1`
    FOREIGN KEY (`facturas_id_factura`)
    REFERENCES `mydb`.`facturas` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`movimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movimientos` (
  `id_movimiento_consecutivo` INT NOT NULL,
  `cuenta` VARCHAR(45) NOT NULL,
  `descripcion_cuenta` VARCHAR(45) NOT NULL,
  `debitos` VARCHAR(45) NOT NULL,
  `creditos` VARCHAR(45) NOT NULL COMMENT '	',
  `fecha_movimiento` DATE NULL,
  `usuarios_id_usuario` INT NOT NULL,
  `nota_contable_id_notacontable` INT NOT NULL,
  PRIMARY KEY (`id_movimiento_consecutivo`),
  INDEX `fk_movimientos_usuarios1_idx` (`usuarios_id_usuario` ASC),
  INDEX `fk_movimientos_nota_contable1_idx` (`nota_contable_id_notacontable` ASC),
  CONSTRAINT `fk_movimientos_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimientos_nota_contable1`
    FOREIGN KEY (`nota_contable_id_notacontable`)
    REFERENCES `mydb`.`nota_contable` (`id_notacontable`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish2_ci;


-- -----------------------------------------------------
-- Table `mydb`.`log_tirilla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`log_tirilla` (
  `id_logtirilla` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL,
  `hora` TIME NULL,
  `tirillas_id_tirilla` INT NOT NULL,
  `eventos_id_evento` INT NOT NULL,
  `usuarios_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_logtirilla`),
  INDEX `fk_log_tirilla_tirillas1_idx` (`tirillas_id_tirilla` ASC),
  INDEX `fk_log_tirilla_eventos1_idx` (`eventos_id_evento` ASC),
  INDEX `fk_log_tirilla_usuarios1_idx` (`usuarios_id_usuario` ASC),
  CONSTRAINT `fk_log_tirilla_tirillas1`
    FOREIGN KEY (`tirillas_id_tirilla`)
    REFERENCES `mydb`.`tirillas` (`id_tirilla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_tirilla_eventos1`
    FOREIGN KEY (`eventos_id_evento`)
    REFERENCES `mydb`.`eventos` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_tirilla_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`log_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`log_factura` (
  `id_logfactura` INT NOT NULL,
  `fecha` DATE NULL,
  `hora` TIME NULL,
  `usuarios_id_usuario` INT NOT NULL,
  `eventos_id_evento` INT NOT NULL,
  `facturas_id_factura` INT NOT NULL,
  PRIMARY KEY (`id_logfactura`),
  INDEX `fk_log_factura_usuarios1_idx` (`usuarios_id_usuario` ASC),
  INDEX `fk_log_factura_eventos1_idx` (`eventos_id_evento` ASC),
  INDEX `fk_log_factura_facturas1_idx` (`facturas_id_factura` ASC),
  CONSTRAINT `fk_log_factura_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `mydb`.`usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_factura_eventos1`
    FOREIGN KEY (`eventos_id_evento`)
    REFERENCES `mydb`.`eventos` (`id_evento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_factura_facturas1`
    FOREIGN KEY (`facturas_id_factura`)
    REFERENCES `mydb`.`facturas` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mensualidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mensualidades` (
  `id_mensualidad` INT NOT NULL,
  `cedula_cliente` VARCHAR(20) NULL,
  `nombre_cliente` VARCHAR(45) NULL,
  `apellido_cliente` VARCHAR(45) NULL,
  `placa` VARCHAR(45) NULL,
  `fecha_registro` DATE NULL,
  `tipos_vehiculos_id_tipo_vehiculo` INT NOT NULL,
  `tipo_tarifas_id_tipo_tarifa` INT NOT NULL,
  PRIMARY KEY (`id_mensualidad`),
  INDEX `fk_mensualidades_tipos_vehiculos1_idx` (`tipos_vehiculos_id_tipo_vehiculo` ASC),
  INDEX `fk_mensualidades_tipo_tarifas1_idx` (`tipo_tarifas_id_tipo_tarifa` ASC),
  CONSTRAINT `fk_mensualidades_tipos_vehiculos1`
    FOREIGN KEY (`tipos_vehiculos_id_tipo_vehiculo`)
    REFERENCES `mydb`.`tipos_vehiculos` (`id_tipo_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mensualidades_tipo_tarifas1`
    FOREIGN KEY (`tipo_tarifas_id_tipo_tarifa`)
    REFERENCES `mydb`.`tipo_tarifas` (`id_tipo_tarifa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
