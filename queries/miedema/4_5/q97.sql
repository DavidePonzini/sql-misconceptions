select pname 
from natural product join inventory
where unit_price >
        (select unit_price
        from inventory natural join product
        where pname = 'Banana')