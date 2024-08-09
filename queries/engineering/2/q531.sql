SELECT 
    SUM(p.prezzo * d.quantità) AS total_amount
FROM 
    Ordine o
JOIN 
    DettaglioOrdine d ON o.idOrd = d.idOrd
JOIN 
    Prodotto p ON d.idProd = p.idProd
WHERE 
    o.idClient = 1234
    AND o.data = (
        SELECT MAX(data)
        FROM Ordine
        WHERE idClient = 1234
    );
