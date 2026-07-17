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

-- Questões
-- Exercício 1
CREATE VIEW vw_clientes_ativos AS
SELECT * 
FROM clientes
WHERE ativo = TRUE;
SELECT * FROM vw_clientes_ativos;

-- Exercício 2
CREATE VIEW vw_clientes_pedidos AS
SELECT clientes.nome, pedidos.data_pedido 
FROM clientes
INNER JOIN pedidos ON clientes.id = pedidos.cliente_id;
SELECT * FROM vw_clientes_pedidos;

-- Exercício 3
CREATE VIEW vw_produtos_caros AS
SELECT produtos.nome, produtos.preco
FROM produtos
WHERE produtos.preco > 500;
SELECT * FROM vw_produtos_caros;

-- Exercício 4
CREATE VIEW vw_produto_qnt_valor AS
SELECT produtos.nome, itens_pedido.quantidade, itens_pedido.valor_unitario
FROM itens_pedido
INNER JOIN produtos ON itens_pedido.produto_id = produtos.id;
SELECT * FROM vw_produto_qnt_valor;

-- Exercício 5
CREATE VIEW vw_total_pedidos AS
SELECT pedido_id, SUM(quantidade * valor_unitario) AS total_pedido
FROM itens_pedido
GROUP BY pedido_id;
SELECT * FROM vw_total_pedidos;

-- Exercício 6
DELIMITER $$
CREATE PROCEDURE sp_listar_todos_clientes()
BEGIN
    SELECT * FROM clientes;
END $$
CALL sp_listar_todos_clientes();

-- Exercício 7
DELIMITER $$

CREATE PROCEDURE sp_pedidos_por_cliente(IN p_cliente_id INT)
BEGIN
    SELECT clientes.nome, pedidos.id AS pedido_id, pedidos.data_pedido
    FROM clientes
    INNER JOIN pedidos ON clientes.id = pedidos.cliente_id
    WHERE clientes.id = p_cliente_id;
END $$

DELIMITER ;
CALL sp_pedidos_por_cliente(1);

-- Exercício 8
DELIMITER $$

CREATE PROCEDURE sp_cadastrar_produto(
    IN p_nome VARCHAR(100),
    IN p_preco DECIMAL(10,2),
    IN p_estoque INT
)
BEGIN
    INSERT INTO produtos (nome, preco, estoque)
    VALUES (p_nome, p_preco, p_estoque);
END $$

DELIMITER ;

CALL sp_cadastrar_produto('Teclado Mecânico', 250.00, 10);
SELECT * FROM produtos;

-- Exercício 9
DELIMITER $$

CREATE FUNCTION fn_calcular_total_pedido(p_pedido_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);
    
    SELECT SUM(quantidade * valor_unitario) INTO v_total
    FROM itens_pedido
    WHERE pedido_id = p_pedido_id;
    
    RETURN IFNULL(v_total, 0);
END $$

DELIMITER ;
SELECT fn_calcular_total_pedido(1) AS total_do_pedido_1;

-- Exercício 10
DELIMITER $$

CREATE PROCEDURE sp_produtos_baixo_estoque(IN p_limite_estoque INT)
BEGIN
    SELECT * 
    FROM produtos 
    WHERE estoque < p_limite_estoque;
END $$

DELIMITER ;
CALL sp_produtos_baixo_estoque(20);

-- Exercício 11
DELIMITER $$

CREATE FUNCTION fn_aplicar_desconto(p_preco DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_preco * 0.90;
END $$

DELIMITER ;

SELECT fn_aplicar_desconto(100.00) AS preco_com_desconto;

SELECT nome, preco, fn_aplicar_desconto(preco) AS preco_promocional 
FROM produtos;

-- Exercício 12
DELIMITER $$

CREATE FUNCTION fn_calcular_valor_total(p_quantidade INT, p_valor_unitario DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_quantidade * p_valor_unitario;
END $$

DELIMITER ;

SELECT fn_calcular_valor_total(10, 10.00) AS resultado_teste;

-- Teste aplicado à tabela de itens de pedido
SELECT 
    pedido_id, 
    produto_id, 
    quantidade, 
    valor_unitario, 
    fn_calcular_valor_total(quantidade, valor_unitario) AS subtotal
FROM itens_pedido;

-- Exercício 13
DELIMITER $$

CREATE FUNCTION fn_verificar_status_estoque(p_quantidade INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_quantidade > 0 THEN
        RETURN 'Em estoque';
    ELSE
        RETURN 'Sem estoque';
    END IF;
END $$

DELIMITER ;

SELECT 
    nome, 
    estoque, 
    fn_verificar_status_estoque(estoque) AS disponibilidade
FROM produtos;

-- Exercício 14
DELIMITER $$

CREATE FUNCTION fn_converter_maiusculo(p_nome VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN UPPER(p_nome);
END $$

DELIMITER ;

SELECT fn_converter_maiusculo('ana silva') AS resultado;

SELECT nome, fn_converter_maiusculo(nome) AS nome_formatado 
FROM clientes;

-- Exercício 15
DELIMITER $$

CREATE FUNCTION fn_dobro_estoque(p_estoque INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN p_estoque * 2;
END $$

DELIMITER ;

SELECT fn_dobro_estoque(50) AS resultado_teste;

SELECT 
    nome, 
    estoque AS estoque_atual, 
    fn_dobro_estoque(estoque) AS estoque_dobrado 
FROM produtos;

-- Exercício 16
DELIMITER $$

CREATE TRIGGER trg_log_produto_inserir
AFTER INSERT ON produtos
FOR EACH ROW
BEGIN
    INSERT INTO log_produtos (produto_id, acao, data_log)
    VALUES (NEW.id, 'INSERT', NOW());
END $$

DELIMITER ;

INSERT INTO produtos (nome, preco, estoque) VALUES ('Webcam 4K', 450.00, 15);
SELECT * FROM log_produtos;

-- Exercício 17
DELIMITER $$

CREATE TRIGGER trg_log_produto_atualizar
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    INSERT INTO log_produtos (produto_id, acao, data_log)
    VALUES (NEW.id, 'UPDATE', NOW());
END $$

DELIMITER ;

UPDATE produtos SET preco = 3200.00 WHERE id = 1;
SELECT * FROM log_produtos;

-- Exercício 18
DELIMITER $$

CREATE TRIGGER trg_log_produto_excluir
AFTER DELETE ON produtos
FOR EACH ROW
BEGIN
    INSERT INTO log_produtos (produto_id, acao, data_log)
    VALUES (OLD.id, 'DELETE', NOW());
END $$

DELIMITER ;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM produtos WHERE nome = 'Webcam 4K';
SELECT * FROM log_produtos;

-- Exercício 19
DELIMITER $$

CREATE TRIGGER trg_prevenir_estoque_negativo
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
    IF NEW.estoque < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Não é permitido cadastrar produtos com estoque negativo.';
    END IF;
END $$

DELIMITER ;

INSERT INTO produtos (nome, preco, estoque) VALUES ('Produto Errado', 10.00, -5);

-- Exercício 20
DELIMITER $$

CREATE TRIGGER trg_prevenir_preco_invalido
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
    IF NEW.preco <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: O preço do produto deve ser maior que zero.';
    END IF;
END $$

DELIMITER ;

INSERT INTO produtos (nome, preco, estoque) VALUES ('Produto Grátis', 0.00, 10);

-- Desafio Final
-- VIEWS

CREATE VIEW vw_faturamento_clientes AS
SELECT c.nome, SUM(i.quantidade * i.valor_unitario) AS total_gasto
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
JOIN itens_pedido i ON p.id = i.pedido_id
GROUP BY c.nome;

CREATE VIEW vw_estoque_critico AS
SELECT nome, estoque
FROM produtos
WHERE estoque < 15;

SELECT * FROM vw_faturamento_clientes;
SELECT * FROM vw_estoque_critico;


-- FUNCTIONS

DELIMITER $$

CREATE FUNCTION fn_calcular_desconto_venda(p_valor DECIMAL(10,2), p_percentual DECIMAL(5,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_valor - (p_valor * (p_percentual / 100));
END $$

DELIMITER $$

CREATE FUNCTION fn_status_faturamento(p_total DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_total > 2000 THEN RETURN 'CLIENTE VIP';
    ELSE RETURN 'CLIENTE NORMAL';
    END IF;
END $$

DELIMITER ;

SELECT nome, preco, fn_calcular_desconto_venda(preco, 10) as preco_com_10_off FROM produtos;
SELECT nome, total_gasto, fn_status_faturamento(total_gasto) as classificacao FROM vw_faturamento_clientes;


-- PROCEDURES

DELIMITER $$

CREATE PROCEDURE sp_reajustar_precos_massa(IN p_taxa_aumento DECIMAL(5,2))
BEGIN
    UPDATE produtos SET preco = preco * (1 + (p_taxa_aumento / 100));
END $$

CREATE PROCEDURE sp_detalhar_pedido(IN p_pedido_id INT)
BEGIN
    SELECT pr.nome, i.quantidade, i.valor_unitario, (i.quantidade * i.valor_unitario) AS subtotal
    FROM itens_pedido i
    JOIN produtos pr ON i.produto_id = pr.id
    WHERE i.pedido_id = p_pedido_id;
END $$

DELIMITER ;

CALL sp_reajustar_precos_massa(5.00);
SELECT * FROM produtos;

CALL sp_detalhar_pedido(1);


-- TRIGGERS
DELIMITER $$

CREATE TRIGGER trg_atualizar_estoque_venda
AFTER INSERT ON itens_pedido
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;
END $$

CREATE TRIGGER trg_log_alteracao_preco
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO log_produtos (produto_id, acao, data_log)
        VALUES (NEW.id, 'PRECO_ALTERADO', NOW());
    END IF;
END $$

DELIMITER ;

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, valor_unitario) VALUES (1, 3, 2, 150.00);
SELECT nome, estoque FROM produtos WHERE id = 3;

UPDATE produtos SET preco = 3600.00 WHERE id = 1;
SELECT * FROM log_produtos WHERE acao = 'PRECO_ALTERADO';