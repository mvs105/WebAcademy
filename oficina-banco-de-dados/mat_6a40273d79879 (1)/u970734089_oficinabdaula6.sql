-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 20/06/2026 às 15:37
-- Versão do servidor: 11.8.6-MariaDB-log
-- Versão do PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `u970734089_oficinabdaula6`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `Alunos`
--

DROP TABLE IF EXISTS `Alunos`;
CREATE TABLE `Alunos` (
  `aluno_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `Alunos`
--

INSERT INTO `Alunos` (`aluno_id`, `nome`, `email`, `data_nascimento`) VALUES
(1, 'Ana Clara', 'ana.clara@email.com', '2005-04-12'),
(2, 'Bruno Silva', 'bruno.silva@email.com', '2002-09-30'),
(3, 'Carla Mendes', 'carla.mendes@email.com', '2004-11-22'),
(4, 'Diego Costa', 'diego.costa@email.com', '2003-01-15'),
(8, 'DANIEL DE souza', 'danielbinsemb@gmail.com', '2005-03-18');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Auditoria`
--

DROP TABLE IF EXISTS `Auditoria`;
CREATE TABLE `Auditoria` (
  `log_id` int(11) NOT NULL,
  `acao` varchar(50) NOT NULL,
  `tabela_afetada` varchar(50) NOT NULL,
  `registro_id` int(11) NOT NULL,
  `detalhes` text DEFAULT NULL,
  `data_log` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `Auditoria`
--

INSERT INTO `Auditoria` (`log_id`, `acao`, `tabela_afetada`, `registro_id`, `detalhes`, `data_log`) VALUES
(1, 'DELETE', 'Alunos', 7, 'Aluno excluído: EZEQUIEL (EZEGMAIL.CO)', '2025-08-26 16:56:57'),
(2, 'DELETE', 'Alunos', 5, 'Aluno excluído: Fernanda Souza (fernanda.souza@email.com)', '2025-10-24 21:58:26');

-- --------------------------------------------------------

--
-- Estrutura para tabela `Cursos`
--

DROP TABLE IF EXISTS `Cursos`;
CREATE TABLE `Cursos` (
  `curso_id` int(11) NOT NULL,
  `nome_curso` varchar(100) NOT NULL,
  `carga_horaria` int(11) NOT NULL CHECK (`carga_horaria` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `Cursos`
--

INSERT INTO `Cursos` (`curso_id`, `nome_curso`, `carga_horaria`) VALUES
(1, 'Matemática Básica', 60),
(2, 'Inglês Intermediário', 80),
(3, 'Programação Web', 100),
(4, 'Banco de Dados', 90),
(5, 'História do Brasil', 70);

-- --------------------------------------------------------

--
-- Estrutura para tabela `Matriculas`
--

DROP TABLE IF EXISTS `Matriculas`;
CREATE TABLE `Matriculas` (
  `matricula_id` int(11) NOT NULL,
  `aluno_id` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `data_matricula` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `Matriculas`
--

INSERT INTO `Matriculas` (`matricula_id`, `aluno_id`, `curso_id`, `data_matricula`) VALUES
(1, 1, 3, '2025-01-10'),
(2, 1, 4, '2025-02-01'),
(3, 2, 1, '2025-03-05'),
(4, 3, 2, '2025-03-12'),
(5, 4, 5, '2025-04-20');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `Alunos`
--
ALTER TABLE `Alunos`
  ADD PRIMARY KEY (`aluno_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `Auditoria`
--
ALTER TABLE `Auditoria`
  ADD PRIMARY KEY (`log_id`);

--
-- Índices de tabela `Cursos`
--
ALTER TABLE `Cursos`
  ADD PRIMARY KEY (`curso_id`);

--
-- Índices de tabela `Matriculas`
--
ALTER TABLE `Matriculas`
  ADD PRIMARY KEY (`matricula_id`),
  ADD KEY `fk_m_aluno` (`aluno_id`),
  ADD KEY `fk_m_curso` (`curso_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `Alunos`
--
ALTER TABLE `Alunos`
  MODIFY `aluno_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `Auditoria`
--
ALTER TABLE `Auditoria`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `Cursos`
--
ALTER TABLE `Cursos`
  MODIFY `curso_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `Matriculas`
--
ALTER TABLE `Matriculas`
  MODIFY `matricula_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `Matriculas`
--
ALTER TABLE `Matriculas`
  ADD CONSTRAINT `fk_m_aluno` FOREIGN KEY (`aluno_id`) REFERENCES `Alunos` (`aluno_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_m_curso` FOREIGN KEY (`curso_id`) REFERENCES `Cursos` (`curso_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
