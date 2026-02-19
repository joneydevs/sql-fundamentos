INSERT INTO pedido (cliente_id, status)

VALUES

((SELECT id FROM cliente WHERE nome='João' COLLATE NOCASE), 'ABERTO'), 
((SELECT id FROM cliente WHERE nome='Maria'), 'ABERTO'),
((SELECT id FROM cliente WHERE nome='João'), 'CANCELADO'),
((SELECT id FROM cliente WHERE nome='Maria'), 'PAGO'),
((SELECT id FROM cliente WHERE nome='Luiza'), 'ABERTO'),
((SELECT id FROM cliente WHERE nome='Gustavo'), 'ABERTO'),
((SELECT id FROM cliente WHERE nome='Eusébio'), 'ABERTO'),
((SELECT id FROM cliente WHERE nome='Isabela'), 'ABERTO'),
((SELECT id FROM cliente WHERE nome='Marina'), 'ABERTO'),
((SELECT id FROM cliente WHERE nome='Ana'), 'ABERTO'),
((SELECT id FROM cliente WHERE nome='Álvaro'), 'ABERTO'),
((SELECT id FROM cliente WHERE nome='Isabela'), 'CANCELADO'),
((SELECT id FROM cliente WHERE nome='Marina'), 'PAGO'),
((SELECT id FROM cliente WHERE nome='Ana'), 'PAGO'),
((SELECT id FROM cliente WHERE nome='Álvaro'), 'CANCELADO');
