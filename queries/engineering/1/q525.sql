SELECT Prodotto.nome, prodotto.idProd
FROM Categoria INNER JOIN DettaglioOrdine INNER JOIN Prodotto ON
Prodotto.idProd = DettaglioOrdine.idOrd ON Categoria.idcat = Prodotto.idCat
WHERE Categoria.none ="bevande" and Ordine.data.anno <> 2023;
