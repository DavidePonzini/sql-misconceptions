SELECT p.nome
FROM Prodotto p
JOIN Categoria c ON p.idCat = c.idCat
LEFT JOIN DettaglioOrdine do ON p.idProd = do.idProd
LEFT JOIN Ordine o ON do.idOrd = o.idOrd AND EXTRACT(YEAR FROM o.data) = 2023
WHERE c.nome = 'bevande'
AND o.idOrd IS NULL;
