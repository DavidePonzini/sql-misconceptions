SELECT
    s.cognome,
    s.nome,
    p.cognome
FROM
    studenti s
    JOIN professori p ON s.relatore = p.id
ORDER BY s.cognome, s.nome;
