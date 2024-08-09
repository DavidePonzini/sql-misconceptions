SELECT Prodotto.nome
FROM (SELECT Prodotto.nome FROM Prodotto) - (SELECT Prodotto.nome
FROM Prodotto INNER JOIN Dettaglio_Ordine ON Prodotto.idprod = Dettaglio_Ordine.idProd
INNER JOIN Ordine ON Ordine.idord = Dettaglio_Ordine.idOrd
INNER JOIN Cliente ON Ordine.idClient = Cliente.idClient
WHERE Cliente.città = "Venezia"
OR CLiente.città = "Brescia"
GROUP BY prodotto.nome )
