SELECT IdT 
FROM Torneo 
NATURAL JOIN Registrazione 
NATURAL JOIN Giocain 
NATURAL JOIN Giocatore 
GROUP BY IdT 
HAVING AVG(DataN) >= ALL (
    SELECT AVG(DataN) 
    FROM Giocatore 
    NATURAL JOIN Giocain 
    NATURAL JOIN Registrazione 
    NATURAL JOIN Torneo 
    GROUP BY IdT
);
