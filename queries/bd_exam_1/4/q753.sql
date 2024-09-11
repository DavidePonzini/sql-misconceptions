-- SQL Query: German players who have never participated in Wimbledon
SELECT g.Nome, g.Cognome, g.Nazione
FROM GIOCATORE g
WHERE g.Nazione = 'Germany'
  AND g.IdG NOT IN (
      SELECT gi.IdG
      FROM GIOCAIN gi
      JOIN REGISTRAZIONE r ON gi.IdT = r.IdT AND gi.IdCat = r.IdCat AND gi.NumRegistrazione = r.NumRegistrazione
      JOIN TORNEO t ON r.IdT = t.IdT
      WHERE t.NomeT = 'Wimbledon'
  );
