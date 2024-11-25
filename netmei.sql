-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 25-Nov-2024 às 17:44
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `netmei`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `categoria`) VALUES
(1, 'Comércio de alimentos'),
(2, 'Serviços de cabeleireiro'),
(3, 'Reparação de eletrônicos'),
(4, 'Manutenção de veículos'),
(5, 'Artesanato'),
(6, 'Consultoria empresarial'),
(7, 'Serviços de construção'),
(8, 'Aulas particulares'),
(9, 'Design gráfico'),
(10, 'Desenvolvimento de software'),
(11, 'Venda de roupas'),
(12, 'Produção de eventos'),
(13, 'Fotografia'),
(14, 'Serviços de limpeza'),
(15, 'Serviços de jardinagem'),
(16, 'Marcenaria'),
(17, 'Serviços de contabilidade'),
(18, 'Marketing digital'),
(19, 'Vendas online'),
(20, 'Serviços de estética');

-- --------------------------------------------------------

--
-- Estrutura da tabela `mei`
--

CREATE TABLE `mei` (
  `id_mei` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `cnpj` varchar(50) DEFAULT NULL,
  `facebook` varchar(50) DEFAULT NULL,
  `instagram` varchar(50) DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `FK_categoria_id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `mei`
--

INSERT INTO `mei` (`id_mei`, `nome`, `cnpj`, `facebook`, `instagram`, `endereco`, `FK_categoria_id_categoria`) VALUES
(2, 'Loja Escura', '91259128', 'ALojaEscura', 'ALojaMaisEscura', 'Esgoto', 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `mei_produto`
--

CREATE TABLE `mei_produto` (
  `FK_mei_id_mei` int(11) DEFAULT NULL,
  `FK_produto_id_produto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `permissao`
--

CREATE TABLE `permissao` (
  `id_permissao` int(11) NOT NULL,
  `permissao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `permissao`
--

INSERT INTO `permissao` (`id_permissao`, `permissao`) VALUES
(1, 'mei'),
(2, 'user'),
(3, 'adm');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL,
  `nome_produto` varchar(50) DEFAULT NULL,
  `quantidade` varchar(100) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `Nome`, `email`, `senha`, `telefone`) VALUES
(3, 'Thiago', 'thigas@gmail.com', '123', '19 998602493'),
(4, 'Guilherme', 'guelerme@gmail.com', '123', '18238152'),
(5, 'Daniel', 'daniel@gmail.com', '123', '19243892185');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_avalia_mei`
--

CREATE TABLE `usuario_avalia_mei` (
  `FK_usuario_id_usuario` int(11) DEFAULT NULL,
  `FK_mei_id_mei` int(11) DEFAULT NULL,
  `id_avaliacao` int(11) NOT NULL,
  `data_avaliacao` date DEFAULT NULL,
  `avaliacao` int(11) DEFAULT NULL,
  `comentario` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_mei`
--

CREATE TABLE `usuario_mei` (
  `id_usuariomei` int(11) NOT NULL,
  `FK_usuario_id_usuario` int(11) DEFAULT NULL,
  `FK_mei_id_mei` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `usuario_mei`
--

INSERT INTO `usuario_mei` (`id_usuariomei`, `FK_usuario_id_usuario`, `FK_mei_id_mei`) VALUES
(8, 4, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_permissao`
--

CREATE TABLE `usuario_permissao` (
  `id_relacao` int(11) NOT NULL,
  `id_permissao_id` int(11) NOT NULL,
  `id_usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `usuario_permissao`
--

INSERT INTO `usuario_permissao` (`id_relacao`, `id_permissao_id`, `id_usuario_id`) VALUES
(1, 2, 3),
(2, 1, 4),
(3, 3, 5);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Índices para tabela `mei`
--
ALTER TABLE `mei`
  ADD PRIMARY KEY (`id_mei`),
  ADD KEY `FK_categoria` (`FK_categoria_id_categoria`);

--
-- Índices para tabela `mei_produto`
--
ALTER TABLE `mei_produto`
  ADD KEY `FK_mei_produto_0` (`FK_mei_id_mei`),
  ADD KEY `FK_mei_produto_1` (`FK_produto_id_produto`);

--
-- Índices para tabela `permissao`
--
ALTER TABLE `permissao`
  ADD PRIMARY KEY (`id_permissao`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_produto`);

--
-- Índices para tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Índices para tabela `usuario_avalia_mei`
--
ALTER TABLE `usuario_avalia_mei`
  ADD PRIMARY KEY (`id_avaliacao`),
  ADD KEY `FK_usuario_avalia_mei_1` (`FK_usuario_id_usuario`),
  ADD KEY `FK_usuario_avalia_mei_2` (`FK_mei_id_mei`);

--
-- Índices para tabela `usuario_mei`
--
ALTER TABLE `usuario_mei`
  ADD PRIMARY KEY (`id_usuariomei`),
  ADD KEY `FK_usuario_mei_0` (`FK_usuario_id_usuario`),
  ADD KEY `FK_usuario_mei_1` (`FK_mei_id_mei`);

--
-- Índices para tabela `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  ADD PRIMARY KEY (`id_relacao`),
  ADD KEY `FK_usuario_permissao` (`id_usuario_id`),
  ADD KEY `FK_permissao` (`id_permissao_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `mei`
--
ALTER TABLE `mei`
  MODIFY `id_mei` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `permissao`
--
ALTER TABLE `permissao`
  MODIFY `id_permissao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id_produto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `usuario_avalia_mei`
--
ALTER TABLE `usuario_avalia_mei`
  MODIFY `id_avaliacao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `usuario_mei`
--
ALTER TABLE `usuario_mei`
  MODIFY `id_usuariomei` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  MODIFY `id_relacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `mei`
--
ALTER TABLE `mei`
  ADD CONSTRAINT `FK_categoria` FOREIGN KEY (`FK_categoria_id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `mei_produto`
--
ALTER TABLE `mei_produto`
  ADD CONSTRAINT `FK_mei_produto_0` FOREIGN KEY (`FK_mei_id_mei`) REFERENCES `mei` (`id_mei`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mei_produto_1` FOREIGN KEY (`FK_produto_id_produto`) REFERENCES `produto` (`id_produto`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limitadores para a tabela `usuario_avalia_mei`
--
ALTER TABLE `usuario_avalia_mei`
  ADD CONSTRAINT `FK_usuario_avalia_mei_1` FOREIGN KEY (`FK_usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `FK_usuario_avalia_mei_2` FOREIGN KEY (`FK_mei_id_mei`) REFERENCES `mei` (`id_mei`);

--
-- Limitadores para a tabela `usuario_mei`
--
ALTER TABLE `usuario_mei`
  ADD CONSTRAINT `FK_usuario_mei_0` FOREIGN KEY (`FK_usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `FK_usuario_mei_1` FOREIGN KEY (`FK_mei_id_mei`) REFERENCES `mei` (`id_mei`);

--
-- Limitadores para a tabela `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  ADD CONSTRAINT `FK_permissao` FOREIGN KEY (`id_permissao_id`) REFERENCES `permissao` (`id_permissao`),
  ADD CONSTRAINT `FK_usuario_permissao` FOREIGN KEY (`id_usuario_id`) REFERENCES `usuario` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
