-- Step 1: Find the latest order ID for the customer with ID 1234
WITH LastOrder AS (
    SELECT idOrd
    FROM Ordine
    WHERE idClient = 1234
    ORDER BY data DESC
    LIMIT 1
)

-- Step 2: Calculate the total amount for that order
SELECT SUM(d.quantità * p.prezzo) AS TotalAmount
FROM DettaglioOrdine d
JOIN Prodotto p ON d.idProd = p.idProd
JOIN LastOrder l ON d.idOrd = l.idOrd;
