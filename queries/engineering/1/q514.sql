SELECT p.nome
FROM Prodotto p
JOIN Categoria c ON p.idCat = c.idCat
LEFT JOIN DettaglioOrdine d1 ON p.idProd = d1.idProd
LEFT JOIN Ordine o ON d1.idOrd = o.idOrd AND EXTRACT(YEAR FROM o.data) = 2023
WHERE c.nome = 'bevande'
AND o.idOrd IS NULL;
