WITH ultimo_semestre AS (
    SELECT MAX(semestreLetivo) AS semestre
    FROM ministra
    WHERE nomeProfessor = 'Professor1'
      AND sobrenomeProfessor = 'SobProfessor1'
      AND telefoneProfessor = '9231298646'
),
avaliacoes_professor AS (
    SELECT 
        a.notaDidatica,
        a.notaMaterial,
        a.notaRelevancia,
        a.notaInfra
    FROM 
        avalia a
    JOIN 
        ministra m ON a.nomeProfessor = m.nomeProfessor 
                  AND a.sobrenomeProfessor = m.sobrenomeProfessor 
                  AND a.telefoneProfessor = m.telefoneProfessor 
                  AND a.codigoDisciplina = m.codigoDisciplina
    WHERE 
        m.nomeProfessor = 'Professor1'
        AND m.sobrenomeProfessor = 'SobProfessor1'
        AND m.telefoneProfessor = '9231298646'
        AND m.semestreLetivo = (SELECT semestre FROM ultimo_semestre)
)
SELECT 
    ROUND(AVG(notaDidatica), 2) AS media_didatica,
    ROUND(AVG(notaMaterial), 2) AS media_material,
    ROUND(AVG(notaRelevancia), 2) AS media_relevancia,
    ROUND(AVG(notaInfra), 2) AS media_infra
FROM 
    avaliacoes_professor;