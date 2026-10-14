-- Migração de exemplo solicitada na avaliação.
ALTER TABLE notas ADD COLUMN descricao TEXT;
-- Disparo do workflow de migracao para a avaliacao.
