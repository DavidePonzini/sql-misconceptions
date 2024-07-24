Select
	matricola
From
	unicorsi.studenti, unicorsi.corsidilaurea
Where
	corsidilaurea.denominazione = 'Informatica' 
	AND studenti.laurea < DATE '1-Nov-2009'
	AND studenti.corsodilaurea = corsidilaurea.id
Order By studenti.matricola ASC;