
-- 03 - INSERTS (dados de exemplo)

PRAGMA foreign_keys = ON;

-- CLIENTES
INSERT INTO cliente (nome, email) VALUES
('Ana Lima',   'ana@exemplo.com'),
('Bruno Reis', 'bruno@exemplo.com'),
('Carla Souza','carla@exemplo.com'),
('Diego Melo', 'diego@exemplo.com');  -- vai ficar sem pedido (pra testar LEFT JOIN)

-- PRODUTOS (preço em centavos)
INSERT INTO produto (nome, preco_atual_centavos, ativo) VALUES
('Camiseta',  5900, 1),
('Calça',    12900, 1),
('Tênis',    24990, 1),
('Boné',      3990, 1),
('Meia',      1990, 1),
('Jaqueta',  19990, 0); -- produto inativo (pra discutir regra depois)

-- PEDIDOS
-- Obs: ids assumem inserção sequencial (SQLite AUTOINCREMENT)
INSERT INTO pedido (cliente_id, status) VALUES
(1, 'PAGO'),
(1, 'ABERTO'),
(2, 'PAGO'),
(3, 'CANCELADO');

-- ITENS DO PEDIDO
-- Pedido 1 (cliente 1, PAGO)
INSERT INTO pedido_item (pedido_id, produto_id, quantidade, preco_unitario_centavos) VALUES
(1, 1, 2, 5900),   -- 2 camisetas
(1, 4, 1, 3990);   -- 1 boné

-- Pedido 2 (cliente 1, ABERTO)
INSERT INTO pedido_item (pedido_id, produto_id, quantidade, preco_unitario_centavos) VALUES
(2, 3, 1, 24990),  -- 1 tênis
(2, 5, 3, 1990);   -- 3 meias

-- Pedido 3 (cliente 2, PAGO)
INSERT INTO pedido_item (pedido_id, produto_id, quantidade, preco_unitario_centavos) VALUES
(3, 2, 1, 12900),  -- 1 calça
(3, 1, 1, 5900);   -- 1 camiseta

-- Pedido 4 (cliente 3, CANCELADO)
INSERT INTO pedido_item (pedido_id, produto_id, quantidade, preco_unitario_centavos) VALUES
(4, 4, 2, 3990);   -- 2 bonés
