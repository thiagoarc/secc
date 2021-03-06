-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Sep 14, 2015 at 04:01 PM
-- Server version: 5.5.34
-- PHP Version: 5.5.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `secc`
--

-- --------------------------------------------------------

--
-- Table structure for table `aditivo`
--

CREATE TABLE `aditivo` (
  `idaditivo` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `validade` date DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `obs` text,
  PRIMARY KEY (`idaditivo`),
  KEY `fk_aditivo_compra1_idx` (`idcontrato`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `aditivo`
--

INSERT INTO `aditivo` (`idaditivo`, `idcontrato`, `numero`, `validade`, `valor`, `obs`) VALUES
(1, 9, '1332444', '2015-09-30', 10000.00, ''),
(5, 9, '2323', '2015-09-09', 10000.00, NULL),
(6, 7, '9988726', '2015-09-09', 12500.00, 'Teste observação.'),
(7, 7, '11225533', '2015-09-00', 5500.00, 'oi'),
(8, 10, '12344556', '2016-09-00', 121313.12, 'Fase 2');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `cidade`
--

INSERT INTO `cidade` (`idcidade`, `iduf`, `nome`) VALUES
(1, 1, 'Rio Branco');

-- --------------------------------------------------------

--
-- Table structure for table `contrato`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `contrato`
--

INSERT INTO `contrato` (`idcontrato`, `idorgao`, `tipo`, `tipoobjetos`, `numerotali`, `dataassinaturatali`, `numeroata`, `numeropregao`, `numeroprocesso`, `validadeata`, `numerocd`, `numeroparecerjuridico`, `datacompra`, `numerocontrato`, `objeto`, `valor`, `validade`, `dataassinatura`, `numeroempenho`) VALUES
(7, 1, 1, 1, '45345', '2015-08-25', '98989', '878787', '09880', '2015-08-25', NULL, NULL, NULL, '5552243', 'obj', 1200.00, '2015-08-25', '2015-08-25', '234234'),
(9, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, '111111', NULL, '2015-09-02', '111111', 'obj', 100000.98, '2015-09-02', '2015-09-02', '2323'),
(10, 1, 1, 1, '123456', '2015-09-09', '4321', 'PRP 123', '321', '2016-09-09', NULL, NULL, '0000-00-00', '2112', 'Contratação de material de consumo', 123.45, '2016-09-09', '2015-09-09', '2121');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `fornecedor`
--

INSERT INTO `fornecedor` (`idfornecedor`, `idcidade`, `razaosocial`, `cnpj`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `telefone`, `celular`, `email`, `responsavel`) VALUES
(2, 1, 'TARC Tecnologia', '11444777000161', '69900643', 'Rua Dom Bosco', 89, NULL, 'Bosque', '6832248204', '6899487908', 'thiagoarc@gmail.com', 'Thiago Chaves'),
(3, 1, 'Kambo Tecnologia', '12345678910110', '69900643', 'Rua Bartolomeu Bueno', 89, NULL, 'Bosque', '6832248204', '6899487908', 'thiagoarc@gmail.com', 'Thiago Chaves'),
(4, 1, 'Mil Presentes', '53534757000121', '69900000', 'Rua do Centro', 90, 'e', 'Centro', '6832255555', '6899009988', 'milton@gmail.com', 'Milton Cruz');

-- --------------------------------------------------------

--
-- Table structure for table `fornecedor_contrato`
--

CREATE TABLE `fornecedor_contrato` (
  `idfornecedor_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `idfornecedor` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL,
  PRIMARY KEY (`idfornecedor_contrato`),
  KEY `fk_fornecedor_has_contrato_contrato1_idx` (`idcontrato`),
  KEY `fk_fornecedor_has_contrato_fornecedor1_idx` (`idfornecedor`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `fornecedor_contrato`
--

INSERT INTO `fornecedor_contrato` (`idfornecedor_contrato`, `idfornecedor`, `idcontrato`) VALUES
(1, 3, 9),
(2, 4, 7),
(3, 2, 7),
(4, 2, 9),
(5, 4, 9);

-- --------------------------------------------------------

--
-- Table structure for table `itens_aditivo`
--

CREATE TABLE `itens_aditivo` (
  `iditens_aditivo` int(11) NOT NULL AUTO_INCREMENT,
  `idaditivo` int(11) NOT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idfornecedor` int(11) NOT NULL,
  PRIMARY KEY (`iditens_aditivo`),
  KEY `fk_itens_aditivo_aditivo1_idx` (`idaditivo`),
  KEY `fk_itens_aditivo_unidade_medida1_idx` (`idunidade_medida`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `itens_aditivo`
--

INSERT INTO `itens_aditivo` (`iditens_aditivo`, `idaditivo`, `idunidade_medida`, `descricao`, `qtd`, `valorunitario`, `idfornecedor`) VALUES
(6, 5, 1, 'Pendrive de 256gb', 20, 1000.00, 3),
(7, 5, 1, 'Pendrive de 512gb', 25, 1500.00, 3),
(8, 1, 1, 'Pendrive de 256gb', 20, 1000.00, 3);

-- --------------------------------------------------------

--
-- Table structure for table `itens_contrato`
--

CREATE TABLE `itens_contrato` (
  `iditens_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `idcontrato` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  PRIMARY KEY (`iditens_contrato`),
  KEY `fk_itens_contrato_contrato1_idx` (`idcontrato`),
  KEY `fk_itens_contrato_unidade_medida1_idx` (`idunidade_medida`),
  KEY `idfornecedor` (`idfornecedor`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `itens_contrato`
--

INSERT INTO `itens_contrato` (`iditens_contrato`, `idcontrato`, `descricao`, `qtd`, `valorunitario`, `idunidade_medida`, `idfornecedor`) VALUES
(1, 9, 'Pendrive de 256gb', 20, 1000.00, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `itens_ordem_servico`
--

CREATE TABLE `itens_ordem_servico` (
  `iditens_ordem_servico` int(11) NOT NULL AUTO_INCREMENT,
  `idordem_servico` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idunidade_medida` int(11) NOT NULL,
  PRIMARY KEY (`iditens_ordem_servico`),
  KEY `fk_itens_ordem_servico_ordem_servico1_idx` (`idordem_servico`),
  KEY `fk_itens_ordem_servico_unidade_medida1_idx` (`idunidade_medida`)
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `orgao`
--

INSERT INTO `orgao` (`idorgao`, `sigla`, `nome`) VALUES
(1, 'SAI', 'Secretaria de Articulação Institucional');

-- --------------------------------------------------------

--
-- Table structure for table `uf`
--

CREATE TABLE `uf` (
  `iduf` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iduf`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `uf`
--

INSERT INTO `uf` (`iduf`, `nome`) VALUES
(1, 'ACRE');

-- --------------------------------------------------------

--
-- Table structure for table `unidade_medida`
--

CREATE TABLE `unidade_medida` (
  `idunidade_medida` int(11) NOT NULL AUTO_INCREMENT,
  `sigla` varchar(20) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idunidade_medida`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `unidade_medida`
--

INSERT INTO `unidade_medida` (`idunidade_medida`, `sigla`, `descricao`) VALUES
(1, 'UN', 'Unidade'),
(2, 'KG', 'Quilograma'),
(3, 'M', 'Metro'),
(4, 'CM', 'Centimetro');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varchar(60) DEFAULT NULL,
  `perfil` int(11) DEFAULT NULL,
  `liberado` int(11) DEFAULT '1',
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nome`, `email`, `senha`, `perfil`, `liberado`) VALUES
(1, 'Jaisson Santos', 'jaissonssantos@gmail.com', 'ab5f505601d22946514ef4de8a45345574e7414b', 1, 1),
(2, 'Gestor de Contrato', 'gestor@ac.gov.br', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 3, 1),
(3, 'Thiago Chaves', 'thiagoarc@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1),
(4, 'Richard Oliveira', 'richardzero@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `usuario_permissao`
--

CREATE TABLE `usuario_permissao` (
  `idusuario_permissao` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `roles` varchar(40) DEFAULT NULL,
  `idusuario` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`idusuario_permissao`),
  KEY `idusuario` (`idusuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=84 ;

--
-- Dumping data for table `usuario_permissao`
--

INSERT INTO `usuario_permissao` (`idusuario_permissao`, `roles`, `idusuario`) VALUES
(1, '/usuario', 1),
(2, '/usuario/add', 1),
(3, '/usuario/edit', 1),
(4, '/unidademedida', 1),
(5, '/unidademedida/add', 1),
(6, '/unidademedida/edit', 1),
(7, '/fornecedor', 1),
(8, '/fornecedor/add', 1),
(9, '/fornecedor/edit', 1),
(10, '/produto', 1),
(11, '/produto/add', 1),
(12, '/produto/edit', 1),
(13, '/app', 2),
(14, '/usuario', 2),
(15, '/usuario/add', 2),
(16, '/usuario/edit', 2),
(17, '/unidademedida', 2),
(18, '/unidademedida/add', 2),
(19, '/unidademedida/edit', 2),
(20, '/fornecedor', 2),
(21, '/fornecedor/add', 2),
(22, '/fornecedor/edit', 2),
(23, '/produto', 2),
(24, '/produto/add', 2),
(25, '/produto/edit', 2),
(26, '/relatorio', 2),
(27, '/usuario', 3),
(28, '/usuario/add', 3),
(29, '/usuario/edit', 3),
(30, '/unidademedida', 3),
(31, '/unidademedida/add', 3),
(32, '/unidademedida/edit', 3),
(33, '/fornecedor', 3),
(34, '/fornecedor/add', 3),
(35, '/fornecedor/edit', 3),
(36, '/produto', 3),
(37, '/produto/add', 3),
(38, '/produto/edit', 3),
(39, '/contrato', 3),
(40, '/contrato/add', 3),
(41, '/contrato/edit', 3),
(42, '/app', 1),
(43, '/404', 1),
(44, '/contrato', 1),
(45, '/contrato/add', 1),
(46, '/contrato/edit', 1),
(47, '/contrato', 2),
(48, '/contrato/add', 2),
(49, '/contrato/edit', 2),
(53, '/app', 3),
(54, '/404', 3),
(55, '/contrato/fornecedor', 3),
(56, '/contrato/aditivos', 1),
(57, '/contrato/aditivos', 2),
(58, '/contrato/aditivos', 3),
(59, '/contrato/aditivos/add', 1),
(60, '/contrato/aditivos/add', 2),
(61, '/contrato/aditivos/add', 3),
(62, '/contrato/aditivos/edit', 1),
(63, '/contrato/aditivos/edit', 2),
(64, '/contrato/aditivos/edit', 3),
(65, '/app', 4),
(66, '/usuario', 4),
(67, '/usuario/add', 4),
(68, '/usuario/edit', 4),
(69, '/unidademedida', 4),
(70, '/unidademedida/add', 4),
(71, '/unidademedida/edit', 4),
(72, '/fornecedor', 4),
(73, '/fornecedor/add', 4),
(74, '/fornecedor/edit', 4),
(75, '/produto', 4),
(76, '/produto/add', 4),
(77, '/produto/edit', 4),
(78, '/contrato', 4),
(79, '/contrato/add', 4),
(80, '/contrato/edit', 4),
(81, '/compras', 4),
(82, '/estoque', 4),
(83, '/relatorio', 4);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aditivo`
--
ALTER TABLE `aditivo`
  ADD CONSTRAINT `fk_aditivo_contrato` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `cidade`
--
ALTER TABLE `cidade`
  ADD CONSTRAINT `fk_cidade_uf` FOREIGN KEY (`iduf`) REFERENCES `uf` (`iduf`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD CONSTRAINT `fk_fornecedor_cidade1` FOREIGN KEY (`idcidade`) REFERENCES `cidade` (`idcidade`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `fornecedor_contrato`
--
ALTER TABLE `fornecedor_contrato`
  ADD CONSTRAINT `fk_fornecedor_has_contrato_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fornecedor_has_contrato_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `itens_aditivo`
--
ALTER TABLE `itens_aditivo`
  ADD CONSTRAINT `fk_itens_aditivo_aditivo1` FOREIGN KEY (`idaditivo`) REFERENCES `aditivo` (`idaditivo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_aditivo_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `itens_contrato`
--
ALTER TABLE `itens_contrato`
  ADD CONSTRAINT `fk_itens_contrato_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_contrato_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `itens_contrato_ibfk_1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `itens_ordem_servico`
--
ALTER TABLE `itens_ordem_servico`
  ADD CONSTRAINT `fk_itens_ordem_servico_ordem_servico1` FOREIGN KEY (`idordem_servico`) REFERENCES `ordem_servico` (`idordem_servico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_ordem_servico_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ordem_servico`
--
ALTER TABLE `ordem_servico`
  ADD CONSTRAINT `fk_ordem_servico_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  ADD CONSTRAINT `usuario_permissao_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);
