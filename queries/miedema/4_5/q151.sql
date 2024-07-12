select pName 
from inventory natural join product
where unit_price >= all (select unit_price from inventory natural join product
                                                where pName='Bananas');