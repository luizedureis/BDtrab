CREATE OR REPLACE VIEW catalogo_detalhado_cursos AS
SELECT 
    c.codigo AS codigo_curso,
    c.nome AS nome_curso,
    c.nivel,
    c.cargaHoraria,
    c.vagas,
    c.salaDeAula,
    c.Ementa,
    d.nome AS nome_departamento,
    p.nome || ' ' || p.sobrenome AS nome_professor_chefe
FROM curso c
JOIN departamento d ON c.codigoDepartamento = d.codigo
JOIN professor p ON d.nomeProfessor = p.nome 
                 AND d.sobrenomeProfessor = p.sobrenome
                 AND d.telefoneProfessor = p.telefone;