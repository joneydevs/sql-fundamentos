-- DIA 2 - SQL BÁSICO
-- Objetivo: SELECT, WHERE, ORDER BY, LIMIT

-- Selecionar todas as colunas
SELECT * FROM customers;

-- Selecionar colunas específicas
SELECT first_name, last_name FROM customers;

-- Filtrar resultados
SELECT * FROM customers
WHERE country = 'Brazil';

-- Ordenar resultados
SELECT * FROM customers
ORDER BY last_name;

-- Limitar quantidade
SELECT * FROM customers
LIMIT 5;

