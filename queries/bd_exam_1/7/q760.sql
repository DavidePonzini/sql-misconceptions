SELECT T.NomeT, COUNT(R.TestaDiSerie) AS NumTesteDiSerie
FROM TORNEO T
JOIN REGISTRAZIONE R ON T.IdT = R.IdT
WHERE R.TestaDiSerie = TRUE
GROUP BY T.NomeT
ORDER BY NumTesteDiSerie DESC
LIMIT 1;
