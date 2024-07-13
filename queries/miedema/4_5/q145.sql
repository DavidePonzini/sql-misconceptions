select product.pName
from inventory natural join product
where unit_price > (
    
    select unit_price
    from inventory natural join product
    where pName = 'bananas'
    
    )