SELECT IdT 
FROM TORNEO 
NATURAL JOIN GIOCAIN 
NATURAL JOIN GIOCATORE 
GROUP BY IdT 
HAVING COUNT(DISTINCT NAZIONE) >= ALL (SELECT IdT, COUNT(DISTINCT NAZIONE) 
FROM TORNEO 
NATURAL JOIN GIOCAIN 
NATURAL JOIN GIOCATORE 
GROUP BY IdT);
