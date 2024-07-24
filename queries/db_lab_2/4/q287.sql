SELECT s.matricola FROM studenti AS s, corsidilaurea AS cdl WHERE s.corsodilaurea=cdl.id AND s.laurea<='30-10-2009' AND cdl.denominazione='Informatica'
