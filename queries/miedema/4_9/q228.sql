SELECT 
    s.sName AS store_chain_name
FROM 
    store s
JOIN 
    transaction t ON s.sID = t.sID
GROUP BY 
    s.sName
HAVING 
    COUNT(DISTINCT s.sID) > 1 AND AVG(t.quantity) > 4;