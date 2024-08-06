SELECT p.nome
FROM Prodotto p
JOIN Categoria c ON p.idCat = c.idCat
LEFT JOIN DettaglioOrdine do ON p.idProd = do.idProd
LEFT JOIN Ordine o ON do.idOrd = o.idOrd
WHERE c.nome = 'bevande'
  AND (o.data IS NULL OR o.data < '2023-01-01' OR o.data >= '2024-01-01');
