SELECT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
JOIN GIOCAIN gi ON g.IdG = gi.IdG
JOIN REGISTRAZIONE r ON gi.NumRegistrazione = r.NumRegistrazione
WHERE g.Nazione = 'Francia'
  AND NOT EXISTS (
    SELECT 1
    FROM REGISTRAZIONE r2
    WHERE r2.IdT = r.IdT
      AND r2.IdCat = r.IdCat
      AND r2.TestaDiSerie = TRUE
      AND r2.NumRegistrazione = r.NumRegistrazione
  );