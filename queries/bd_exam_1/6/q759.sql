SELECT 
    g.IdG,
    g.Nome,
    g.Cognome,
    COUNT(DISTINCT gi.IdT) AS TorneiGiocati
FROM 
    GIOCATORE g
JOIN 
    GIOCAIN gi ON g.IdG = gi.IdG
GROUP BY 
    g.IdG, g.Nome, g.Cognome
ORDER BY 
    TorneiGiocati DESC
LIMIT 1;
