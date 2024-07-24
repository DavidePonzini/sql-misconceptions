INNER JOIN unicorsi.corsidilaurea ON corsidilaurea.id=studenti.corsodilaurea
WHERE studenti.laurea <'2009-11-01' AND corsidilaurea.denominazione LIKE 'Informatica'
