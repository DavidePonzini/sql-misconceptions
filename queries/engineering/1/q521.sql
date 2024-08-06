SELECT nome FROM prodotto
JOIN Categoria ON Categoria.idCat = Prodotto.idCat
WHERE Categoria.nome = "bevande"
JOIN Dettaglio_Ordine ON Dettaglio_Ordine.idProd = Prodotto.idProd
JOIN Ordine ON Ordine.idOrd = Dettaglio_Ordine.idOrd
WHERE EXTRACT (YEAR FROM Ordine data) <> 2023 ;
