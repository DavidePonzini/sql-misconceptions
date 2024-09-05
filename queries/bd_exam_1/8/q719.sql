SELECT IdT 
FROM Torneo 
JOIN Giocatore ON NomeT = Genere
WHERE DataN = (
    SELECT MAX(AVG(DataN)) 
    FROM Giocatore
);
