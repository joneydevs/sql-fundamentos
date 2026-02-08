-- Dia 15: ALTER TABLE - alterando tabelas

--Inserindo nova colunas

ALTER TABLE mytable
ADD column DataType OptionalTableConstraint 
    DEFAULT default_value;

-- Removendo colunas

ALTER TABLE mytable
DROP column_to_be_deleted;

-- Renomeando colunas

ALTER TABLE mytable
RENAME TO new_table_name;
