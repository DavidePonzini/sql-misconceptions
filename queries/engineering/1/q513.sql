SELECT p.nome
FROM Prodotto p
JOIN Categoria c ON p.idCat = c.idCat
LEFT JOIN DettaglioOrdine d1 ON p.idProd = d1.idProd
LEFT JOIN Ordine o ON d1.idOrd = o.idOrd
WHERE c.nome = 'bevande'
  AND (o.data IS NULL OR o.data < '2023-01-01' OR o.data >= '2024-01-01');
