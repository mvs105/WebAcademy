-- PARA REMOVER O BANCO, SE ESTE JÁ EXISTIR
DROP DATABASE IF EXISTS db_having_exercicios;

-- CRIAÇÃO DO BANCO E INSERÇÃO DOS DADOS NAS TABELAS

-- ======================================
-- CRIAÇÃO DO BANCO DE DADOS
-- ======================================
CREATE DATABASE db_having_exercicios;
USE db_having_exercicios;

-- ======================================
-- TABELA: VENDAS
-- ======================================
CREATE TABLE vendas (
 id_venda INT AUTO_INCREMENT PRIMARY KEY,
 vendedor VARCHAR(50),
 valor DECIMAL(10,2),
 data_venda DATE
);

INSERT INTO vendas (vendedor, valor, data_venda) VALUES
('João', 500, '2025-10-01'),
('Maria', 700, '2025-10-02'),
('João', 300, '2025-10-03'),
('Ana', 900, '2025-10-04'),
('Maria', 400, '2025-10-05'),
('Carlos', 1500, '2025-10-06'),
('João', 250, '2025-10-07'),
('Ana', 1200, '2025-10-08');
-- ======================================
-- TABELA: PRODUTOS
-- ======================================
CREATE TABLE produtos (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100),
 categoria VARCHAR(50),
 preco DECIMAL(10,2)
);
INSERT INTO produtos (nome, categoria, preco) VALUES
('Notebook', 'Informática', 3500),
('Mouse', 'Informática', 80),
('Teclado', 'Informática', 150),
('Cadeira Gamer', 'Móveis', 1200),
('Mesa de Escritório', 'Móveis', 900),
('Camiseta', 'Vestuário', 70),
('Calça Jeans', 'Vestuário', 120),
('Tênis', 'Vestuário', 350),
('Sofá', 'Móveis', 2500),
('Monitor', 'Informática', 1100);

-- ======================================
-- TABELA: FUNCIONÁRIOS
-- ======================================
CREATE TABLE funcionarios (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100),
 departamento VARCHAR(50),
 salario DECIMAL(10,2)
);
INSERT INTO funcionarios (nome, departamento, salario) VALUES
('Lucas', 'TI', 4500),
('Fernanda', 'TI', 7000),
('Ricardo', 'RH', 4200),
('Paula', 'RH', 5200),
('Marcos', 'Financeiro', 8000),
('Juliana', 'Financeiro', 6500),
('Renato', 'TI', 4000),
('Lívia', 'Financeiro', 9000);
-- ======================================
-- TABELA: ALUNOS
-- ======================================
CREATE TABLE alunos (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100),
 curso VARCHAR(100)
);
INSERT INTO alunos (nome, curso) VALUES
('Ana', 'Engenharia'),
('Carlos', 'Engenharia'),
('Maria', 'Engenharia'),
('Pedro', 'Direito'),
('Lucas', 'Direito'),
('João', 'Direito'),
('Fernanda', 'Psicologia'),
('Paula', 'Psicologia'),
('Rafaela', 'Psicologia'),
('Bianca', 'Psicologia'),
('Rodrigo', 'Psicologia'),
('Juliana', 'Administração'),
('Marcos', 'Administração');

-- ======================================
-- TABELA: PEDIDOS
-- ======================================
CREATE TABLE pedidos (
 id_pedido INT AUTO_INCREMENT PRIMARY KEY,
 cliente VARCHAR(100),
 valor_total DECIMAL(10,2)
);

INSERT INTO pedidos (cliente, valor_total) VALUES
('Carlos', 1200),
('Carlos', 900),
('Carlos', 1800),
('Maria', 700),
('Maria', 4500),
('João', 300),
('Ana', 2500),
('Ana', 800),
('Ana', 1100),
('Rafaela', 1500),
('Rafaela', 1300),
('Rafaela', 400),
('Ricardo', 2000),
('Ricardo', 2200),
('Ricardo', 2800);
-- ======================================
-- TABELA: ITENS_PEDIDO
-- ======================================
CREATE TABLE itens_pedido (
 id INT AUTO_INCREMENT PRIMARY KEY,
 produto VARCHAR(100),
 quantidade INT
);

INSERT INTO itens_pedido (produto, quantidade) VALUES
('Notebook', 25),
('Mouse', 120),
('Teclado', 80),
('Cadeira Gamer', 40),
('Mesa de Escritório', 30),
('Camiseta', 200),
('Calça Jeans', 150),
('Tênis', 90),
('Sofá', 10),
('Monitor', 50);

-- ======================================
-- TABELA: CLIENTES
-- ======================================
CREATE TABLE clientes (
 id INT AUTO_INCREMENT PRIMARY KEY,
 nome VARCHAR(100),
 cidade VARCHAR(50)
);

INSERT INTO clientes (nome, cidade) VALUES
('Ana', 'Rio Branco'),
('Carlos', 'Rio Branco'),
('Maria', 'Rio Branco'),
('João', 'Cruzeiro do Sul'),
('Fernanda', 'Cruzeiro do Sul'),
('Paula', 'Cruzeiro do Sul'),
('Ricardo', 'Sena Madureira'),
('Juliana', 'Sena Madureira'),
('Rafaela', 'Sena Madureira'),
('Lucas', 'Sena Madureira'),
('Lívia', 'Sena Madureira'),
('Marcos', 'Tarauacá'),
('Bruna', 'Tarauacá');
-- ======================================
-- TABELA: VENDAS MENSAL
-- ======================================
CREATE TABLE vendas_mensal (
 id INT AUTO_INCREMENT PRIMARY KEY,
 data_venda DATE,
 valor DECIMAL(10,2)
);


INSERT INTO vendas_mensal (data_venda, valor) VALUES
('2025-01-10', 15000),
('2025-01-20', 12000),
('2025-02-05', 8000),
('2025-02-18', 7000),
('2025-03-01', 25000),
('2025-03-15', 30000),
('2025-04-10', 52000),
('2025-04-20', 48000),
('2025-05-12', 60000),
('2025-06-22', 42000);


-- EXERCÍCIOS

-- EXERCÍCIO 1
SELECT vendedor,
       SUM(valor) AS total_vendas
FROM vendas
GROUP BY vendedor
HAVING SUM(valor) > 1000;

-- EXERCÍCIO 2
SELECT categoria,
       COUNT(*) AS quantidade_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 3;

-- EXERCÍCIO 3
SELECT departamento,
       AVG(salario) AS media_salarial
FROM funcionarios
GROUP BY departamento
HAVING AVG(salario) > 5000;

-- EXERCÍCIO 4
SELECT curso,
       COUNT(*) AS quantidade_alunos
FROM alunos
GROUP BY curso
HAVING COUNT(*) > 10;

-- EXERCÍCIO 5
SELECT cliente,
       SUM(valor_total) AS total_gasto
FROM pedidos
GROUP BY cliente
HAVING SUM(valor_total) > 5000;

-- EXERCÍCIO 6
SELECT vendedor,
       AVG(valor) AS media_vendas
FROM vendas
GROUP BY vendedor
HAVING AVG(valor) > 400;

-- EXERCÍCIO 7
SELECT produto,
       SUM(quantidade) AS total_vendido
FROM itens_pedido
GROUP BY produto
HAVING SUM(quantidade) > 100;

-- EXERCÍCIO 8
SELECT cidade,
       COUNT(*) AS total_clientes
FROM clientes
GROUP BY cidade
HAVING COUNT(*) > 5;

-- EXERCÍCIO 9
SELECT departamento,
       COUNT(*) AS funcionarios_acima_media
FROM funcionarios
WHERE salario >
(
    SELECT AVG(salario)
    FROM funcionarios
)
GROUP BY departamento
HAVING COUNT(*) > 2;

-- EXERCÍCIO 10
SELECT cliente,
       COUNT(*) AS pedidos_acima_1000
FROM pedidos
WHERE valor_total > 1000
GROUP BY cliente
HAVING COUNT(*) > 3;

-- EXERCÍCIO 11
SELECT MONTH(data_venda) AS mes,
       SUM(valor) AS faturamento
FROM vendas_mensal
GROUP BY MONTH(data_venda)
HAVING SUM(valor) > 50000;

-- EXERCÍCIO 12
SELECT categoria,
       AVG(preco) AS media_preco
FROM produtos
GROUP BY categoria
HAVING AVG(preco) >
(
    SELECT AVG(preco)
    FROM produtos
);

-- DESAFIO EXTRA
SELECT vendedor,
       COUNT(*) AS quantidade_vendas,
       SUM(valor) AS total_vendido
FROM vendas
GROUP BY vendedor
HAVING COUNT(*) > 5
AND SUM(valor) >
(
    SELECT AVG(valor)
    FROM vendas
);