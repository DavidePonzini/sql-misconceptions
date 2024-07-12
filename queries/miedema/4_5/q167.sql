select *
from inventory
where unit_price >
(select unit_price from inventory natural join product where pName = "banana")