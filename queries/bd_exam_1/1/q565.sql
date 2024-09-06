SELECT DISTINCT G1.idG
FROM Giocain G1
JOIN Giocain G2 ON G1.idT = G2.idT
    AND G1.idG = G2.idG
JOIN Categoria C1 ON G1.idCat = C1.idCat
JOIN Categoria C2 ON G2.idCat = C2.idCat
JOIN Giocatore ON G1.idG = Giocatore.idG
WHERE C1.idCat = 1 
    AND C2.idCat = 2 
    AND Giocatore.Genere = 'F';
