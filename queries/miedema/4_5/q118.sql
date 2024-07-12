select product.pname
from inventory join product on inventory.pid=product.pid
where inventory.unit_price > (select inventory.unit_price
      from inventory join product on inventory.pid=product.pid
      where pname='Banana');