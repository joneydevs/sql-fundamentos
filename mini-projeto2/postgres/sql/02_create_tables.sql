-- MINI PROJETO: SISTEMA DE AGENDAMENTO DE CONSULTAS
-- CREATE TABLES (PK/FK/CONSTRAINS/DEFAULTS) 
-- SQL POSTGRES

--- TABELA 1 paciente (guarda dados do paciente)

CREATE TABLE  IF NOT EXISTS paciente (                                             -- Criação da tabela

	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,			   -- id deve ser de preenchimento automático e é uma chave primária 
	nome VARCHAR(100) NOT NULL, 						   -- nome apenas não pode estar vazio
	email VARCHAR(100) NOT NULL UNIQUE					   -- e-mail não pode ser vazio e o UNIQUE impede que o e-mail se repita
		CHECK (email ~ '^[^@]+@[^@]+\.[^@]+$'),				   -- check para ver se o e-mail tem o padrão comum dos e-mails
	celular TEXT NOT NULL 							   -- celular do paciente não pode ser vazio
		CHECK (celular ~ '^[0-9]{11}$'),					   -- check para saber se o celular tem 11 caracteres e números
	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP			   -- coluna para inclusão da data da criação do cadastro do paciente
);

-- Criar a função de trigger para garantir que o e-mail seja gravado com minúsculos --

CREATE OR REPLACE FUNCTION paciente_email_minusculo()
RETURNS TRIGGER AS $$
BEGIN
    NEW.email := LOWER(NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar o trigger para executar a função

CREATE TRIGGER trg_email_minusculo
BEFORE INSERT OR UPDATE ON paciente
FOR EACH ROW
EXECUTE FUNCTION paciente_email_minusculo();


-- TABELA 2 profissional (guarda dados do médico)

CREATE TABLE IF NOT EXISTS profissional (

	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	especialidade VARCHAR(100) NOT NULL,
	email VARCAR (100) NOT NULL UNIQUE
		CHECK (email ~'^[^@]+@[^@]+\.[^@]+$),
	celular TEXT NOT NULL
		CHECK (celular ~'^[0-9]{11}$'),
	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Criar a função de trigger para garantir que o e-mail seja gravado com minúsculos --

CREATE OR REPLACE FUNCTION profissional_email_minusculo()
RETURNS TRIGGER AS $$
BEGIN
    NEW.email := LOWER(NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar o trigger para executar a função

CREATE TRIGGER trg_email_minusculo
BEFORE INSERT OR UPDATE ON profissional
FOR EACH ROW
EXECUTE FUNCTION profissional_email_minusculo();


-- TABELA 3 contempla o agendamento das consultadas

CREATE TABLE IF NOT  EXISTS consulta (

	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	paciente_id INTEGER NOT NULL,
	profissional_id INTEGER NOT NULL,
	data_hora TIMESTAMP NOT NULL,
	status VARCHAR(20) NOT NULL
		CHECK (status IN ('MARCADA', 'CANCELADA', 'REALIZADA')),
	obs TEXT,
	criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,


UNIQUE (profissional_id, data_hora),
UNIQUE (paciente_id, data_hora),


FOREIGN KEY (paciente_id) REFERENCES paciente(id)

ON DELETE RESTRICT,

FOREIGN KEY (profissional_id) REFERENCES profissional(id)

ON DELETE RESTRICT

);

-- Criação de índices - no postgres PK e unique já criam índices automaticamente, não sendo necessário a criação de indice no meu caso, porém estou mantendo a criação para efeito didático

CREATE INDEX IF NOT EXISTS idx_paciente_id ON consulta (paciente_id, data_hora);
CREATE INDEX IF NOT EXISTS idx_profissional_id ON consulta (profissional_id, data_hora);

