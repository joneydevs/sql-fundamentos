INSERT INTO pedido_item (pedido_id, produto_id, quantidade, preco_unitario_centavos)

SELECT
1,
id,
10,
preco_atual_centavos

FROM produto
WHERE nome = 'Boné'

UNION ALL

SELECT
2,
id,
100,
preco_atual_centavos

FROM produto
WHERE nome = 'Camisa'

UNION ALL

SELECT
3,
id,
99,
preco_atual_centavos

FROM produto
WHERE nome = 'Calça'

UNION ALL

SELECT
4,
id,
1000,
preco_atual_centavos

FROM produto
WHERE nome = 'Tênis de corrida'

UNION ALL

SELECT
5,
id,
9,
preco_atual_centavos

FROM produto
WHERE nome = 'Sapato social'

UNION ALL

SELECT
6,
id,
90,
preco_atual_centavos

FROM produto
WHERE nome = 'Camisa social' ;
