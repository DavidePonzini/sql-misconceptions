SELECT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
JOIN GIOCAIN gi ON g.IdG = gi.IdG
JOIN TORNEO t ON gi.IdT = t.IdT
WHERE g.Nazione = 'Italia'
  AND t.NomeT IN ('US Open', 'Australian Open')
  AND EXTRACT(YEAR FROM t.DataI) = EXTRACT(YEAR FROM t.DataI)
GROUP BY g.IdG, g.Nome, g.Cognome
HAVING COUNT(DISTINCT CASE WHEN t.NomeT = 'US Open' THEN t.IdT END) > 0
   AND COUNT(DISTINCT CASE WHEN t.NomeT = 'Australian Open' THEN t.IdT END) > 0;
