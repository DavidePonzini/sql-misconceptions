SELECT 
    T.NomeT,
    COUNT(R.TestaDiSerie) AS NumTestaDiSerie
FROM 
    TORNEO T
JOIN 
    REGISTRAZIONE R ON T.IdT = R.IdT
WHERE 
    R.TestaDiSerie = TRUE
GROUP BY 
    T.IdT, T.NomeT
ORDER BY 
    NumTestaDiSerie DESC
LIMIT 1;
