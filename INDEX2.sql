CREATE INDEX idx_matricula_relatorio ON matricula(codigoDisciplina)
INCLUDE (status, notaFinal, periodoLetivo);

ANALYZE matricula;
