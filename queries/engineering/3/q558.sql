SELECT Prodotto.nome FROM Prodotto, Dettaglio_Ordime, Cliente, Ordine
WHERE Prodotto.idProd= Dettaglio_ordine.idProd
AND Dettaglio_Ordine.idOrd = Ordine.idOrd
AND Ordine.idClient = ClienTe.idClient
AND Cliente città IN ('Venezia', 'Brescia')
GROUP BY Dettaglio_Ordine, idProd
HAVING COUNT (*) = 0 ;
