-- DIA 8 - Funções de agregação básicas

SELECT COUNT(*) AS total_movies
FROM movies;

SELECT AVG(domestic_sales) AS avg_domestic_sales
FROM boxoffice;

SELECT MAX(international_sales) AS max_international_sales
FROM boxoffice;
