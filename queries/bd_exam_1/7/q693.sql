SELECT IdT
FROM REGISTRAZIONE
WHERE TestaDiSerie = (
    SELECT MAX(TestaDiSerie)
    FROM REGISTRAZIONE
);
