SELECT studenti.matricola
FROM unicorsi.corsidilaurea, unicorsi.studenti
WHERE corsidilaurea.id = studenti.corsodilaurea
AND corsidilaurea.denominazione = 'Informatica'
and studenti.laurea < '2009-01-11'