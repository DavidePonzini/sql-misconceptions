SELECT p. nome
FROM Prodotto p
JOIN Categoria c ON p.idCat = c.idCat
WHERE c.nome = 'bevande'
AND p.id Prod NOT IN (SELECT d.idProd
FROM Dettaglio_Ordine d WHERE d.idOrd IN ( SELECT idOrd
FROM Dettaglio_Ordine
WHERE YEAR data = '2023'
