-- ============================================================================
-- Base de Dados para Prática – Módulo 6
-- Views, Procedures, Functions e Triggers
-- ============================================================================

-- 1. Criação do Banco de Dados
CREATE DATABASE IF NOT EXISTS oficina_modulo6;
USE oficina_modulo6;

-- 2. Tabela de Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    cidade VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

-- 3. Tabela de Produtos
CREATE TABLE IF NOT EXISTS produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

-- 4. Tabela de Pedidos
CREATE TABLE IF NOT EXISTS pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- 5. Tabela de Itens do Pedido
CREATE TABLE IF NOT EXISTS itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    valor_unitario DECIMAL(10,2),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- 6. Tabela de Log
CREATE TABLE IF NOT EXISTS log_produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    acao VARCHAR(50),
    data_log DATETIME
);

-- ============================================================================
-- Inserção de Dados de Teste
-- ============================================================================

-- Clientes
INSERT INTO clientes(nome, email, cidade) VALUES
('Ana Silva', 'ana@email.com', 'Rio Branco'),
('Carlos Souza', 'carlos@email.com', 'Brasileia'),
('João Pedro', 'joao@email.com', 'Cruzeiro do Sul'),
('Maria Lima', 'maria@email.com', 'Rio Branco');

-- Produtos
INSERT INTO produtos(nome, preco, estoque) VALUES
('Notebook', 3500, 20),
('Mouse', 80, 100),
('Teclado', 150, 50),
('Monitor', 1200, 15),
('SSD 1TB', 600, 30);

-- Pedidos
INSERT INTO pedidos(cliente_id, data_pedido) VALUES
(1, '2026-06-01'),
(2, '2026-06-02'),
(1, '2026-06-05'),
(4, '2026-06-07');

-- Itens do Pedido
INSERT INTO itens_pedido(pedido_id, produto_id, quantidade, valor_unitario) VALUES
(1, 1, 1, 3500),
(1, 2, 2, 80),
(2, 3, 1, 150),
(2, 5, 1, 600),
(3, 4, 1, 1200),
(4, 2, 3, 80);
