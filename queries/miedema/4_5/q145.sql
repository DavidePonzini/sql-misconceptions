select product.pName
from miedema.inventory natural join miedema.product
where unit_price > (
    
    select unit_price
    from miedema.inventory natural join miedema.product
    where pName = 'bananas'
    
    )