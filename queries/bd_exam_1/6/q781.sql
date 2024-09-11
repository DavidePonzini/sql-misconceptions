SELECT g.IdG, g.Nome, g.Cognome, COUNT(DISTINCT gi.IdT) AS num_tournaments
FROM GIOCATORE g
JOIN GIOCAIN gi ON g.IdG = gi.IdG
GROUP BY g.IdG, g.Nome, g.Cognome
ORDER BY num_tournaments DESC
LIMIT 1;
