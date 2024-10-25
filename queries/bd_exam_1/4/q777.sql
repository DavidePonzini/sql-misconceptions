SELECT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
WHERE g.Nazione = 'Germania'
  AND g.IdG NOT IN (
    SELECT gi.IdG
    FROM GIOCAIN gi
    JOIN TORNEO t ON gi.IdT = t.IdT
    WHERE t.NomeT = 'Wimbledon'
  );
