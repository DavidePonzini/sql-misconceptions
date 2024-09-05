SELECT IdT 
FROM Torneo 
NATURAL JOIN Giocatore 
NATURAL JOIN Registrazione 
GROUP BY IdT 
HAVING AVG(DataCurr - DataN) >= ALL (
    SELECT AVG(DataCurr - DataN) 
    FROM Torneo 
    NATURAL JOIN Registrazione 
    NATURAL JOIN Giocatore 
    GROUP BY IdT
);
