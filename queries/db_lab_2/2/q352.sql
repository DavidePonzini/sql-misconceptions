select 
	facolta,
	denominazione
from
	corsidilaurea
where
	attivazione < '2006' OR attivazione > '2010' 
ORDER BY 
	facolta,denominazione ASC;