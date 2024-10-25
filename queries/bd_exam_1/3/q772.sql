SELECT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
JOIN GIOCAIN gi1 ON g.IdG = gi1.IdG
JOIN TORNEO t1 ON gi1.IdT = t1.IdT
JOIN GIOCAIN gi2 ON g.IdG = gi2.IdG
JOIN TORNEO t2 ON gi2.IdT = t2.IdT
WHERE g.Nazione = 'Italia'
  AND t1.NomeT = 'US Open'
  AND t2.NomeT = 'Australian Open'
  AND EXTRACT(YEAR FROM t1.DataI) = EXTRACT(YEAR FROM t2.DataI)
GROUP BY g.IdG, g.Nome, g.Cognome
HAVING COUNT(DISTINCT t1.IdT) > 0
   AND COUNT(DISTINCT t2.IdT) > 0;
