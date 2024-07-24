select studente from esami where corso='bdd1n' and data between '01-06-2010' and '30-06-2010'
		EXCEPT select studente from esami where corso='ig' and data between '01-06-2010' and '30-06-2010';