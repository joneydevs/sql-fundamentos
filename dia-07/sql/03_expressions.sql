-- DIA 7 - Expressions e aliases
-- Uso de funções, cálculos e nomes legíveis

SELECT
  title,
  domestic_sales + international_sales AS total_sales
FROM movies
JOIN boxoffice
  ON movies.id = boxoffice.movie_id
WHERE (domestic_sales + international_sales) > 500000000;
