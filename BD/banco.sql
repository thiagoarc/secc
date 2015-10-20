# ************************************************************
# Sequel Pro SQL dump
# Vers�o 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.38)
# Base de Dados: secc
# Tempo de Gera��o: 2015-10-20 14:11:35 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump da tabela aditivo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `aditivo`;

CREATE TABLE `aditivo` (
  `idaditivo` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `validade` date DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `obs` text,
  PRIMARY KEY (`idaditivo`),
  KEY `fk_aditivo_compra1_idx` (`idcontrato`),
  CONSTRAINT `fk_aditivo_contrato` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `aditivo` WRITE;
/*!40000 ALTER TABLE `aditivo` DISABLE KEYS */;

INSERT INTO `aditivo` (`idaditivo`, `idcontrato`, `numero`, `validade`, `valor`, `obs`)
VALUES
	(1,9,'1332444','2015-09-20',10000.00,'teste 2'),
	(5,9,'2323','2015-09-09',10000.00,NULL),
	(6,7,'9988726','2015-09-09',12500.00,'Teste observação.'),
	(7,7,'11225533','2015-09-00',5500.00,'oi'),
	(8,10,'12344556','2016-09-09',121313.12,'Fase 2');

/*!40000 ALTER TABLE `aditivo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela cidade
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

LOCK TABLES `cidade` WRITE;
/*!40000 ALTER TABLE `cidade` DISABLE KEYS */;

INSERT INTO `cidade` (`idcidade`, `iduf`, `nome`)
VALUES
	(1,1,'Rio Branco');

/*!40000 ALTER TABLE `cidade` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela contrato
# ------------------------------------------------------------

DROP TABLE IF EXISTS `contrato`;

CREATE TABLE `contrato` (
  `idcontrato` int(11) NOT NULL AUTO_INCREMENT,
  `idorgao` int(11) DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL COMMENT '1 - Termo de Adesão, 2 - Compra Direta, 3 - Aditivo',
  `tipoobjetos` int(11) DEFAULT NULL,
  `numerotali` varchar(50) DEFAULT NULL,
  `dataassinaturatali` date DEFAULT NULL,
  `numeroata` varchar(50) DEFAULT NULL,
  `numeropregao` varchar(50) DEFAULT NULL,
  `numeroprocesso` varchar(50) DEFAULT NULL,
  `validadeata` date DEFAULT NULL,
  `numerocd` varchar(50) DEFAULT NULL,
  `numeroparecerjuridico` varchar(50) DEFAULT NULL,
  `datacompra` date DEFAULT NULL,
  `numerocontrato` varchar(50) DEFAULT NULL,
  `objeto` varchar(255) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `validade` date DEFAULT NULL,
  `dataassinatura` date DEFAULT NULL,
  `numeroempenho` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcontrato`),
  KEY `fk_contrato_orgao1_idx` (`idorgao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `contrato` WRITE;
/*!40000 ALTER TABLE `contrato` DISABLE KEYS */;

INSERT INTO `contrato` (`idcontrato`, `idorgao`, `tipo`, `tipoobjetos`, `numerotali`, `dataassinaturatali`, `numeroata`, `numeropregao`, `numeroprocesso`, `validadeata`, `numerocd`, `numeroparecerjuridico`, `datacompra`, `numerocontrato`, `objeto`, `valor`, `validade`, `dataassinatura`, `numeroempenho`)
VALUES
	(7,1,1,2,'45345','2015-09-29','98989','878787','09880','2015-09-29',NULL,NULL,'0000-00-00','5552243','obj',1200.00,'2015-10-29','2015-09-29','234234'),
	(9,NULL,3,1,NULL,'0000-00-00',NULL,NULL,NULL,'0000-00-00','111111','12345','2015-09-20','111111','obj',100000.98,'2015-09-20','2015-09-20','23234'),
	(10,1,1,1,'123456','2015-09-09','4321','PRP 123','321','2016-09-09',NULL,NULL,'0000-00-00','2112','Contratação de material de consumo',123.45,'2016-09-09','2015-09-09','2121');

/*!40000 ALTER TABLE `contrato` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela fornecedor
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

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;

INSERT INTO `fornecedor` (`idfornecedor`, `idcidade`, `razaosocial`, `cnpj`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `telefone`, `celular`, `email`, `responsavel`)
VALUES
	(2,1,'TARC Tecnologia','11444777000161','69900643','Rua Dom Bosco',89,NULL,'Bosque','6832248204','6899487908','thiagoarc@gmail.com','Thiago Chaves'),
	(3,1,'Kambo Tecnologia','12345678910110','69900643','Rua Bartolomeu Bueno',89,NULL,'Bosque','6832248204','6899487908','thiagoarc@gmail.com','Thiago Chaves'),
	(4,1,'Mil Presentes','53534757000121','69900000','Rua do Centro',90,'e','Centro','6832255555','6899009988','milton@gmail.com','Milton Cruz');

/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela fornecedor_contrato
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fornecedor_contrato`;

CREATE TABLE `fornecedor_contrato` (
  `idfornecedor_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `idfornecedor` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL,
  PRIMARY KEY (`idfornecedor_contrato`),
  KEY `fk_fornecedor_has_contrato_contrato1_idx` (`idcontrato`),
  KEY `fk_fornecedor_has_contrato_fornecedor1_idx` (`idfornecedor`),
  CONSTRAINT `fk_fornecedor_has_contrato_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_fornecedor_has_contrato_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `fornecedor_contrato` WRITE;
/*!40000 ALTER TABLE `fornecedor_contrato` DISABLE KEYS */;

INSERT INTO `fornecedor_contrato` (`idfornecedor_contrato`, `idfornecedor`, `idcontrato`)
VALUES
	(1,3,9),
	(2,4,7),
	(3,2,7),
	(4,2,9),
	(5,4,9),
	(8,3,10);

/*!40000 ALTER TABLE `fornecedor_contrato` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela itens_aditivo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `itens_aditivo`;

CREATE TABLE `itens_aditivo` (
  `iditens_aditivo` int(11) NOT NULL AUTO_INCREMENT,
  `idaditivo` int(11) NOT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT '0',
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idfornecedor` int(11) NOT NULL,
  `qtdordem` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iditens_aditivo`),
  KEY `fk_itens_aditivo_aditivo1_idx` (`idaditivo`),
  KEY `fk_itens_aditivo_unidade_medida1_idx` (`idunidade_medida`),
  CONSTRAINT `fk_itens_aditivo_aditivo1` FOREIGN KEY (`idaditivo`) REFERENCES `aditivo` (`idaditivo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_aditivo_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `itens_aditivo` WRITE;
/*!40000 ALTER TABLE `itens_aditivo` DISABLE KEYS */;

INSERT INTO `itens_aditivo` (`iditens_aditivo`, `idaditivo`, `idunidade_medida`, `descricao`, `qtd`, `valorunitario`, `idfornecedor`, `qtdordem`)
VALUES
	(6,5,1,'Pendrive de 256gb',10,1000.00,3,0),
	(8,1,1,'Pendrive de 256gb',20,1000.00,3,0),
	(9,8,1,'Borracha de Silicone',25,2.50,3,0),
	(10,8,1,'Apontador Faber Castel Preto',25,1.00,3,0),
	(11,8,1,'Mouse sem fio - Microsoft',1,25.00,3,0);

/*!40000 ALTER TABLE `itens_aditivo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela itens_contrato
# ------------------------------------------------------------

DROP TABLE IF EXISTS `itens_contrato`;

CREATE TABLE `itens_contrato` (
  `iditens_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT '0',
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `qtdordem` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iditens_contrato`),
  KEY `fk_itens_contrato_contrato1_idx` (`idcontrato`),
  KEY `fk_itens_contrato_unidade_medida1_idx` (`idunidade_medida`),
  KEY `idfornecedor` (`idfornecedor`),
  CONSTRAINT `fk_itens_contrato_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_contrato_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `itens_contrato_ibfk_1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `itens_contrato` WRITE;
/*!40000 ALTER TABLE `itens_contrato` DISABLE KEYS */;

INSERT INTO `itens_contrato` (`iditens_contrato`, `idcontrato`, `descricao`, `qtd`, `valorunitario`, `idunidade_medida`, `idfornecedor`, `qtdordem`)
VALUES
	(1,9,'Pendrive de 256gb',20,1000.00,1,3,0),
	(2,10,'Borracha de Silicone',25,2.50,1,3,0),
	(9,10,'Apontador Faber Castel Preto',25,1.00,1,3,0),
	(10,10,'Mouse sem fio - Microsoft',1,25.00,1,3,0);

/*!40000 ALTER TABLE `itens_contrato` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela itens_ordem_servico
# ------------------------------------------------------------

DROP TABLE IF EXISTS `itens_ordem_servico`;

CREATE TABLE `itens_ordem_servico` (
  `iditens_ordem_servico` int(11) NOT NULL AUTO_INCREMENT,
  `idordem_servico` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `iditem_contratoaditivo` int(11) NOT NULL,
  PRIMARY KEY (`iditens_ordem_servico`),
  KEY `fk_itens_ordem_servico_ordem_servico1_idx` (`idordem_servico`),
  KEY `fk_itens_ordem_servico_unidade_medida1_idx` (`idunidade_medida`),
  CONSTRAINT `fk_itens_ordem_servico_ordem_servico1` FOREIGN KEY (`idordem_servico`) REFERENCES `ordem_servico` (`idordem_servico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_ordem_servico_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump da tabela ordem_servico
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ordem_servico`;

CREATE TABLE `ordem_servico` (
  `idordem_servico` int(11) NOT NULL AUTO_INCREMENT,
  `datasolicitacao` date DEFAULT NULL,
  `idcontratoaditivo` int(11) DEFAULT NULL,
  `tipo` int(10) DEFAULT NULL,
  PRIMARY KEY (`idordem_servico`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump da tabela orgao
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


# Dump da tabela produto
# ------------------------------------------------------------

DROP TABLE IF EXISTS `produto`;

CREATE TABLE `produto` (
  `idproduto` int(11) NOT NULL AUTO_INCREMENT,
  `idfornecedor` int(11) NOT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `descricao` varchar(250) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `qtdminima` int(11) DEFAULT '0',
  `qtdatual` int(11) DEFAULT '0',
  `datacadastro` datetime DEFAULT NULL,
  `dataatualizacao` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idproduto`),
  KEY `fk_produto_fornecedor1_idx` (`idfornecedor`),
  KEY `fk_produto_unidade_medida1_idx` (`idunidade_medida`),
  CONSTRAINT `fk_produto_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;

INSERT INTO `produto` (`idproduto`, `idfornecedor`, `idunidade_medida`, `descricao`, `valorunitario`, `qtdminima`, `qtdatual`, `datacadastro`, `dataatualizacao`, `idusuario`)
VALUES
	(1,2,1,'Caneta BIC',10.00,1,31,'2015-09-21 00:00:00','2015-10-15 09:38:06',1),
	(4,2,2,'Borracha BIC',15.00,3,30,'2015-09-21 00:00:00','2015-09-21 16:36:49',1),
	(5,2,2,'Apontador BIC',25.00,5,16,'2015-09-21 00:00:00','2015-09-21 00:00:00',1);

/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela saida
# ------------------------------------------------------------

DROP TABLE IF EXISTS `saida`;

CREATE TABLE `saida` (
  `idsaida` int(11) NOT NULL AUTO_INCREMENT,
  `datasaida` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idsaida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `saida` WRITE;
/*!40000 ALTER TABLE `saida` DISABLE KEYS */;

INSERT INTO `saida` (`idsaida`, `datasaida`, `idusuario`)
VALUES
	(2,'2015-10-08 10:42:24',1),
	(3,'2015-10-08 11:23:12',1),
	(4,'2015-10-15 09:38:45',1);

/*!40000 ALTER TABLE `saida` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela saida_produto
# ------------------------------------------------------------

DROP TABLE IF EXISTS `saida_produto`;

CREATE TABLE `saida_produto` (
  `idsaida_produto` int(11) NOT NULL AUTO_INCREMENT,
  `saida_idsaida` int(11) NOT NULL,
  `produto_idproduto` int(11) NOT NULL,
  `qtd` int(11) NOT NULL,
  PRIMARY KEY (`idsaida_produto`),
  KEY `fk_saida_has_produto_produto1_idx` (`produto_idproduto`),
  KEY `fk_saida_has_produto_saida1_idx` (`saida_idsaida`),
  CONSTRAINT `fk_saida_has_produto_produto1` FOREIGN KEY (`produto_idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_saida_has_produto_saida1` FOREIGN KEY (`saida_idsaida`) REFERENCES `saida` (`idsaida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `saida_produto` WRITE;
/*!40000 ALTER TABLE `saida_produto` DISABLE KEYS */;

INSERT INTO `saida_produto` (`idsaida_produto`, `saida_idsaida`, `produto_idproduto`, `qtd`)
VALUES
	(1,2,1,5),
	(2,3,4,10),
	(3,4,1,10);

/*!40000 ALTER TABLE `saida_produto` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela setor
# ------------------------------------------------------------

DROP TABLE IF EXISTS `setor`;

CREATE TABLE `setor` (
  `idsetor` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `sigla` varchar(20) NOT NULL,
  PRIMARY KEY (`idsetor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `setor` WRITE;
/*!40000 ALTER TABLE `setor` DISABLE KEYS */;

INSERT INTO `setor` (`idsetor`, `nome`, `sigla`)
VALUES
	(1,'Desenvolvimento de Sistemas','DSIS');

/*!40000 ALTER TABLE `setor` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela solicitacao
# ------------------------------------------------------------

DROP TABLE IF EXISTS `solicitacao`;

CREATE TABLE `solicitacao` (
  `idsolicitacao` int(11) NOT NULL AUTO_INCREMENT,
  `datasolicitacao` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0 - Aguardando; 1 - Finalizada; 2 - Cancelada;',
  `motivo` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idsolicitacao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `solicitacao` WRITE;
/*!40000 ALTER TABLE `solicitacao` DISABLE KEYS */;

INSERT INTO `solicitacao` (`idsolicitacao`, `datasolicitacao`, `idusuario`, `status`, `motivo`)
VALUES
	(1,'2015-09-21 00:00:00',1,0,NULL),
	(2,'2015-09-24 00:00:00',1,2,''),
	(5,'2015-09-22 11:36:55',1,1,'Acabou o Estoque.'),
	(6,'2015-09-29 10:57:53',1,1,NULL);

/*!40000 ALTER TABLE `solicitacao` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela solicitacao_produto
# ------------------------------------------------------------

DROP TABLE IF EXISTS `solicitacao_produto`;

CREATE TABLE `solicitacao_produto` (
  `idsolicitacao_produto` int(11) NOT NULL AUTO_INCREMENT,
  `idsolicitacao` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `qtd` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 - aguardando; 1 - deferido; 2 - indeferido;',
  `motivo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idsolicitacao_produto`),
  KEY `fk_solicitacao_has_produto_produto1_idx` (`idproduto`),
  KEY `fk_solicitacao_has_produto_solicitacao1_idx` (`idsolicitacao`),
  CONSTRAINT `fk_solicitacao_has_produto_produto1` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitacao_has_produto_solicitacao1` FOREIGN KEY (`idsolicitacao`) REFERENCES `solicitacao` (`idsolicitacao`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `solicitacao_produto` WRITE;
/*!40000 ALTER TABLE `solicitacao_produto` DISABLE KEYS */;

INSERT INTO `solicitacao_produto` (`idsolicitacao_produto`, `idsolicitacao`, `idproduto`, `qtd`, `status`, `motivo`)
VALUES
	(8,5,5,2,1,NULL),
	(10,5,4,10,1,NULL),
	(11,5,1,4,1,NULL),
	(12,2,1,5,0,NULL),
	(13,2,5,5,0,NULL),
	(14,6,1,20,1,'sfdgsdfgsdf'),
	(15,6,4,20,2,'O material já foi bloqueado.'),
	(16,6,5,10,1,NULL),
	(17,1,1,10,0,NULL);

/*!40000 ALTER TABLE `solicitacao_produto` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela uf
# ------------------------------------------------------------

DROP TABLE IF EXISTS `uf`;

CREATE TABLE `uf` (
  `iduf` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iduf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `uf` WRITE;
/*!40000 ALTER TABLE `uf` DISABLE KEYS */;

INSERT INTO `uf` (`iduf`, `nome`)
VALUES
	(1,'ACRE');

/*!40000 ALTER TABLE `uf` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela unidade_medida
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
	(1,'UN','Unidade'),
	(2,'KG','Quilograma'),
	(3,'M','Metro'),
	(4,'CM','Centimetro');

/*!40000 ALTER TABLE `unidade_medida` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela usuario
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `idusuario` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varchar(60) DEFAULT NULL,
  `perfil` int(11) DEFAULT NULL,
  `liberado` int(11) DEFAULT '1',
  `idsetor` int(11) NOT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;

INSERT INTO `usuario` (`idusuario`, `nome`, `email`, `senha`, `perfil`, `liberado`, `idsetor`)
VALUES
	(1,'Jaisson Santos','jaissonssantos@gmail.com','ab5f505601d22946514ef4de8a45345574e7414b',1,1,1),
	(2,'Gestor de Contrato','gestor@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',3,1,1),
	(3,'Thiago Chaves','thiagoarc@gmail.com','7c4a8d09ca3762af61e59520943dc26494f8941b',1,1,1),
	(4,'Richard Oliveira','richardzero@gmail.com','7c4a8d09ca3762af61e59520943dc26494f8941b',1,1,1);

/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;


# Dump da tabela usuario_permissao
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
	(47,'/contrato',2),
	(48,'/contrato/add',2),
	(49,'/contrato/edit',2),
	(53,'/app',3),
	(54,'/404',3),
	(55,'/contrato/fornecedor',3),
	(57,'/contrato/aditivos',2),
	(58,'/contrato/aditivos',3),
	(60,'/contrato/aditivos/add',2),
	(61,'/contrato/aditivos/add',3),
	(63,'/contrato/aditivos/edit',2),
	(64,'/contrato/aditivos/edit',3),
	(65,'/app',4),
	(66,'/usuario',4),
	(67,'/usuario/add',4),
	(68,'/usuario/edit',4),
	(69,'/unidademedida',4),
	(70,'/unidademedida/add',4),
	(71,'/unidademedida/edit',4),
	(72,'/fornecedor',4),
	(73,'/fornecedor/add',4),
	(74,'/fornecedor/edit',4),
	(75,'/produto',4),
	(76,'/produto/add',4),
	(77,'/produto/edit',4),
	(78,'/contrato',4),
	(79,'/contrato/add',4),
	(80,'/contrato/edit',4),
	(81,'/compras',4),
	(82,'/estoque',4),
	(83,'/relatorio',4),
	(85,'/solicitacaouser',2),
	(86,'/solicitacaouser',3),
	(87,'/solicitacaouser',4),
	(89,'/solicitacaouser/add',2),
	(90,'/solicitacaouser/add',3),
	(91,'/solicitacaouser/add',4),
	(93,'/solicitacaouser/edit',2),
	(94,'/solicitacaouser/edit',3),
	(95,'/solicitacaouser/edit',4),
	(97,'/solicitacao',2),
	(98,'/solicitacao',3),
	(99,'/solicitacao',4),
	(101,'/solicitacao/detalhes',2),
	(102,'/solicitacao/detalhes',3),
	(103,'/solicitacao/detalhes',4),
	(105,'/saida/add',2),
	(106,'/saida/add',3),
	(107,'/saida/add',4),
	(109,'/saida',2),
	(110,'/saida',3),
	(111,'/saida',4),
	(113,'/saida/detalhes',2),
	(114,'/saida/detalhes',3),
	(115,'/saida/detalhes',4),
	(116,'/app',NULL),
	(117,'/usuario',NULL),
	(118,'/usuario/add',NULL),
	(119,'/usuario/edit',NULL),
	(120,'/unidademedida',NULL),
	(121,'/unidademedida/add',NULL),
	(122,'/unidademedida/edit',NULL),
	(123,'/fornecedor',NULL),
	(124,'/fornecedor/add',NULL),
	(125,'/fornecedor/edit',NULL),
	(126,'/produto',NULL),
	(127,'/produto/add',NULL),
	(128,'/produto/edit',NULL),
	(129,'/contrato',NULL),
	(130,'/contrato/add',NULL),
	(131,'/contrato/edit',NULL),
	(132,'/compras',NULL),
	(133,'/estoque',NULL),
	(134,'/relatorio',NULL),
	(192,'/app',1),
	(193,'/usuario',1),
	(194,'/usuario/add',1),
	(195,'/usuario/edit',1),
	(196,'/unidademedida',1),
	(197,'/unidademedida/add',1),
	(198,'/unidademedida/edit',1),
	(199,'/fornecedor',1),
	(200,'/fornecedor/add',1),
	(201,'/fornecedor/edit',1),
	(202,'/produto',1),
	(203,'/produto/add',1),
	(204,'/produto/edit',1),
	(205,'/contrato',1),
	(206,'/contrato/add',1),
	(207,'/contrato/edit',1),
	(208,'/ordemservico',1),
	(209,'/estoque',1),
	(210,'/relatorio',1);

/*!40000 ALTER TABLE `usuario_permissao` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
