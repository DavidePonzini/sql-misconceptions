SELECT idT 
FROM Torneo 
NATURAL JOIN Giocain 
NATURAL JOIN Giocatore
GROUP BY idT
HAVING COUNT(DISTINCT Nazione) >= ALL 
(SELECT COUNT(DISTINCT Nazione)
 FROM Giocain 
 NATURAL JOIN Giocatore 
 GROUP BY idT);
