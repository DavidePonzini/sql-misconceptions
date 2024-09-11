SELECT 
    T.NomeT AS TournamentName,
    COUNT(DISTINCT G.Nazione) AS NumberOfNations
FROM 
    GIOCAIN GI
JOIN 
    GIOCATORE G ON GI.IdG = G.IdG
JOIN 
    TORNEO T ON GI.IdT = T.IdT
GROUP BY 
    T.NomeT
ORDER BY 
    NumberOfNations DESC
LIMIT 1;
