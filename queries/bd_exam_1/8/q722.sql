SELECT NomeT 
FROM Torneo 
JOIN Registrazione ON Registrazione.IdT = IdT 
JOIN Giocain ON Giocain.NumRegistrazione = Registrazione.NumRegistrazione 
JOIN Giocatore ON Giocain.IdG = Giocatore.IdG 
HAVING AVG(Current_Date - DataN) > ALL (
    SELECT AVG(Current_Date - DataN) 
    FROM Giocain 
    JOIN Giocatore ON Giocain.IdG = Giocatore.IdG
);
