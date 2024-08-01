SELECT p.Nome
FROM
Prodotto p
JOIN
Dettaglio_ORDINE ON p.IDProd= d.IDProd
JOIN
Ordine O ON
O.IDORD = 0.IDORDD
WHERE p.IdCat ="bevanDe" AND
YEAR(O.Data)! = 2023 OR O.IDPROD IS NULL
