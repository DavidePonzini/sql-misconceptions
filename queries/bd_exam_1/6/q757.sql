SELECT 
    G.IdG, 
    G.Nome, 
    G.Cognome, 
    COUNT(DISTINCT GI.IdT) AS NumeroTornei
FROM 
    GIOCATORE G
JOIN 
    GIOCAIN GI ON G.IdG = GI.IdG
GROUP BY 
    G.IdG, G.Nome, G.Cognome
ORDER BY 
    NumeroTornei DESC
LIMIT 1;
