SELECT DISTINCT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
JOIN GIOCAIN gi1 ON g.IdG = gi1.IdG
JOIN REGISTRAZIONE r1 ON gi1.IdT = r1.IdT AND gi1.IdCat = r1.IdCat AND gi1.NumRegistrazione = r1.NumRegistrazione
JOIN CATEGORIA c1 ON r1.IdCat = c1.IdCat
JOIN GIOCAIN gi2 ON g.IdG = gi2.IdG
JOIN REGISTRAZIONE r2 ON gi2.IdT = r2.IdT AND gi2.IdCat = r2.IdCat AND gi2.NumRegistrazione = r2.NumRegistrazione
JOIN CATEGORIA c2 ON r2.IdCat = c2.IdCat
WHERE c1.NomeCategoria = 'singles'
AND c2.NomeCategoria = 'doppio'
AND gi1.IdT = gi2.IdT;
