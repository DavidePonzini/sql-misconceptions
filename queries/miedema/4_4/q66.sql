select C.cID,T.date,P.pName
from Customer C 
natural join Transaction T natural join Product P
where P.pName = 'Apples'