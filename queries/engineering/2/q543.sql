SELECT SUM (p.prezzo * d1.quantità) AS Importo_Totale
FROM (Cliente c
JOIN Dettaglio_Ordine d1 ON c.idClient = d1.idClient
WHERE C.id Client = '1234'
AND d1. idOrd =
SELECT MAX (idOrd)
FROM Dettaglio_Ordine
WHERE idClient '1234'
