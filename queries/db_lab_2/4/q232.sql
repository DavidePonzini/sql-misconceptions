SELECT matricola
FROM studenti JOIN corsidilaurea ON studenti.corsodilaurea=corsidilaurea.id
WHERE laurea<'2009-11-01'
	AND denominazione='Informatica';
