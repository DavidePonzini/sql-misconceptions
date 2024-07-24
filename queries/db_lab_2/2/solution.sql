SELECT facolta, denominazione
FROM corsidilaurea
WHERE attivazione < '2006/2007'
	OR attivazione > '2009/2010'
ORDER BY facolta, denominazione;