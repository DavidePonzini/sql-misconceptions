SELECT a.cID AS CustomerID1, b.cID AS CustomerID2
FROM miedema.customer a, miedema.customer b
WHERE a.street = b.street AND a.city <> b.city AND a.cID < b.cID;