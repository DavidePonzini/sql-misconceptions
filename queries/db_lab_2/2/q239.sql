select facolta, denominazione, attivazione
from corsidilaurea
where attivazione not like '2006%'
	and attivazione not like '2007%'
	and attivazione not like '2008%'
	and attivazione not like '2009%'
order by facolta asc, denominazione asc;