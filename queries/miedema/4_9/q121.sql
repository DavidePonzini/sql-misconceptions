select store.sname as store_chain
from store join store as s on (store.sID != s.sID and store.sname=s.sname)
join ( select sID, avg(quantity) as avg_quantity
       from transaction
       group by sID) 
       as avg_transaction on store.sID = avg_transaction.sID
where avg_transaction.avg_quantity > 4
group by store.sname;