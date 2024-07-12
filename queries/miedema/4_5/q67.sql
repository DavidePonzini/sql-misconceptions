select distinct(P.pName)
from Inventory I natural join Product P 
where I.unit_price > ALL (select I.unit_price from Inventory I natural join Product P where P.pName = 'Banana' )