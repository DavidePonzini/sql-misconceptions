SELECT DISTINCT X.IdG
FROM GIOCAIN NATURAL JOIN GIOCATORE NATURAL JOIN REGISTRAZIONE
WHERE X.NomeCategoria = 'singolo' AND X.genere = 'F'
AND X.IdG IN (SELECT IdG
FROM GIOCAIN NATURAL JOIN GIOCATORE
NATURAL JOIN REGISTRAZIONE NATURAL JOIN CATEGORIA
WHERE IdT = X.IdT AND IdG = X.IdG
AND genere = 'F'
AND NomeCategoria = 'doppi')