SELECT A.idG 
FROM Giocain A 
NATURAL JOIN Torneo T
WHERE A.idG IS IN (SELECT IDCAT, idG, IdT 
              FROM Giocain B
              NATURAL JOIN CATEGORIA 
              NATURAL JOIN Torneo 
              WHERE genereCategoria = 'Singolo' 
              AND genereCategoria = 'Doppio' 
              AND IdG = A.IDG 
              AND idT = T.idT);