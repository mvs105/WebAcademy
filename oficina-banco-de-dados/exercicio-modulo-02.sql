DROP DATABASE lojinha_exercicio_02;
CREATE DATABASE lojinha_exercicio_02;
USE lojinha_exercicio_02;
CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco_entrega VARCHAR(255)
);

CREATE TABLE produtos (
    produto_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2)
);

CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE itens_pedido (
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

INSERT INTO clientes (nome, telefone, endereco_entrega) VALUES 
('João', '123-456', 'Rua A, 100'),
('Maria', '987-654', 'Rua B, 200');

INSERT INTO produtos (nome, preco) VALUES 
('Caneta', 2.00),
('Caderno', 10.00);

INSERT INTO pedidos (cliente_id) VALUES 
(1),
(2);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade) VALUES 
(1, 1, 10), 
(1, 2, 5),  
(2, 1, 15); 

SELECT 
    ped.pedido_id AS Pedido, 
    c.nome AS Cliente, 
    c.telefone AS Telefone, 
    p.nome AS Produto, 
    ip.quantidade AS Quantidade, 
    p.preco AS Preco,
    c.endereco_entrega AS Endereco_Entrega
FROM pedidos ped
JOIN clientes c ON ped.cliente_id = c.cliente_id
JOIN itens_pedido ip ON ped.pedido_id = ip.pedido_id
JOIN produtos p ON ip.produto_id = p.produto_id;