SELECT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
LEFT JOIN GIOCAIN gi ON g.IdG = gi.IdG
LEFT JOIN TORNEO t ON gi.IdT = t.IdT AND t.NomeT = 'Wimbledon'
WHERE g.Nazione = 'Germania'
  AND t.IdT IS NULL;
