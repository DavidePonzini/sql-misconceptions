SELECT corsidilaurea.facolta, corsidilaurea.denominazione
FROM unicorsi.corsidilaurea
WHERE corsidilaurea.attivazione < '2006' OR corsidilaurea.attivazione > '2009'
ORDER BY corsidilaurea.facolta ASC, corsidilaurea.denominazione ASC