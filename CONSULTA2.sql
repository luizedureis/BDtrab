SELECT 
    d.nome AS disciplina,
    m.notaFinal,
    ROUND(AVG(m.notaFinal) OVER (), 2) AS media_geral
FROM 
    matricula m
JOIN 
    disciplina d ON m.codigoDisciplina = d.codigo
WHERE 
    m.nomeAluno = 'Aluno3'
    AND m.sobrenomeAluno = 'SobAluno3'
    AND m.telefoneAluno = '9117817125'
    AND m.status = 'concluída';