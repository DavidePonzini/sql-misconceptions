SELECT 
    t.cID, 
    t.date, 
    t.quantity
FROM 
    miedema.transaction t
JOIN 
    miedema.product p ON t.pID = p.pID
WHERE 
    p.pName = 'Apples';