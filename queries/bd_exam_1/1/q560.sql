SELECT G.IdG 
FROM GIOCAIN G 
NATURAL JOIN GIOCATORE 
NATURAL JOIN CATEGORIA 
WHERE Genere = 'f' 
AND NomeCategoria = 'Singolo' 
AND IdG IN (SELECT IdG 
FROM GIOCATORE 
NATURAL JOIN GIOCAIN 
NATURAL JOIN CATEGORIA 
WHERE NomeCategoria = 'Doppio' 
AND G.IdT = IdT);