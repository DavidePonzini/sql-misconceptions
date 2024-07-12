SELECT t.cID, t.date, t.quantity
FROM transaction t
JOIN shoppinglist s ON t.cID = s.cID AND t.pID = s.pID
JOIN product p ON t.pID = p.pID
WHERE p.pName = 'Apples';
