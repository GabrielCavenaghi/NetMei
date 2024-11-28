-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 29/11/2024 às 00:28
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

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
-- Estrutura para tabela `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categoria`
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
-- Estrutura para tabela `mei`
--

CREATE TABLE `mei` (
  `id_mei` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `cnpj` varchar(50) DEFAULT NULL,
  `facebook` varchar(50) DEFAULT NULL,
  `instagram` varchar(50) DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `FK_categoria_id_categoria` int(11) NOT NULL,
  `media_avaliacao` decimal(3,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `mei`
--

INSERT INTO `mei` (`id_mei`, `nome`, `cnpj`, `facebook`, `instagram`, `endereco`, `FK_categoria_id_categoria`, `media_avaliacao`) VALUES
(3, 'Loja Escura', '81562727', 'LojaMuitoEscura', 'ALojaMaisEscura', 'Brooklyn', 5, 3.33),
(4, 'Daniel', '199982852', 'thigaslegal', 'thigas0606', 'esgoto', 10, 3.50),
(5, 'sr_de_engenho', '2314234', 'eeee', 'aaaa', 'sapato', 13, 2.00),
(6, 'sr_de_engenho', '324453345', 'sdv', 'aszxczsdc', 'asdasd', 8, 0.00),
(7, 'pedro', '123123123', 'pedroamalfi', 'pedro_amalfi', 'rua do bobo', 12, 0.00),
(8, 'pedro', '12312313', 'asfsfsafaws', 'asdcdcsasca', 'afssfasfa', 4, 0.00),
(10, 'wqe', 'ca', 'caacac', 'wwd', 'aw', 20, 0.00),
(11, 'wqe', '214125', '6216521', '21621', '62162', 4, 0.00),
(12, 'wqe', 'avwvawd', 'vwadv', 'vdwvawdva', 'vwadvawd', 8, 0.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `mei_produto`
--

CREATE TABLE `mei_produto` (
  `FK_mei_id_mei` int(11) DEFAULT NULL,
  `FK_produto_id_produto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `permissao`
--

CREATE TABLE `permissao` (
  `id_permissao` int(11) NOT NULL,
  `permissao` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `permissao`
--

INSERT INTO `permissao` (`id_permissao`, `permissao`) VALUES
(1, 'mei'),
(2, 'user'),
(3, 'adm');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL,
  `nome_produto` varchar(50) DEFAULT NULL,
  `quantidade` varchar(100) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `senha` varchar(50) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `Nome`, `email`, `senha`, `telefone`) VALUES
(3, 'Thiago', 'thigas@gmail.com', '123', '19 998602493'),
(4, 'Guilherme', 'guelerme@gmail.com', '123', '18238152'),
(5, 'Daniel', 'daniel@gmail.com', '123', '19243892185'),
(6, 'sr_de_engenho', 'ricoemmelanina@gmail.com', '123', '123123123'),
(7, 'pedro', 'pedroamalfi@gmail.com', '123', '19 945345435'),
(9, 'wqe', 'adsfa', '123', 'awd'),
(10, 'sapato', 'arroz@gmail.com', '123', '162521');

--
-- Acionadores `usuario`
--
DELIMITER $$
CREATE TRIGGER `trigger_previnir_email_igual` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN
  
    IF EXISTS (
        SELECT 1 
        FROM usuario 
        WHERE email = NEW.email
    ) THEN
    
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O e-mail informado já está cadastrado no sistema.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario_avalia_mei`
--

CREATE TABLE `usuario_avalia_mei` (
  `FK_usuario_id_usuario` int(11) DEFAULT NULL,
  `FK_mei_id_mei` int(11) DEFAULT NULL,
  `id_avaliacao` int(11) NOT NULL,
  `data_avaliacao` date DEFAULT NULL,
  `avaliacao` int(11) DEFAULT NULL,
  `comentario` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario_avalia_mei`
--

INSERT INTO `usuario_avalia_mei` (`FK_usuario_id_usuario`, `FK_mei_id_mei`, `id_avaliacao`, `data_avaliacao`, `avaliacao`, `comentario`) VALUES
(3, 3, 1, '2024-11-28', 5, 'Muito bom!'),
(3, 4, 2, '2024-11-28', 5, 'Bom demais zé'),
(3, 3, 3, '2024-11-30', 3, 'Ficou meio mid'),
(10, 3, 7, '2024-12-01', 2, 'Muito a melhorar!'),
(10, 5, 8, '2024-12-15', 2, 'Melhorou!'),
(10, 4, 9, '0000-00-00', 2, 'Muito a melhorar!');

--
-- Acionadores `usuario_avalia_mei`
--
DELIMITER $$
CREATE TRIGGER `atualiza_media_avaliacao` AFTER INSERT ON `usuario_avalia_mei` FOR EACH ROW BEGIN
    UPDATE mei
    SET media_avaliacao = (
        SELECT IFNULL(AVG(avaliacao), 0)
        FROM usuario_avalia_mei
        WHERE FK_mei_id_mei = NEW.FK_mei_id_mei
    )
    WHERE id_mei = NEW.FK_mei_id_mei;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `atualiza_media_avaliacao_update` AFTER UPDATE ON `usuario_avalia_mei` FOR EACH ROW BEGIN
    UPDATE mei
    SET media_avaliacao = (
        SELECT IFNULL(AVG(avaliacao), 0)
        FROM usuario_avalia_mei
        WHERE FK_mei_id_mei = NEW.FK_mei_id_mei
    )
    WHERE id_mei = NEW.FK_mei_id_mei;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario_mei`
--

CREATE TABLE `usuario_mei` (
  `FK_usuario_id_usuario` int(11) DEFAULT NULL,
  `FK_mei_id_mei` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario_mei`
--

INSERT INTO `usuario_mei` (`FK_usuario_id_usuario`, `FK_mei_id_mei`) VALUES
(5, 4),
(6, 5),
(6, 6),
(7, 7),
(7, 8),
(9, 10),
(9, 11),
(9, 12);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario_permissao`
--

CREATE TABLE `usuario_permissao` (
  `id_relacao` int(11) NOT NULL,
  `id_permissao_id` int(11) NOT NULL,
  `id_usuario_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario_permissao`
--

INSERT INTO `usuario_permissao` (`id_relacao`, `id_permissao_id`, `id_usuario_id`) VALUES
(1, 2, 3),
(2, 1, 4),
(3, 3, 5),
(4, 2, 6),
(5, 2, 7),
(7, 1, 9),
(8, 2, 10);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Índices de tabela `mei`
--
ALTER TABLE `mei`
  ADD PRIMARY KEY (`id_mei`),
  ADD KEY `FK_categoria` (`FK_categoria_id_categoria`);

--
-- Índices de tabela `mei_produto`
--
ALTER TABLE `mei_produto`
  ADD KEY `FK_mei_produto_0` (`FK_mei_id_mei`),
  ADD KEY `FK_mei_produto_1` (`FK_produto_id_produto`);

--
-- Índices de tabela `permissao`
--
ALTER TABLE `permissao`
  ADD PRIMARY KEY (`id_permissao`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_produto`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Índices de tabela `usuario_avalia_mei`
--
ALTER TABLE `usuario_avalia_mei`
  ADD PRIMARY KEY (`id_avaliacao`),
  ADD KEY `FK_usuario_avalia_mei_1` (`FK_usuario_id_usuario`),
  ADD KEY `FK_usuario_avalia_mei_2` (`FK_mei_id_mei`);

--
-- Índices de tabela `usuario_mei`
--
ALTER TABLE `usuario_mei`
  ADD KEY `FK_usuario_mei_0` (`FK_usuario_id_usuario`),
  ADD KEY `FK_usuario_mei_1` (`FK_mei_id_mei`);

--
-- Índices de tabela `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  ADD PRIMARY KEY (`id_relacao`),
  ADD KEY `FK_usuario_permissao` (`id_usuario_id`),
  ADD KEY `FK_permissao` (`id_permissao_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
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
  MODIFY `id_mei` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `usuario_avalia_mei`
--
ALTER TABLE `usuario_avalia_mei`
  MODIFY `id_avaliacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  MODIFY `id_relacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `mei`
--
ALTER TABLE `mei`
  ADD CONSTRAINT `FK_categoria` FOREIGN KEY (`FK_categoria_id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `mei_produto`
--
ALTER TABLE `mei_produto`
  ADD CONSTRAINT `FK_mei_produto_0` FOREIGN KEY (`FK_mei_id_mei`) REFERENCES `mei` (`id_mei`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mei_produto_1` FOREIGN KEY (`FK_produto_id_produto`) REFERENCES `produto` (`id_produto`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `usuario_avalia_mei`
--
ALTER TABLE `usuario_avalia_mei`
  ADD CONSTRAINT `FK_usuario_avalia_mei_1` FOREIGN KEY (`FK_usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `FK_usuario_avalia_mei_2` FOREIGN KEY (`FK_mei_id_mei`) REFERENCES `mei` (`id_mei`);

--
-- Restrições para tabelas `usuario_mei`
--
ALTER TABLE `usuario_mei`
  ADD CONSTRAINT `FK_usuario_mei_0` FOREIGN KEY (`FK_usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `FK_usuario_mei_1` FOREIGN KEY (`FK_mei_id_mei`) REFERENCES `mei` (`id_mei`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Restrições para tabelas `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  ADD CONSTRAINT `FK_permissao` FOREIGN KEY (`id_permissao_id`) REFERENCES `permissao` (`id_permissao`),
  ADD CONSTRAINT `FK_usuario_permissao` FOREIGN KEY (`id_usuario_id`) REFERENCES `usuario` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
