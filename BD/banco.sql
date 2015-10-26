# ************************************************************
# Sequel Pro SQL dump
# Vers�o 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.38)
# Base de Dados: secc
# Tempo de Gera��o: 2015-10-26 19:46:34 +0000
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
  KEY `fk_aditivo_compra1_idx` (`idcontrato`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `aditivo` WRITE;
/*!40000 ALTER TABLE `aditivo` DISABLE KEYS */;

INSERT INTO `aditivo` (`idaditivo`, `idcontrato`, `numero`, `validade`, `valor`, `obs`)
VALUES
	(13,13,'111111','2016-01-30',50000.00,'Teste de observação de Aditivo.'),
	(14,14,'9898-1','2018-10-21',1000.00,'Teste');

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
	(13,NULL,3,1,NULL,'0000-00-00',NULL,NULL,NULL,'0000-00-00','111111','111111','2015-10-20','111111','Teste de Cadastro de Contrato.',100000.00,'2015-12-31','2015-10-22','111111'),
	(14,1,2,1,'010101','2015-10-10','10101','919191','909090','2018-10-10',NULL,NULL,'0000-00-00','989898','12121121121',1212.11,'2018-10-20','2015-10-20','818181');

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
	(4,1,'Mil Presentes','53534757000121','69900000','Rua do Centro',90,'e','Centro','6832255555','6899009988','milton@gmail.com','Milton Cruz'),
	(5,1,'Móveis Gazin','11111111000000','69900000','Avenida Getúlio Vargas',1476,NULL,'Bosque','6832246565','6899887766','rufino@gmail.com','Rufino Maia'),
	(6,1,'Teste em TI','11111111000000','69900000','Rua teste 1',1,'Casa','Teste','6832232323','6899880101','teste@ti.com.br','Teste');

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
  KEY `fk_fornecedor_has_contrato_fornecedor1_idx` (`idfornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `fornecedor_contrato` WRITE;
/*!40000 ALTER TABLE `fornecedor_contrato` DISABLE KEYS */;

INSERT INTO `fornecedor_contrato` (`idfornecedor_contrato`, `idfornecedor`, `idcontrato`)
VALUES
	(2,2,13),
	(4,5,14);

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
	(3,13,1,'Mouse sem fio - Microsoft',15,500.00,2,15),
	(5,13,1,'Monitor de 25 Polegadas - Multilaser',5,1500.00,2,5),
	(6,13,1,'Nobreak 1500VA - Multilaser',10,550.00,2,10),
	(7,13,1,'Carregador de Pihas - Multilaser',5,55.00,2,5),
	(8,13,5,'Cado de Rede CAT6 - Mondial',150,1.50,2,150),
	(9,13,1,'Crimpador de Cado de Rede',1,150.00,2,1),
	(10,14,5,'hdhdf',6,12.11,5,6),
	(12,14,5,'teste',8,100.00,5,8);

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
	(1,13,'Memória RAM - 8GB - 1600 - Kingstom',15,500.00,1,2,13),
	(2,13,'HD 1TR - Samsung',15,1500.00,1,2,14),
	(3,13,'Mouse sem fio - Microsoft',10,1000.00,1,2,7),
	(4,13,'Teclado Sem Fio - Multilaser',15,1000.00,1,2,11),
	(5,14,'hdhdf',6,1.21,5,5,3),
	(6,14,'Teste',5,120.00,5,5,3),
	(7,14,'teste',5,8.00,5,5,3);

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

LOCK TABLES `itens_ordem_servico` WRITE;
/*!40000 ALTER TABLE `itens_ordem_servico` DISABLE KEYS */;

INSERT INTO `itens_ordem_servico` (`iditens_ordem_servico`, `idordem_servico`, `descricao`, `qtd`, `valorunitario`, `idunidade_medida`, `iditem_contratoaditivo`)
VALUES
	(1,4,'HD 1TR - Samsung',1,1500.00,1,2),
	(2,4,'Memória RAM - 8GB - 1600 - Kingstom',2,500.00,1,1),
	(3,4,'Mouse sem fio - Microsoft',3,1000.00,1,3),
	(4,4,'Teclado Sem Fio - Multilaser',4,1000.00,1,4),
	(5,5,'hdhdf',1,1.21,5,5),
	(6,5,'teste',1,8.00,5,7),
	(7,5,'Teste',1,120.00,5,6),
	(8,7,'hdhdf',1,1.21,5,5),
	(9,7,'teste',1,8.00,5,7),
	(10,7,'Teste',1,120.00,5,6),
	(11,8,'hdhdf',3,1.21,5,5),
	(12,8,'teste',2,8.00,5,7),
	(13,8,'Teste',2,120.00,5,6),
	(14,9,'HD 1TR - Samsung',1,1500.00,1,2),
	(15,9,'Memória RAM - 8GB - 1600 - Kingstom',2,500.00,1,1),
	(16,9,'Mouse sem fio - Microsoft',3,1000.00,1,3),
	(17,9,'Teclado Sem Fio - Multilaser',4,1000.00,1,4);

/*!40000 ALTER TABLE `itens_ordem_servico` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `ordem_servico` WRITE;
/*!40000 ALTER TABLE `ordem_servico` DISABLE KEYS */;

INSERT INTO `ordem_servico` (`idordem_servico`, `datasolicitacao`, `idcontratoaditivo`, `tipo`)
VALUES
	(4,'2015-10-26',13,1),
	(5,'2015-10-26',14,1),
	(7,'2015-10-26',14,1),
	(8,'2015-10-26',14,1),
	(9,'2015-10-26',13,1);

/*!40000 ALTER TABLE `ordem_servico` ENABLE KEYS */;
UNLOCK TABLES;


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
	(1,2,1,'HD 1TR - Samsung',1500.00,0,0,NULL,NULL,NULL),
	(2,2,1,'Memória RAM - 8GB - 1600 - Kingstom',500.00,0,0,NULL,NULL,NULL),
	(3,2,1,'Mouse sem fio - Microsoft',1000.00,0,0,NULL,NULL,NULL),
	(4,2,1,'Teclado Sem Fio - Multilaser',1000.00,0,0,NULL,NULL,NULL),
	(5,5,5,'hdhdf',1.21,0,0,NULL,NULL,NULL),
	(6,5,5,'teste',8.00,0,0,NULL,NULL,NULL),
	(7,5,5,'Teste',120.00,0,0,NULL,NULL,NULL);

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
	(4,'CM','Centimetro'),
	(5,'M','Metro'),
	(6,'CX','Caixa');

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
	(1,'Jaisson Santos','jaissonssantos@gmail.com','ab5f505601d22946514ef4de8a45345574e7414b',5,1,1),
	(2,'Gestor de Contrato','gestor@ac.gov.br','7c4a8d09ca3762af61e59520943dc26494f8941b',2,1,1),
	(3,'Thiago Chaves','thiagoarc@gmail.com','7c4a8d09ca3762af61e59520943dc26494f8941b',1,1,1),
	(4,'Richard Oliveira','richardzero@gmail.com','7c4a8d09ca3762af61e59520943dc26494f8941b',1,1,1),
	(5,'Teste','teste@ti.com.br','682fe8b745dd5442773ba0e687bfa256af1cabe0',5,0,0),
	(6,'Teste','teste@ac.gov.br','1d4ed28ea7990c050c7189cf25aefd66f06ed1fb',5,0,0);

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
	(53,'/app',3),
	(54,'/404',3),
	(55,'/contrato/fornecedor',3),
	(58,'/contrato/aditivos',3),
	(61,'/contrato/aditivos/add',3),
	(64,'/contrato/aditivos/edit',3),
	(86,'/solicitacaouser',3),
	(90,'/solicitacaouser/add',3),
	(94,'/solicitacaouser/edit',3),
	(98,'/solicitacao',3),
	(102,'/solicitacao/detalhes',3),
	(106,'/saida/add',3),
	(110,'/saida',3),
	(114,'/saida/detalhes',3),
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
	(300,'/app',4),
	(301,'/usuario',4),
	(302,'/usuario/add',4),
	(303,'/usuario/edit',4),
	(304,'/unidademedida',4),
	(305,'/unidademedida/add',4),
	(306,'/unidademedida/edit',4),
	(307,'/fornecedor',4),
	(308,'/fornecedor/add',4),
	(309,'/fornecedor/edit',4),
	(310,'/produto',4),
	(311,'/produto/add',4),
	(312,'/produto/edit',4),
	(313,'/contrato',4),
	(314,'/contrato/add',4),
	(315,'/contrato/edit',4),
	(316,'/ordemservico',4),
	(317,'/estoque',4),
	(318,'/relatorio',4),
	(319,'/app',5),
	(320,'/usuario',5),
	(321,'/usuario/add',5),
	(322,'/usuario/edit',5),
	(323,'/unidademedida',5),
	(324,'/unidademedida/add',5),
	(325,'/unidademedida/edit',5),
	(326,'/fornecedor',5),
	(327,'/fornecedor/add',5),
	(328,'/fornecedor/edit',5),
	(329,'/produto',5),
	(330,'/produto/add',5),
	(331,'/produto/edit',5),
	(332,'/contrato',5),
	(333,'/contrato/add',5),
	(334,'/contrato/edit',5),
	(335,'/relatorio',5),
	(336,'/app',6),
	(337,'/usuario',6),
	(338,'/usuario/add',6),
	(339,'/usuario/edit',6),
	(340,'/unidademedida',6),
	(341,'/unidademedida/add',6),
	(342,'/unidademedida/edit',6),
	(343,'/fornecedor',6),
	(344,'/fornecedor/add',6),
	(345,'/fornecedor/edit',6),
	(346,'/produto',6),
	(347,'/produto/add',6),
	(348,'/produto/edit',6),
	(349,'/contrato',6),
	(350,'/contrato/add',6),
	(351,'/contrato/edit',6),
	(352,'/relatorio',6),
	(370,'/app',2),
	(371,'/usuario',2),
	(372,'/usuario/add',2),
	(373,'/usuario/edit',2),
	(374,'/unidademedida',2),
	(375,'/unidademedida/add',2),
	(376,'/unidademedida/edit',2),
	(377,'/fornecedor',2),
	(378,'/fornecedor/add',2),
	(379,'/fornecedor/edit',2),
	(380,'/produto',2),
	(381,'/produto/add',2),
	(382,'/produto/edit',2),
	(383,'/contrato',2),
	(384,'/contrato/add',2),
	(385,'/contrato/edit',2),
	(386,'/relatorio',2),
	(461,'/app',1),
	(462,'/ordemservico',1),
	(463,'/ordemservico/add',1),
	(464,'/relatorio',1),
	(465,'/entrada',1),
	(466,'/solicitacao',1),
	(467,'/solicitacao/detalhes',1),
	(468,'/saida',1),
	(469,'/saida/add',1),
	(470,'/saida/detalhes',1),
	(471,'/solicitacaouser',1),
	(472,'/solicitacaouser/add',1),
	(473,'/solicitacaouser/edit',1),
	(474,'/solicitacaouser/detalhes',1),
	(475,'/relatorio',1);

/*!40000 ALTER TABLE `usuario_permissao` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
