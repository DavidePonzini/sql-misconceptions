SELECT IdT
FROM REGISTRAZIONE
GROUP BY IdT
HAVING COUNT(TestaDiSerie) >= ALL (
    SELECT COUNT(TestaDiSerie)
    FROM REGISTRAZIONE
    GROUP BY IdT
);