-- DIA 4 - INNER JOIN
-- Objetivo: relacionar tabelas usando chave estrangeira

SELECT orders.id, customers.name
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.id;

-- No INNER JOIN indico a segunda tabela e ON, traduzindo para um modelo
--  mental mais simples, pode ser lido como ONDE e serve para indicar
--  qual coluna, em cada uma das tabelas, tem a chave comum entre elas. 
