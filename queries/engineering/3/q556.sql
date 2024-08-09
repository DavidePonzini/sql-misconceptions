SELECT Prodotto.nome
FROM Ordine INNER JOIN(
Dettaglio_Ordine INNER JOIN Prodotto
ON Dettaglio_Ordine.idProd=Prodotto.idProd) ON Ordine. idord = Dettaglio_Ordine.idProd
INNER jOIN CLIENTE ON cliente.idClient = ordine.idClient
INTERSECT
select prodotto.nome
FROM ORDINE JOIN DETTAGIOORDINE JOIN PRODOTO JOIN Cliente
WHERE Cliente.città = 'VENEZIA' AND Cliente.città = 'BRESCIA'
