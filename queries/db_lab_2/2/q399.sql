SELECT facolta, denominazione, attivazione
FROM corsidilaurea
WHERE attivazione < '2006/2007' OR attivazione > '2009/2010'
ORDER BY facolta ASC, denominazione ASC;