SELECT p.nome
FROM Prodotto p
WHERE p.idProd NOT IN (
    SELECT d.idProd
    FROM DettaglioOrdine d
    JOIN Ordine o ON d.idOrd = o.idOrd
    JOIN Cliente c ON o.idClient = c.idClient
    WHERE c.città IN ('Venezia', 'Brescia')
);
