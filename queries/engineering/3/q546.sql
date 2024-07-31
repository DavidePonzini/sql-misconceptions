SELECT P.nome
FROM Prodotto P
WHERE P.idProd NOT IN (
    SELECT DO.idProd
    FROM DettaglioOrdine DO
    JOIN Ordine O ON DO.idOrd = O.idOrd
    JOIN Cliente C ON O.idClient = C.idClient
    WHERE C.città IN ('Venezia', 'Brescia')
);
