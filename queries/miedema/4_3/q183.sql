Select distinct c1.cID, c2.cID
From customers c1 natural join customer c2
Where c1.street = c2.street AND c1.city <> c2.city;