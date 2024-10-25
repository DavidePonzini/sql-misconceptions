SELECT DISTINCT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
JOIN GIOCAIN g1 ON g.IdG = g1.IdG
JOIN GIOCAIN g2 ON g1.IdT = g2.IdT AND g1.IdCat <> g2.IdCat
JOIN CATEGORIA c1 ON g1.IdCat = c1.IdCat
JOIN CATEGORIA c2 ON g2.IdCat = c2.IdCat
WHERE c1.NomeCategoria = 'singolo' AND c2.NomeCategoria = 'doppio';