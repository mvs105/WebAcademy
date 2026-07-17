CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100)
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE itens_pedido (
    id_item INT PRIMARY KEY,
    id_pedido INT,
    produto VARCHAR(100),
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- INSERÇÃO DOS DADOS

INSERT INTO clientes VALUES
(1,'Ana Silva','Rio Branco'),
(2,'João Costa','Cruzeiro do Sul'),
(3,'Maria Lima','Rio Branco'),
(4,'Paulo Souza','Sena Madureira');

INSERT INTO pedidos VALUES
(101,1,'2024-09-01',250.00),
(102,2,'2024-09-03',120.00),
(103,1,'2024-09-10',540.00),
(104,3,'2024-09-15',300.00);

INSERT INTO itens_pedido VALUES
(1,101,'Teclado',1,100.00),
(2,101,'Mouse',2,75.00),
(3,102,'Monitor',1,120.00),
(4,103,'Notebook',1,540.00),
(5,104,'Cadeira',2,150.00);

-- Parte 1 – INNER JOIN

-- Lista dos nomes dos clientes e as datas dos pedidos.
SELECT c.nome, p.data_pedido
FROM clientes c
INNER JOIN pedidos p
ON c.id_cliente = p.id_cliente;

-- Lista dos nomes dos clientes, produtos e quantidades compradas.
SELECT c.nome, i.produto, i.quantidade
FROM clientes c
INNER JOIN pedidos p
ON c.id_cliente = p.id_cliente
INNER JOIN itens_pedido i
ON p.id_pedido = i.id_pedido;

-- Lista dos pedidos com seus respectivos valores e os nomes dos clientes.
SELECT p.id_pedido, c.nome, p.valor_total
FROM pedidos p
INNER JOIN clientes c
ON p.id_cliente = c.id_cliente;

-- Parte 2 – LEFT JOIN

-- Lista de todos os clientes e seus pedidos.
SELECT c.nome, p.id_pedido
FROM clientes c
LEFT JOIN pedidos p
ON c.id_cliente = p.id_cliente;


-- Lista de nomes dos clientes e valor total dos pedidos.
SELECT c.nome, p.valor_total
FROM clientes c
LEFT JOIN pedidos p
ON c.id_cliente = p.id_cliente;

-- Lista de nomes dos clientes e produtos comprados.
SELECT c.nome, i.produto
FROM clientes c
LEFT JOIN pedidos p
ON c.id_cliente = p.id_cliente
LEFT JOIN itens_pedido i
ON p.id_pedido = i.id_pedido;

-- Parte 3 – RIGHT JOIN

-- Lista de todos os pedidos e os nomes dos clientes.
SELECT c.nome, p.id_pedido
FROM clientes c
RIGHT JOIN pedidos p
ON c.id_cliente = p.id_cliente;

-- Lista de todos os itens de pedidos e os nomes dos clientes.
SELECT c.nome, i.produto, i.quantidade
FROM clientes c
RIGHT JOIN pedidos p
ON c.id_cliente = p.id_cliente
RIGHT JOIN itens_pedido i
ON p.id_pedido = i.id_pedido;

-- Parte 4 – DESAFIOS

-- Consulta com os nomes dos clientes, cidades, quantidades de pedidos e somas dos valores.
SELECT
    c.nome,
    c.cidade,
    COUNT(p.id_pedido) AS total_pedidos,
    COALESCE(SUM(p.valor_total),0) AS soma_valores
FROM clientes c
LEFT JOIN pedidos p
ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome, c.cidade;

-- Lista de produtos que nunca foram vendidos.
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    produto VARCHAR(100)
);

INSERT INTO produtos VALUES
(1,'Teclado'),
(2,'Mouse'),
(3,'Monitor'),
(4,'Notebook'),
(5,'Cadeira'),
(6,'Impressora'),
(7,'Webcam');

SELECT p.produto
FROM produtos p
LEFT JOIN itens_pedido i
ON p.produto = i.produto
WHERE i.id_pedido IS NULL;

use exercicio_modulo_04;
use sgcm;