select matricola from studenti join corsidilaurea on studenti.corsodilaurea=corsidilaurea.id
where (laurea<'2009-11-01' and corsidilaurea.denominazione='Informatica');
