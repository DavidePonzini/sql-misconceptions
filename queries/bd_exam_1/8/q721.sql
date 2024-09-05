SELECT IdT 
FROM Torneo 
JOIN Registrazione ON Torneo.IdT = Registrazione.IdT 
JOIN Giocain ON Registrazione.NumRegistrazione = Giocain.NumRegistrazione 
JOIN Giocatore ON Giocain.IdG = Giocatore.IdG 
GROUP BY IdT 
HAVING AVG(Current_Date - Giocatore.DataN) = ALL (
    SELECT AVG(Current_Date - Giocatore.DataN) 
    FROM Giocatore 
    JOIN Giocain ON Giocain.IdG = Giocatore.IdG 
    JOIN Registrazione ON Giocain.NumRegistrazione = Registrazione.NumRegistrazione 
    JOIN Torneo ON Registrazione.IdT = Torneo.IdT 
    GROUP BY IdT
);
