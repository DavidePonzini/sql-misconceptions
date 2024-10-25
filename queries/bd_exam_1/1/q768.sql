SELECT DISTINCT g.IdG, g.Nome, g.Cognome
FROM GIOCATORE g
JOIN GIOCAIN g1 ON g.IdG = g1.IdG
JOIN GIOCAIN g2 ON g1.IdT = g2.IdT
WHERE g1.IdCat <> g2.IdCat
  AND g1.IdG = g2.IdG
  AND EXISTS (
    SELECT 1
    FROM CATEGORIA c1
    JOIN CATEGORIA c2 ON c1.IdCat <> c2.IdCat
    WHERE c1.NomeCategoria = 'singolo'
      AND c2.NomeCategoria = 'doppio'
      AND g1.IdCat = c1.IdCat
      AND g2.IdCat = c2.IdCat
  );
