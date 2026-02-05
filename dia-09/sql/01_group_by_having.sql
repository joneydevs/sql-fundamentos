-- DIA 9 - GROUP BY e HAVING

SELECT
  director,
  COUNT(*) AS total_movies
FROM movies
GROUP BY director
HAVING COUNT(*) > 1;
