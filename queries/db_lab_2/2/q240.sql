select facolta, denominazione, attivazione
from corsidilaurea
where left(attivazione, 4) not between '2006' and '2009'
order by facolta asc, denominazione asc;