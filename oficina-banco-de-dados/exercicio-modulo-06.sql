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


-- =====================================================
-- PARTE 1 - VIEWS
-- =====================================================

-- EXERCÍCIO 1
-- View dos clientes ativos
CREATE OR REPLACE VIEW vw_clientes_ativos AS
SELECT
    id AS cliente_id,
    nome,
    email
FROM clientes
WHERE ativo = TRUE;

-- EXERCÍCIO 2
-- Nome do cliente e data do pedido
CREATE OR REPLACE VIEW vw_clientes_pedidos AS
SELECT
    c.nome,
    p.data_pedido
FROM clientes c
INNER JOIN pedidos p
ON c.id = p.cliente_id;

-- EXERCÍCIO 3
-- Produtos acima de R$500
CREATE OR REPLACE VIEW vw_produtos_caros AS
SELECT
    id AS id_produto,
    nome,
    preco
FROM produtos
WHERE preco > 500;

-- EXERCÍCIO 4
-- Produto, quantidade e valor unitário
CREATE OR REPLACE VIEW vw_itens_pedido AS
SELECT
    pr.nome AS produto,
    ip.quantidade,
    ip.valor_unitario
FROM itens_pedido ip
INNER JOIN produtos pr
ON ip.produto_id = pr.id;

-- EXERCÍCIO 5
-- Total de cada pedido
CREATE OR REPLACE VIEW vw_total_pedido AS
SELECT
    pedido_id AS id_pedido,
    SUM(quantidade * valor_unitario) AS total
FROM itens_pedido
GROUP BY pedido_id;


-- =====================================================
-- PARTE 2 - PROCEDURES
-- =====================================================

-- EXERCÍCIO 6
-- Lista todos os clientes
DELIMITER $$

CREATE PROCEDURE sp_listar_clientes()
BEGIN
    SELECT *
    FROM clientes;
END $$

DELIMITER ;

-- Executar:
-- CALL sp_listar_clientes();

-- EXERCÍCIO 7
-- Retorna os pedidos de um cliente
DELIMITER $$

CREATE PROCEDURE sp_pedidos_cliente(IN p_cliente_id INT)
BEGIN
    SELECT *
    FROM pedidos
    WHERE cliente_id = p_cliente_id;
END $$

DELIMITER ;

-- Exemplo:
-- CALL sp_pedidos_cliente(1);

-- EXERCÍCIO 8
-- Cadastra um novo produto
DELIMITER $$

CREATE PROCEDURE sp_cadastrar_produto(
    IN p_nome VARCHAR(100),
    IN p_preco DECIMAL(10,2),
    IN p_estoque INT
)
BEGIN
    INSERT INTO produtos(nome, preco, estoque)
    VALUES (p_nome, p_preco, p_estoque);
END $$

DELIMITER ;

-- Exemplo:
-- CALL sp_cadastrar_produto('SSD 1TB',650.00,20);

-- EXERCÍCIO 9
-- Aumenta o estoque
DELIMITER $$

CREATE PROCEDURE sp_aumentar_estoque(
    IN p_id_produto INT,
    IN p_quantidade INT
)
BEGIN
    UPDATE produtos
    SET estoque = estoque + p_quantidade
    WHERE id = p_id_produto;
END $$

DELIMITER ;

-- Exemplo:
-- CALL sp_aumentar_estoque(2,10);

-- EXERCÍCIO 10
-- Produtos abaixo do estoque informado
DELIMITER $$

CREATE PROCEDURE sp_produtos_baixo_estoque(
    IN p_limite INT
)
BEGIN
    SELECT *
    FROM produtos
    WHERE estoque < p_limite;
END $$

DELIMITER ;

-- Exemplo:
-- CALL sp_produtos_baixo_estoque(15);


-- =====================================================
-- PARTE 3 - FUNCTIONS
-- =====================================================

-- EXERCÍCIO 11
-- Preço com 10% de desconto
DELIMITER $$

CREATE FUNCTION fn_desconto(preco DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN preco * 0.90;
END $$

DELIMITER ;

-- Exemplo:
-- SELECT fn_desconto(1000);

-- EXERCÍCIO 12
-- Calcula o valor total
DELIMITER $$

CREATE FUNCTION fn_total(
    quantidade INT,
    valor_unitario DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN quantidade * valor_unitario;
END $$

DELIMITER ;

-- Exemplo:
-- SELECT fn_total(5,150);

-- EXERCÍCIO 13
-- Situação do estoque
DELIMITER $$

CREATE FUNCTION fn_status_estoque(
    estoque INT
)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN

    IF estoque > 0 THEN
        RETURN 'Em estoque';
    ELSE
        RETURN 'Sem estoque';
    END IF;

END $$

DELIMITER ;

-- Exemplo:
-- SELECT fn_status_estoque(10);
-- SELECT fn_status_estoque(0);

-- EXERCÍCIO 14
-- Nome em maiúsculas
DELIMITER $$

CREATE FUNCTION fn_maiusculo(
    texto VARCHAR(100)
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN

    RETURN UPPER(texto);

END $$

DELIMITER ;

-- Exemplo:
-- SELECT fn_maiusculo('Marcos Vinicius');

-- EXERCÍCIO 15
-- Dobro do estoque
DELIMITER $$

CREATE FUNCTION fn_dobro_estoque(
    estoque INT
)
RETURNS INT
DETERMINISTIC
BEGIN

    RETURN estoque * 2;

END $$

DELIMITER ;

-- Exemplo:
-- SELECT fn_dobro_estoque(15);


-- =====================================================
-- PARTE 4 - TRIGGERS
-- =====================================================

-- EXERCÍCIO 16
-- Log de INSERT
DELIMITER $$

CREATE TRIGGER trg_produto_insert
AFTER INSERT
ON produtos
FOR EACH ROW
BEGIN

    INSERT INTO log_produtos(produto_id, acao, data_log)
    VALUES(NEW.id, 'INSERT', NOW());

END $$

DELIMITER ;

-- EXERCÍCIO 17
-- Log de UPDATE
DELIMITER $$

CREATE TRIGGER trg_produto_update
AFTER UPDATE
ON produtos
FOR EACH ROW
BEGIN

    INSERT INTO log_produtos(produto_id, acao, data_log)
    VALUES(NEW.id, 'UPDATE', NOW());

END $$

DELIMITER ;

-- EXERCÍCIO 18
-- Log de DELETE
DELIMITER $$

CREATE TRIGGER trg_produto_delete
AFTER DELETE
ON produtos
FOR EACH ROW
BEGIN

    INSERT INTO log_produtos(produto_id, acao, data_log)
    VALUES(OLD.id, 'DELETE', NOW());

END $$

DELIMITER ;

-- EXERCÍCIO 19
-- Impede estoque negativo
DELIMITER $$

CREATE TRIGGER trg_verifica_estoque
BEFORE INSERT
ON produtos
FOR EACH ROW
BEGIN

    IF NEW.estoque < 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: estoque não pode ser negativo.';

    END IF;

END $$

DELIMITER ;

-- EXERCÍCIO 20
-- Impede preço inválido
DELIMITER $$

CREATE TRIGGER trg_verifica_preco
BEFORE INSERT
ON produtos
FOR EACH ROW
BEGIN

    IF NEW.preco <= 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: preço deve ser maior que zero.';

    END IF;

END $$

DELIMITER ;

-- =====================================================
-- DESAFIO FINAL
-- =====================================================

-- =====================================================
-- DESAFIO FINAL
-- Sistema de gerenciamento de vendas
--
-- Recursos implementados:
--
-- Views:
--   - vw_clientes_ativos
--   - vw_total_pedido
--
-- Procedures:
--   - sp_cadastrar_produto
--   - sp_aumentar_estoque
--
-- Functions:
--   - fn_desconto
--   - fn_total
--
-- Triggers:
--   - trg_produto_insert
--   - trg_verifica_estoque
--
-- O sistema automatiza o cadastro, controle de estoque,
-- consultas e auditoria das operações realizadas.
-- =====================================================