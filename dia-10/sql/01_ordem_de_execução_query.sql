-- DIA 10 - Order of execution of a SQL query
-- Ordem real de execução:
-- 1. FROM / JOIN
-- 2. WHERE
-- 3. GROUP BY
-- 4. HAVING
-- 5. SELECT
-- 6. ORDER BY
-- 7. LIMIT / OFFSET

-- Exemplo: uso de alias no ORDER BY (funciona)
SELECT
  director,
  COUNT(*) AS total_movies
FROM movies
GROUP BY director
HAVING COUNT(*) > 1
ORDER BY total_movies DESC;

-- Exemplo: alias não pode ser usado no WHERE
-- (comentado propositalmente para documentação)
-- WHERE total_movies > 1;
