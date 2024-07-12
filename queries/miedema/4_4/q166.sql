select ID, date, quantity
from transactions natural join product
where pName = 'apples'