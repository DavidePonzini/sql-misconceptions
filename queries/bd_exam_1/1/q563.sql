SELECT IdG, Nome, Cognome, IdT 
FROM Giocatore 
NATURAL JOIN Giocain 
NATURAL JOIN Torneo 
NATURAL JOIN Categoria 
WHERE Genere = 'F' 
AND NomeCategoria = 'Singolo'

INTERSECT

SELECT IdG, Nome, Cognome, IdT 
FROM Giocatore 
NATURAL JOIN Giocain 
NATURAL JOIN Torneo 
NATURAL JOIN Categoria 
WHERE Genere = 'F' 
AND NomeCategoria = 'Doppio';
