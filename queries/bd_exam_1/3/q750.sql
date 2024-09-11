SELECT DISTINCT g.Nome, g.Cognome, t1.DataI AS Year
FROM GIOCATORE g
JOIN GIOCAIN gi1 ON g.IdG = gi1.IdG
JOIN REGISTRAZIONE r1 ON gi1.IdT = r1.IdT AND gi1.IdCat = r1.IdCat AND gi1.NumRegistrazione = r1.NumRegistrazione
JOIN TORNEO t1 ON r1.IdT = t1.IdT
JOIN GIOCAIN gi2 ON g.IdG = gi2.IdG
JOIN REGISTRAZIONE r2 ON gi2.IdT = r2.IdT AND gi2.IdCat = r2.IdCat AND gi2.NumRegistrazione = r2.NumRegistrazione
JOIN TORNEO t2 ON r2.IdT = t2.IdT
WHERE g.Nazione = 'Italy'
  AND t1.NomeT = 'US Open'
  AND t2.NomeT = 'Australian Open'
  AND EXTRACT(YEAR FROM t1.DataI) = EXTRACT(YEAR FROM t2.DataI);
