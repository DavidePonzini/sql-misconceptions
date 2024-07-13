SELECT 
    t.cID, 
    t.date, 
    t.quantity
FROM 
    transaction t
JOIN 
    product p ON t.pID = p.pID
WHERE 
    p.pName = 'Apples';
