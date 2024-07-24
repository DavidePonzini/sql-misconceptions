SELECT facolta, denominazione
FROM unicorsi.corsidilaurea
WHERE attivazione NOT BETWEEN '2006/2007' AND '2009/2010'
ORDER BY facolta, denominazione