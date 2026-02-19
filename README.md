# sql-fundamentos
Objetivo: consolidar SQL com entregáveis semanais, usando SQL para back-end orientado a dados.

#dia 2 - sql-fundamentos
- Primeiros comandos SQL (SELECT, WHERE, ORDER BY, LIMIT)
- Exercícios práticos realizados no SQLBolt (lições 1 a 3)

## Dia 3
- Funções de agregação (COUNT)
- Agrupamento de dados com GROUP BY
- Filtro de grupos com HAVING
- Exercícios práticos no SQLBolt (lições 4, 5 e 6)

## Dia 4
- Relacionamento entre tabelas
- Uso de INNER JOIN
- Entendimento de chave primária e estrangeira
- Exercícios práticos no SQLBolt

## Dia 5
- Uso de LEFT JOIN
- Diferença prática entre INNER JOIN e LEFT JOIN
- Entendimento de registros opcionais e valores NULL
- Exercícios práticos no SQLBolt

## Dia 6
- Entendimento do conceito de NULL
- Diferença entre NULL, 0 e string vazia
- Uso de IS NULL e IS NOT NULL
- Impacto do NULL em JOINs e agregações

## Dia 7
- Subqueries (IN, EXISTS)
- Uso de EXPRESSIONS em SELECT e WHERE
- Cálculos, funções e aliases (AS)

## Dia 8
- Funções de agregação básicas (COUNT, AVG, MAX, SUM)
- Diferença entre agregação e expressions

## Dia 9
- GROUP BY para agregação por grupo
- HAVING para filtrar resultados agregados
- Diferença prática entre WHERE e HAVING

## Dia 10 – Ordem de execução de uma query SQL

- Ordem real de execução de uma query
- Diferença entre WHERE e HAVING
- Uso correto de alias
- Impacto da ordem na escrita de queries
- Exercícios realizados no SQLBolt (lição 12)
-- Ordem real de execução:
-- 1. FROM / JOIN
-- 2. WHERE
-- 3. GROUP BY
-- 4. HAVING
-- 5. SELECT
-- 6. ORDER BY
-- 7. LIMIT / OFFSET

## Dia 11 - Inserção de Dados

- Inserir dados simples na tabela
- Inserir dados múltiplos na tabela
- Uso INSERT INTO e VALUES

##Dia 12 - 

- UPDATE e atualização de registros

## Dia 13

- Como deletar linhas inseridas

## Dia 14

- Criação de tabelas, entendimento da criação de tabela via CREATE TABLE
- Entendimento de tipo de Dado, PK e constrains associadas as linhas

## Dia 15

- Alterando tabelas já criadas
	- ADD column (adiciona colunas)
	- DROP (remove colunas) alguns bancos não suportam essa opção, sendo necessário migrar o banco
	- RENAME (renomear uma coluna já criada)


## APÓS O DIA 15

- A partir do dia 15 trabalhei na aplicação prática dos conceitos estudados no SQL Bolt, criando um mini projeto com 4 tabelas de vendas

 -- MINI PROJETO CADASTRO DE VENDAS

	- Tabela cliente
	- Tabela produto
	- Tabela pedido
	- Tabela pedido_item

- Novos conceitos foram estudados e inseridos na criação das tabelas

	- Pragma foreing_keys -- Ativa FK no SQLite, que estou usando nessa fase dos estudos
	- FOREING KEY (coluna_x) REFERENCES tabela(coluna_x) -- Amarra tabela pai com tabela filho via cascade update, restrict ou delete
	- CREATE INDEX IF NOT EXISTS -- Criação de indices para permitir melhor performance no banco

## Atualizações do dia 19/02/2026

### Estrutura e organização
- Separei os arquivos de INSERT por tabela, facilitando testes e manutenção.
- Renomeei arquivos SQL para melhor organização e clareza.
- Atualizei o README com instruções mais detalhadas.
- Configurei o `.gitignore` para evitar versionamento de arquivos desnecessários (.db, arquivos temporários, etc).

### Banco de dados
- Criei as tabelas `cliente`, `produto`, `pedido` e `pedido_item` com:
  - Primary Keys
  - Foreign Keys
  - Constraints (NOT NULL, UNIQUE, CHECK)
  - Regras de integridade referencial (ON UPDATE / ON DELETE)
  - Índices para otimização de consultas

- Inserção de dados realizada de forma controlada:
  - Inserts separados por tabela
  - Uso de `INSERT ... SELECT` com `UNION ALL`
  - Validação de chaves estrangeiras
  - Correção de conflitos de UNIQUE e FOREIGN KEY

### Testes realizados
- Verificação de integridade referencial
- Conferência de dados com `SELECT` e `COUNT`
- Ajuste de formatação no terminal (`.mode box` / `.headers on`)
