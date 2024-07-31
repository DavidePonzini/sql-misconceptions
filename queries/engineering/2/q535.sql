SELECT SUM(p.prezzo * do.quantità) AS total_amount
FROM Ordine o
JOIN DettaglioOrdine do ON o.idOrd = do.idOrd
JOIN Prodotto p ON do.idProd = p.idProd
WHERE o.idClient = 1234
AND o.data = (
    SELECT MAX(data)
    FROM Ordine
    WHERE idClient = 1234
);
