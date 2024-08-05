SELECT p.Nome
FROM
Prodotto p
JOIN
DettaglioORDINE d ON p.IDProd= d.IDProd
JOIN
Ordine O ON
O.IDORD = d.IDORDD
WHERE p.IdCat ="bevande" AND
EXTRACT (YEAR FROM Ordine.data)! = 2023 OR O.IDPROD IS NULL
