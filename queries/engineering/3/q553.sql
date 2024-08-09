SELECT nome FROM Prodotto
JOIN Dettaglio_Ordine ON Prodotto.idProd = Dettaglio_OrdiNe.idProd
JOIN Ordine ON Ordine.idOrd = DettagliO_Ordine.idOrd
JOIN Cliente ON Cliente.idClient = Ordine.idClient
WHERE Cliente.città NOT IN ("Venezia", "Brescia")
