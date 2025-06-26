SELECT 
    m.nomeAluno || ' ' || m.sobrenomeAluno AS nome_completo,
    u.email
FROM 
    matricula m
JOIN 
    usuario u 
    ON u.nome = m.nomeAluno 
    AND u.sobrenome = m.sobrenomeAluno
    AND u.telefone = m.telefoneAluno
JOIN 
    disciplina d 
    ON d.codigo = m.codigoDisciplina
WHERE 
    d.nome = 'Disciplina1'
    AND m.periodoLetivo = '20251';
