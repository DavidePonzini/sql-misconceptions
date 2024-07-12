SELECT c1.cID, c2.cID FROM Customer c1, Customer c2
WHERE c1.street = c2.street AND c1.city != c2.city