-- -----------------------------------------------------
-- Table `orgao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orgao` (
  `idorgao` INT NOT NULL AUTO_INCREMENT,
  `sigla` VARCHAR(20) NULL,
  `nome` VARCHAR(150) NULL,
  PRIMARY KEY (`idorgao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `uf` (
  `iduf` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  PRIMARY KEY (`iduf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cidade` (
  `idcidade` INT NOT NULL AUTO_INCREMENT,
  `iduf` INT NOT NULL,
  `nome` VARCHAR(150) NULL,
  PRIMARY KEY (`idcidade`),
  INDEX `fk_cidade_uf_idx` (`iduf` ASC),
  CONSTRAINT `fk_cidade_uf`
    FOREIGN KEY (`iduf`)
    REFERENCES `uf` (`iduf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fornecedor` (
  `idfornecedor` INT NOT NULL AUTO_INCREMENT,
  `idcidade` INT NOT NULL,
  `razaosocial` VARCHAR(150) NULL,
  `cnpj` VARCHAR(20) NULL,
  `cep` VARCHAR(9) NULL,
  `logradouro` VARCHAR(150) NULL,
  `numero` INT NULL,
  `complemento` VARCHAR(60) NULL,
  `bairro` VARCHAR(100) NULL,
  `telefone` VARCHAR(15) NULL,
  `celular` VARCHAR(15) NULL,
  `email` VARCHAR(100) NULL,
  `responsavel` VARCHAR(150) NULL,
  PRIMARY KEY (`idfornecedor`),
  INDEX `fk_fornecedor_cidade1_idx` (`idcidade` ASC),
  CONSTRAINT `fk_fornecedor_cidade1`
    FOREIGN KEY (`idcidade`)
    REFERENCES `cidade` (`idcidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `unidade_medida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `unidade_medida` (
  `idunidade_medida` INT NOT NULL AUTO_INCREMENT,
  `sigla` VARCHAR(20) NULL,
  `descricao` VARCHAR(100) NULL,
  PRIMARY KEY (`idunidade_medida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produto` (
  `idproduto` INT NOT NULL AUTO_INCREMENT,
  `idunidade_medida` INT NOT NULL,
  `nome` VARCHAR(100) NULL,
  `descricao` VARCHAR(200) NULL,
  `marca` VARCHAR(100) NULL,
  PRIMARY KEY (`idproduto`),
  INDEX `fk_produto_unidade_medida1_idx` (`idunidade_medida` ASC),
  CONSTRAINT `fk_produto_unidade_medida1`
    FOREIGN KEY (`idunidade_medida`)
    REFERENCES `unidade_medida` (`idunidade_medida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `contrato` (
  `idcontrato` INT NOT NULL AUTO_INCREMENT,
  `idorgao` INT NOT NULL,
  `numerocontrato` VARCHAR(50) NULL,
  `objetocontrato` VARCHAR(255) NULL,
  `valorcontrato` DECIMAL(10,2) NULL,
  `validadecontrato` DATE NULL,
  `dataassinaturacontrato` DATE NULL,
  `tipo` INT NULL COMMENT '1 - Termo de Adesão, 2 - Compra Direta, 3 - Aditivo',
  `numerotermo` VARCHAR(50) NULL,
  `dataassinaturatermo` DATE NULL,
  `numeroata` VARCHAR(50) NULL,
  `numeropregao` VARCHAR(50) NULL,
  `numeroprocesso` VARCHAR(50) NULL,
  `validadeata` DATE NULL,
  `numerocompra` VARCHAR(50) NULL,
  `numeroparecerjuridico` VARCHAR(50) NULL,
  `datacompra` DATE NULL,
  `valorcompra` DECIMAL(10,2) NULL,
  `numeroaditivo` VARCHAR(50) NULL,
  `validadeaditivo` DATE NULL,
  `valoraditivo` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idcontrato`),
  INDEX `fk_contrato_orgao1_idx` (`idorgao` ASC),
  CONSTRAINT `fk_contrato_orgao1`
    FOREIGN KEY (`idorgao`)
    REFERENCES `orgao` (`idorgao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itens_contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itens_contrato` (
  `iditens_contrato` INT NOT NULL AUTO_INCREMENT,
  `idcontrato` INT NOT NULL,
  `idproduto` INT NOT NULL,
  `idfornecedor` INT NOT NULL,
  `qtd` INT NULL,
  `valorunitario` DECIMAL(10,2) NULL,
  PRIMARY KEY (`iditens_contrato`),
  INDEX `fk_itens_contrato_contrato1_idx` (`idcontrato` ASC),
  INDEX `fk_itens_contrato_produto1_idx` (`idproduto` ASC),
  INDEX `fk_itens_contrato_fornecedor1_idx` (`idfornecedor` ASC),
  CONSTRAINT `fk_itens_contrato_contrato1`
    FOREIGN KEY (`idcontrato`)
    REFERENCES `contrato` (`idcontrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_contrato_produto1`
    FOREIGN KEY (`idproduto`)
    REFERENCES `produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_contrato_fornecedor1`
    FOREIGN KEY (`idfornecedor`)
    REFERENCES `fornecedor` (`idfornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ordem_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ordem_servico` (
  `idordem_servico` INT NOT NULL AUTO_INCREMENT,
  `idcontrato` INT NOT NULL,
  `datasolicitacao` DATE NULL,
  PRIMARY KEY (`idordem_servico`),
  INDEX `fk_ordem_servico_contrato1_idx` (`idcontrato` ASC),
  CONSTRAINT `fk_ordem_servico_contrato1`
    FOREIGN KEY (`idcontrato`)
    REFERENCES `contrato` (`idcontrato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `itens_ordem_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `itens_ordem_servico` (
  `idordem_servico` INT NOT NULL AUTO_INCREMENT,
  `idordem_servico` INT NOT NULL,
  `idfornecedor` INT NOT NULL,
  `idproduto` INT NOT NULL,
  `qtd` INT NULL,
  `valorunitario` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idordem_servico`),
  INDEX `fk_itens_ordem_servico_ordem_servico1_idx` (`idordem_servico` ASC),
  INDEX `fk_itens_ordem_servico_fornecedor1_idx` (`idfornecedor` ASC),
  INDEX `fk_itens_ordem_servico_produto1_idx` (`idproduto` ASC),
  CONSTRAINT `fk_itens_ordem_servico_ordem_servico1`
    FOREIGN KEY (`idordem_servico`)
    REFERENCES `ordem_servico` (`idordem_servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_ordem_servico_fornecedor1`
    FOREIGN KEY (`idfornecedor`)
    REFERENCES `fornecedor` (`idfornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_ordem_servico_produto1`
    FOREIGN KEY (`idproduto`)
    REFERENCES `produto` (`idproduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
