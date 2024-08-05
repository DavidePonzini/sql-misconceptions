SELECT Prodotto.nome
FROM Prodotto, DettaglioOrdine, Categoria, Ordine
WHERE Prodotto.idProd=DettaglioOrdine.idProd AND Categoria.idCat = Prodotto.idCat AND EXTRACT (YEAR FROM data) = 2023
AND Ordine.idOrd= DettaglioOrdine.idOrd
GROUP BY Categoria, idCat
HAVING SUM (DettaglioOrdine.quantità) = 0
