-- DIA 3 - AGREGAÇÕES
-- Objetivo: COUNT, GROUP BY, HAVING

-- Contar todos os registros
SELECT COUNT(*) FROM customers;

-- Contar clientes por país
SELECT country, COUNT(*) 
FROM customers
GROUP BY country;

-- Contar clientes por país e ordenar do maior para o menor
SELECT country, COUNT(*) 
FROM customers
GROUP BY country
ORDER BY COUNT(*) DESC;

-- Filtrar grupos (apenas países com mais de 5 clientes)
SELECT country, COUNT(*) 
FROM customers
GROUP BY country
HAVING COUNT(*) > 5;
