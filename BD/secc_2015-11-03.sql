-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Nov 03, 2015 at 05:26 PM
-- Server version: 5.5.42
-- PHP Version: 5.6.10

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
  `idaditivo` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `validade` date DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `obs` text
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `aditivo`
--

INSERT INTO `aditivo` (`idaditivo`, `idcontrato`, `numero`, `validade`, `valor`, `obs`) VALUES
(13, 13, '222222', '2016-01-30', '50000.00', 'Teste de observação de Aditivo.'),
(14, 14, '898989', '2018-10-21', '1000.00', 'Teste');

-- --------------------------------------------------------

--
-- Table structure for table `cidade`
--

CREATE TABLE `cidade` (
  `idcidade` int(11) NOT NULL,
  `iduf` int(11) NOT NULL,
  `nome` varchar(150) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

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
  `idcontrato` int(11) NOT NULL,
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
  `numeroempenho` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contrato`
--

INSERT INTO `contrato` (`idcontrato`, `idorgao`, `tipo`, `tipoobjetos`, `numerotali`, `dataassinaturatali`, `numeroata`, `numeropregao`, `numeroprocesso`, `validadeata`, `numerocd`, `numeroparecerjuridico`, `datacompra`, `numerocontrato`, `objeto`, `valor`, `validade`, `dataassinatura`, `numeroempenho`) VALUES
(13, NULL, 3, 1, NULL, '0000-00-00', NULL, NULL, NULL, '0000-00-00', '111111', '111111', '2015-10-20', '111111', 'Teste de Cadastro de Contrato.', '100000.00', '2015-12-31', '2015-10-22', '111111'),
(14, 1, 2, 1, '010101', '2015-10-10', '10101', '919191', '909090', '2018-10-10', NULL, NULL, '0000-00-00', '989898', '12121121121', '1212.11', '2018-10-20', '2015-10-20', '818181');

-- --------------------------------------------------------

--
-- Table structure for table `empenho_aditivo`
--

CREATE TABLE `empenho_aditivo` (
  `idempenho_aditivo` int(11) NOT NULL,
  `idaditivo` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `empenho_contrato`
--

CREATE TABLE `empenho_contrato` (
  `idempenho_contrato` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `empenho_contrato`
--

INSERT INTO `empenho_contrato` (`idempenho_contrato`, `idcontrato`, `idfornecedor`, `numero`, `valor`) VALUES
(2, 13, 2, 12321, '10000.00'),
(3, 13, 2, 121212, '12300.00'),
(4, 14, 5, 7676767, '1000.00');

-- --------------------------------------------------------

--
-- Table structure for table `fornecedor`
--

CREATE TABLE `fornecedor` (
  `idfornecedor` int(11) NOT NULL,
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
  `responsavel` varchar(150) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fornecedor`
--

INSERT INTO `fornecedor` (`idfornecedor`, `idcidade`, `razaosocial`, `cnpj`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `telefone`, `celular`, `email`, `responsavel`) VALUES
(2, 1, 'TARC Tecnologia', '11444777000161', '69900643', 'Rua Dom Bosco', 89, NULL, 'Bosque', '6832248204', '6899487908', 'thiagoarc@gmail.com', 'Thiago Chaves'),
(3, 1, 'Kambo Tecnologia', '12345678910110', '69900643', 'Rua Bartolomeu Bueno', 89, NULL, 'Bosque', '6832248204', '6899487908', 'thiagoarc@gmail.com', 'Thiago Chaves'),
(4, 1, 'Mil Presentes', '53534757000121', '69900000', 'Rua do Centro', 90, 'e', 'Centro', '6832255555', '6899009988', 'milton@gmail.com', 'Milton Cruz'),
(5, 1, 'Móveis Gazin', '11111111000000', '69900000', 'Avenida Getúlio Vargas', 1476, NULL, 'Bosque', '6832246565', '6899887766', 'rufino@gmail.com', 'Rufino Maia'),
(6, 1, 'Teste em TI', '11111111000000', '69900000', 'Rua teste 1', 1, 'Casa', 'Teste', '6832232323', '6899880101', 'teste@ti.com.br', 'Teste');

-- --------------------------------------------------------

--
-- Table structure for table `fornecedor_contrato`
--

CREATE TABLE `fornecedor_contrato` (
  `idfornecedor_contrato` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fornecedor_contrato`
--

INSERT INTO `fornecedor_contrato` (`idfornecedor_contrato`, `idfornecedor`, `idcontrato`) VALUES
(2, 2, 13),
(4, 5, 14);

-- --------------------------------------------------------

--
-- Table structure for table `itens_aditivo`
--

CREATE TABLE `itens_aditivo` (
  `iditens_aditivo` int(11) NOT NULL,
  `idaditivo` int(11) NOT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT '0',
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idfornecedor` int(11) NOT NULL,
  `qtdordem` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `itens_aditivo`
--

INSERT INTO `itens_aditivo` (`iditens_aditivo`, `idaditivo`, `idunidade_medida`, `descricao`, `qtd`, `valorunitario`, `idfornecedor`, `qtdordem`) VALUES
(3, 13, 1, 'Mouse sem fio - Microsoft', 15, '500.00', 2, 16),
(5, 13, 1, 'Monitor de 25 Polegadas - Multilaser', 5, '1500.00', 2, 5),
(6, 13, 1, 'Nobreak 1500VA - Multilaser', 10, '550.00', 2, 10),
(7, 13, 1, 'Carregador de Pihas - Multilaser', 5, '55.00', 2, 5),
(8, 13, 5, 'Cado de Rede CAT6 - Mondial', 150, '1.50', 2, 151),
(9, 13, 1, 'Crimpador de Cado de Rede', 1, '150.00', 2, 2),
(10, 14, 5, 'hdhdf', 6, '12.11', 5, 6),
(12, 14, 5, 'teste', 8, '100.00', 5, 8);

-- --------------------------------------------------------

--
-- Table structure for table `itens_contrato`
--

CREATE TABLE `itens_contrato` (
  `iditens_contrato` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT '0',
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `qtdordem` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `itens_contrato`
--

INSERT INTO `itens_contrato` (`iditens_contrato`, `idcontrato`, `descricao`, `qtd`, `valorunitario`, `idunidade_medida`, `idfornecedor`, `qtdordem`) VALUES
(2, 13, 'HD 1TR - Samsung', 15, '1500.00', 1, 2, 2),
(3, 13, 'Mouse sem fio - Microsoft', 10, '1000.00', 1, 2, 3),
(4, 13, 'Teclado Sem Fio - Multilaser', 15, '1000.00', 1, 2, 3),
(5, 14, 'hdhdf', 6, '1.21', 5, 5, 0),
(6, 14, 'Teste', 5, '120.00', 5, 5, 0),
(7, 14, 'teste', 5, '8.00', 5, 5, 0),
(8, 13, 'Pen Drive 16GB', 20, '100.00', 1, 2, 2),
(9, 13, 'Processador i5', 10, '1000.00', 1, 2, 2),
(10, 13, 'Cabo HDMI', 12, '50.00', 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `itens_ordem_servico`
--

CREATE TABLE `itens_ordem_servico` (
  `iditens_ordem_servico` int(11) NOT NULL,
  `idordem_servico` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `iditem_contratoaditivo` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `itens_ordem_servico`
--

INSERT INTO `itens_ordem_servico` (`iditens_ordem_servico`, `idordem_servico`, `descricao`, `qtd`, `valorunitario`, `idunidade_medida`, `iditem_contratoaditivo`) VALUES
(9, 5, 'HD 1TR - Samsung', 1, '1500.00', 1, 2),
(10, 5, 'Memória RAM - 8GB - 1600 - Kingstom', 1, '500.00', 1, 1),
(11, 5, 'Mouse sem fio - Microsoft', 1, '1000.00', 1, 3),
(12, 5, 'Teclado Sem Fio - Multilaser', 1, '1000.00', 1, 4),
(13, 6, 'hdhdf', 2, '1.21', 5, 5),
(14, 6, 'teste', 2, '8.00', 5, 7),
(15, 6, 'Teste', 2, '120.00', 5, 6),
(16, 7, 'Cabo HDMI', 2, '50.00', 1, 10),
(17, 7, 'HD 1TR - Samsung', 2, '1500.00', 1, 2),
(18, 7, 'Memória RAM - 8GB - 1600 - Kingstom', 2, '500.00', 1, 1),
(19, 7, 'Mouse sem fio - Microsoft', 2, '1000.00', 1, 3),
(20, 7, 'Pen Drive 16GB', 2, '100.00', 1, 8),
(21, 7, 'Processador i5', 2, '1000.00', 1, 9),
(22, 7, 'Teclado Sem Fio - Multilaser', 2, '1000.00', 1, 4),
(23, 8, 'Cabo HDMI', 1, '50.00', 1, 10),
(24, 8, 'HD 1TR - Samsung', 1, '1500.00', 1, 2),
(25, 8, 'Mouse sem fio - Microsoft', 1, '1000.00', 1, 3),
(26, 8, 'Pen Drive 16GB', 1, '100.00', 1, 8),
(27, 8, 'Processador i5', 1, '1000.00', 1, 9),
(28, 8, 'Teclado Sem Fio - Multilaser', 1, '1000.00', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `ordem_servico`
--

CREATE TABLE `ordem_servico` (
  `idordem_servico` int(11) NOT NULL,
  `datasolicitacao` date DEFAULT NULL,
  `idcontratoaditivo` int(11) DEFAULT NULL,
  `tipo` int(10) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ordem_servico`
--

INSERT INTO `ordem_servico` (`idordem_servico`, `datasolicitacao`, `idcontratoaditivo`, `tipo`) VALUES
(5, '2015-10-28', 13, 1),
(6, '2015-10-29', 14, 2),
(7, '2015-10-29', 13, 1),
(8, '2015-11-03', 13, 2);

-- --------------------------------------------------------

--
-- Table structure for table `orgao`
--

CREATE TABLE `orgao` (
  `idorgao` int(11) NOT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  `nome` varchar(150) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orgao`
--

INSERT INTO `orgao` (`idorgao`, `sigla`, `nome`) VALUES
(1, 'SAI', 'Secretaria de Articulação Institucional');

-- --------------------------------------------------------

--
-- Table structure for table `produto`
--

CREATE TABLE `produto` (
  `idproduto` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `descricao` varchar(250) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `qtdminima` int(11) DEFAULT '0',
  `qtdatual` int(11) DEFAULT '0',
  `datacadastro` datetime DEFAULT NULL,
  `dataatualizacao` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `produto`
--

INSERT INTO `produto` (`idproduto`, `idfornecedor`, `idunidade_medida`, `descricao`, `valorunitario`, `qtdminima`, `qtdatual`, `datacadastro`, `dataatualizacao`, `idusuario`) VALUES
(1, 2, 1, 'HD 1TR - Samsung', '1500.00', 2, 4, NULL, '2015-10-29 12:08:27', 1),
(2, 2, 1, 'Memória RAM - 8GB - 1600 - Kingstom', '500.00', 10, 13, NULL, '2015-10-29 10:28:51', 1),
(3, 2, 1, 'Mouse sem fio - Microsoft', '1000.00', 3, 4, NULL, '2015-10-29 12:06:47', 1),
(4, 2, 1, 'Teclado Sem Fio - Multilaser', '1000.00', 5, 1020, NULL, '2015-10-27 09:11:34', 1),
(5, 5, 5, 'hdhdf', '1.21', 0, 0, NULL, NULL, NULL),
(6, 5, 5, 'teste', '8.00', 0, 0, NULL, NULL, NULL),
(7, 5, 5, 'Teste', '120.00', 0, 0, NULL, NULL, NULL),
(8, 2, 1, 'Cabo HDMI', '50.00', 2, 5, NULL, '2015-10-29 12:23:02', 1),
(9, 2, 1, 'Pen Drive 16GB', '100.00', 2, 3, NULL, '2015-10-29 12:22:31', 1),
(10, 2, 1, 'Processador i5', '1000.00', 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `saida`
--

CREATE TABLE `saida` (
  `idsaida` int(11) NOT NULL,
  `datasaida` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saida`
--

INSERT INTO `saida` (`idsaida`, `datasaida`, `idusuario`) VALUES
(1, '2015-10-27 08:53:18', 1),
(2, '2015-10-27 08:56:03', 1),
(3, '2015-10-29 10:32:50', 1);

-- --------------------------------------------------------

--
-- Table structure for table `saida_produto`
--

CREATE TABLE `saida_produto` (
  `idsaida_produto` int(11) NOT NULL,
  `saida_idsaida` int(11) NOT NULL,
  `produto_idproduto` int(11) NOT NULL,
  `qtd` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `saida_produto`
--

INSERT INTO `saida_produto` (`idsaida_produto`, `saida_idsaida`, `produto_idproduto`, `qtd`) VALUES
(1, 2, 4, 1),
(2, 3, 2, 1),
(3, 3, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `setor`
--

CREATE TABLE `setor` (
  `idsetor` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `sigla` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `setor`
--

INSERT INTO `setor` (`idsetor`, `nome`, `sigla`) VALUES
(1, 'Desenvolvimento de Sistemas', 'DSIS');

-- --------------------------------------------------------

--
-- Table structure for table `solicitacao`
--

CREATE TABLE `solicitacao` (
  `idsolicitacao` int(11) NOT NULL,
  `datasolicitacao` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0 - Aguardando; 1 - Finalizada; 2 - Cancelada;',
  `motivo` varchar(250) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `solicitacao`
--

INSERT INTO `solicitacao` (`idsolicitacao`, `datasolicitacao`, `idusuario`, `status`, `motivo`) VALUES
(1, '2015-10-27 08:58:00', 1, 2, NULL),
(2, '2015-10-27 08:59:42', 1, 1, NULL),
(3, '2015-10-27 09:06:15', 1, 1, NULL),
(4, '2015-10-27 09:08:07', 1, 1, NULL),
(5, '2015-10-27 09:09:12', 1, 1, NULL),
(6, '2015-10-27 09:20:44', 1, 1, NULL),
(7, '2015-10-29 10:57:01', 3, 1, NULL),
(8, '2015-10-29 11:06:14', 3, 1, NULL),
(9, '2015-11-03 09:25:15', 4, 2, NULL),
(10, '2015-11-03 11:07:12', 4, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `solicitacao_produto`
--

CREATE TABLE `solicitacao_produto` (
  `idsolicitacao_produto` int(11) NOT NULL,
  `idsolicitacao` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `qtd` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 - aguardando; 1 - deferido; 2 - indeferido;',
  `motivo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `solicitacao_produto`
--

INSERT INTO `solicitacao_produto` (`idsolicitacao_produto`, `idsolicitacao`, `idproduto`, `qtd`, `status`, `motivo`) VALUES
(1, 2, 4, 1, 1, NULL),
(2, 3, 3, 1, 2, 'Sem produto'),
(3, 4, 3, 1, 2, 'Sem produto'),
(4, 4, 4, 1, 1, NULL),
(5, 4, 1, 1, 2, 'Sem produto'),
(6, 5, 4, 1, 1, NULL),
(7, 6, 3, 1, 2, 'Fora do periodo'),
(8, 7, 2, 1, 2, 'Você já fez uma solicitação.'),
(9, 8, 2, 1, 1, NULL),
(10, 9, 3, 1, 0, NULL),
(11, 10, 3, 1, 1, NULL),
(12, 10, 4, 1, 1, NULL),
(13, 10, 1, 1, 2, 'Sem produto no estoque.'),
(14, 10, 9, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `uf`
--

CREATE TABLE `uf` (
  `iduf` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

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
  `idunidade_medida` int(11) NOT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unidade_medida`
--

INSERT INTO `unidade_medida` (`idunidade_medida`, `sigla`, `descricao`) VALUES
(1, 'UN', 'Unidade'),
(2, 'KG', 'Quilograma'),
(4, 'CM', 'Centimetro'),
(5, 'M', 'Metro'),
(6, 'CX', 'Caixa');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) unsigned NOT NULL,
  `nome` varchar(60) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varchar(60) DEFAULT NULL,
  `perfil` int(11) DEFAULT NULL,
  `liberado` int(11) DEFAULT '1',
  `idsetor` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nome`, `email`, `senha`, `perfil`, `liberado`, `idsetor`) VALUES
(1, 'Jaisson Santos', 'jaissonssantos@gmail.com', 'ab5f505601d22946514ef4de8a45345574e7414b', 1, 1, 1),
(2, 'Gestor de Contrato', 'gestor@ac.gov.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', 2, 1, 1),
(3, 'Thiago Chaves', 'thiagoarc@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1, 1),
(4, 'Richard Oliveira', 'richardzero@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1, 1),
(5, 'Teste', 'teste@ti.com.br', '682fe8b745dd5442773ba0e687bfa256af1cabe0', 5, 0, 0),
(6, 'Teste', 'teste@ac.gov.br', '1d4ed28ea7990c050c7189cf25aefd66f06ed1fb', 5, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `usuario_permissao`
--

CREATE TABLE `usuario_permissao` (
  `idusuario_permissao` int(11) unsigned NOT NULL,
  `roles` varchar(40) DEFAULT NULL,
  `idusuario` int(11) unsigned DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=584 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario_permissao`
--

INSERT INTO `usuario_permissao` (`idusuario_permissao`, `roles`, `idusuario`) VALUES
(116, '/app', NULL),
(117, '/usuario', NULL),
(118, '/usuario/add', NULL),
(119, '/usuario/edit', NULL),
(120, '/unidademedida', NULL),
(121, '/unidademedida/add', NULL),
(122, '/unidademedida/edit', NULL),
(123, '/fornecedor', NULL),
(124, '/fornecedor/add', NULL),
(125, '/fornecedor/edit', NULL),
(126, '/produto', NULL),
(127, '/produto/add', NULL),
(128, '/produto/edit', NULL),
(129, '/contrato', NULL),
(130, '/contrato/add', NULL),
(131, '/contrato/edit', NULL),
(132, '/compras', NULL),
(133, '/estoque', NULL),
(134, '/relatorio', NULL),
(319, '/app', 5),
(320, '/usuario', 5),
(321, '/usuario/add', 5),
(322, '/usuario/edit', 5),
(323, '/unidademedida', 5),
(324, '/unidademedida/add', 5),
(325, '/unidademedida/edit', 5),
(326, '/fornecedor', 5),
(327, '/fornecedor/add', 5),
(328, '/fornecedor/edit', 5),
(329, '/produto', 5),
(330, '/produto/add', 5),
(331, '/produto/edit', 5),
(332, '/contrato', 5),
(333, '/contrato/add', 5),
(334, '/contrato/edit', 5),
(335, '/relatorio', 5),
(336, '/app', 6),
(337, '/usuario', 6),
(338, '/usuario/add', 6),
(339, '/usuario/edit', 6),
(340, '/unidademedida', 6),
(341, '/unidademedida/add', 6),
(342, '/unidademedida/edit', 6),
(343, '/fornecedor', 6),
(344, '/fornecedor/add', 6),
(345, '/fornecedor/edit', 6),
(346, '/produto', 6),
(347, '/produto/add', 6),
(348, '/produto/edit', 6),
(349, '/contrato', 6),
(350, '/contrato/add', 6),
(351, '/contrato/edit', 6),
(352, '/relatorio', 6),
(370, '/app', 2),
(371, '/usuario', 2),
(372, '/usuario/add', 2),
(373, '/usuario/edit', 2),
(374, '/unidademedida', 2),
(375, '/unidademedida/add', 2),
(376, '/unidademedida/edit', 2),
(377, '/fornecedor', 2),
(378, '/fornecedor/add', 2),
(379, '/fornecedor/edit', 2),
(380, '/produto', 2),
(381, '/produto/add', 2),
(382, '/produto/edit', 2),
(383, '/contrato', 2),
(384, '/contrato/add', 2),
(385, '/contrato/edit', 2),
(386, '/relatorio', 2),
(476, '/app', 1),
(477, '/usuario', 1),
(478, '/usuario/add', 1),
(479, '/usuario/edit', 1),
(480, '/unidademedida', 1),
(481, '/unidademedida/add', 1),
(482, '/unidademedida/edit', 1),
(483, '/fornecedor', 1),
(484, '/fornecedor/add', 1),
(485, '/fornecedor/edit', 1),
(486, '/produto', 1),
(487, '/produto/add', 1),
(488, '/produto/edit', 1),
(489, '/contrato', 1),
(490, '/contrato/add', 1),
(491, '/contrato/edit', 1),
(492, '/contrato/fornecedor', 1),
(493, '/contrato/aditivos', 1),
(494, '/contrato/aditivo/add', 1),
(495, '/contrato/aditivo/edit', 1),
(496, '/contrato/aditivos/itens', 1),
(497, '/contrato/itens', 1),
(498, '/ordemservico', 1),
(499, '/ordemservico/add', 1),
(500, '/estoque', 1),
(501, '/entrada', 1),
(502, '/solicitacao', 1),
(503, '/solicitacao/detalhes', 1),
(504, '/saida', 1),
(505, '/saida/add', 1),
(506, '/saida/detalhes', 1),
(507, '/solicitacaouser', 1),
(508, '/solicitacaouser/add', 1),
(509, '/solicitacaouser/edit', 1),
(510, '/solicitacaouser/detalhes', 1),
(511, '/relatorio', 1),
(512, '/app', 4),
(513, '/usuario', 4),
(514, '/usuario/add', 4),
(515, '/usuario/edit', 4),
(516, '/unidademedida', 4),
(517, '/unidademedida/add', 4),
(518, '/unidademedida/edit', 4),
(519, '/fornecedor', 4),
(520, '/fornecedor/add', 4),
(521, '/fornecedor/edit', 4),
(522, '/produto', 4),
(523, '/produto/add', 4),
(524, '/produto/edit', 4),
(525, '/contrato', 4),
(526, '/contrato/add', 4),
(527, '/contrato/edit', 4),
(528, '/contrato/fornecedor', 4),
(529, '/contrato/aditivos', 4),
(530, '/contrato/aditivo/add', 4),
(531, '/contrato/aditivo/edit', 4),
(532, '/contrato/aditivos/itens', 4),
(533, '/contrato/itens', 4),
(534, '/ordemservico', 4),
(535, '/ordemservico/add', 4),
(536, '/estoque', 4),
(537, '/entrada', 4),
(538, '/solicitacao', 4),
(539, '/solicitacao/detalhes', 4),
(540, '/saida', 4),
(541, '/saida/add', 4),
(542, '/saida/detalhes', 4),
(543, '/solicitacaouser', 4),
(544, '/solicitacaouser/add', 4),
(545, '/solicitacaouser/edit', 4),
(546, '/solicitacaouser/detalhes', 4),
(547, '/relatorio', 4),
(548, '/app', 3),
(549, '/usuario', 3),
(550, '/usuario/add', 3),
(551, '/usuario/edit', 3),
(552, '/unidademedida', 3),
(553, '/unidademedida/add', 3),
(554, '/unidademedida/edit', 3),
(555, '/fornecedor', 3),
(556, '/fornecedor/add', 3),
(557, '/fornecedor/edit', 3),
(558, '/produto', 3),
(559, '/produto/add', 3),
(560, '/produto/edit', 3),
(561, '/contrato', 3),
(562, '/contrato/add', 3),
(563, '/contrato/edit', 3),
(564, '/contrato/fornecedor', 3),
(565, '/contrato/aditivos', 3),
(566, '/contrato/aditivo/add', 3),
(567, '/contrato/aditivo/edit', 3),
(568, '/contrato/aditivos/itens', 3),
(569, '/contrato/itens', 3),
(570, '/ordemservico', 3),
(571, '/ordemservico/add', 3),
(572, '/estoque', 3),
(573, '/entrada', 3),
(574, '/solicitacao', 3),
(575, '/solicitacao/detalhes', 3),
(576, '/saida', 3),
(577, '/saida/add', 3),
(578, '/saida/detalhes', 3),
(579, '/solicitacaouser', 3),
(580, '/solicitacaouser/add', 3),
(581, '/solicitacaouser/edit', 3),
(582, '/solicitacaouser/detalhes', 3),
(583, '/relatorio', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aditivo`
--
ALTER TABLE `aditivo`
  ADD PRIMARY KEY (`idaditivo`),
  ADD KEY `fk_aditivo_compra1_idx` (`idcontrato`);

--
-- Indexes for table `cidade`
--
ALTER TABLE `cidade`
  ADD PRIMARY KEY (`idcidade`),
  ADD KEY `fk_cidade_uf_idx` (`iduf`);

--
-- Indexes for table `contrato`
--
ALTER TABLE `contrato`
  ADD PRIMARY KEY (`idcontrato`),
  ADD KEY `fk_contrato_orgao1_idx` (`idorgao`);

--
-- Indexes for table `empenho_contrato`
--
ALTER TABLE `empenho_contrato`
  ADD PRIMARY KEY (`idempenho_contrato`);

--
-- Indexes for table `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD PRIMARY KEY (`idfornecedor`),
  ADD KEY `fk_fornecedor_cidade1_idx` (`idcidade`);

--
-- Indexes for table `fornecedor_contrato`
--
ALTER TABLE `fornecedor_contrato`
  ADD PRIMARY KEY (`idfornecedor_contrato`),
  ADD KEY `fk_fornecedor_has_contrato_contrato1_idx` (`idcontrato`),
  ADD KEY `fk_fornecedor_has_contrato_fornecedor1_idx` (`idfornecedor`);

--
-- Indexes for table `itens_aditivo`
--
ALTER TABLE `itens_aditivo`
  ADD PRIMARY KEY (`iditens_aditivo`),
  ADD KEY `fk_itens_aditivo_aditivo1_idx` (`idaditivo`),
  ADD KEY `fk_itens_aditivo_unidade_medida1_idx` (`idunidade_medida`);

--
-- Indexes for table `itens_contrato`
--
ALTER TABLE `itens_contrato`
  ADD PRIMARY KEY (`iditens_contrato`),
  ADD KEY `fk_itens_contrato_contrato1_idx` (`idcontrato`),
  ADD KEY `fk_itens_contrato_unidade_medida1_idx` (`idunidade_medida`),
  ADD KEY `idfornecedor` (`idfornecedor`);

--
-- Indexes for table `itens_ordem_servico`
--
ALTER TABLE `itens_ordem_servico`
  ADD PRIMARY KEY (`iditens_ordem_servico`),
  ADD KEY `fk_itens_ordem_servico_ordem_servico1_idx` (`idordem_servico`),
  ADD KEY `fk_itens_ordem_servico_unidade_medida1_idx` (`idunidade_medida`);

--
-- Indexes for table `ordem_servico`
--
ALTER TABLE `ordem_servico`
  ADD PRIMARY KEY (`idordem_servico`);

--
-- Indexes for table `orgao`
--
ALTER TABLE `orgao`
  ADD PRIMARY KEY (`idorgao`);

--
-- Indexes for table `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`idproduto`),
  ADD KEY `fk_produto_fornecedor1_idx` (`idfornecedor`),
  ADD KEY `fk_produto_unidade_medida1_idx` (`idunidade_medida`);

--
-- Indexes for table `saida`
--
ALTER TABLE `saida`
  ADD PRIMARY KEY (`idsaida`);

--
-- Indexes for table `saida_produto`
--
ALTER TABLE `saida_produto`
  ADD PRIMARY KEY (`idsaida_produto`),
  ADD KEY `fk_saida_has_produto_produto1_idx` (`produto_idproduto`),
  ADD KEY `fk_saida_has_produto_saida1_idx` (`saida_idsaida`);

--
-- Indexes for table `setor`
--
ALTER TABLE `setor`
  ADD PRIMARY KEY (`idsetor`);

--
-- Indexes for table `solicitacao`
--
ALTER TABLE `solicitacao`
  ADD PRIMARY KEY (`idsolicitacao`);

--
-- Indexes for table `solicitacao_produto`
--
ALTER TABLE `solicitacao_produto`
  ADD PRIMARY KEY (`idsolicitacao_produto`),
  ADD KEY `fk_solicitacao_has_produto_produto1_idx` (`idproduto`),
  ADD KEY `fk_solicitacao_has_produto_solicitacao1_idx` (`idsolicitacao`);

--
-- Indexes for table `uf`
--
ALTER TABLE `uf`
  ADD PRIMARY KEY (`iduf`);

--
-- Indexes for table `unidade_medida`
--
ALTER TABLE `unidade_medida`
  ADD PRIMARY KEY (`idunidade_medida`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`);

--
-- Indexes for table `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  ADD PRIMARY KEY (`idusuario_permissao`),
  ADD KEY `idusuario` (`idusuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aditivo`
--
ALTER TABLE `aditivo`
  MODIFY `idaditivo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `cidade`
--
ALTER TABLE `cidade`
  MODIFY `idcidade` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `contrato`
--
ALTER TABLE `contrato`
  MODIFY `idcontrato` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `empenho_contrato`
--
ALTER TABLE `empenho_contrato`
  MODIFY `idempenho_contrato` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `idfornecedor` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `fornecedor_contrato`
--
ALTER TABLE `fornecedor_contrato`
  MODIFY `idfornecedor_contrato` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `itens_aditivo`
--
ALTER TABLE `itens_aditivo`
  MODIFY `iditens_aditivo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `itens_contrato`
--
ALTER TABLE `itens_contrato`
  MODIFY `iditens_contrato` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `itens_ordem_servico`
--
ALTER TABLE `itens_ordem_servico`
  MODIFY `iditens_ordem_servico` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `ordem_servico`
--
ALTER TABLE `ordem_servico`
  MODIFY `idordem_servico` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `orgao`
--
ALTER TABLE `orgao`
  MODIFY `idorgao` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `produto`
--
ALTER TABLE `produto`
  MODIFY `idproduto` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `saida`
--
ALTER TABLE `saida`
  MODIFY `idsaida` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `saida_produto`
--
ALTER TABLE `saida_produto`
  MODIFY `idsaida_produto` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `setor`
--
ALTER TABLE `setor`
  MODIFY `idsetor` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `solicitacao`
--
ALTER TABLE `solicitacao`
  MODIFY `idsolicitacao` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `solicitacao_produto`
--
ALTER TABLE `solicitacao_produto`
  MODIFY `idsolicitacao_produto` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `uf`
--
ALTER TABLE `uf`
  MODIFY `iduf` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `unidade_medida`
--
ALTER TABLE `unidade_medida`
  MODIFY `idunidade_medida` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  MODIFY `idusuario_permissao` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=584;
--
-- Constraints for dumped tables
--

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
-- Constraints for table `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_produto_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_produto_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `saida_produto`
--
ALTER TABLE `saida_produto`
  ADD CONSTRAINT `fk_saida_has_produto_produto1` FOREIGN KEY (`produto_idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_saida_has_produto_saida1` FOREIGN KEY (`saida_idsaida`) REFERENCES `saida` (`idsaida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `solicitacao_produto`
--
ALTER TABLE `solicitacao_produto`
  ADD CONSTRAINT `fk_solicitacao_has_produto_produto1` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_solicitacao_has_produto_solicitacao1` FOREIGN KEY (`idsolicitacao`) REFERENCES `solicitacao` (`idsolicitacao`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  ADD CONSTRAINT `usuario_permissao_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);
