-- MINI PROJETO: SISTEMA DE PEDIDOS
-- Exercícios SQL (Blocos 1 a 4) – Versão corrigida
-- Observação: consultas pensadas para SQLite


-- ==============================
-- BLOCO 1 — Lógica de Negócio
-- ==============================

-- 1) Mostrar o valor total apenas dos pedidos com status PAGO (total geral)
SELECT
  p.status AS status_pedido,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS valor_total
FROM pedido p
LEFT JOIN pedido_item pi ON pi.pedido_id = p.id
WHERE p.status = 'PAGO'
GROUP BY p.status;


-- 2) Mostrar o faturamento total "perdido" com pedidos CANCELADO (total geral)
SELECT
  p.status AS status_pedido,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS faturamento_total
FROM pedido p
LEFT JOIN pedido_item pi ON pi.pedido_id = p.id
WHERE p.status = 'CANCELADO'
GROUP BY p.status;


-- 3) Listar pedidos que não possuem nenhum item
SELECT
  p.id AS id_pedido
FROM pedido p
LEFT JOIN pedido_item pi ON pi.pedido_id = p.id
WHERE pi.id IS NULL
ORDER BY p.id;


-- 4) Mostrar clientes que têm pedidos CANCELADOS mas também possuem pedidos PAGO
SELECT
  c.id   AS id_cliente,
  c.nome AS nome_cliente
FROM cliente c
JOIN pedido p ON p.cliente_id = c.id
GROUP BY c.id, c.nome
HAVING
  SUM(CASE WHEN p.status = 'PAGO'      THEN 1 ELSE 0 END) > 0
  AND
  SUM(CASE WHEN p.status = 'CANCELADO' THEN 1 ELSE 0 END) > 0;


-- ==============================
-- BLOCO 2 — Subqueries e médias
-- ==============================

-- 5) Mostrar produtos cujo preço atual está acima da média de preço dos produtos
SELECT
  id,
  nome,
  preco_atual_centavos
FROM produto
WHERE preco_atual_centavos > (
  SELECT AVG(preco_atual_centavos)
  FROM produto
)
ORDER BY preco_atual_centavos DESC;


-- 6) Mostrar clientes que fizeram mais pedidos do que a média de pedidos por cliente
-- (considera apenas clientes que possuem pelo menos 1 pedido)
SELECT
  p.cliente_id,
  COUNT(*) AS total_pedidos
FROM pedido p
GROUP BY p.cliente_id
HAVING COUNT(*) > (
  SELECT AVG(total_pedidos)
  FROM (
    SELECT COUNT(*) AS total_pedidos
    FROM pedido
    GROUP BY cliente_id
  )
)
ORDER BY total_pedidos DESC;


-- 7) Mostrar os pedidos cujo valor total é maior que o valor médio dos pedidos
SELECT
  p.id AS id_pedido,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS valor_total_pedido
FROM pedido p
JOIN pedido_item pi ON pi.pedido_id = p.id
GROUP BY p.id
HAVING SUM(pi.quantidade * pi.preco_unitario_centavos) > (
  SELECT AVG(total_pedido)
  FROM (
    SELECT SUM(quantidade * preco_unitario_centavos) AS total_pedido
    FROM pedido_item
    GROUP BY pedido_id
  )
)
ORDER BY valor_total_pedido DESC;


-- ==============================
-- BLOCO 3 — Análises (ticket, rankings)
-- ==============================

-- 8) Ticket médio por cliente
-- ticket médio = total gasto ÷ quantidade de pedidos
SELECT
  c.id AS id_cliente,
  c.nome AS nome_cliente,
  COUNT(DISTINCT p.id) AS qtd_pedidos,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS total_gasto,
  1.0 * SUM(pi.quantidade * pi.preco_unitario_centavos) / COUNT(DISTINCT p.id) AS ticket_medio
FROM cliente c
JOIN pedido p       ON p.cliente_id = c.id
JOIN pedido_item pi ON pi.pedido_id = p.id
GROUP BY c.id, c.nome
ORDER BY ticket_medio DESC;


-- 9) Mostrar o cliente que gerou maior faturamento total
SELECT
  c.id,
  c.nome,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS faturamento_total
FROM cliente c
JOIN pedido p       ON p.cliente_id = c.id
JOIN pedido_item pi ON pi.pedido_id = p.id
GROUP BY c.id, c.nome
ORDER BY faturamento_total DESC
LIMIT 1;


-- 10) Mostrar os 3 produtos mais rentáveis (maior faturamento)
SELECT
  pr.id AS id_produto,
  pr.nome AS nome_produto,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS faturamento_produto
FROM produto pr
JOIN pedido_item pi ON pi.produto_id = pr.id
GROUP BY pr.id, pr.nome
ORDER BY faturamento_produto DESC
LIMIT 3;


-- ==============================
-- BLOCO 4 — Desafio profissional
-- ==============================

-- 11) Para cada cliente, mostrar:
-- nome, quantidade de pedidos, total gasto, valor médio por pedido, data do pedido mais recente
SELECT
  c.id   AS id_cliente,
  c.nome AS nome_cliente,
  COUNT(DISTINCT p.id) AS qtd_pedidos,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS total_gasto,
  1.0 * SUM(pi.quantidade * pi.preco_unitario_centavos) / COUNT(DISTINCT p.id) AS valor_medio_por_pedido,
  MAX(p.criado_em) AS pedido_mais_recente
FROM cliente c
JOIN pedido p       ON p.cliente_id = c.id
JOIN pedido_item pi ON pi.pedido_id = p.id
GROUP BY c.id, c.nome
ORDER BY total_gasto DESC;


-- 12) Mostrar clientes cujo total gasto é maior que a média geral de faturamento por cliente
SELECT
  c.id   AS id_cliente,
  c.nome AS nome_cliente,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS total_cliente
FROM cliente c
JOIN pedido p       ON p.cliente_id = c.id
JOIN pedido_item pi ON pi.pedido_id = p.id
GROUP BY c.id, c.nome
HAVING total_cliente > (
  SELECT AVG(total_por_cliente)
  FROM (
    SELECT SUM(pi2.quantidade * pi2.preco_unitario_centavos) AS total_por_cliente
    FROM pedido p2
    JOIN pedido_item pi2 ON pi2.pedido_id = p2.id
    GROUP BY p2.cliente_id
  )
)
ORDER BY total_cliente DESC;


-- 13) Ranking: todos os clientes ordenados do maior faturamento para o menor
SELECT
  c.id,
  c.nome,
  SUM(pi.quantidade * pi.preco_unitario_centavos) AS gasto_cliente
FROM cliente c
JOIN pedido p       ON p.cliente_id = c.id
JOIN pedido_item pi ON pi.pedido_id = p.id
GROUP BY c.id, c.nome
ORDER BY gasto_cliente DESC;


-- 14) Produtos vendidos em TODOS os pedidos
-- Versão A: considera todos os pedidos existentes em `pedido` (mesmo os sem item)
SELECT
  pr.id,
  pr.nome
FROM produto pr
JOIN pedido_item pi ON pi.produto_id = pr.id
GROUP BY pr.id, pr.nome
HAVING COUNT(DISTINCT pi.pedido_id) = (SELECT COUNT(*) FROM pedido);

-- Versão B: considera apenas pedidos que têm itens (normalmente o mais justo)
-- SELECT pr.id, pr.nome
-- FROM produto pr
-- JOIN pedido_item pi ON pi.produto_id = pr.id
-- GROUP BY pr.id, pr.nome
-- HAVING COUNT(DISTINCT pi.pedido_id) = (SELECT COUNT(DISTINCT pedido_id) FROM pedido_item);
