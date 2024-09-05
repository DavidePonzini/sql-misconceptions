SELECT IdT
FROM Torneo T FROM Torneo 
NATURAL JOIN Registrazione 
NATURAL JOIN Giocain 
NATURAL JOIN Giocatore 
GROUP BY IdT 
HAVING AVG(DataF - DataN) > (
    SELECT AVG(T.DataF - DataN) 
    FROM Torneo 
    NATURAL JOIN Registrazione 
    NATURAL JOIN Giocain 
    NATURAL JOIN Giocatore
);
