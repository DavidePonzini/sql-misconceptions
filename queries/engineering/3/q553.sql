SELECT nome FROM Prodotto
JOIN Dettaglio_Ordine ON Prodotto.idProd = Dettaglio_OrdiNe.id Prod
JOIN Ordine ON Ordine.idOrd = DettagliO_Ordine.idOrd
JOIN Cliente ON Cliente.idClient = Ordine.idClient
WHERE Cliente.citta NOT IN ("Venezia", "Brescia")
