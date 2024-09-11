SELECT t.NomeT, COUNT(r.TestaDiSerie) AS NumeroTesteDiSerie
FROM TORNEO t
JOIN REGISTRAZIONE r ON t.IdT = r.IdT
WHERE r.TestaDiSerie = TRUE
GROUP BY t.IdT, t.NomeT
ORDER BY NumeroTesteDiSerie DESC
LIMIT 1;
