-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Jul 16, 2015 at 12:18 AM
-- Server version: 5.5.34
-- PHP Version: 5.5.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `secc`
--

-- --------------------------------------------------------

--
-- Table structure for table `cidade`
--

CREATE TABLE `cidade` (
  `idcidade` int(11) NOT NULL AUTO_INCREMENT,
  `iduf` int(11) NOT NULL,
  `nome` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idcidade`),
  KEY `fk_cidade_uf_idx` (`iduf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `contrato`
--

CREATE TABLE `contrato` (
  `idcontrato` int(11) NOT NULL AUTO_INCREMENT,
  `idorgao` int(11) NOT NULL,
  `numerocontrato` varchar(50) DEFAULT NULL,
  `objetocontrato` varchar(255) DEFAULT NULL,
  `valorcontrato` decimal(10,2) DEFAULT NULL,
  `validadecontrato` date DEFAULT NULL,
  `dataassinaturacontrato` date DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL COMMENT '1 - Termo de Adesão, 2 - Compra Direta, 3 - Aditivo',
  `numerotermo` varchar(50) DEFAULT NULL,
  `dataassinaturatermo` date DEFAULT NULL,
  `numeroata` varchar(50) DEFAULT NULL,
  `numeropregao` varchar(50) DEFAULT NULL,
  `numeroprocesso` varchar(50) DEFAULT NULL,
  `validadeata` date DEFAULT NULL,
  `numerocompra` varchar(50) DEFAULT NULL,
  `numeroparecerjuridico` varchar(50) DEFAULT NULL,
  `datacompra` date DEFAULT NULL,
  `valorcompra` decimal(10,2) DEFAULT NULL,
  `numeroaditivo` varchar(50) DEFAULT NULL,
  `validadeaditivo` date DEFAULT NULL,
  `valoraditivo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idcontrato`),
  KEY `fk_contrato_orgao1_idx` (`idorgao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fornecedor`
--

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
  KEY `fk_fornecedor_cidade1_idx` (`idcidade`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `itens_contrato`
--

CREATE TABLE `itens_contrato` (
  `iditens_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`iditens_contrato`),
  KEY `fk_itens_contrato_contrato1_idx` (`idcontrato`),
  KEY `fk_itens_contrato_produto1_idx` (`idproduto`),
  KEY `fk_itens_contrato_fornecedor1_idx` (`idfornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `itens_ordem_servico`
--

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
  KEY `fk_itens_ordem_servico_produto1_idx` (`idproduto`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `ordem_servico`
--

CREATE TABLE `ordem_servico` (
  `idordem_servico` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `datasolicitacao` date DEFAULT NULL,
  PRIMARY KEY (`idordem_servico`),
  KEY `fk_ordem_servico_contrato1_idx` (`idcontrato`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `orgao`
--

CREATE TABLE `orgao` (
  `idorgao` int(11) NOT NULL AUTO_INCREMENT,
  `sigla` varchar(20) DEFAULT NULL,
  `nome` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idorgao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `produto`
--

CREATE TABLE `produto` (
  `idproduto` int(11) NOT NULL AUTO_INCREMENT,
  `idunidade_medida` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idproduto`),
  KEY `fk_produto_unidade_medida1_idx` (`idunidade_medida`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `produto`
--

INSERT INTO `produto` (`idproduto`, `idunidade_medida`, `nome`, `descricao`, `marca`) VALUES
(4, 1, 'Pendrive', 'Pendrive de 64gb', 'SODAME'),
(5, 1, 'Pendrive', 'Pendrive de 256gb', 'SODAME'),
(6, 3, 'Lápis', 'Lápis preto com bosda emborrachada', 'Faber Castel'),
(8, 1, 'Papel', 'Papel A4', 'CHAMEKINHO');

-- --------------------------------------------------------

--
-- Table structure for table `uf`
--

CREATE TABLE `uf` (
  `iduf` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iduf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `unidade_medida`
--

CREATE TABLE `unidade_medida` (
  `idunidade_medida` int(11) NOT NULL AUTO_INCREMENT,
  `sigla` varchar(20) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idunidade_medida`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `unidade_medida`
--

INSERT INTO `unidade_medida` (`idunidade_medida`, `sigla`, `descricao`) VALUES
(1, 'UN', 'Unidade'),
(3, 'LT', 'Litros'),
(4, 'MT', 'Metro'),
(5, 'CM', 'Centimetro'),
(6, 'KM', 'Kilometro'),
(7, 'M3', 'Metro Cúbico');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cidade`
--
ALTER TABLE `cidade`
  ADD CONSTRAINT `fk_cidade_uf` FOREIGN KEY (`iduf`) REFERENCES `uf` (`iduf`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `fk_contrato_orgao1` FOREIGN KEY (`idorgao`) REFERENCES `orgao` (`idorgao`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD CONSTRAINT `fk_fornecedor_cidade1` FOREIGN KEY (`idcidade`) REFERENCES `cidade` (`idcidade`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `itens_contrato`
--
ALTER TABLE `itens_contrato`
  ADD CONSTRAINT `fk_itens_contrato_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_contrato_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_contrato_produto1` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `itens_ordem_servico`
--
ALTER TABLE `itens_ordem_servico`
  ADD CONSTRAINT `fk_itens_ordem_servico_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_ordem_servico_ordem_servico1` FOREIGN KEY (`idordem_servico`) REFERENCES `ordem_servico` (`idordem_servico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_ordem_servico_produto1` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ordem_servico`
--
ALTER TABLE `ordem_servico`
  ADD CONSTRAINT `fk_ordem_servico_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_produto_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION;
