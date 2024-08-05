SELECT p. nome
FROM Prodotto p
JOIN Categoria c ON p.idCat = c.idCat
WHERE c.nome = 'bevande'
AND p.idProd NOT IN SELECT d.idProd
FROM DettaglioOrdine d WHERE d.idOrd IN ( SELECT idOrd
FROM DettaglioOrdine
WHERE EXTRACT (YEAR FROM data) = '2023')
