-- Select German players who have never participated in Wimbledon
SELECT g.Nome, g.Cognome
FROM GIOCATORE g
WHERE g.Nazione = 'Germany'
AND g.IdG NOT IN (
    SELECT gi.IdG
    FROM GIOCAIN gi
    JOIN TORNEO t ON gi.IdT = t.IdT
    WHERE t.NomeT = 'Wimbledon'
);
