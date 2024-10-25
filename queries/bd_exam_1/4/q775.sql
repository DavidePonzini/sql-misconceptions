SELECT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
WHERE g.Nazione = 'Germania'
  AND NOT EXISTS (
    SELECT 1
    FROM GIOCAIN gi
    JOIN TORNEO t ON gi.IdT = t.IdT
    WHERE g.IdG = gi.IdG
      AND t.NomeT = 'Wimbledon'
  );
