select name
from transaction left join store s as t 
where exists (Select * from s where sName = s.sName)
and exists (Select * from s where sId <> s.sId)
and (Select avg(quantity) from t group by sName) > 4