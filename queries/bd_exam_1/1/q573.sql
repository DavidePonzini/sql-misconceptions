SELECT IdG
FROM GIOCATORE NATURAL JOIN GIOCAIN AS T NATURAL JOIN CATEGORIA
WHERE genereCategoria='Donna' AND NomeCategoria='Singoli'
AND IN (SELECT IdG
FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN CATEGORIA
WHERE genereCategoria='Donna' AND NOMEcategorig ='Doppi'
AND IdT=T.IdT)