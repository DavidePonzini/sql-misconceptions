SELECT nome
FROM Prodotto
WHERE idProd NOT IN (
    SELECT DISTINCT DettaglioOrdine.idProd
    FROM DettaglioOrdine
    JOIN Ordine ON DettaglioOrdine.idOrd = Ordine.idOrd
    JOIN Cliente ON Ordine.idClient = Cliente.idClient
    WHERE Cliente.città IN ('Venezia', 'Brescia')
);
