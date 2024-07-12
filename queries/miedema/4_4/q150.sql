select cID,date,quantity 
from transaction t join product p on t.pID = p.pID
where p.pName='Apples';