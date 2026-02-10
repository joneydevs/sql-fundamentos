-- MINI PROJETO: SISTEMA DE PEDIDOS

-- ENTIDADES
-- cliente
-- produto
-- pedido
-- pedido_item

-- RELACIONAMENTOS
-- cliente (1) -> (N) pedido
-- pedido (1) -> (N) pedido_item
-- produto (1) -> (N) pedido_item

-- REGRAS DE NEGÓCIO
-- Um pedido pertence a um cliente
-- Um pedido tem pelo menos um item
-- O preço do item é salvo no momento da compra
