SELECT g.Nome, g.Cognome
FROM GIOCATORE g
JOIN GIOCAIN gi ON g.IdG = gi.IdG
JOIN REGISTRAZIONE r ON gi.IdT = r.IdT AND gi.IdCat = r.IdCat AND gi.NumRegistrazione = r.NumRegistrazione
WHERE g.Nazione = 'France'
AND r.TestaDiSerie = FALSE;
