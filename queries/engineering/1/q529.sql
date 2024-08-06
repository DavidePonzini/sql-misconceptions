SELECT Prodotto.nome
FROM Prodotto, Dettaglio_Ordine, Categoria, Ordine
WHERE Prodotto.idProd=DettaglioOrdine.idProd AND Categoria.idCat = Prodotto.idCat AND YEAR (date) = 2023
AND Ordine.idOrd= Dettaglio_Ordine.idOrd
GROUP BY Categoria, idCat
HAVING SUM (Dettaglio_Ordine.quantità) = 0
