-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: 29-Set-2015 às 18:07
-- Versão do servidor: 5.5.42
-- PHP Version: 5.6.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `secc`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `aditivo`
--

CREATE TABLE `aditivo` (
  `idaditivo` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL,
  `numero` varchar(45) DEFAULT NULL,
  `validade` date DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `obs` text
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `aditivo`
--

INSERT INTO `aditivo` (`idaditivo`, `idcontrato`, `numero`, `validade`, `valor`, `obs`) VALUES
(1, 9, '1332444', '2015-09-20', '10000.00', 'teste 2'),
(5, 9, '2323', '2015-09-09', '10000.00', NULL),
(6, 7, '9988726', '2015-09-09', '12500.00', 'Teste observação.'),
(7, 7, '11225533', '2015-09-00', '5500.00', 'oi'),
(8, 10, '12344556', '2016-09-09', '121313.12', 'Fase 2');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cidade`
--

CREATE TABLE `cidade` (
  `idcidade` int(11) NOT NULL,
  `iduf` int(11) NOT NULL,
  `nome` varchar(150) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `cidade`
--

INSERT INTO `cidade` (`idcidade`, `iduf`, `nome`) VALUES
(1, 1, 'Rio Branco');

-- --------------------------------------------------------

--
-- Estrutura da tabela `contrato`
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `contrato`
--

INSERT INTO `contrato` (`idcontrato`, `idorgao`, `tipo`, `tipoobjetos`, `numerotali`, `dataassinaturatali`, `numeroata`, `numeropregao`, `numeroprocesso`, `validadeata`, `numerocd`, `numeroparecerjuridico`, `datacompra`, `numerocontrato`, `objeto`, `valor`, `validade`, `dataassinatura`, `numeroempenho`) VALUES
(7, 1, 1, 2, '45345', '2015-09-29', '98989', '878787', '09880', '2015-09-29', NULL, NULL, '0000-00-00', '5552243', 'obj', '1200.00', '2015-09-29', '2015-09-29', '234234'),
(9, NULL, 3, 1, NULL, '0000-00-00', NULL, NULL, NULL, '0000-00-00', '111111', '12345', '2015-09-20', '111111', 'obj', '100000.98', '2015-09-20', '2015-09-20', '23234'),
(10, 1, 1, 1, '123456', '2015-09-09', '4321', 'PRP 123', '321', '2016-09-09', NULL, NULL, '0000-00-00', '2112', 'Contratação de material de consumo', '123.45', '2016-09-09', '2015-09-09', '2121');

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor`
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `fornecedor`
--

INSERT INTO `fornecedor` (`idfornecedor`, `idcidade`, `razaosocial`, `cnpj`, `cep`, `logradouro`, `numero`, `complemento`, `bairro`, `telefone`, `celular`, `email`, `responsavel`) VALUES
(2, 1, 'TARC Tecnologia', '11444777000161', '69900643', 'Rua Dom Bosco', 89, NULL, 'Bosque', '6832248204', '6899487908', 'thiagoarc@gmail.com', 'Thiago Chaves'),
(3, 1, 'Kambo Tecnologia', '12345678910110', '69900643', 'Rua Bartolomeu Bueno', 89, NULL, 'Bosque', '6832248204', '6899487908', 'thiagoarc@gmail.com', 'Thiago Chaves'),
(4, 1, 'Mil Presentes', '53534757000121', '69900000', 'Rua do Centro', 90, 'e', 'Centro', '6832255555', '6899009988', 'milton@gmail.com', 'Milton Cruz');

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor_contrato`
--

CREATE TABLE `fornecedor_contrato` (
  `idfornecedor_contrato` int(11) NOT NULL,
  `idfornecedor` int(11) NOT NULL,
  `idcontrato` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `fornecedor_contrato`
--

INSERT INTO `fornecedor_contrato` (`idfornecedor_contrato`, `idfornecedor`, `idcontrato`) VALUES
(1, 3, 9),
(2, 4, 7),
(3, 2, 7),
(4, 2, 9),
(5, 4, 9),
(8, 3, 10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_aditivo`
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `itens_aditivo`
--

INSERT INTO `itens_aditivo` (`iditens_aditivo`, `idaditivo`, `idunidade_medida`, `descricao`, `qtd`, `valorunitario`, `idfornecedor`, `qtdordem`) VALUES
(6, 5, 1, 'Pendrive de 256gb', 10, '1000.00', 3, 0),
(8, 1, 1, 'Pendrive de 256gb', 20, '1000.00', 3, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_contrato`
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
-- Extraindo dados da tabela `itens_contrato`
--

INSERT INTO `itens_contrato` (`iditens_contrato`, `idcontrato`, `descricao`, `qtd`, `valorunitario`, `idunidade_medida`, `idfornecedor`, `qtdordem`) VALUES
(1, 9, 'Pendrive de 256gb', 20, '1000.00', 1, 3, 0),
(2, 10, 'Borracha de Silicone', 25, '2.50', 1, 3, 0),
(9, 10, 'Apontador Faber Castel Preto', 25, '1.00', 1, 3, 0),
(10, 10, 'Mouse sem fio - Microsoft', 1, '25.00', 1, 3, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_ordem_servico`
--

CREATE TABLE `itens_ordem_servico` (
  `iditens_ordem_servico` int(11) NOT NULL,
  `idordem_servico` int(11) NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `qtd` int(11) DEFAULT NULL,
  `valorunitario` decimal(10,2) DEFAULT NULL,
  `idunidade_medida` int(11) NOT NULL,
  `iditem_contratoaditivo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ordem_servico`
--

CREATE TABLE `ordem_servico` (
  `idordem_servico` int(11) NOT NULL,
  `datasolicitacao` date DEFAULT NULL,
  `idcontratoaditivo` int(11) DEFAULT NULL,
  `tipo` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `orgao`
--

CREATE TABLE `orgao` (
  `idorgao` int(11) NOT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  `nome` varchar(150) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `orgao`
--

INSERT INTO `orgao` (`idorgao`, `sigla`, `nome`) VALUES
(1, 'SAI', 'Secretaria de Articulação Institucional');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`idproduto`, `idfornecedor`, `idunidade_medida`, `descricao`, `valorunitario`, `qtdminima`, `qtdatual`, `datacadastro`, `dataatualizacao`, `idusuario`) VALUES
(1, 2, 1, 'Caneta BIC', '10.00', 1, -45, '2015-09-21 00:00:00', '2015-09-21 00:00:00', 1),
(4, 2, 2, 'Borracha BIC', '15.00', 3, 12, '2015-09-21 00:00:00', '2015-09-21 16:36:49', 1),
(5, 2, 2, 'Apontador BIC', '25.00', 5, -45, '2015-09-21 00:00:00', '2015-09-21 00:00:00', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `saida`
--

CREATE TABLE `saida` (
  `idsaida` int(11) NOT NULL,
  `datasaida` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `saida_produto`
--

CREATE TABLE `saida_produto` (
  `idsaida_produto` int(11) NOT NULL,
  `saida_idsaida` int(11) NOT NULL,
  `produto_idproduto` int(11) NOT NULL,
  `qtd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `setor`
--

CREATE TABLE `setor` (
  `idsetor` int(11) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `sigla` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `setor`
--

INSERT INTO `setor` (`idsetor`, `nome`, `sigla`) VALUES
(1, 'Desenvolvimento de Sistemas', 'DSIS');

-- --------------------------------------------------------

--
-- Estrutura da tabela `solicitacao`
--

CREATE TABLE `solicitacao` (
  `idsolicitacao` int(11) NOT NULL,
  `datasolicitacao` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `deferido` varchar(3) DEFAULT 'agu',
  `motivo` varchar(250) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `solicitacao`
--

INSERT INTO `solicitacao` (`idsolicitacao`, `datasolicitacao`, `idusuario`, `deferido`, `motivo`) VALUES
(1, '2015-09-21 00:00:00', 1, 'sim', NULL),
(2, '2015-09-24 00:00:00', 1, 'agu', ''),
(5, '2015-09-22 11:36:55', 1, 'nao', 'Acabou o Estoque.'),
(6, '2015-09-29 10:57:53', 1, 'agu', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `solicitacao_produto`
--

CREATE TABLE `solicitacao_produto` (
  `idsolicitacao_produto` int(11) NOT NULL,
  `idsolicitacao` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `qtd` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `motivo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `solicitacao_produto`
--

INSERT INTO `solicitacao_produto` (`idsolicitacao_produto`, `idsolicitacao`, `idproduto`, `qtd`, `status`, `motivo`) VALUES
(8, 5, 5, 2, 0, NULL),
(10, 5, 4, 10, 0, NULL),
(11, 5, 1, 4, 0, NULL),
(12, 2, 1, 5, 0, NULL),
(13, 2, 5, 5, 0, NULL),
(14, 6, 1, 20, 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `uf`
--

CREATE TABLE `uf` (
  `iduf` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `uf`
--

INSERT INTO `uf` (`iduf`, `nome`) VALUES
(1, 'ACRE');

-- --------------------------------------------------------

--
-- Estrutura da tabela `unidade_medida`
--

CREATE TABLE `unidade_medida` (
  `idunidade_medida` int(11) NOT NULL,
  `sigla` varchar(20) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `unidade_medida`
--

INSERT INTO `unidade_medida` (`idunidade_medida`, `sigla`, `descricao`) VALUES
(1, 'UN', 'Unidade'),
(2, 'KG', 'Quilograma'),
(3, 'M', 'Metro'),
(4, 'CM', 'Centimetro');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) unsigned NOT NULL,
  `nome` varchar(60) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varchar(60) DEFAULT NULL,
  `perfil` int(11) DEFAULT NULL,
  `liberado` int(11) DEFAULT '1',
  `idsetor` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nome`, `email`, `senha`, `perfil`, `liberado`, `idsetor`) VALUES
(1, 'Jaisson Santos', 'jaissonssantos@gmail.com', 'ab5f505601d22946514ef4de8a45345574e7414b', 1, 1, 1),
(2, 'Gestor de Contrato', 'gestor@ac.gov.br', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 3, 1, 1),
(3, 'Thiago Chaves', 'thiagoarc@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1, 1),
(4, 'Richard Oliveira', 'richardzero@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 1, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_permissao`
--

CREATE TABLE `usuario_permissao` (
  `idusuario_permissao` int(11) unsigned NOT NULL,
  `roles` varchar(40) DEFAULT NULL,
  `idusuario` int(11) unsigned DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `usuario_permissao`
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
(83, '/relatorio', 4),
(84, '/solicitacaouser', 1),
(85, '/solicitacaouser', 2),
(86, '/solicitacaouser', 3),
(87, '/solicitacaouser', 4),
(88, '/solicitacaouser/add', 1),
(89, '/solicitacaouser/add', 2),
(90, '/solicitacaouser/add', 3),
(91, '/solicitacaouser/add', 4),
(92, '/solicitacaouser/edit', 1),
(93, '/solicitacaouser/edit', 2),
(94, '/solicitacaouser/edit', 3),
(95, '/solicitacaouser/edit', 4),
(96, '/solicitacao', 1),
(97, '/solicitacao', 2),
(98, '/solicitacao', 3),
(99, '/solicitacao', 4),
(100, '/solicitacao/detalhes', 1),
(101, '/solicitacao/detalhes', 2),
(102, '/solicitacao/detalhes', 3),
(103, '/solicitacao/detalhes', 4);

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
  MODIFY `idaditivo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `cidade`
--
ALTER TABLE `cidade`
  MODIFY `idcidade` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `contrato`
--
ALTER TABLE `contrato`
  MODIFY `idcontrato` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `fornecedor`
--
ALTER TABLE `fornecedor`
  MODIFY `idfornecedor` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `fornecedor_contrato`
--
ALTER TABLE `fornecedor_contrato`
  MODIFY `idfornecedor_contrato` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `itens_aditivo`
--
ALTER TABLE `itens_aditivo`
  MODIFY `iditens_aditivo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `itens_contrato`
--
ALTER TABLE `itens_contrato`
  MODIFY `iditens_contrato` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `itens_ordem_servico`
--
ALTER TABLE `itens_ordem_servico`
  MODIFY `iditens_ordem_servico` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `ordem_servico`
--
ALTER TABLE `ordem_servico`
  MODIFY `idordem_servico` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `orgao`
--
ALTER TABLE `orgao`
  MODIFY `idorgao` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `produto`
--
ALTER TABLE `produto`
  MODIFY `idproduto` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `saida`
--
ALTER TABLE `saida`
  MODIFY `idsaida` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `saida_produto`
--
ALTER TABLE `saida_produto`
  MODIFY `idsaida_produto` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `setor`
--
ALTER TABLE `setor`
  MODIFY `idsetor` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `solicitacao`
--
ALTER TABLE `solicitacao`
  MODIFY `idsolicitacao` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
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
  MODIFY `idunidade_medida` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  MODIFY `idusuario_permissao` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=104;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `aditivo`
--
ALTER TABLE `aditivo`
  ADD CONSTRAINT `fk_aditivo_contrato` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `cidade`
--
ALTER TABLE `cidade`
  ADD CONSTRAINT `fk_cidade_uf` FOREIGN KEY (`iduf`) REFERENCES `uf` (`iduf`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `fornecedor`
--
ALTER TABLE `fornecedor`
  ADD CONSTRAINT `fk_fornecedor_cidade1` FOREIGN KEY (`idcidade`) REFERENCES `cidade` (`idcidade`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `fornecedor_contrato`
--
ALTER TABLE `fornecedor_contrato`
  ADD CONSTRAINT `fk_fornecedor_has_contrato_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_fornecedor_has_contrato_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `itens_aditivo`
--
ALTER TABLE `itens_aditivo`
  ADD CONSTRAINT `fk_itens_aditivo_aditivo1` FOREIGN KEY (`idaditivo`) REFERENCES `aditivo` (`idaditivo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_aditivo_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `itens_contrato`
--
ALTER TABLE `itens_contrato`
  ADD CONSTRAINT `fk_itens_contrato_contrato1` FOREIGN KEY (`idcontrato`) REFERENCES `contrato` (`idcontrato`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_contrato_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `itens_contrato_ibfk_1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `itens_ordem_servico`
--
ALTER TABLE `itens_ordem_servico`
  ADD CONSTRAINT `fk_itens_ordem_servico_ordem_servico1` FOREIGN KEY (`idordem_servico`) REFERENCES `ordem_servico` (`idordem_servico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_itens_ordem_servico_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `fk_produto_fornecedor1` FOREIGN KEY (`idfornecedor`) REFERENCES `fornecedor` (`idfornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_produto_unidade_medida1` FOREIGN KEY (`idunidade_medida`) REFERENCES `unidade_medida` (`idunidade_medida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `saida_produto`
--
ALTER TABLE `saida_produto`
  ADD CONSTRAINT `fk_saida_has_produto_produto1` FOREIGN KEY (`produto_idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_saida_has_produto_saida1` FOREIGN KEY (`saida_idsaida`) REFERENCES `saida` (`idsaida`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `solicitacao_produto`
--
ALTER TABLE `solicitacao_produto`
  ADD CONSTRAINT `fk_solicitacao_has_produto_produto1` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_solicitacao_has_produto_solicitacao1` FOREIGN KEY (`idsolicitacao`) REFERENCES `solicitacao` (`idsolicitacao`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  ADD CONSTRAINT `usuario_permissao_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);
