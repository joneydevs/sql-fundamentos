-- Dia 12: UPDATE - atualização de registros

-- Atualização simples
UPDATE customers
SET country = 'Brazil'
WHERE id = 1;

-- Atualizando múltiplas colunas
UPDATE customers
SET
  first_name = 'Maria',
  last_name = 'Souza'
WHERE id = 2;

-- Atualização com expressão
UPDATE movies
SET rating = rating + 0.5
WHERE year < 2000;
