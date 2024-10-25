WITH NationCounts AS (
    SELECT t.IdT, t.NomeT, COUNT(DISTINCT g.Nazione) AS num_nazioni
    FROM TORNEO t
    JOIN GIOCAIN gi ON t.IdT = gi.IdT
    JOIN GIOCATORE g ON gi.IdG = g.IdG
    GROUP BY t.IdT, t.NomeT
)
SELECT IdT, NomeT, num_nazioni
FROM NationCounts
ORDER BY num_nazioni DESC
LIMIT 1;
