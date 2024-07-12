select C.cID
from Customer C, Customer L
where C.street = L.street and C.city !=L.city