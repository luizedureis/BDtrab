CREATE OR REPLACE VIEW painel_avaliacao_professores AS
SELECT
    p.nome || ' ' || p.sobrenome AS nome_professor,
    d.nome AS disciplina,
    ROUND(AVG(a.notaDidatica), 2)   AS media_didatica,
    ROUND(AVG(a.notaMaterial), 2)   AS media_material,
    ROUND(AVG(a.notaRelevancia), 2) AS media_relevancia,
    ROUND(AVG(a.notaInfra), 2)      AS media_infra,
    STRING_AGG(a.texto, ' | ')      AS comentarios
FROM avalia a
JOIN professor p ON a.nomeProfessor = p.nome
               AND a.sobrenomeProfessor = p.sobrenome
               AND a.telefoneProfessor = p.telefone
JOIN disciplina d ON a.codigoDisciplina = d.codigo
GROUP BY p.nome, p.sobrenome, d.nome
ORDER BY nome_professor, disciplina;