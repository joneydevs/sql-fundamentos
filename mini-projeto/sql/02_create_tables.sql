-- MINI PROJETO: SISTEMAS DE PEDIDOS
-- 02 - CREATE TABLES (com PK/FK/Constraints/defaults)

PRAGMA foreign_keys = ON; -- Ativa verificação de chaves estrangeiras no SQLite (retirar nos demais)

-- TABELA 1 cliente (guarda dados dos clientes)

CREATE TABLE IF NOT EXISTS cliente (
	id               INTEGER  PRIMARY KEY AUTOINCREMENT,               -- identificador único do cliente
	nome             TEXT     NOT NULL,                                -- nome do cliente
	email            TEXT     NOT NULL UNIQUE,                         -- email único
	criado_em        TEXT     NOT NULL DEFAULT (datetime('now'))       -- data de criação com preenchimento automático
);

-- TABELA 2 produto (registra informações do produto, especialmente preço)

CREATE TABLE IF NOT EXISTS produto (
	id               INTEGER PRIMARY KEY AUTOINCREMENT,               -- identificador único do produto
	nome             TEXT    NOT NULL,                                -- nome do produto
	preco_atual      REAL    NOT NULL CHECK (preco_atual >=0),        -- indica o preço atual do produto
	ativo            INTEGER NOT NULL DEFAULT 1 CHECK (ativo IN(0,1)), -- confere se o produto está ativo ou não
	criado_em        TEXT    NOT NULL DEFAULT (datetime('now'))       -- data de criação do produto
);

-- TABELA 3 pedidos (registra os pedidos gerados pelos clientes)

CREATE TABLE IF NOT EXISTS pedido (
	id               INTEGER PRIMARY KEY AUTOINCREMENT,              -- identificador único do pedido
	client_id        INTEGER NOT NULL,                               -- identificador único do cliente
	status           TEXT    NOT NULL DEFAULT 'ABERTO'               -- por default pedido aberto, serve para verificar finalização ou andamento do pedido
		         CHECK (status IN ('ABERTO','PAGO','CANCELADO')),-- check serve para garantir que o valor preennchido será uma das três opções listadas)
	criado_em        TEXT    NOT NULL DEFAULT (datetime('now')), 
FOREIGN KEY (client_id) REFERENCES cliente(id)                          -- amarra as chaves criando conexão entre as tabelas de pedidos e clientes
 ON UPDATE CASCADE                                                       -- CASCADE amarra as atualizações do PK da tabela clientes alterando também na tabela pedido
 ON DELETE RESTRICT                                                      -- DELETE impede a exclusão do cliente se existirem pedidos vinculados
);

-- TABELA 4 pedido_item (registra os dados os itens dos pedidos)

CREATE TABLE IF NOT EXISTS pedido_item (
	id               INTEGER PRIMARY KEY AUTOINCREMENT,              -- identificador único do pedido_item
        pedido_id        INTEGER NOT NULL,                  	 	 -- identificador do pedido, conectado via FK ao id da tabela de pedido
        produto_id       INTEGER NOT NULL,	  			 -- identificador do produto, conectado via FK ao id da tabela produto
        quantidade       INTEGER NOT NULL CHECK (quantidade > 0),        -- quantidade de itens, regra de negócio para que seja sempre maior que 0 e que não seja vazio
        preco_unitario   REAL    NOT NULL CHECK (preco_unitario >= 0),   -- preço unitário do pedido item

-- evita repetir o mesmo produto no mesmo pedido (força 1 linha por produto)

UNIQUE  (pedido_id, produto_id),                                         -- garante unicidade dos dados, o pedido deve ser único desde seja para produto diferente  

FOREIGN KEY (pedido_id) REFERENCES pedido(id)                            -- conexão do campo entre as tabelas de pedido(PK) e pedido_item (FK)
 ON UPDATE CASCADE 							 -- condição para atrelar mudanças no id do pedido, PK da tabela pedido, com o pedido_id
 ON DELETE CASCADE,							 -- condição para atrelar a exclusão do id do pedido

FOREIGN KEY (produto_id) REFERENCES produto(id) 			 -- conexão do campo entre as tabelas de produto (PK) e pedido_item (FK)
 ON UPDATE CASCADE							 -- condição para atrelar mudanças no id da tabela produto com a tabela pedido_item
 ON DELETE  RESTRICT							 -- condição para impedir a exclusão do ID da FK
);

-- Índices úteis (performance)
CREATE INDEX IF NOT EXISTS idx_pedido_client_id ON pedido(client_id);  -- índice criado para facilitar e melhorar performance de consultas a partir do cliente_id
CREATE INDEX IF NOT EXISTS idx_item_pedido_id   ON pedido_item(pedido_id); -- índice criado para facilitar e melhorar performance de consultas a partir do pedido_id
CREATE INDEX IF NOT EXISTS idx_item_produto_id  ON pedido_item(produto_id); -- índice criado para facilitar e melhorar performance de consultas a partir do produto_id
