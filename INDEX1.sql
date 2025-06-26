CREATE INDEX idx_matricula_aluno
ON matricula (nomeAluno, sobrenomeAluno, telefoneAluno);

ANALYZE matricula;
