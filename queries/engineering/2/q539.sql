SELECT SUM(ProdOtto.prezzo * Dettaglio_OrdiNe.quantità)
FROM Prodotto P
JOIN DETTAGLIO_ORDINE d ON Prodotto.idProd = DETTAGLIO_ORDINE.idProD
JOIN Ordine O ON O.idOrd = d.IdOrd
Order by O.data
LIMIT 1;
