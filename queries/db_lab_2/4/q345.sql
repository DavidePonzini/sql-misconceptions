select matricola from unicorsi.studenti
join unicorsi.corsidilaurea on id = corsodilaurea
where corsidilaurea.denominazione = 'Informatica' and laurea < '2009-11-01'