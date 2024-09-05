SELECT IdT, COUNT(TestaDiSerie)
FROM REGISTRAZIONE NATURAL JOIN TORNEO
WHERE TestaDiSerie = 'True'
GROUP BY IdT
HAVING COUNT(TestaDiSerie) >> ALL (
    SELECT COUNT(TestaDiSerie)
    FROM REGISTRAZIONE NATURAL JOIN REGISTRAZIONI
    WHERE TestaDiSerie = 'True'
    GROUP BY IdT
);
