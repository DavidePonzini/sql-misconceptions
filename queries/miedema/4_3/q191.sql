SELECT C1.cID as cID1, C2.cID as cID2
FROM Customer C1, Customer C2
WHERE C1.street = C2.street AND C1.city <> C2.city;