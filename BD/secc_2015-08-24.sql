# ************************************************************
# Sequel Pro SQL dump
# Version 4135
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.38)
# Database: secc
# Generation Time: 2015-08-24 14:27:36 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cidade
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cidade`;

CREATE TABLE `cidade` (
  `idcidade` int(11) NOT NULL AUTO_INCREMENT,
  `iduf` int(11) NOT NULL,
  `nome` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idcidade`),
  KEY `fk_cidade_uf_idx` (`iduf`),
  CONSTRAINT `fk_cidade_uf` FOREIGN KEY (`iduf`) REFERENCES `uf` (`iduf`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table compra
# ------------------------------------------------------------

DROP TABLE IF EXISTS `compra`;

CREATE TABLE `compra` (
  `idcompra` int(11) NOT NULL AUTO_INCREMENT,
  `idorgao` int(11) NOT NULL,
  `tipo` int(11) DEFAULT NULL COMMENT '1 - Termo de Adesão, 2 - Compra Direta, 3 - Aditivo',
  `numerotali` varchar(50) DEFAULT NULL,
  `dataassinaturatali` date DEFAULT NULL,
  `numeroata` varchar(50) DEFAULT NULL,
  `numeropregao` varchar(50) DEFAULT NULL,
  `numeroprocesso` varchar(50) DEFAULT NULL,
  `validadeata` date DEFAULT NULL,
  `tipocompra` int(11) DEFAULT NULL,
  `numerocdem` varchar(50) DEFAULT NULL,
  `numeroparecerjuridico` varchar(50) DEFAULT NULL,
  `datacompra` date DEFAULT NULL,
  `numerocontratoempenho` varchar(50) DEFAULT NULL,
  `objeto` varchar(255) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `validade` date DEFAULT NULL,
  `dataassinatura` date DEFAULT NULL,
  `numeroaditivo` varchar(50) DEFAULT NULL,
  `validadeaditivo` date DEFAULT NULL,
  `valoraditivo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idcompra`),
  KEY `fk_contrato_orgao1_idx` (`idorgao`),
  CONSTRAINT `fk_contrato_orgao1` FOREIGN KEY (`idorgao`) REFERENCES `orgao` (`idorgao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table fornecedor
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fornecedor`;

CREATE TABLE `fornecedor` (
  `idfornecedor` int(11) NOT NULL AUTO_INCREMENT,
  `idcidade` int(11) NOT NULL,
  `razaosocial` varchar(150) DEFAULT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `logradouro` varchar(150) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `complemento` varchar(60) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `responsavel` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idfornecedor`),
  KEY `fk_fornecedor_cidade1_idx` (`idcidade`),
  CONSTRAINT `fk_fornecedor_cidade1` FOREIGN KEY (`idcidade`) REFERENCES `cidade` (`idcidade`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table itens_contrato
# ------------------------------------------------------------

DROP TABLE IF EXISTS `itens_contrato`;

CREATE TABLE `itens_contrato` (
  `iditens_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `idcompra` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`iditens_contrato`),
  KEY `fk_itens_contrato_contrato1_idx` (`idcompra`),
  KEY `fk_itens_contrato_produto1_idx` (`idproduto`),
  KEY `fk_itens_contrato_fornecedor1_idx` (`idfornecedor`),
  CONSTRAINT `fk_itens_contrato_contrato1` FOREIGN KEY (`idcompra`) REFERENCES `compra` (`idcompra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_contrato_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_contrato_produto1` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table itens_ordem_servico
# ------------------------------------------------------------

DROP TABLE IF EXISTS `itens_ordem_servico`;

CREATE TABLE `itens_ordem_servico` (
  `iditens_ordem_servico` int(11) NOT NULL AUTO_INCREMENT,
  `idordem_servico` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`iditens_ordem_servico`),
  KEY `fk_itens_ordem_servico_ordem_servico1_idx` (`idordem_servico`),
  KEY `fk_itens_ordem_servico_fornecedor1_idx` (`idfornecedor`),
  KEY `fk_itens_ordem_servico_produto1_idx` (`idproduto`),
  CONSTRAINT `fk_itens_ordem_servico_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_ordem_servico_ordem_servico1` FOREIGN KEY (`idordem_servico`) REFERENCES `ordem_servico` (`idordem_servico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_ordem_servico_produto1` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ordem_servico
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ordem_servico`;

CREATE TABLE `ordem_servico` (
  `idordem_servico` int(11) NOT NULL AUTO_INCREMENT,
  `idcompra` int(11) NOT NULL,
  `datasolicitacao` date DEFAULT NULL,
  PRIMARY KEY (`idordem_servico`),
  KEY `fk_ordem_servico_contrato1_idx` (`idcompra`),
  CONSTRAINT `fk_ordem_servico_contrato1` FOREIGN KEY (`idcompra`) REFERENCES `compra` (`idcompra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table orgao
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orgao`;

CREATE TABLE `orgao` (
  `idorgao` int(11) NOT NULL AUTO_INCREMENT,
  `sigla` varchar(20) DEFAULT NULL,
  `nome` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idorgao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `orgao` WRITE;
/*!40000 ALTER TABLE `orgao` DISABLE KEYS */;

INSERT INTO `orgao` (`idorgao`, `sigla`, `nome`)
VALUES
	(1,'SAI','Secretaria de Articulação Institucional');

/*!40000 ALTER TABLE `orgao` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table produto
# ------------------------------------------------------------

DROP TABLE IF EXISTS `produto`;

CREATE TABLE `produto` (
  `idproduto` int(11) NOT NULL AUTO_INCREMENT,
  `idunidade_medida` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idproduto`),
  KEY `fk_produto_unidade_medida1_idx` (`idunidade_medida`),
  CONSTRAINT `fk_produto_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;

INSERT INTO `produto` (`idproduto`, `idunidade_medida`, `nome`, `descricao`, `marca`)
VALUES
	(1,2,'iPhone 6','Celular','Apple'),
	(2,2,'Honda City','Carro 1.5','Honda');

/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table uf
# ------------------------------------------------------------

DROP TABLE IF EXISTS `uf`;

CREATE TABLE `uf` (
  `iduf` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iduf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table unidade_medida
# ------------------------------------------------------------

DROP TABLE IF EXISTS `unidade_medida`;

CREATE TABLE `unidade_medida` (
  `idunidade_medida` int(11) NOT NULL AUTO_INCREMENT,
  `sigla` varchar(20) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idunidade_medida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `unidade_medida` WRITE;
/*!40000 ALTER TABLE `unidade_medida` DISABLE KEYS */;

INSERT INTO `unidade_medida` (`idunidade_medida`, `sigla`, `descricao`)
VALUES
	(1,'Kilo','KL'),
	(2,'UN','Unidade');

/*!40000 ALTER TABLE `unidade_medida` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table usuario
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `idusuario` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varchar(60) DEFAULT NULL,
  `perfil` int(11) DEFAULT NULL,
  `liberado` int(11) DEFAULT '1',
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;

INSERT INTO `usuario` (`idusuario`, `nome`, `email`, `senha`, `perfil`, `liberado`)
VALUES
	(1,'Jaisson Santos','jaissonssantos@gmail.com','ab5f505601d22946514ef4de8a45345574e7414b',1,1),
	(2,'Gestor de Contrato','gestor@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',5,1),
	(3,'Thiago Chaves','thiagoarc@gmail.com','7c4a8d09ca3762af61e59520943dc26494f8941b',1,1);

/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table usuario_permissao
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usuario_permissao`;

CREATE TABLE `usuario_permissao` (
  `idusuario_permissao` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roles` varchar(40) DEFAULT NULL,
  `idusuario` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`idusuario_permissao`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `usuario_permissao_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `usuario_permissao` WRITE;
/*!40000 ALTER TABLE `usuario_permissao` DISABLE KEYS */;

INSERT INTO `usuario_permissao` (`idusuario_permissao`, `roles`, `idusuario`)
VALUES
	(1,'/usuario',1),
	(2,'/usuario/add',1),
	(3,'/usuario/edit',1),
	(4,'/unidademedida',1),
	(5,'/unidademedida/add',1),
	(6,'/unidademedida/edit',1),
	(7,'/fornecedor',1),
	(8,'/fornecedor/add',1),
	(9,'/fornecedor/edit',1),
	(10,'/produto',1),
	(11,'/produto/add',1),
	(12,'/produto/edit',1),
	(13,'/app',2),
	(14,'/usuario',2),
	(15,'/usuario/add',2),
	(16,'/usuario/edit',2),
	(17,'/unidademedida',2),
	(18,'/unidademedida/add',2),
	(19,'/unidademedida/edit',2),
	(20,'/fornecedor',2),
	(21,'/fornecedor/add',2),
	(22,'/fornecedor/edit',2),
	(23,'/produto',2),
	(24,'/produto/add',2),
	(25,'/produto/edit',2),
	(26,'/relatorio',2),
	(27,'/usuario',3),
	(28,'/usuario/add',3),
	(29,'/usuario/edit',3),
	(30,'/unidademedida',3),
	(31,'/unidademedida/add',3),
	(32,'/unidademedida/edit',3),
	(33,'/fornecedor',3),
	(34,'/fornecedor/add',3),
	(35,'/fornecedor/edit',3),
	(36,'/produto',3),
	(37,'/produto/add',3),
	(38,'/produto/edit',3),
	(39,'/contrato',3),
	(40,'/contrato/add',3),
	(41,'/contrato/edit',3),
	(42,'/app',1),
	(43,'/404',1);

/*!40000 ALTER TABLE `usuario_permissao` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
