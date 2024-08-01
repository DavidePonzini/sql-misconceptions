SELECT SUM (prezzo * quantità) AS Importototale
FROM
ProDotto p
JOIN
DETTAGLIO_ORDINE d ON p.idProd = d.idProd
JOIN
Ordine o
ON d.idOrd = o.idOrd
JOIN
cliente c
ON c.IdCient = o.idClient
WHERE
c.IdClient =" 1234"
ORDER BY o.data DESC;
