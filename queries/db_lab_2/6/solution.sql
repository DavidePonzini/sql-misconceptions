SELECT
    s.cognome,
    s.nome
FROM studenti s
    JOIN pianidistudio p on s.matricola = p.studente
WHERE
    p.anno = 5
    AND p.annoaccademico = 2011
    AND s.relatore IS NOT NULL
ORDER BY s.cognome DESC, s.nome DESC;