SELECT IdT
FROM REGISTRAZIONE
WHERE TestaDiSerie = TRUE
GROUP BY IdT
HAVING COUNT(*) >= ALL (
    SELECT COUNT(*)
    FROM REGISTRAZIONE
    WHERE TestaDiSerie = TRUE
    GROUP BY IdT
);
