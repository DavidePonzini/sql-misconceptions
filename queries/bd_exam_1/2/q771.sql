SELECT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
JOIN GIOCAIN gi ON g.IdG = gi.IdG
JOIN REGISTRAZIONE r ON gi.NumRegistrazione = r.NumRegistrazione
LEFT JOIN REGISTRAZIONE r2 ON r.IdT = r2.IdT
  AND r.IdCat = r2.IdCat
  AND r2.TestaDiSerie = TRUE
  AND r.NumRegistrazione = r2.NumRegistrazione
WHERE g.Nazione = 'Francia'
  AND r2.NumRegistrazione IS NULL;
