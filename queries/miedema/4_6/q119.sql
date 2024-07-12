select distinct city, count(sname)
from store 
group by city;