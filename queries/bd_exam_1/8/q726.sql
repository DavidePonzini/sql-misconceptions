SELECT DISTINCT IdT 
FROM Torneo 
NATURAL JOIN Registrazione 
NATURAL JOIN Giocain 
NATURAL JOIN Giocatore 
GROUP BY IdT 
HAVING SUM(DataN) <= ALL (
    SELECT SUM(DataN) 
    FROM Torneo 
    NATURAL JOIN Registrazione 
    NATURAL JOIN Giocain 
    NATURAL JOIN Giocatore 
    GROUP BY IdT
);
