-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 02-Dez-2024 às 12:35
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
  `FK_categoria_id_categoria` int(11) NOT NULL,
  `media_avaliacao` decimal(3,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `mei`
--

INSERT INTO `mei` (`id_mei`, `nome`, `cnpj`, `facebook`, `instagram`, `endereco`, `FK_categoria_id_categoria`, `media_avaliacao`) VALUES
(3, 'Loja Escura', '81562727', 'LojaMuitoEscura', 'ALojaMaisEscura', 'Brooklyn', 5, '3.33'),
(4, 'Daniel', '199982852', 'thigaslegal', 'thigas0606', 'esgoto', 10, '3.50'),
(6, 'legal', 'legal', 'legal', 'esgoto', '0,00', 8, '0.00'),
(7, 'pedro', '123123123', 'pedroamalfi', 'pedro_amalfi', 'rua do bobo', 12, '0.00'),
(8, 'pedro', 'pedrolaws', 'pedro_laws', 'brooklyn', '0,00', 4, '0.00'),
(13, 'sapato', '123456789', 'sapatos.web', 'WebSapato', 'sapataria', 19, '0.00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `mei_produto`
--

CREATE TABLE `mei_produto` (
  `FK_mei_id_mei` int(11) DEFAULT NULL,
  `FK_produto_id_produto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `mei_produto`
--

INSERT INTO `mei_produto` (`FK_mei_id_mei`, `FK_produto_id_produto`) VALUES
(13, 1),
(13, 5);

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

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`id_produto`, `nome_produto`, `quantidade`, `valor`) VALUES
(1, 'Sapato', '50', '259.90'),
(2, 'Chinelo', '100', '49.90'),
(3, 'aa', '32', '312.00'),
(4, '5126', '216', '62612.00'),
(5, 'ABC', '100', '49.90');

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
(5, 'Daniel', 'daniel@gmail.com', '123', '19243892185'),
(6, 'ronnie coleman', 'ricoemmelanina@gmail.com', '123', '+55 19 1929562'),
(7, 'pedro', 'pedroamalfi@gmail.com', '123', '19 945345435'),
(10, 'Sapatos', 'arroz@gmail.com', '321', '199925892'),
(12, 'cbum', 'trembolona@gmail.com', '123', '+55 19 98925919');

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

--
-- Extraindo dados da tabela `usuario_avalia_mei`
--

INSERT INTO `usuario_avalia_mei` (`FK_usuario_id_usuario`, `FK_mei_id_mei`, `id_avaliacao`, `data_avaliacao`, `avaliacao`, `comentario`) VALUES
(3, 3, 1, '2024-11-28', 5, 'Muito bom!'),
(3, 4, 2, '2024-11-28', 5, 'Bom demais zé'),
(3, 3, 3, '2024-11-30', 3, 'Ficou meio mid');

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
-- Estrutura da tabela `usuario_mei`
--

CREATE TABLE `usuario_mei` (
  `FK_usuario_id_usuario` int(11) DEFAULT NULL,
  `FK_mei_id_mei` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `usuario_mei`
--

INSERT INTO `usuario_mei` (`FK_usuario_id_usuario`, `FK_mei_id_mei`) VALUES
(5, 4),
(6, 6),
(7, 7),
(7, 8),
(10, 13);

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
(3, 3, 5),
(4, 2, 6),
(5, 2, 7),
(8, 1, 10),
(10, 1, 12);

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
  MODIFY `id_mei` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `permissao`
--
ALTER TABLE `permissao`
  MODIFY `id_permissao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id_produto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `usuario_avalia_mei`
--
ALTER TABLE `usuario_avalia_mei`
  MODIFY `id_avaliacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `usuario_permissao`
--
ALTER TABLE `usuario_permissao`
  MODIFY `id_relacao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  ADD CONSTRAINT `FK_usuario_mei_1` FOREIGN KEY (`FK_mei_id_mei`) REFERENCES `mei` (`id_mei`) ON DELETE SET NULL ON UPDATE CASCADE;

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
