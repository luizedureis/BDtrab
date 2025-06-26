WITH periodo_atual AS (
    SELECT MAX(periodoLetivo) AS periodo
    FROM matricula
)
SELECT 
    d.codigo,
    d.nome,
    COUNT(DISTINCT m.nomeAluno || m.sobrenomeAluno || m.telefoneAluno) AS total_alunos
FROM 
    matricula m
JOIN 
    disciplina d ON m.codigoDisciplina = d.codigo
WHERE 
    m.periodoLetivo = (SELECT periodo FROM periodo_atual)
GROUP BY 
    d.codigo, d.nome
ORDER BY 
    total_alunos DESC
LIMIT 5;
