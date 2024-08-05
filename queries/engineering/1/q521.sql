SELECT nome FROM prodotto
JOIN Categoria ON Categoria.idCat = Prodotto.idCat
WHERE Categoria.nome = 'bevande'
JOIN DettaglioOrdine ON DettaglioOrdine.idProd = Prodotto.idProd
JOIN Ordine ON Ordine.idOrd = DettaglioOrdine.idOrd
WHERE EXTRACT (YEAR FROM Ordine data) <> 2023 ;
