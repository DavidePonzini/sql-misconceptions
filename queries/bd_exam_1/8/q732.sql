SELECT IdT 
FROM giocain NATURAL JOIN GIOCATORE
GROUP BY IdT 
HAVING AVG(CURRENT_DATE-DataN) YEAR >= ALL (SELECT AVG(CURRENT_DATE-DataN) YEAR 
FROM GIOCATORE NATURAL JOIN GIOCAIN 
GROUP BY IdT);
