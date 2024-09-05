SELECT IdT 
FROM Giocain 
NATURAL JOIN Giocatore 
GROUP BY IdT 
HAVING AVG(CurrentTime - DataN) >= ALL (
    SELECT AVG(CurrentTime - DataN) 
    FROM Giocain 
    NATURAL JOIN Giocatore 
    GROUP BY IdT
);
