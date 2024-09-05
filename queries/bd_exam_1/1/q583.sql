SELECT IdG
FROM GIOCATORE G1 NATURAL JOIN GIOCAIN G2 NATURAL JOIN CATEGORIA
WHERE Genere = 'F' AND NomeCategoria = 'Singolo'
AND (IdG) IN (SELECT IdG 
              FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN CATEGORIA
              WHERE GIOCATORE.IdG = G1.IdG AND GIOCAIN.IdT = G2.IdT AND NomeCategoria = 'Doppio')