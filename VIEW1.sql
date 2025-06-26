CREATE OR REPLACE VIEW historico_academico_completo AS
SELECT 
    m.nomeAluno || ' ' || m.sobrenomeAluno AS aluno,
    u.email,
    d.nome AS disciplina,
    m.periodoLetivo,
    m.notaFinal,
    m.status,
    c.nome AS curso,
    un.cidade || ' - ' || un.estado AS unidade
FROM matricula m
JOIN aluno a ON a.nome = m.nomeAluno AND a.sobrenome = m.sobrenomeAluno AND a.telefone = m.telefoneAluno
JOIN usuario u ON u.nome = m.nomeAluno AND u.sobrenome = m.sobrenomeAluno AND u.telefone = m.telefoneAluno
JOIN disciplina d ON d.codigo = m.codigoDisciplina
LEFT JOIN compoe cp ON cp.codigoDisciplina = d.codigo
LEFT JOIN curso c ON c.codigo = cp.codigoCurso
LEFT JOIN unidade un ON d.codigoUnidade = un.codigo;
