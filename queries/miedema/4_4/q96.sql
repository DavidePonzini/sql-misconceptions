select ID, date, quantity
from transaction natural join product
where pName = 'Apples'