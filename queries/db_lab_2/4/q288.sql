SELECT s.matricola FROM studenti AS s JOIN corsidilaurea AS cdl ON s.corsodilaurea=cdl.id WHERE s.laurea<='30-10-2009' AND cdl.denominazione='Informatica'
