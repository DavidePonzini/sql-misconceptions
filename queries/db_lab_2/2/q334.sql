SELECT facolta, denominazione FROM unicorsi.corsidilaurea
WHERE attivazione<'2006' OR attivazione>'2010' 
ORDER BY facolta, denominazione ASC;