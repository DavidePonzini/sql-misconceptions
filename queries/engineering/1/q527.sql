SELECT p. nome
FROM Prodotto p
JOIN Categoria c ON p.idCat = c.idCat
WHERE c.nome = 'bevande'
AND p.idProd NOT IN (SELECT d.idProd
FROM Dettaglio_Ordine d WHERE d.idOrd IN ( SELECT idOrd
FROM Dettaglio_Ordine
WHERE EXTRACT(YEAR FROM O.data) = '2023'
