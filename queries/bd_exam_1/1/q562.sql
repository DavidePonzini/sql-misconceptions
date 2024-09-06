SELECT DISTINCT giocain.IdG
FROM giocain
JOIN categoria ON giocain.IdCat = categoria.IdCat
WHERE categoria.NomeCategoria = 'Singolo' 
AND giocain.IdG IN (
    SELECT p.IdG 
    FROM giocain AS p 
    JOIN categoria AS c ON p.IdCat = c.IdCat 
    WHERE c.NomeCategoria = 'Doppi' 
    AND p.IdT = giocain.IdT
);