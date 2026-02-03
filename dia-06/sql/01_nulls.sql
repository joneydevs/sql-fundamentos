-- Dia 6 - NULL em SQL

-- Filtrar registros sem valor
SELECT *
FROM tabela_exemplo
WHERE coluna IS NULL;

-- Filtrar registros com valor
SELECT *
FROM tabela_exemplo
WHERE coluna IS NOT NULL;
