SELECT c1.cID, c2.cID 
FROM Customer c1 
INNER JOIN Customer c2 ON c1.street = c2.street AND c1.city != c2.city AND c1.cID < c2.cID;