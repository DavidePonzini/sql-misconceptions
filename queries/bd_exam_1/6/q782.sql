WITH TournamentCounts AS (
    SELECT gi.IdG, COUNT(DISTINCT gi.IdT) AS num_tournaments
    FROM GIOCAIN gi
    GROUP BY gi.IdG
)
SELECT g.IdG, g.Nome, g.Cognome, tc.num_tournaments
FROM GIOCATORE g
JOIN TournamentCounts tc ON g.IdG = tc.IdG
ORDER BY tc.num_tournaments DESC
LIMIT 1;
