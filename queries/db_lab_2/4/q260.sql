select matricola from studenti join corsidilaurea on studenti.corsodilaurea=corsidilaurea.id 
where laurea<'1/11/2009' and corsidilaurea.denominazione='Informatica';