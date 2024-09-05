SELECT DISTINCT IdT 
FROM TORNEO 
NATURAL JOIN REGISTRAZIONE 
NATURAL JOIN GIOCAIN
NATURAL JOIN GIOCATORE 
GROUP BY IdT 
HAVING AVG(DataN) >= ALL (SELECT AVG(DataN) FROM GIOCATORE)
