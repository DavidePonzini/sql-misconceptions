SELECT P.NOME FROM PRODOTTO AS P
INNER JOIN DETTAGLIO_ORDINE AS PO ON P.IDPROD = DO.IDPROD
INNER JOIN ORDINE AS O ON DO.IDPROD = O.IDORD
INNER JOIN CLIENTE AS C ON O.IDCLIENT = C.IDCLIENT WHERE C.città <> 'VENEZIA' OR C. città <> 'BRESCIA'
