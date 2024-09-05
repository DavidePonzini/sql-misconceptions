SELECT DISTINCT IdG
FROM GIOCATORI AS G
NATURAL JOIN GIOCAIN AS G1
NATURAL JOIN CATEGORIA

WHERE G.Genere = 'Femmina'
AND NomeCategoria = 'Singolo'
AND EXISTS 
(SELECT * FROM GIOCAIN
NATURAL JOIN CATEGORIA 
WHERE IdG=G.IdG AND IdT = G1.IdT AND
NomeCategoria = 'Doppio')