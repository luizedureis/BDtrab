WITH ultimo_periodo AS (
    SELECT MAX(periodoLetivo) AS periodo
    FROM matricula
),
cursos_com_matricula AS (
    SELECT DISTINCT c.codigo
    FROM curso c
    JOIN compoe cp ON c.codigo = cp.codigoCurso
    JOIN matricula m ON m.codigoDisciplina = cp.codigoDisciplina
    WHERE m.periodoLetivo = (SELECT periodo FROM ultimo_periodo)
),
cursos_todos AS (
    SELECT codigo, nome FROM curso
)
SELECT ct.codigo, ct.nome
FROM cursos_todos ct
LEFT JOIN cursos_com_matricula cm ON ct.codigo = cm.codigo
WHERE cm.codigo IS NULL;