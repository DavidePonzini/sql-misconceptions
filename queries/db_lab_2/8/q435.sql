SELECT matricola FROM esami
	INNER JOIN studenti ON esami.studente=studenti.matricola
	INNER JOIN corsi ON esami.corso=corsi.id
	INNER JOIN corsidilaurea ON corsidilaurea.id=corsi.corsodilaurea
WHERE corsidilaurea.denominazione LIKE 'Informatica' 
	AND 
		data BETWEEN '2010-05-31' AND '2010-07-01' AND corsi.denominazione LIKE'Basi Di Dati 1' 
except
SELECT matricola FROM esami
	INNER JOIN studenti ON esami.studente=studenti.matricola
	INNER JOIN corsi ON esami.corso=corsi.id
	INNER JOIN corsidilaurea ON corsidilaurea.id=corsi.corsodilaurea
	WHERE corsidilaurea.denominazione LIKE 'Informatica' 
	AND
		data BETWEEN '2010-05-31' AND '2010-07-01' AND corsi.denominazione  IN ( 'Interfacce Grafiche') 
	
ORDER BY matricola ASC