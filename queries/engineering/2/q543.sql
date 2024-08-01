SELECT SUM (p.prezzo * do.quantità) AS Importo_Totale
FROM (Cliente c
JOIN Dettaglio_Ordine do ON c.idClient = do.idClient
WHERE C.id Client = '1234'
AND do. idOrd =
SELECT MAX (idOrd)
FROM Dettaglio_Ordine
WHERE idClient '1234'
