
-- MINI PROJETO: SISTEMA DE PEDIDOS
-- Exercícios de Consultas SQL
-- Autor: Joney Ferreira
-- Objetivo: Treinar JOIN, GROUP BY, HAVING e Subqueries


-- ==============================
-- BLOCO 1 - JOINs
-- ==============================

-- 1) Listar ID do pedido, nome do cliente, status e data de criação

SELECT 
    p.id AS id_pedido,
    c.nome AS nome_cliente,
    p.status,
    p.criado_em
FROM pedido p
LEFT JOIN cliente c
    ON p.cliente_id = c.id
ORDER BY p.criado_em DESC;



-- 2) Listar itens de pedido com nome do produto

SELECT 
    pi.pedido_id,
    pr.nome AS nome_produto,
    pi.quantidade,
    pi.preco_unitario_centavos
FROM pedido_item pi
LEFT JOIN produto pr
    ON pi.produto_id = pr.id;



-- 3) Listar pedidos CANCELADOS

SELECT 
    c.nome,
    p.criado_em,
    p.id AS id_pedido
FROM cliente c
JOIN pedido p
    ON c.id = p.cliente_id
WHERE p.status = 'CANCELADO';



-- ==============================
-- BLOCO 2 - Agregações
-- ==============================

-- 4) Valor total de cada item

SELECT
    pedido_id,
    produto_id,
    quantidade,
    preco_unitario_centavos,
    (quantidade * preco_unitario_centavos) AS valor_total_item
FROM pedido_item;



-- 5) Valor total de cada pedido

SELECT
    p.id AS id_pedido,
    SUM(pi.quantidade * pi.preco_unitario_centavos) AS valor_total_pedido
FROM pedido p
JOIN pedido_item pi
    ON p.id = pi.pedido_id
GROUP BY p.id
ORDER BY valor_total_pedido DESC;



-- 6) Nome do cliente + valor total por pedido

SELECT
    c.nome AS nome_cliente,
    p.id AS id_pedido,
    SUM(pi.quantidade * pi.preco_unitario_centavos) AS valor_total_pedido
FROM cliente c
JOIN pedido p
    ON c.id = p.cliente_id
JOIN pedido_item pi
    ON p.id = pi.pedido_id
GROUP BY c.nome, p.id
ORDER BY valor_total_pedido ASC;



-- 7) Cliente com mais pedidos

SELECT
    c.id,
    c.nome,
    COUNT(p.id) AS qtd_pedidos
FROM cliente c
LEFT JOIN pedido p
    ON c.id = p.cliente_id
GROUP BY c.id, c.nome
ORDER BY qtd_pedidos DESC
LIMIT 1;



-- 8) Produto mais vendido (quantidade)

SELECT
    p.id,
    p.nome,
    SUM(pi.quantidade) AS quantidade_vendida
FROM produto p
LEFT JOIN pedido_item pi
    ON p.id = pi.produto_id
GROUP BY p.id, p.nome
ORDER BY quantidade_vendida DESC
LIMIT 1;



-- 9) Produto com maior faturamento

SELECT
    p.id,
    p.nome,
    SUM(pi.quantidade * pi.preco_unitario_centavos) AS faturamento
FROM produto p
LEFT JOIN pedido_item pi
    ON p.id = pi.produto_id
GROUP BY p.id, p.nome
ORDER BY faturamento DESC
LIMIT 1;



-- 10) Clientes que nunca fizeram pedido

SELECT
    c.id,
    c.nome
FROM cliente c
LEFT JOIN pedido p
    ON c.id = p.cliente_id
WHERE p.id IS NULL;

