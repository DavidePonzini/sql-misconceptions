select a.cid, b.cid
from customer a join customer b on a.street = b.street 
where a.city <> b.city