select matricola from studenti
join corsidilaurea on id = corsodilaurea
where corsidilaurea.denominazione = 'Informatica' and laurea < '2009-11-01'