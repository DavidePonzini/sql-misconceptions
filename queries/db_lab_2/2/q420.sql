select facolta , denominazione 
from corsidilaurea
where attivazione < '2006/2007' or attivazione > '2009/2010'
order by facolta asc , denominazione asc; 