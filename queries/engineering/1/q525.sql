SELECT Prodotto.nome, prodotto.idProd
FROM Categoria INNER JOIN Dettaglio_Ordine INNER JOIN Prodotto ON
Prodotto.idProd = Dettaglio_Ordine.idOrd) ON Categoria.idcat = Prodotto.idCat
WHERE Categoria.none ="bevande" and Ordine.data.anno <> 2023;
