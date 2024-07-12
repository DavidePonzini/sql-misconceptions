SELECT t.cID AS customer_id, t.date AS transazione_data, t.quantity
FROM transaction AS t
JOIN product p ON t.pID = p.pID
WHERE p.pName = 'Apples';