select avg(T.quantity) as mediaquantita,T.sID
from Transaction T Natural join store S
group by T.sID 
having avg(T.quantity) >= 4
select S.sName, Count(*) as numeronegozi 
from store S
group by S.sName
Having Count(*)>=2