-- MINI PROJETO 2 (PostgreSQL): SISTEMA DE AGENDAMENTO
-- Modelagem sugerida (MVP)

-- ENTIDADES
-- paciente: pessoa que agenda
-- profissional: pessoa que atende
-- consulta: agendamento em data/hora com status

-- RELACIONAMENTOS
-- paciente (1) -> (N) consulta
-- profissional (1) -> (N) consulta

-- CAMPOS (mínimo)
-- paciente:
-- - id (PK)
-- - nome
-- - email (único)
-- - telefone (opcional)
-- - criado_em

-- profissional:
-- - id (PK)
-- - nome
-- - email (único)
-- - criado_em

-- consulta:
-- - id (PK)
-- - paciente_id (FK)
-- - profissional_id (FK)
-- - data_hora (quando acontece)
-- - status (MARCADA/CANCELADA/REALIZADA)
-- - observacao (opcional)
-- - criado_em

-- REGRAS DE NEGÓCIO
-- 1) consulta sempre tem paciente_id e profissional_id
-- 2) status permitido: MARCADA, CANCELADA, REALIZADA
-- 3) impedir conflitos: mesmo profissional no mesmo data_hora (unique)
-- 4) impedir paciente duplicado no mesmo data_hora (unique)
-- 5) data_hora é obrigatória

-- CONSULTAS QUE A API VAI PRECISAR (exemplos)
-- 1) Listar agenda do profissional por dia (filtrar por data)
-- 2) Listar consultas do paciente
-- 3) Criar consulta (status começa MARCADA)
-- 4) Cancelar consulta (muda status)
-- 5) Marcar como realizada (muda status)
