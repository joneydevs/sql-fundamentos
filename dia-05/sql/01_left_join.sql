
-- DIA 5 - LEFT JOIN
-- Objetivo: retornar todos os registros da tabela principal,
-- mesmo quando não existe relacionamento na tabela secundária

SELECT c.name, o.id
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id;
