# ************************************************************
# Sequel Pro SQL dump
# Version 4135
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.42)
# Database: secc
# Generation Time: 2015-11-11 19:40:32 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table aditivo
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
	(13,13,'222222','2016-01-30',50000.00,'Teste de observação de Aditivo.'),
	(14,14,'898989','2015-10-21',1000.00,'Teste'),
	(15,15,'889988','2015-11-25',10000.00,'Teste');

/*!40000 ALTER TABLE `aditivo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table arquivos_aditivo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `arquivos_aditivo`;

CREATE TABLE `arquivos_aditivo` (
  `idarquivos_aditivo` int(11) NOT NULL AUTO_INCREMENT,
  `idaditivo` int(11) NOT NULL,
  `nome` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `arquivo` varchar(250) NOT NULL,
  PRIMARY KEY (`idarquivos_aditivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `arquivos_aditivo` WRITE;
/*!40000 ALTER TABLE `arquivos_aditivo` DISABLE KEYS */;

INSERT INTO `arquivos_aditivo` (`idarquivos_aditivo`, `idaditivo`, `nome`, `arquivo`)
VALUES
	(2,15,'Captura de Tela 2015-10-29 às 14.14.49.png','ea5838289dc516653a3b30df81e8608c.png'),
	(3,15,'Certidao Negativa.pdf','dbd19a65c0d916816dc4d5149b4fdf76.pdf');

/*!40000 ALTER TABLE `arquivos_aditivo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table arquivos_contrato
# ------------------------------------------------------------

DROP TABLE IF EXISTS `arquivos_contrato`;

CREATE TABLE `arquivos_contrato` (
  `idarquivos_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `nome` varchar(250) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `arquivo` varchar(250) NOT NULL,
  PRIMARY KEY (`idarquivos_contrato`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `arquivos_contrato` WRITE;
/*!40000 ALTER TABLE `arquivos_contrato` DISABLE KEYS */;

INSERT INTO `arquivos_contrato` (`idarquivos_contrato`, `idcontrato`, `nome`, `arquivo`)
VALUES
	(21,16,'Captura de Tela 2015-10-29 às 14.14.49.png','0582bd75dc861eb866781965b2bdd2ae.png'),
	(22,16,'Certidao Negativa.pdf','346bf66f5b0bde5a7269fb6d92e5f234.pdf'),
	(23,16,'NF-e - dominio kambotecnologia.com.br.pdf','b0af7755d5269ad7d8bced5a250b22a2.pdf'),
	(24,16,'formulario_paypal.pdf','a8602b61eee671e27d205dea76c27cc7.pdf'),
	(26,13,'Captura de Tela 2015-10-29 às 14.14.49.png','809be08a11e13847e742937063d28616.png'),
	(27,13,'Certidao Negativa.pdf','298abaa9ac762b8407e688d60da1bd41.pdf'),
	(28,16,'Organograma Estrutural - SAI - 25-08-15.pdf','474decc192e78313c4429b3b7a511069.pdf'),
	(29,16,'TERMO DE RESPONSABILIDADE - SAI.doc','8ac920bf8c74baad67a55af504fc8045.doc'),
	(30,16,'FORMULÁRIO -  CADASTRO DE USUÁRIO SECC.doc','423c4df68706d77f59de84958ae480fa.doc');

/*!40000 ALTER TABLE `arquivos_contrato` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `cidade` WRITE;
/*!40000 ALTER TABLE `cidade` DISABLE KEYS */;

INSERT INTO `cidade` (`idcidade`, `iduf`, `nome`)
VALUES
	(1,1,'Rio Branco'),
	(2,2,'São Paulo');

/*!40000 ALTER TABLE `cidade` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table contrato
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
	(13,NULL,4,4,NULL,'0000-00-00',NULL,NULL,NULL,'0000-00-00','111111','111111','2015-10-20','111111','Teste de Cadastro de Contrato.',100000.00,'2015-12-31','2015-10-22','111111'),
	(14,1,2,1,'010101','2015-10-10','10101','919191','909090','2018-10-10',NULL,NULL,'0000-00-00','989898','12121121121',1212.11,'2015-11-20','2015-10-20','818181'),
	(15,NULL,4,1,NULL,'0000-00-00',NULL,NULL,NULL,'0000-00-00','231234123','234123413412','2015-11-01','78585786','uyuieyqiwrqwer',100000.00,'2015-11-10','2015-11-02',NULL),
	(16,NULL,3,1,NULL,'0000-00-00',NULL,NULL,NULL,'0000-00-00','9999999','9999999','2015-10-10','99999999','Teste',10000.00,'2015-10-10','2015-10-10',NULL),
	(17,1,1,3,'3333','2015-10-20','3333','3333','3333','2015-11-20',NULL,NULL,'0000-00-00','3333','Testando os detalhes.',100000.00,'2015-11-30','2015-11-15',NULL);

/*!40000 ALTER TABLE `contrato` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table empenho_aditivo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `empenho_aditivo`;

CREATE TABLE `empenho_aditivo` (
  `idempenho_aditivo` int(11) NOT NULL AUTO_INCREMENT,
  `idaditivo` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idempenho_aditivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `empenho_aditivo` WRITE;
/*!40000 ALTER TABLE `empenho_aditivo` DISABLE KEYS */;

INSERT INTO `empenho_aditivo` (`idempenho_aditivo`, `idaditivo`, `idfornecedor`, `numero`, `valor`)
VALUES
	(2,13,2,897979,1000.00),
	(3,13,2,8979,1000.00);

/*!40000 ALTER TABLE `empenho_aditivo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table empenho_contrato
# ------------------------------------------------------------

DROP TABLE IF EXISTS `empenho_contrato`;

CREATE TABLE `empenho_contrato` (
  `idempenho_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idempenho_contrato`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `empenho_contrato` WRITE;
/*!40000 ALTER TABLE `empenho_contrato` DISABLE KEYS */;

INSERT INTO `empenho_contrato` (`idempenho_contrato`, `idcontrato`, `idfornecedor`, `numero`, `valor`)
VALUES
	(2,13,2,12321,50000.00),
	(3,13,2,121212,12300.00),
	(4,14,5,7676767,1000.00);

/*!40000 ALTER TABLE `empenho_contrato` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `fornecedor` WRITE;
/*!40000 ALTER TABLE `fornecedor` DISABLE KEYS */;

INSERT INTO `fornecedor` (`idfornecedor`, `idcidade`, `razaosocial`, `cnpj`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `telefone`, `celular`, `email`, `responsavel`)
VALUES
	(2,1,'TARC Tecnologia','11444777000161','69900643','Rua Dom Bosco',89,NULL,'Bosque','6832248204','6899487908','thiagoarc@gmail.com','Thiago Chaves'),
	(3,1,'Kambo Tecnologia','12345678910110','69900643','Rua Bartolomeu Bueno',89,NULL,'Bosque','6832248204','6899487908','thiagoarc@gmail.com','Thiago Chaves'),
	(4,1,'Mil Presentes','53534757000121','69900000','Rua do Centro',90,'e','Centro','6832255555','6899009988','milton@gmail.com','Milton Cruz'),
	(5,1,'Móveis Gazin','11111111000000','69900000','Avenida Getúlio Vargas',1476,NULL,'Bosque','6832246565','6899887766','rufino@gmail.com','Rufino Maia'),
	(6,1,'Teste em TI','11111111000000','69900000','Rua teste 1',1,'Casa','Teste','6832232323','6899880101','teste@ti.com.br','Teste'),
	(7,1,'Teste 1','11111111000000',NULL,NULL,NULL,NULL,'Bosque','6899999999',NULL,NULL,'Teste 1'),
	(8,2,'Marilza Lanches','00000000000000','69900000','Rua do Cinquentinha',89,NULL,'Bosque','6899887788','6899887766','marilza@gmail.com','Marilza de Oliveira');

/*!40000 ALTER TABLE `fornecedor` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fornecedor_contrato
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


# Dump of table itens_aditivo
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
	(3,13,1,'Mouse sem fio - Microsoft',15,500.00,2,16),
	(5,13,1,'Monitor de 25 Polegadas - Multilaser',5,1500.00,2,5),
	(6,13,1,'Nobreak 1500VA - Multilaser',10,550.00,2,10),
	(7,13,1,'Carregador de Pihas - Multilaser',5,55.00,2,5),
	(8,13,5,'Cado de Rede CAT6 - Mondial',150,1.50,2,150),
	(9,13,1,'Crimpador de Cado de Rede',1,150.00,2,2),
	(10,14,5,'hdhdf',6,12.11,5,6),
	(12,14,5,'teste',8,100.00,5,8);

/*!40000 ALTER TABLE `itens_aditivo` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table itens_contrato
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
	(2,13,'HD 1TR - Samsung',15,1500.00,1,2,4),
	(3,13,'Mouse sem fio - Microsoft',10,1000.00,1,2,5),
	(4,13,'Teclado Sem Fio - Multilaser',15,1000.00,1,2,5),
	(5,14,'hdhdf',6,1.21,5,5,1),
	(6,14,'Teste',5,120.00,5,5,1),
	(7,14,'teste',5,8.00,5,5,1),
	(8,13,'Pen Drive 16GB',20,100.00,1,2,4),
	(9,13,'Processador i5',10,1000.00,1,2,4),
	(10,13,'Cabo HDMI',12,50.00,1,2,4);

/*!40000 ALTER TABLE `itens_contrato` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table itens_ordem_servico
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
	(9,5,'HD 1TR - Samsung',1,1500.00,1,2),
	(10,5,'Memória RAM - 8GB - 1600 - Kingstom',1,500.00,1,1),
	(11,5,'Mouse sem fio - Microsoft',1,1000.00,1,3),
	(12,5,'Teclado Sem Fio - Multilaser',1,1000.00,1,4),
	(13,6,'hdhdf',2,1.21,5,5),
	(14,6,'teste',2,8.00,5,7),
	(15,6,'Teste',2,120.00,5,6),
	(16,7,'Cabo HDMI',2,50.00,1,10),
	(17,7,'HD 1TR - Samsung',2,1500.00,1,2),
	(18,7,'Memória RAM - 8GB - 1600 - Kingstom',2,500.00,1,1),
	(19,7,'Mouse sem fio - Microsoft',2,1000.00,1,3),
	(20,7,'Pen Drive 16GB',2,100.00,1,8),
	(21,7,'Processador i5',2,1000.00,1,9),
	(22,7,'Teclado Sem Fio - Multilaser',2,1000.00,1,4),
	(23,8,'Cabo HDMI',1,50.00,1,10),
	(24,8,'HD 1TR - Samsung',1,1500.00,1,2),
	(25,8,'Mouse sem fio - Microsoft',1,1000.00,1,3),
	(26,8,'Pen Drive 16GB',1,100.00,1,8),
	(27,8,'Processador i5',1,1000.00,1,9),
	(28,8,'Teclado Sem Fio - Multilaser',1,1000.00,1,4),
	(29,9,'Cabo HDMI',2,50.00,1,10),
	(30,9,'HD 1TR - Samsung',2,1500.00,1,2),
	(31,9,'Mouse sem fio - Microsoft',2,1000.00,1,3),
	(32,9,'Pen Drive 16GB',2,100.00,1,8),
	(33,9,'Processador i5',2,1000.00,1,9),
	(34,9,'Teclado Sem Fio - Multilaser',2,1000.00,1,4),
	(35,10,'hdhdf',1,1.21,5,5),
	(36,10,'teste',1,8.00,5,7),
	(37,10,'Teste',1,120.00,5,6);

/*!40000 ALTER TABLE `itens_ordem_servico` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ordem_servico
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
	(5,'2015-10-28',13,1),
	(6,'2015-10-29',14,2),
	(7,'2015-10-29',13,1),
	(8,'2015-11-03',13,2),
	(9,'2015-11-06',13,1),
	(10,'2015-11-06',14,1);

/*!40000 ALTER TABLE `ordem_servico` ENABLE KEYS */;
UNLOCK TABLES;


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
	(1,2,1,'HD 1TR - Samsung',1500.00,2,4,NULL,'2015-10-29 12:08:27',1),
	(2,2,1,'Memória RAM - 8GB - 1600 - Kingstom',500.00,10,12,NULL,'2015-10-29 10:28:51',1),
	(3,2,1,'Mouse sem fio - Microsoft',1000.00,3,6,NULL,'2015-11-06 16:16:51',1),
	(4,2,1,'Teclado Sem Fio - Multilaser',1000.00,5,4,NULL,'2015-11-10 15:11:08',1),
	(5,5,5,'hdhdf',1.21,3,2,NULL,'2015-11-10 15:41:31',1),
	(6,5,5,'teste',8.00,5,2,NULL,'2015-11-10 15:41:39',1),
	(7,5,5,'Teste',120.00,4,3,NULL,'2015-11-10 15:41:47',1),
	(8,2,1,'Cabo HDMI',50.00,2,5,NULL,'2015-10-29 12:23:02',1),
	(9,2,1,'Pen Drive 16GB',100.00,3,0,NULL,'2015-11-10 15:10:27',1),
	(10,2,1,'Processador i5',1000.00,2,1,NULL,'2015-11-10 15:40:45',1);

/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table saida
# ------------------------------------------------------------

DROP TABLE IF EXISTS `saida`;

CREATE TABLE `saida` (
  `idsaida` int(11) NOT NULL AUTO_INCREMENT,
  `datasaida` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `idsetor` int(11) NOT NULL,
  `tipo` int(11) NOT NULL DEFAULT '1' COMMENT '1: saida; 2: solicitação',
  PRIMARY KEY (`idsaida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `saida` WRITE;
/*!40000 ALTER TABLE `saida` DISABLE KEYS */;

INSERT INTO `saida` (`idsaida`, `datasaida`, `idusuario`, `idsetor`, `tipo`)
VALUES
	(1,'2015-10-27 08:53:18',1,0,1),
	(2,'2015-10-27 08:56:03',1,0,1),
	(3,'2015-10-29 10:32:50',1,0,1),
	(4,'2015-11-04 11:18:14',3,1,1),
	(5,'2015-11-04 11:34:03',4,1,1),
	(6,'2015-11-06 16:25:12',4,2,1),
	(7,'2015-11-10 15:12:04',4,11,1),
	(8,'2015-11-10 15:14:56',4,9,1),
	(9,'2015-11-10 15:15:40',4,12,1);

/*!40000 ALTER TABLE `saida` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table saida_produto
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
	(1,2,4,1),
	(2,3,2,1),
	(3,3,4,1),
	(4,4,2,1),
	(5,5,9,1),
	(6,6,3,1),
	(7,7,9,3),
	(8,8,4,2130),
	(9,9,4,2);

/*!40000 ALTER TABLE `saida_produto` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table setor
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
	(1,'Tecnologia da Informação Política',''),
	(2,'Gabinete do Secretario','GabSec'),
	(3,'Gabinete da Secretaria Adjunta','GabAdj'),
	(4,'Assessoria da Juventude','AsseJuv'),
	(5,'Assessoria de Planejamento',''),
	(6,'Gabinete Digital',''),
	(7,'Coordenação das Regionais',''),
	(8,'Observatório Político',''),
	(9,'Assessoria Jurídica',''),
	(10,'Departamento de Recursos Humanos',''),
	(11,'Departamento Administrativo',''),
	(12,'Departamento Financeiro',''),
	(13,'Divisão de Serviços Administrativos',''),
	(14,'Mediação de Conflitos','');

/*!40000 ALTER TABLE `setor` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table solicitacao
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
	(1,'2015-10-27 08:58:00',1,2,NULL),
	(2,'2015-10-27 08:59:42',1,1,NULL),
	(3,'2015-10-27 09:06:15',1,1,NULL),
	(4,'2015-10-27 09:08:07',1,1,NULL),
	(5,'2015-10-27 09:09:12',1,1,NULL),
	(6,'2015-10-27 09:20:44',1,1,NULL),
	(7,'2015-11-03 10:57:01',3,1,NULL),
	(8,'2015-10-29 11:06:14',3,1,NULL),
	(9,'2015-11-03 09:25:15',4,2,NULL),
	(10,'2015-11-03 11:07:12',4,1,NULL),
	(11,'2015-11-04 15:10:42',3,1,NULL),
	(12,'2015-11-06 16:25:41',4,1,NULL);

/*!40000 ALTER TABLE `solicitacao` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table solicitacao_produto
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
	(1,2,4,1,1,NULL),
	(2,3,3,1,2,'Sem produto'),
	(3,4,3,1,2,'Sem produto'),
	(4,4,4,1,1,NULL),
	(5,4,1,1,2,'Sem produto'),
	(6,5,4,1,1,NULL),
	(7,6,3,1,2,'Fora do periodo'),
	(8,7,2,1,2,'Você já fez uma solicitação.'),
	(9,8,2,1,1,NULL),
	(10,9,3,1,0,NULL),
	(11,10,3,1,1,NULL),
	(12,10,4,1,1,NULL),
	(13,10,1,1,2,'Sem produto no estoque.'),
	(14,10,9,1,1,NULL),
	(15,11,2,2,2,'Teste'),
	(16,12,3,1,1,NULL),
	(17,12,4,1,1,NULL),
	(18,12,9,1,2,'Baixo estoque');

/*!40000 ALTER TABLE `solicitacao_produto` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table uf
# ------------------------------------------------------------

DROP TABLE IF EXISTS `uf`;

CREATE TABLE `uf` (
  `iduf` int(11) NOT NULL AUTO_INCREMENT,
  `uf` varchar(2) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iduf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `uf` WRITE;
/*!40000 ALTER TABLE `uf` DISABLE KEYS */;

INSERT INTO `uf` (`iduf`, `uf`, `nome`)
VALUES
	(1,'AC','ACRE'),
	(2,'SP','SÃO PAULO');

/*!40000 ALTER TABLE `uf` ENABLE KEYS */;
UNLOCK TABLES;


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
	(1,'UN','Unidade'),
	(2,'KG','Quilograma'),
	(4,'CM','Centimetro'),
	(5,'M','Metro'),
	(6,'CX','Caixa'),
	(7,'T','Teste');

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
  `idsetor` int(11) NOT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;

INSERT INTO `usuario` (`idusuario`, `nome`, `email`, `senha`, `perfil`, `liberado`, `idsetor`)
VALUES
	(1,'Jaisson Santos','jaissonssantos@gmail.com','ab5f505601d22946514ef4de8a45345574e7414b',1,1,1),
	(2,'Gestor do Sistema','sistema@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',7,1,1),
	(3,'Thiago Chaves','thiagoarc@gmail.com','7c4a8d09ca3762af61e59520943dc26494f8941b',1,1,1),
	(4,'Richard Oliveira','richardzero@gmail.com','7c4a8d09ca3762af61e59520943dc26494f8941b',1,1,1),
	(5,'Teste','teste@ti.com.br','682fe8b745dd5442773ba0e687bfa256af1cabe0',5,0,0),
	(6,'Teste','teste@ac.gov.br','1d4ed28ea7990c050c7189cf25aefd66f06ed1fb',5,0,0),
	(7,'Gestor de Contrato','contrato@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',2,1,11),
	(8,'Gestor de Compras','compras@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',3,1,12),
	(9,'Gestor de Estoque','estoque@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',4,1,13),
	(10,'Solicitante de Material','solicitante@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',9,1,4),
	(11,'Observador','observador@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',6,1,2),
	(12,'Gestor de Contrato e Compras','cc@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',8,1,3),
	(13,'Gestor de Compras e Estoque','ce@ac.gov.br','40bd001563085fc35165329ea1ff5c5ecbdbbeef',5,1,8),
	(14,'teste','teste@ac.gov.br','682fe8b745dd5442773ba0e687bfa256af1cabe0',7,1,4);

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
	(476,'/app',1),
	(477,'/usuario',1),
	(478,'/usuario/add',1),
	(479,'/usuario/edit',1),
	(480,'/unidademedida',1),
	(481,'/unidademedida/add',1),
	(482,'/unidademedida/edit',1),
	(483,'/fornecedor',1),
	(484,'/fornecedor/add',1),
	(485,'/fornecedor/edit',1),
	(486,'/produto',1),
	(487,'/produto/add',1),
	(488,'/produto/edit',1),
	(489,'/contrato',1),
	(490,'/contrato/add',1),
	(491,'/contrato/edit',1),
	(492,'/contrato/fornecedor',1),
	(493,'/contrato/aditivos',1),
	(494,'/contrato/aditivo/add',1),
	(495,'/contrato/aditivo/edit',1),
	(496,'/contrato/aditivos/itens',1),
	(497,'/contrato/itens',1),
	(498,'/ordemservico',1),
	(499,'/ordemservico/add',1),
	(500,'/estoque',1),
	(501,'/entrada',1),
	(502,'/solicitacao',1),
	(503,'/solicitacao/detalhes',1),
	(504,'/saida',1),
	(505,'/saida/add',1),
	(506,'/saida/detalhes',1),
	(507,'/solicitacaouser',1),
	(508,'/solicitacaouser/add',1),
	(509,'/solicitacaouser/edit',1),
	(510,'/solicitacaouser/detalhes',1),
	(511,'/relatorio',1),
	(512,'/app',4),
	(513,'/usuario',4),
	(514,'/usuario/add',4),
	(515,'/usuario/edit',4),
	(516,'/unidademedida',4),
	(517,'/unidademedida/add',4),
	(518,'/unidademedida/edit',4),
	(519,'/fornecedor',4),
	(520,'/fornecedor/add',4),
	(521,'/fornecedor/edit',4),
	(522,'/produto',4),
	(523,'/produto/add',4),
	(524,'/produto/edit',4),
	(525,'/contrato',4),
	(526,'/contrato/add',4),
	(527,'/contrato/edit',4),
	(528,'/contrato/fornecedor',4),
	(529,'/contrato/aditivos',4),
	(530,'/contrato/aditivo/add',4),
	(531,'/contrato/aditivo/edit',4),
	(532,'/contrato/aditivos/itens',4),
	(533,'/contrato/itens',4),
	(534,'/ordemservico',4),
	(535,'/ordemservico/add',4),
	(536,'/estoque',4),
	(537,'/entrada',4),
	(538,'/solicitacao',4),
	(539,'/solicitacao/detalhes',4),
	(540,'/saida',4),
	(541,'/saida/add',4),
	(542,'/saida/detalhes',4),
	(543,'/solicitacaouser',4),
	(544,'/solicitacaouser/add',4),
	(545,'/solicitacaouser/edit',4),
	(546,'/solicitacaouser/detalhes',4),
	(547,'/relatorio',4),
	(548,'/app',3),
	(549,'/usuario',3),
	(550,'/usuario/add',3),
	(551,'/usuario/edit',3),
	(552,'/unidademedida',3),
	(553,'/unidademedida/add',3),
	(554,'/unidademedida/edit',3),
	(555,'/fornecedor',3),
	(556,'/fornecedor/add',3),
	(557,'/fornecedor/edit',3),
	(558,'/produto',3),
	(559,'/produto/add',3),
	(560,'/produto/edit',3),
	(561,'/contrato',3),
	(562,'/contrato/add',3),
	(563,'/contrato/edit',3),
	(564,'/contrato/fornecedor',3),
	(565,'/contrato/aditivos',3),
	(566,'/contrato/aditivo/add',3),
	(567,'/contrato/aditivo/edit',3),
	(568,'/contrato/aditivos/itens',3),
	(569,'/contrato/itens',3),
	(570,'/ordemservico',3),
	(571,'/ordemservico/add',3),
	(572,'/estoque',3),
	(573,'/entrada',3),
	(574,'/solicitacao',3),
	(575,'/solicitacao/detalhes',3),
	(576,'/saida',3),
	(577,'/saida/add',3),
	(578,'/saida/detalhes',3),
	(579,'/solicitacaouser',3),
	(580,'/solicitacaouser/add',3),
	(581,'/solicitacaouser/edit',3),
	(582,'/solicitacaouser/detalhes',3),
	(583,'/relatorio',3),
	(751,'/app',2),
	(752,'/unidademedida',2),
	(753,'/unidademedida/add',2),
	(754,'/unidademedida/edit',2),
	(755,'/fornecedor',2),
	(756,'/fornecedor/add',2),
	(757,'/fornecedor/edit',2),
	(758,'/produto',2),
	(759,'/produto/add',2),
	(760,'/produto/edit',2),
	(761,'/contrato',2),
	(762,'/contrato/add',2),
	(763,'/contrato/edit',2),
	(764,'/contrato/fornecedor',2),
	(765,'/contrato/aditivos',2),
	(766,'/contrato/aditivo/add',2),
	(767,'/contrato/aditivo/edit',2),
	(768,'/contrato/aditivos/itens',2),
	(769,'/contrato/itens',2),
	(770,'/ordemservico',2),
	(771,'/ordemservico/add',2),
	(772,'/estoque',2),
	(773,'/entrada',2),
	(774,'/solicitacao',2),
	(775,'/solicitacao/detalhes',2),
	(776,'/saida',2),
	(777,'/saida/add',2),
	(778,'/saida/detalhes',2),
	(779,'/solicitacaouser',2),
	(780,'/solicitacaouser/add',2),
	(781,'/solicitacaouser/edit',2),
	(782,'/solicitacaouser/detalhes',2),
	(783,'/relatorio',2),
	(784,'/app',7),
	(785,'/unidademedida',7),
	(786,'/unidademedida/add',7),
	(787,'/unidademedida/edit',7),
	(788,'/fornecedor',7),
	(789,'/fornecedor/add',7),
	(790,'/fornecedor/edit',7),
	(791,'/produto',7),
	(792,'/produto/add',7),
	(793,'/produto/edit',7),
	(794,'/contrato',7),
	(795,'/contrato/add',7),
	(796,'/contrato/edit',7),
	(797,'/relatorio',7),
	(798,'/app',8),
	(799,'/ordemservico',8),
	(800,'/ordemservico/add',8),
	(801,'/relatorio',8),
	(802,'/app',9),
	(803,'/entrada',9),
	(804,'/solicitacao',9),
	(805,'/solicitacao/detalhes',9),
	(806,'/saida',9),
	(807,'/saida/add',9),
	(808,'/saida/detalhes',9),
	(809,'/solicitacaouser',9),
	(810,'/solicitacaouser/add',9),
	(811,'/solicitacaouser/edit',9),
	(812,'/solicitacaouser/detalhes',9),
	(813,'/relatorio',9),
	(814,'/app',10),
	(815,'/solicitacaouser',10),
	(816,'/solicitacaouser/add',10),
	(817,'/solicitacaouser/edit',10),
	(818,'/solicitacaouser/detalhes',10),
	(819,'/app',11),
	(820,'/relatorio',11),
	(821,'/app',12),
	(822,'/unidademedida',12),
	(823,'/unidademedida/add',12),
	(824,'/unidademedida/edit',12),
	(825,'/fornecedor',12),
	(826,'/fornecedor/add',12),
	(827,'/fornecedor/edit',12),
	(828,'/produto',12),
	(829,'/produto/add',12),
	(830,'/produto/edit',12),
	(831,'/contrato',12),
	(832,'/contrato/add',12),
	(833,'/contrato/edit',12),
	(834,'/ordemservico',12),
	(835,'/ordemservico/add',12),
	(836,'/relatorio',12),
	(842,'/app',14),
	(843,'/unidademedida',14),
	(844,'/unidademedida/add',14),
	(845,'/unidademedida/edit',14),
	(846,'/fornecedor',14),
	(847,'/fornecedor/add',14),
	(848,'/fornecedor/edit',14),
	(849,'/produto',14),
	(850,'/produto/add',14),
	(851,'/produto/edit',14),
	(852,'/contrato',14),
	(853,'/contrato/add',14),
	(854,'/contrato/edit',14),
	(855,'/contrato/fornecedor',14),
	(856,'/contrato/aditivos',14),
	(857,'/contrato/aditivo/add',14),
	(858,'/contrato/aditivo/edit',14),
	(859,'/contrato/aditivos/itens',14),
	(860,'/contrato/itens',14),
	(861,'/ordemservico',14),
	(862,'/ordemservico/add',14),
	(863,'/estoque',14),
	(864,'/entrada',14),
	(865,'/solicitacao',14),
	(866,'/solicitacao/detalhes',14),
	(867,'/saida',14),
	(868,'/saida/add',14),
	(869,'/saida/detalhes',14),
	(870,'/solicitacaouser',14),
	(871,'/solicitacaouser/add',14),
	(872,'/solicitacaouser/edit',14),
	(873,'/solicitacaouser/detalhes',14),
	(874,'/relatorio',14),
	(875,'/app',13),
	(876,'/ordemservico',13),
	(877,'/ordemservico/add',13),
	(878,'/relatorio',13),
	(879,'/entrada',13),
	(880,'/solicitacao',13),
	(881,'/solicitacao/detalhes',13),
	(882,'/saida',13),
	(883,'/saida/add',13),
	(884,'/saida/detalhes',13),
	(885,'/solicitacaouser',13),
	(886,'/solicitacaouser/add',13),
	(887,'/solicitacaouser/edit',13),
	(888,'/solicitacaouser/detalhes',13),
	(889,'/relatorio',13);

/*!40000 ALTER TABLE `usuario_permissao` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
