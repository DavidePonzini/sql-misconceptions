SELECT P.PREZZO, D1.quantità FROM CLIENTE AS C
INNER JOIN ORDINE AS O
ON O.IDCLIENT = C.IDCLIENT
INNER JOIN DETTAGLIO_ORDINE AS D1
ON O.IDORD = D1.IDORD
INNER JOIN PRODOTTO AS P
ON D1.IDPROD = P.IDPROD
WHERE C.IDCLIENT = '1234'
ORDER BY O.DATA DESC
LIMIT 1
