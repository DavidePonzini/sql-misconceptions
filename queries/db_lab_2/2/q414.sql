Select 
	facolta, denominazione
From 
	corsidilaurea
Where 
	attivazione < '2006' OR attivazione > '2010'
Order By facolta, denominazione ASC;