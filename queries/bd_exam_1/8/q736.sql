SELECT IdT 
FROM Giocain NATURAL JOIN Giocatore 
GROUP BY IdT 
HAVING AVG(currentdate - DataN) = (SELECT AVG(currentdate - DataN) as eta 
FROM Giocatore GROUP BY IdT 
HAVING eta = MAX(eta))
