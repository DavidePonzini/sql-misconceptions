SELECT facolta,denominazione
FROM corsidilaurea
WHERE attivazione<'2006' OR attivazione>'2010'
ORDER BY facolta,denominazione
