SELECT DISTINCT IdT
FROM TORNEO NATURAL JOIN GIOCAIN NATURAL JOIN GIOCATORE
GROUP BY IdT
HAVING AVG(DataI-DataN) >= ALL 
(SELECT AVG(DataI-DataN)
  FROM TORNEO NATURAL JOIN GIOCAIN NATURAL JOIN GIOCATORE
  GROUP BY IdT)
