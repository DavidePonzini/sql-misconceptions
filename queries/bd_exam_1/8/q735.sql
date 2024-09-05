SELECT IdT 
FROM Giocain NATURAL JOIN Giocatore 
WHERE AVG (currentdate - DataN) > ALL 
(SELECT AVG (currentdate - DataN) 
FROM Giocain NATURAL JOIN Giocatore 
WHERE IdT= T.IdT);
